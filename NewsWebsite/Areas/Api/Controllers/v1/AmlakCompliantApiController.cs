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
using System.IO;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Data;
using NewsWebsite.ViewModels;
using System.Linq;
using NewsWebsite.ViewModels.Api.Contract.AmlakCompliant;

namespace NewsWebsite.Areas.Api.Controllers.v1 {
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class AmlakCompliantApiController : EnhancedController {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public AmlakCompliantApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment, ProgramBuddbContext db){
            _config = config;
            _uw = uw;
            _webHostEnvironment = webHostEnvironment;
            _db = db;
        }


        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------


        [Route("AmlakCompliant/List")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakCompliantListVm>>> AmlakCompliantList(AmlakCompliantReadInputVm param){
            await CheckUserAuth(_db);

            var items = await _db.AmlakCompliants
                .AmlakInfoId(param.AmlakInfoId)
                .Subject(param.Subject)
                .FileNumber(param.FileNumber)
                .Status(param.Status)
                .ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakCompliant, AmlakCompliantListVm>(items);

            return Ok(finalItems);
        }

        [Route("AmlakCompliant/Read")]
        [HttpGet]
        public async Task<ApiResult<AmlakCompliantReadVm>> AmlakCompliantRead(PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakCompliants.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");

            var finalItem = MyMapper.MapTo<AmlakCompliant, AmlakCompliantReadVm>(item);

            return Ok(finalItem);
        }


        [Route("AmlakCompliant/Store")]
        [HttpPost]
        public async Task<ApiResult<AmlakCompliantStoreResultVm>> AmlakCompliantUpdate([FromBody] AmlakCompliantStoreVm param){
            await CheckUserAuth(_db);

            var amlakInfo = await _db.AmlakInfos.Id(param.AmlakInfoId).FirstOrDefaultAsync();
            if (amlakInfo == null)
                return BadRequest("پیدا نشد");

            var item = new AmlakCompliant();
            item.AmlakInfoId = param.AmlakInfoId;
            item.Subject = param.Subject;
            item.FileNumber = param.FileNumber;
            item.Status = param.Status;
            item.Date = param.Date;
            item.Description = param.Description;
            item.Steps = param.Steps;
            item.CreatedAt = DateTime.Now;
            _db.Add(item);
            await _db.SaveChangesAsync();

            var result = new AmlakCompliantStoreResultVm();
            result.Id = item.Id;
            result.Message = "با موفقیت انجام شد";
            return Ok(result);
        }


        [Route("AmlakCompliant/Update")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakCompliantUpdate([FromBody] AmlakCompliantUpdateVm param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakCompliants.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");

            item.Subject = param.Subject;
            item.FileNumber = param.FileNumber;
            item.Date = param.Date;
            item.Description = param.Description;
            await _db.SaveChangesAsync();

            return Ok("با موفقیت انجام شد");
        }

        
        [Route("AmlakCompliant/Status")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakCompliantUpdateStatus([FromBody] AmlakCompliantUpdateStatusVm param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakCompliants.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");

            item.Status = param.Status;
            item.Steps = item.Steps + "<br>" + Helpers.MiladiToHejri(DateTime.Now.ToString()) + ":" + param.Steps;
            await _db.SaveChangesAsync();

            return Ok("با موفقیت انجام شد");
        }
    }
}