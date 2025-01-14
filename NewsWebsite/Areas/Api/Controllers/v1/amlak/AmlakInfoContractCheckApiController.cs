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
    public class AmlakInfoContractCheckApiController : EnhancedController
    {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public AmlakInfoContractCheckApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment,ProgramBuddbContext db)
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
        public async Task<ApiResult<object>> CheckList(AmlakInfoContractCheckListInputVm param){
            await CheckUserAuth(_db);

            var builder = _db.AmlakInfoContractChecks
                .AmlakInfoContractId(param.ContractId)
                .OwnerId(param.OwnerId)
                .PassStatus(param.PassStatus)
                .DateFrom(param.DateFrom)
                .DateTo(param.DateTo);

            if (param.Export == 1){
                param.Page = 1;
                param.PageRows = 100000;
            }
            var items = await builder
                .OrderBy(param.Sort,param.SortType)
                .Page2(param.Page,param.PageRows)
                .ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakInfoContractCheck, AmlakInfoContractCheckListVm>(items);

            if (param.Export == 1){
                var fileUrl = ExportExcel(items);
                return Ok(new {fileUrl});
            }
            var pageCount = (int)Math.Ceiling((await builder.CountAsync())/Convert.ToDouble(param.PageRows));
            
            return Ok(new{items=finalItems,pageCount});
        }

        
        private static object ExportExcel(List<AmlakInfoContractCheck> items){
            var finalItems = new List<List<object>>();

            foreach (var item in items){
                var row = new List<object>();
                row.Add(item.Id);
                row.Add(item.AmlakInfoContractId);
                row.Add(item.Number);
                row.Add(item.DateFa);
                row.Add(item.Amount);
                row.Add(item.Issuer);
                row.Add(item.IssuerBank);
                row.Add(item.Description);
                row.Add(item.PassStatusText);
                row.Add(item.CheckTypeText);
                row.Add(item.IsSubmitted);
                row.Add(item.CreatedAtFa);
                row.Add(item.UpdatedAtFa);
                
                finalItems.Add(row);
            }

            return Helpers.ExportExcelFile(finalItems, "amlak_contract_check");
        }
        
        [Route("Read")]
        [HttpGet]
        public async Task<ApiResult<AmlakInfoContractCheckListVm>> CheckRead(int id){
            await CheckUserAuth(_db);
            
            var item = await _db.AmlakInfoContractChecks
                .Id(id)
                .FirstAsync();
            
            
            var finalItem = MyMapper.MapTo<AmlakInfoContractCheck, AmlakInfoContractCheckListVm>(item);

            return Ok(finalItem);
        }
        
       
        [Route("Insert")]
        [HttpPost]
        public async Task<ApiResult<string>> CheckInsert([FromBody] AmlakInfoContractCheckInsertVm param){
            await CheckUserAuth(_db);

            var contract =await  _db.AmlakInfoContracts.Id( param.AmlakInfoContractId).FirstOrDefaultAsync();
            if (contract == null)
                return BadRequest("قرارداد یافت نشد");
            
            // insert Check 

            var check = new AmlakInfoContractCheck();
            check.AmlakInfoContractId=param.AmlakInfoContractId;
            check.Number=param.Number;
            check.Date=DateTime.Parse(param.Date);
            check.Amount=param.Amount;
            check.CheckType=param.CheckType;
            check.Issuer=param.Issuer;
            check.IssuerBank=param.IssuerBank;
            check.IsSubmitted=param.IsSubmitted;
            check.Description=param.Description;
            check.CreatedAt = Helpers.GetServerDateTimeType();
            check.UpdatedAt = Helpers.GetServerDateTimeType();
            
            _db.Add(check);
            await _db.SaveChangesAsync();

            await SaveLogAsync(_db, contract.Id, TargetTypes.Contract, "چک قرارداد با شناسه "+check.Id+" ثبت شد");

            return Ok(check.Id.ToString());
        }



        [Route("Update")]
        [HttpPost]
        public async Task<ApiResult<string>> CheckUpdate([FromBody] AmlakInfoContractCheckUpdateVm param){
            await CheckUserAuth(_db);
            
            var check =await  _db.AmlakInfoContractChecks.Id( param.Id).FirstOrDefaultAsync();
            if (check == null)
                return BadRequest("چک یافت نشد");


            // Helpers.dd(new{ param.DateEnd , a=DateTime.Parse(param.DateEnd) });
        // update Check 
            check.Number=param.Number;
            check.Date=DateTime.Parse(param.Date);
            check.Amount=param.Amount;
            check.CheckType=param.CheckType;
            check.Issuer=param.Issuer;
            check.IssuerBank=param.IssuerBank;
            check.IsSubmitted=param.IsSubmitted;
            check.Description=param.Description;
            check.UpdatedAt = Helpers.GetServerDateTimeType();
            
            await _db.SaveChangesAsync();

            await SaveLogAsync(_db, check.AmlakInfoContractId, TargetTypes.Contract, "چک قرارداد با شناسه "+check.Id+" ویرایش شد");

            return Ok(check.Id.ToString());
        }

        [Route("Delete")]
        [HttpPost]
        public async Task<ApiResult<string>> CheckDelete([FromBody] PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            var check =await  _db.AmlakInfoContractChecks.Id( param.Id).FirstOrDefaultAsync();
            if (check == null)
                return BadRequest("چک یافت نشد");

            _db.Remove(check);
            await _db.SaveChangesAsync();
            await SaveLogAsync(_db, check.AmlakInfoContractId, TargetTypes.Contract, "چک قرارداد با شناسه "+check.Id+" حذف شد");

          return Ok("با موفقیت انجام شد");
        }
        
        

        [Route("PassStatus")]
        [HttpPost]
        public async Task<ApiResult<string>> CheckUpdate(int checkId,int passStatus){
            await CheckUserAuth(_db);
            
            var check =await  _db.AmlakInfoContractChecks.Id( checkId).FirstOrDefaultAsync();
            if (check == null)
                return BadRequest("چک یافت نشد");

            check.PassStatus=passStatus;
            await _db.SaveChangesAsync();

            await SaveLogAsync(_db, check.AmlakInfoContractId, TargetTypes.Contract, "وضعیت چک  قرارداد با شناسه "+check.Id+" به "+passStatus+" تغییر یافت");

            return Ok("انجام شد");
        }



    }
}
