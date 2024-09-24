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

namespace NewsWebsite.Areas.Api.Controllers.v1.amlak
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class AmlakAppApiController : EnhancedController
    {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public AmlakAppApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment,ProgramBuddbContext db)
        {
            _config = config;
            _uw = uw;
            _webHostEnvironment = webHostEnvironment;
            _db=db;

        }


        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

        
        [Route("Dashboard")]
        [HttpGet]
        public async Task<ApiResult<object>> ContractList(){
            await CheckUserAuth(_db);

            var amlakPrivatesCount = await _db.AmlakPrivateNews.CountAsync();
            var amlakInfosCount = await _db.AmlakInfos.CountAsync();
            var contractAmlakInfosCount = await _db.AmlakInfoContracts.CountAsync();
            var parcels = await _db.AmlakParcels.CountAsync();
            var archives = await _db.AmlakArchives.CountAsync();
            
            
            return Ok(new {amlakPrivatesCount,amlakInfosCount,contractAmlakInfosCount,parcels,archives});
        }


        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

        
        [Route("Areas")]
        [HttpGet]
        public async Task<ApiResult<object>> DistrictsList(){
            await CheckUserAuth(_db);

            var areas = await _db.TblAreas.Where(a => a.Id <= 9 || a.Id == 52).ToListAsync();
            return Ok(new {areas});
        }

        [Route("Owners")]
        [HttpGet]
        public async Task<ApiResult<object>> OwnersList(){
            await CheckUserAuth(_db);

            var owners = await _db.TblAreas.Where(a => a.Id <= 9 || a.StructureId == 2 || a.Id == 52).ToListAsync();
            return Ok(new {owners});
        }


        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

        [Route("Test11")]
        [HttpGet]
        public async Task<ApiResult<TblBudgets>> Test11(int ContractId){
            await CheckUserAuth(_db);

            TblBudgets b = _db.TblBudgets.FirstOrDefault();
            
            return Ok( b);
        }
    }
}
