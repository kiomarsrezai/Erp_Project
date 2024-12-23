﻿using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.FileProviders;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Contract;
using NewsWebsite.ViewModels.Api.Public;
using Newtonsoft.Json;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq.Dynamic.Core;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Data;
using NewsWebsite.Data.Models;
using NewsWebsite.Data.Models.AmlakInfo;
using NewsWebsite.Data.Repositories;
using NewsWebsite.ViewModels;
using NewsWebsite.ViewModels.Api.Contract.AmlakInfo;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using System.Linq;
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;

namespace NewsWebsite.Areas.Api.Controllers.v1.amlak
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class AmlakInfoContractApiController : EnhancedController
    {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public AmlakInfoContractApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment,ProgramBuddbContext db)
        {
            _config = config;
            _uw = uw;
            _webHostEnvironment = webHostEnvironment;
            _db=db;

        }

        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

        [Route("List")]
        [HttpGet]
        public async Task<ApiResult<object>> ContractList(int amlakInfoId,int ownerId,int lessThanNMonth=0,int lessThanNMonthZemanat=0,int? isActive=null,int export=0,int page=1,int pageRows=10,string sort="Id",string sortType="desc"){
            var user=await CheckUserAuth(_db);
            var owners = GetPermission(user, "amlak_info.ownerAndType.owner_name");
            var kinds = GetPermission(user, "amlak_info.ownerAndType.kind");


            var builder = _db.AmlakInfoContracts
                .AmlakInfoId(amlakInfoId)
                .LessThanNMonth(lessThanNMonth)
                .LessThanNMonthZemanat(lessThanNMonthZemanat)
                .IsActive(isActive)
                .OwnerId(ownerId)
                .AmlakInfoOwnerIds(owners)
                .AmlakInfoKindIds(kinds);

            if (export == 1){
                page = 1;
                pageRows = 100000;
            }
            var items = await builder
                .Include(a=>a.Owner)
                .OrderBy(sort,sortType)
                .Page2(page,pageRows)
                .ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakInfoContract, AmlakInfoContractListVm>(items);
            
            if (export == 1){
                var fileUrl = ExportExcel(items);
                return Ok(new {fileUrl});
            }
            
            var pageCount = (int)Math.Ceiling((await builder.CountAsync())/Convert.ToDouble(pageRows));
            
            return Ok(new{items=finalItems,pageCount});
        }

        
        private static object ExportExcel(List<AmlakInfoContract> items){
            var finalItems = new List<List<object>>();

            foreach (var item in items){
                var row = new List<object>();
                row.Add(item.Id);
                row.Add(item.AmlakInfoId);
                row.Add(item.Owner.AreaName);
                row.Add(item.DoingMethodId);
                row.Add(item.StatusText);
                row.Add(item.Number);
                row.Add(item.DateFa);
                row.Add(item.Description);
                row.Add(item.DateFromFa);
                row.Add(item.DateEndFa);
                row.Add(item.ZemanatPrice);
                row.Add(item.ZemanatEndDate);
                row.Add(item.TypeText);
                row.Add(item.ModatValue);
                row.Add(item.Nemayande);
                row.Add(item.Modir);
                row.Add(item.Sarparast);
                row.Add(item.TenderNumber);
                row.Add(item.TenderDate);
                row.Add(item.CreatedAtFa);
                row.Add(item.UpdatedAtFa);
                
                finalItems.Add(row);
            }

            return Helpers.ExportExcelFile(finalItems, "amlak_contract");
        }

       

        [Route("Read")]
        [HttpGet]
        public async Task<ApiResult<AmlakInfoContractReadVm>> ContractRead(int ContractId){
            var user=await CheckUserAuth(_db);
            var owners = GetPermission(user, "amlak_info.ownerAndType.owner_name");
            var kinds = GetPermission(user, "amlak_info.ownerAndType.kind");

            
            var item = await _db.AmlakInfoContracts
                .Id(ContractId)
                .Include(a=>a.AmlakInfo)
                .Include(a=>a.Prices)
                .Include(a=>a.Owner)
                .Include(a=>a.Suppliers)
                .ThenInclude(s=>s.Supplier)
                .AmlakInfoOwnerIds(owners)
                .AmlakInfoKindIds(kinds)
                .FirstAsync();
            
            
            var finalItem = MyMapper.MapTo<AmlakInfoContract, AmlakInfoContractReadVm>(item);

            return Ok(finalItem);
        }

        [Route("Insert")]
        [HttpPost]
        public async Task<ApiResult<string>> ContractInsert([FromBody] AmlakInfoContractInsertVm param){
            var user=await CheckUserAuth(_db);
            var owners = GetPermission(user, "amlak_info.ownerAndType.owner_name");
            var kinds = GetPermission(user, "amlak_info.ownerAndType.kind");

            var amlakInfo =await  _db.AmlakInfos.Id( param.AmlakInfoId)
                .OwnerIds(owners)
                .AmlakInfoKindIds(kinds)
                .FirstOrDefaultAsync();
            if (amlakInfo == null)
                return BadRequest("ملک یافت نشد");
            
            // insert contract 

            var contract = new AmlakInfoContract();
            contract.AmlakInfoId=param.AmlakInfoId;
            contract.OwnerId=param.OwnerId;
            contract.DoingMethodId=0; // todo: remove
            contract.Status=1;
            contract.Number=param.Number;
            contract.Date=DateTime.Parse(param.Date);
            contract.Description=param.Description;
            contract.DateFrom=DateTime.Parse(param.DateFrom);
            contract.DateEnd=DateTime.Parse(param.DateEnd);
            contract.ZemanatPrice=param.ZemanatPrice;
            contract.ZemanatEndDate=DateTime.Parse(param.ZemanatEndDate);
            contract.Type=param.Type;
            contract.ModatValue=param.ModatValue;
            contract.Nemayande=param.Nemayande;
            contract.Modir=param.Modir;
            contract.Sarparast=param.Sarparast;
            contract.TenderNumber=param.TenderNumber;
            contract.TenderDate=string.IsNullOrEmpty(param.TenderDate)? (DateTime?)null : DateTime.Parse(param.TenderDate);
            contract.CreatedAt = Helpers.GetServerDateTimeType();
            contract.UpdatedAt = Helpers.GetServerDateTimeType();
            
            _db.Add(contract);
            
            await SaveLogAsync(_db, contract.Id, TargetTypes.Contract, "قرارداد ثبت شد");

            await _db.SaveChangesAsync();


            // update amlak info 
            if (amlakInfo.Masahat == null || amlakInfo.Masahat == 0){
                amlakInfo.Masahat = param.Masahat;
                amlakInfo.UpdatedAt = Helpers.GetServerDateTimeType();
            }

            if (string.IsNullOrEmpty(amlakInfo.Structure)){
                amlakInfo.Structure = param.Structure;
                amlakInfo.UpdatedAt = Helpers.GetServerDateTimeType();
            }

            if (string.IsNullOrEmpty(amlakInfo.OwnerType)){
                amlakInfo.OwnerType = param.Owner;
                amlakInfo.UpdatedAt = Helpers.GetServerDateTimeType();
            }

            if (string.IsNullOrEmpty(amlakInfo.TypeUsing)){
                amlakInfo.TypeUsing = param.TypeUsing;
                amlakInfo.UpdatedAt = Helpers.GetServerDateTimeType();
            }
            
            if (string.IsNullOrEmpty(amlakInfo.Code)){
                amlakInfo.Code = param.Code;
                amlakInfo.UpdatedAt = Helpers.GetServerDateTimeType();
            }
            

            

            foreach (var price in param.Prices){

                var amlakInfoPrice = new AmlakInfoContractPrice();
                amlakInfoPrice.ContractId = contract.Id;
                amlakInfoPrice.Year = price.Year;
                amlakInfoPrice.Deposit= price.Deposit;
                amlakInfoPrice.Rent= price.Rent;

                _db.Add(amlakInfoPrice);
            }
            
            foreach (var supplierId in param.SupplierIds){

                var amlakInfoSupplier = new AmlakInfoContractSupplier();
                amlakInfoSupplier.ContractId = contract.Id;
                amlakInfoSupplier.SupplierId = supplierId;

                _db.Add(amlakInfoSupplier);
            }
            
            await _db.SaveChangesAsync();

            return Ok(contract.Id.ToString());
        }



        [Route("Update")]
        [HttpPost]
        public async Task<ApiResult<string>> ContractUpdate([FromBody] AmlakInfoContractUpdateVm param){
            var user=await CheckUserAuth(_db);
            var owners = GetPermission(user, "amlak_info.ownerAndType.owner_name");
            var kinds = GetPermission(user, "amlak_info.ownerAndType.kind");


            var contract = await _db.AmlakInfoContracts.Id(param.Id)
                .AmlakInfoOwnerIds(owners)
                .AmlakInfoKindIds(kinds)
                .FirstOrDefaultAsync();
            if (contract == null)
                return BadRequest("قرارداد یافت نشد");

            var amlakInfo = await _db.AmlakInfos.Id(contract.AmlakInfoId).FirstOrDefaultAsync();
            if (amlakInfo == null)
                return BadRequest("ملک یافت نشد");

            // Helpers.dd(new{ param.DateEnd , a=DateTime.Parse(param.DateEnd) });
        // update contract 
            contract.OwnerId=param.OwnerId;
            contract.DoingMethodId=0; // todo: remove
            contract.Number=param.Number;
            contract.Date=DateTime.Parse(param.Date);
            contract.Description=param.Description;
            contract.DateFrom=DateTime.Parse(param.DateFrom);
            contract.DateEnd=DateTime.Parse(param.DateEnd);
            contract.ZemanatPrice=param.ZemanatPrice;
            contract.ZemanatEndDate=DateTime.Parse(param.ZemanatEndDate);
            contract.Type=param.Type;
            contract.ModatValue=param.ModatValue;
            contract.Nemayande=param.Nemayande;
            contract.Modir=param.Modir;
            contract.Sarparast=param.Sarparast;
            contract.TenderNumber=param.TenderNumber;
            contract.TenderDate=string.IsNullOrEmpty(param.TenderDate)? (DateTime?)null : DateTime.Parse(param.TenderDate);
            contract.UpdatedAt = Helpers.GetServerDateTimeType();

            
            
            // update amlak info 
            // if (amlakInfo.Masahat == null || amlakInfo.Masahat == 0)
                amlakInfo.Masahat = param.Masahat;
            // if (string.IsNullOrEmpty(amlakInfo.Structure))
                amlakInfo.Structure=param.Structure;
            // if (string.IsNullOrEmpty(amlakInfo.OwnerType))
                amlakInfo.OwnerType=param.Owner;
            // if (string.IsNullOrEmpty(amlakInfo.TypeUsing))
                amlakInfo.TypeUsing=param.TypeUsing;
                
                amlakInfo.Code=param.Code;


            var prices = await _db.AmlakInfoContractPrices.Where(a => a.ContractId == param.Id).ToListAsync();
            _db.RemoveRange(prices);
            
            var suppliers = await _db.AmlakInfoContractSuppliers.Where(a => a.ContractId == param.Id).ToListAsync();
            _db.RemoveRange(suppliers);
            
            await SaveLogAsync(_db, contract.Id, TargetTypes.Contract, "قرارداد ویرایش شد");

            await _db.SaveChangesAsync();


            foreach (var price in param.Prices){

                var amlakInfoPrice = new AmlakInfoContractPrice();
                amlakInfoPrice.ContractId = contract.Id;
                amlakInfoPrice.Year = price.Year;
                amlakInfoPrice.Deposit= price.Deposit;
                amlakInfoPrice.Rent= price.Rent;

                _db.Add(amlakInfoPrice);
            }
            
            foreach (var supplierId in param.SupplierIds){

                var amlakInfoSupplier = new AmlakInfoContractSupplier();
                amlakInfoSupplier.ContractId = contract.Id;
                amlakInfoSupplier.SupplierId = supplierId;

                _db.Add(amlakInfoSupplier);
            }
            
            await _db.SaveChangesAsync();

            return Ok(contract.Id.ToString());
        }

        // [Route("Delete")]
        // [HttpPost]
        // public async Task<ApiResult<string>> ContractDelete([FromBody] PublicParamIdViewModel param){
        //     await CheckUserAuth(_db);
        //
        //     using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
        //     {
        //         using (SqlCommand sqlCommand = new SqlCommand("SP012_ContractAmlak_Delete", sqlconnect))
        //         {
        //             sqlconnect.Open();
        //             sqlCommand.Parameters.AddWithValue("Id", param.Id);
        //             sqlCommand.CommandType = CommandType.StoredProcedure;
        //             SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
        //          
        //         }
        //     }
        //     
        //     await SaveLogAsync(_db, param.Id, TargetTypes.Contract, "قرارداد حذف شد");
        //
        //   return Ok("با موفقیت انجام شد");
        // }
        //
    }
}
