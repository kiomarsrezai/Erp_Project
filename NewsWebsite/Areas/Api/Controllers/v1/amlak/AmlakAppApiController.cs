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
using NewsWebsite.Data.Models.AmlakPrivate;
using SharpKml.Dom;
using SharpKml.Engine;
using System.IO;
using System.IO.Compression;
using System.Text.Json.Nodes;
using Microsoft.AspNetCore.Mvc.Controllers;
using Microsoft.AspNetCore.Routing.Patterns;
using NewsWebsite.Data.Models.AmlakAdmin;
using NewsWebsite.Data.Models.LogRequest;
using SharpKml.Base;

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
            var amlakPrivatesSanadTakBargCount = await _db.AmlakPrivateNews.DocumentType(1).CountAsync();
            var amlakPrivatesSanadDaftarcheCount = await _db.AmlakPrivateNews.DocumentType(3).CountAsync();
            var amlakPrivatesOwnershipType1Count = await _db.AmlakPrivateNews.OwnershipType("1").CountAsync();
            var amlakPrivatesOwnershipType2Count = await _db.AmlakPrivateNews.OwnershipType("2").CountAsync();
            var amlakPrivatesOwnershipType3Count = await _db.AmlakPrivateNews.OwnershipType("3").CountAsync();
            
            var amlakPrivatesWithParcelCount = await _db.AmlakPrivateNews.HasSdiLayer(1).CountAsync();
            var amlakPrivatesWithoutParcelCount = await _db.AmlakPrivateNews.HasSdiLayer(0).CountAsync();
            
            
            
            var parcelsCount = await _db.AmlakParcels.CountAsync();
            var parcelsPendingCount = await _db.AmlakParcels.Status("1").CountAsync();
            var parcelsAcceptedCount = await _db.AmlakParcels.Status("2").CountAsync();
            var parcelsRejectedCount = await _db.AmlakParcels.Status("3").CountAsync();
            var parcelsRemovedCount = await _db.AmlakParcels.Status("4").CountAsync();
            
            var archivesNotSubmittedCount = await _db.AmlakArchives.IsSubmitted(0).CountAsync();
            var archivesSubmittedCount = await _db.AmlakArchives.IsSubmitted(1).CountAsync();
            
            var amlakInfosNonRentableAllCount = await _db.AmlakInfos.Rentable(0).CountAsync();
            var amlakInfosNonRentableParkCount = await _db.AmlakInfos.Rentable(0).AmlakInfoKindId(5).CountAsync();
            var amlakInfosNonRentableGozarCount = await _db.AmlakInfos.Rentable(0).AmlakInfoKindId(6).CountAsync();
            var amlakInfosNonRentableOtherCount = amlakInfosNonRentableAllCount-amlakInfosNonRentableParkCount-amlakInfosNonRentableGozarCount;
            var amlakInfosRentableAllCount = await _db.AmlakInfos.Rentable(1).CountAsync();
            var amlakInfosRentableWithContractCount = await _db.AmlakInfos.Rentable(1).Where(ai => ai.Contracts.Any()).CountAsync();
            var amlakInfosRentableWithoutContractCount = await _db.AmlakInfos.Rentable(1).Where(ai => !ai.Contracts.Any()).CountAsync();
            var amlakInfosRentableWithActiveContractCount =await _db.AmlakInfos.Rentable(1).Where(ai => ai.Contracts.Any(c => c.DateEnd == null || c.DateEnd > DateTime.Now)).CountAsync();
            var amlakInfosRentableWithoutActiveContractCount =  await _db.AmlakInfos.Where(ai => !ai.Contracts.Any(c => c.DateEnd == null || c.DateEnd > DateTime.Now)).CountAsync();
            
            var contractAmlakInfosAllCount = await _db.AmlakInfoContracts.CountAsync();
            var contractAmlakInfosActiveCount = await _db.AmlakInfoContracts.IsActive(1).CountAsync();
            var contractAmlakInfos2MonthActiveCount = await _db.AmlakInfoContracts.LessThanNMonth(2).CountAsync();


            var generatingAllCount = await _db.AmlakPrivateGeneratings.CountAsync();
            var generating1Count = await _db.AmlakPrivateGeneratings.Decision(1).CountAsync();
            var generating2Count = await _db.AmlakPrivateGeneratings.Decision(2).CountAsync();
            var generating3Count = await _db.AmlakPrivateGeneratings.Decision(3).CountAsync();
            var generating4Count = await _db.AmlakPrivateGeneratings.Decision(4).CountAsync();
            var generating5Count = await _db.AmlakPrivateGeneratings.Decision(5).CountAsync();
            var generating6Count = await _db.AmlakPrivateGeneratings.Decision(6).CountAsync();
            var generating7Count = await _db.AmlakPrivateGeneratings.Decision(7).CountAsync();
            
            
            return Ok(new{
                amlakPrivatesCount,amlakPrivatesSanadTakBargCount,amlakPrivatesSanadDaftarcheCount,amlakPrivatesOwnershipType1Count,amlakPrivatesOwnershipType2Count,amlakPrivatesOwnershipType3Count,amlakPrivatesWithParcelCount,amlakPrivatesWithoutParcelCount,
                parcelsCount,parcelsPendingCount,parcelsAcceptedCount,parcelsRejectedCount,parcelsRemovedCount,
                archivesNotSubmittedCount,archivesSubmittedCount,
                amlakInfosNonRentableAllCount,amlakInfosNonRentableParkCount,amlakInfosNonRentableGozarCount,amlakInfosNonRentableOtherCount,amlakInfosRentableAllCount,amlakInfosRentableWithContractCount,amlakInfosRentableWithoutContractCount,amlakInfosRentableWithActiveContractCount,amlakInfosRentableWithoutActiveContractCount,
                contractAmlakInfosAllCount,contractAmlakInfosActiveCount,contractAmlakInfos2MonthActiveCount,
                generatingAllCount,generating1Count,generating2Count,generating3Count,generating4Count,generating5Count,generating6Count,generating7Count
            });
        }
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

        
        [Route("Areas")]
        [HttpGet]
        public async Task<ApiResult<object>> DistrictsList(){
            await CheckUserAuth(_db);

            var areas = await _db.TblAreas.Where(a => a.Id <= 9 || a.Id == 52).ToListAsync();
            foreach (var area in areas){
                if (area.Id == 9){
                    area.AreaName = "شهرداری اهواز";
                }
            }
            return Ok(new {areas});
        }

        [Route("Owners")]
        [HttpGet]
        public async Task<ApiResult<object>> OwnersList(){
            await CheckUserAuth(_db);

            var owners = await _db.TblAreas.Where(a => a.Id <= 9 || a.StructureId == 2 || a.Id == 52).ToListAsync();
            foreach (var owner in owners){
                if (owner.Id == 9){
                    owner.AreaName = "شهرداری اهواز";
                }
            }
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
            var amlakPrivates = await _db.AmlakPrivateNews.Where(a=> EF.Functions.Like(a.Title, $"%{text}%")).ToListAsync();
            
              var amlakArchives = await _db.AmlakArchives.Where(a=> EF.Functions.Like(a.Address, $"%{text}%") || 
                                                                    EF.Functions.Like(a.Description, $"%{text}%")
                                                        ).ToListAsync();
            
            
            return Ok(new {amlakInfos,amlakPrivates,amlakArchives});
        }
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

        [Route("Test1Success")]
        [HttpGet]
        public async Task<ApiResult<object>> Test11(int ContractId){

            
            var authHeader = Request.Headers["Authorization"].ToString();
            if (authHeader == null || !authHeader.StartsWith("Bearer "))
                return 0;
            
            var token = authHeader.Substring("Bearer ".Length).Trim();
            var user1 = await _db.Users.Where(u => u.Token == token).FirstOrDefaultAsync();
            if (user1 == null){
                return 0;
            }
            Helpers.dd(Helpers.GetUserDeviceInfo(HttpContext));
            
            // Helpers.dd(Helpers.GetUserIp(HttpContext));
            
            
            var a1 = HttpContext.GetEndpoint();
            var b1 = a1.Metadata;
            var c2 = b1.GetMetadata<ControllerActionDescriptor>();
            var c1 = b1.GetMetadata<RouteAttribute>();
            var d2 = c2.AttributeRouteInfo.Template;
            var d1 = c1.Template;
            Helpers.dd(HttpContext.GetEndpoint()?.Metadata.GetMetadata<RoutePattern>()?.RawText);
            var user = await CheckUserAuth(_db);
            bool result = CheckPermission(user, "amlak_info.ownerAndType.kind","1");
            bool result2 = CheckPermission(user, "agreement.show.showAgreement","1");

            return Ok(result+"/"+result2);
            var kinds = GetPermission(user, "amlak_info.ownerAndType.kind");

// Use the kinds in EF Core query
            var houses = _db.AmlakPrivateNews.Where(h => kinds.Contains(h.Id.ToString())).Count();
            
            return Ok(houses);

            var b = 0;
            var a = 5 / b;
            var builder = _db.AmlakArchives;

            var i = await builder.AreaId(ContractId).ToListAsync();
            var pageCount = await builder.CountAsync();

            return Ok( new{i,pageCount});
        }
        
        [Route("Test1Error")]
        [HttpGet]
        public async Task<ApiResult<object>> Test12(int ContractId){

            var logException22 = new LogRequestException{
                LogRequestId = 22,
                Location = "at NewsWebsite.Areas.Api.Controllers.v\n            1.amlak.AmlakAppApiController.Test13(Int32 ContractId) in D:\\projects\\ASP\\Erp_Project\\NewsWebsite\\Areas\\Api\\Controllers\\v1\\amlak\\AmlakApp\n            ApiController.cs:line 227", // todo: , // You can improve this by identifying the exact location
                Exception = "Attempted to divide by zero.", // todo: ,
                Code = "500", // todo: 
            };
              
            
            _db.LogRequestExceptions.Add(logException22);
            await _db.SaveChangesAsync();

            
               return  BadRequest("sssssssss");
        }
        
        
        [Route("Test1Crash")]
        [HttpGet]
        public async Task<ApiResult<object>> Test13(int ContractId){
            var b = 0;
            var a = 5 / b;

            return Ok("ok");
        }
        
        
        
        
        [Route("KMZ")]
        [HttpGet]
        public string CreateKmzFile(){
            // var privs = _db.AmlakPrivateNews.ToList();
            var privs = _db.AmlakInfos.ToList();
            var list = new List<Helpers.KMZVM>();
            foreach (var priv in privs){
                list.Add(new Helpers.KMZVM{Name = "id:" + priv.Id, Coordinates = priv.Coordinates });
            }
            
            return Helpers.ExportKmzFile(list,"infooooo"); 
        }
    }
}
