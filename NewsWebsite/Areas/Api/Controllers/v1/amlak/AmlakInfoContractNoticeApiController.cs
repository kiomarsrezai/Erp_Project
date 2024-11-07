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
    public class AmlakInfoContractNoticeApiController : EnhancedController
    {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public AmlakInfoContractNoticeApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment,ProgramBuddbContext db)
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
        public async Task<ApiResult<object>> NoticeList(AmlakInfoContractNoticeListInputVm param){
            await CheckUserAuth(_db);

            var builder = _db.AmlakInfoContractNotices
                .AmlakInfoContractId(param.ContractId)
                .SupplierId(param.SupplierId);

            
            var items = await builder
                .OrderBy(param.Sort,param.SortType)
                .Page2(param.Page,param.PageRows)
                .ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakInfoContractNotice, AmlakInfoContractNoticeListVm>(items);

            
            var pageCount = (int)Math.Ceiling((await builder.CountAsync())/Convert.ToDouble(param.PageRows));
            
            return Ok(new{items=finalItems,pageCount});
        }

        
        [Route("Insert")]
        [HttpPost]
        public async Task<ApiResult<string>> NoticeInsert([FromBody] AmlakInfoContractNoticeInsertVm param){
            await CheckUserAuth(_db);

            var contract =await  _db.AmlakInfoContracts.Id( param.AmlakInfoContractId).FirstOrDefaultAsync();
            if (contract == null)
                return BadRequest("قرارداد یافت نشد");
            
            // insert Notice 

            var Notice = new AmlakInfoContractNotice();
            Notice.AmlakInfoContractId=param.AmlakInfoContractId;
            Notice.Title=param.Title;
            Notice.Date=DateTime.Parse(param.Date);
            Notice.LetterNumber=param.LetterNumber;
            Notice.Description=param.Description;
            Notice.CreatedAt = Helpers.GetServerDateTimeType();
            Notice.UpdatedAt = Helpers.GetServerDateTimeType();

            if (param.Title == 7){ // canceled
                contract.Status = 3;
            }
            
            _db.Add(Notice);
            await _db.SaveChangesAsync();

            return Ok(Notice.Id.ToString());
        }



        [Route("Update")]
        [HttpPost]
        public async Task<ApiResult<string>> NoticeUpdate([FromBody] AmlakInfoContractNoticeUpdateVm param){
            await CheckUserAuth(_db);
            
            var Notice =await  _db.AmlakInfoContractNotices.Id( param.Id).FirstOrDefaultAsync();
            if (Notice == null)
                return BadRequest("هشدار یافت نشد");


            // Helpers.dd(new{ param.DateEnd , a=DateTime.Parse(param.DateEnd) });
        // update Notice 
            Notice.Date=DateTime.Parse(param.Date);
            Notice.Title=param.Title;
            Notice.LetterNumber=param.LetterNumber;
            Notice.Description=param.Description;
            Notice.UpdatedAt = Helpers.GetServerDateTimeType();
            
            if (param.Title == 7){ // canceled
                var contract =await  _db.AmlakInfoContracts.Id( Notice.AmlakInfoContractId).FirstOrDefaultAsync();
                if (contract != null)
                    contract.Status = 3;
            }
            
            await _db.SaveChangesAsync();

            return Ok(Notice.Id.ToString());
        }

        [Route("Delete")]
        [HttpPost]
        public async Task<ApiResult<string>> NoticeDelete([FromBody] PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            var Notice =await  _db.AmlakInfoContractNotices.Id( param.Id).FirstOrDefaultAsync();
            if (Notice == null)
                return BadRequest("هشدار یافت نشد");

            _db.Remove(Notice);
            await _db.SaveChangesAsync();

          return Ok("با موفقیت انجام شد");
        }
        
    }
}
