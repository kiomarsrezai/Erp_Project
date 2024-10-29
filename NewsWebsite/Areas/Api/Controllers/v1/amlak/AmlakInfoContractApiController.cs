using Microsoft.AspNetCore.Hosting;
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
        public async Task<ApiResult<object>> ContractList(int amlakInfoId,int ownerId,int lessThanNMonth=0,int lessThanNMonthZemanat=0,int? isActive=null,int page=1,int pageRows=10,string sort="Id",string sortType="desc"){
            await CheckUserAuth(_db);

            var builder = _db.AmlakInfoContracts
                .AmlakInfoId(amlakInfoId)
                .LessThanNMonth(lessThanNMonth)
                .LessThanNMonthZemanat(lessThanNMonthZemanat)
                .IsActive(isActive)
                .OwnerId(ownerId);

            
            var items = await builder
                .Include(a=>a.Owner)
                .OrderBy(sort,sortType)
                .Page2(page,pageRows)
                .ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakInfoContract, AmlakInfoContractListVm>(items);

            
            var pageCount = (int)Math.Ceiling((await builder.CountAsync())/Convert.ToDouble(pageRows));
            
            return Ok(new{items=finalItems,pageCount});
        }

       

        [Route("Read")]
        [HttpGet]
        public async Task<ApiResult<AmlakInfoContractReadVm>> ContractRead(int ContractId){
            await CheckUserAuth(_db);
            
            var item = await _db.AmlakInfoContracts
                .Id(ContractId)
                .Include(a=>a.AmlakInfo)
                .Include(a=>a.Prices)
                .Include(a=>a.Owner)
                .Include(a=>a.Suppliers)
                .ThenInclude(s=>s.Supplier)
                .FirstAsync();
            
            
            var finalItem = MyMapper.MapTo<AmlakInfoContract, AmlakInfoContractReadVm>(item);

            return Ok(finalItem);
        }

        [Route("Insert")]
        [HttpPost]
        public async Task<ApiResult<string>> ContractInsert([FromBody] AmlakInfoContractInsertVm param){
            await CheckUserAuth(_db);

            var amlakInfo =await  _db.AmlakInfos.Id( param.AmlakInfoId).FirstOrDefaultAsync();
            if (amlakInfo == null)
                return BadRequest("ملک یافت نشد");
            
            // insert contract 

            var contract = new AmlakInfoContract();
            contract.AmlakInfoId=param.AmlakInfoId;
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
            contract.TenderDate=DateTime.Parse(param.TenderDate);
            contract.CreatedAt = Helpers.GetServerDateTimeType();
            contract.UpdatedAt = Helpers.GetServerDateTimeType();
            
            _db.Add(contract);
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
            await CheckUserAuth(_db);

            var contract = await _db.AmlakInfoContracts.Id(param.Id).FirstOrDefaultAsync();
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
            contract.TenderDate=DateTime.Parse(param.TenderDate);
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


            var prices = await _db.AmlakInfoContractPrices.Where(a => a.ContractId == param.Id).ToListAsync();
            _db.RemoveRange(prices);
            
            var suppliers = await _db.AmlakInfoContractSuppliers.Where(a => a.ContractId == param.Id).ToListAsync();
            _db.RemoveRange(suppliers);
            
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

        [Route("Delete")]
        [HttpPost]
        public async Task<ApiResult<string>> ContractDelete([FromBody] PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP012_ContractAmlak_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                 
                }
            }
          return Ok("با موفقیت انجام شد");
        }
        
    }
}
