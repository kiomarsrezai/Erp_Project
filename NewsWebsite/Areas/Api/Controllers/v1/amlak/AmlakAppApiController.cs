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
using NewsWebsite.Data.Models.AmlakArchive;

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
            var parcelsCount = await _db.AmlakParcels.CountAsync();
            var archivesCount = await _db.AmlakArchives.CountAsync();
            var amlakInfosNonRentableAllCount = await _db.AmlakInfos.Rentable(0).CountAsync();
            var amlakInfosRentableAllCount = await _db.AmlakInfos.Rentable(1).CountAsync();
            var amlakInfosRentableWithContractCount = await _db.AmlakInfos.Rentable(1).Where(ai => ai.Contracts.Any()).CountAsync();
            var amlakInfosRentableWithoutContractCount = await _db.AmlakInfos.Rentable(1).Where(ai => !ai.Contracts.Any()).CountAsync();
            var amlakInfosRentableWithActiveContractCount =await _db.AmlakInfos.Rentable(1).Where(ai => ai.Contracts.Any(c => c.DateEnd == null || c.DateEnd > DateTime.Now)).CountAsync();
            var amlakInfosRentableWithoutActiveContractCount =  await _db.AmlakInfos.Where(ai => !ai.Contracts.Any(c => c.DateEnd == null || c.DateEnd > DateTime.Now)).CountAsync();
            var contractAmlakInfosAllCount = await _db.AmlakInfoContracts.CountAsync();
            var contractAmlakInfosActiveCount = await _db.AmlakInfoContracts.Where(c=>c.DateEnd == null || c.DateEnd > DateTime.Now).CountAsync();
            
            
            return Ok(new {amlakPrivatesCount,parcelsCount,archivesCount,amlakInfosNonRentableAllCount,amlakInfosRentableAllCount,amlakInfosRentableWithContractCount,amlakInfosRentableWithoutContractCount,amlakInfosRentableWithActiveContractCount,amlakInfosRentableWithoutActiveContractCount,contractAmlakInfosAllCount,contractAmlakInfosActiveCount,});
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

        [Route("GeneralSearch")]
        [HttpGet]
        public async Task<ApiResult<object>> GeneralSearch(string text){
            await CheckUserAuth(_db);

            var amlakInfos = await _db.AmlakInfos.Where(a=> EF.Functions.Like(a.EstateInfoName, $"%{text}%") || 
                                                            EF.Functions.Like(a.EstateInfoAddress, $"%{text}%")
                                                        ).ToListAsync();
            var amlakPrivates = await _db.AmlakPrivateNews.Where(a=> EF.Functions.Like(a.Title, $"%{text}%") || 
                                                        EF.Functions.Like(a.TypeUsing, $"%{text}%")
                                                        ).ToListAsync();
            
              var amlakArchives = await _db.AmlakArchives.Where(a=> EF.Functions.Like(a.Address, $"%{text}%") || 
                                                                    EF.Functions.Like(a.Description, $"%{text}%")
                                                        ).ToListAsync();
            
            
            return Ok(new {amlakInfos,amlakPrivates,amlakArchives});
        }
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

        [Route("Test11")]
        [HttpGet]
        public async Task<ApiResult<object>> Test11(int ContractId){
            await CheckUserAuth(_db);

            var builder = _db.AmlakArchives;

            var i = await builder.AreaId(ContractId).ToListAsync();
            var pageCount = await builder.CountAsync();

            return Ok( new{i,pageCount});
        }
    }
}
