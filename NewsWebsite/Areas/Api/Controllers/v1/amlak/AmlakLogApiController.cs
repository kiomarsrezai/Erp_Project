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
using NewsWebsite.Data.Models.AmlakAdmin;
using NewsWebsite.ViewModels.Api.Contract.AmlakAdmin;
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;

namespace NewsWebsite.Areas.Api.Controllers.v1.amlak {
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class AmlakLogApiController : EnhancedController {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public AmlakLogApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment, ProgramBuddbContext db){
            _config = config;
            _uw = uw;
            _webHostEnvironment = webHostEnvironment;
            _db = db;
        }


        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------


        [Route("List")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakLogListVm>>> AmlakLogList(AmlakLogReadInputVm param){
            await CheckUserAuth(_db);

            var items = await _db.AmlakLogs
                .TargetType(param.TargetType)
                .TargetId(param.TargetId)
                .AdminId(param.AdminId)
                .ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakLog, AmlakLogListVm>(items);

            return Ok(finalItems);
        }


        // [NonAction]
        // public static async Task<bool> SaveLogAsync(ProgramBuddbContext _db,AmlakAdmin admin, int targetId,string targetType,string description){
        //     var admin = await CheckUserAuth(_db);
        //     
        //     var item = new AmlakLog();
        //     item.TargetId = targetId;
        //     item.TargetType = targetType;
        //     item.AdminId = admin.Id;
        //     item.Description = description;
        //     item.Date = Helpers.GetServerDateTimeType();
        //     _db.Add(item);
        //     await _db.SaveChangesAsync();
        //
        //     return true;
        // }

    }
}