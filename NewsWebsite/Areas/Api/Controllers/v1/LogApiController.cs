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
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;

namespace NewsWebsite.Areas.Api.Controllers.v1 {
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class LogApiController : EnhancedBudgetController {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public LogApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment, ProgramBuddbContext db){
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
        public async Task<ApiResult<List<BudgetLogListVm>>> BudgetLogList(BudgetLogReadInputVm param){
            await CheckUserAuth(_db);

            var items = await _db.BudgetLogs
                .Include(c=>c.Admin)
                .TargetType(param.TargetType)
                .TargetId(param.TargetId)
                .Coding(param.Coding)
                .Url(param.Url)
                .Description(param.Description)
                .AdminId(param.AdminId)
                .OrderBy(param.Sort,param.SortType).Page2(param.Page, param.PageRows)
                .ToListAsync();

            var finalItems = MyMapper.MapTo<BudgetLog, BudgetLogListVm>(items);

            return Ok(finalItems);
        }


    }
}