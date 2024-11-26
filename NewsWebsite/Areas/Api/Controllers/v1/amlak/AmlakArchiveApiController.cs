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
using NewsWebsite.Data.Models.AmlakArchive;
using NewsWebsite.ViewModels.Api.Contract.AmlakArchive;
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;

namespace NewsWebsite.Areas.Api.Controllers.v1.amlak {
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class AmlakArchiveApiController : EnhancedController {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public AmlakArchiveApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment, ProgramBuddbContext db){
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
        public async Task<ApiResult<object>> AmlakArchiveList(AmlakArchiveReadInputVm param){
            await CheckUserAuth(_db);

            var builder = _db.AmlakArchives
                .ArchiveCode(param.ArchiveCode)
                .AmlakCode(param.AmlakCode)
                .AreaId(param.AreaId)
                .OwnerId(param.OwnerId)
                .IsSubmitted(param.IsSubmitted)
                .MainPlateNumber(param.MainPlateNumber).SubPlateNumber(param.SubPlateNumber)
                .Search(param.Search);

            var pageCount = (int)Math.Ceiling((await builder.CountAsync())/Convert.ToDouble(param.PageRows));
            
            
            if (param.Export == 1){
                param.Page = 1;
                param.PageRows = 100000;
            }
            if (param.ForMap == 0){
                builder = builder
                    .Include(a => a.Area)
                    .Include(a => a.Owner)
                    .OrderBy(param.Sort,param.SortType)
                    .Page2(param.Page, param.PageRows);
            }
            var items = await builder.ToListAsync();
            
             
            if (param.Export == 1){
                var fileUrl = ExportExcel(items);
                return Ok(new {fileUrl});
            }
            
            var finalItems = MyMapper.MapTo<AmlakArchive, AmlakArchiveListVm>(items);
        
            return Ok(new{items=finalItems,pageCount});
        }
        
        
          
        private static object ExportExcel(List<AmlakArchive> items){
            var finalItems = new List<List<object>>();

            foreach (var item in items){
                var row = new List<object>();
                row.Add(item.Id);
                row.Add(item.SdiId);
                row.Add(item.IsSubmitted);
                row.Add(item.Area.AreaName);
                row.Add(item.Owner.AreaName);
                row.Add(item.ArchiveCode);
                row.Add(item.AmlakCode);
                row.Add(item.Section);
                row.Add(item.MainPlateNumber);
                row.Add(item.SubPlateNumber);
                row.Add(item.Description);
                row.Add(item.Address);
                row.Add(item.Coordinates);
                row.Add(item.CreatedAtFa);
                row.Add(item.UpdatedAtFa);
                
                finalItems.Add(row);
            }

            return Helpers.ExportExcelFile(finalItems, "amlak_archive");
        }


        
        [Route("Read")]
        [HttpGet]
        public async Task<ApiResult<AmlakArchiveReadVm>> AmlakArchiveRead(PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakArchives.Id(param.Id)
                .Include(a=>a.Area)
                .Include(a=>a.Owner)
                .FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");
            
            var finalItem = MyMapper.MapTo<AmlakArchive, AmlakArchiveReadVm>(item);
        
            return Ok(finalItem);
        }
        
        
        
        [Route("Update")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakArchiveUpdate([FromBody] AmlakArchiveUpdateVm param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakArchives.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");

            item.AreaId = param.AreaId;
            item.OwnerId = param.OwnerId;
            item.Title = param.Title;
            item.ArchiveCode = param.ArchiveCode;
            item.AmlakCode = param.AmlakCode;
            item.Section = param.Section;
            item.MainPlateNumber = param.MainPlateNumber;
            item.SubPlateNumber = param.SubPlateNumber;
            item.Description = param.Description;
            item.Address = param.Address;
            item.IsSubmitted = 1;
            item.UpdatedAt = Helpers.GetServerDateTimeType();
            await _db.SaveChangesAsync();
        
            await SaveLogAsync(_db, item.Id, TargetTypes.Archive, "آرشیو ویرایش شد.");

            
            return Ok("با موفقیت انجام شد");
        }
    }
}