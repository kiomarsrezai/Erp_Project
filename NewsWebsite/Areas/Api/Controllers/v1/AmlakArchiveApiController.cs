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
using NewsWebsite.ViewModels.Api.Contract.AmlakArchive;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;

namespace NewsWebsite.Areas.Api.Controllers.v1 {
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


        [Route("AmlakArchive/List")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakArchiveListVm>>> AmlakArchiveList(AmlakArchiveReadInputVm param){
            await CheckUserAuth(_db);

            var items = await _db.AmlakArchives
                .ArchiveCode(param.ArchiveCode)
                .AmlakCode(param.AmlakCode)
                .JamCode(param.JamCode)
                .AreaCode(param.AreaCode)
                .ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakArchive, AmlakArchiveListVm>(items);
        
            return Ok(finalItems);
        }
        
        [Route("AmlakArchive/Read")]
        [HttpGet]
        public async Task<ApiResult<AmlakArchiveReadVm>> AmlakArchiveRead(PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakArchives.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");
            
            var finalItem = MyMapper.MapTo<AmlakArchive, AmlakArchiveReadVm>(item);
        
            return Ok(finalItem);
        }
        
        
        [Route("AmlakArchive/Store")]
        [HttpPost]
        public async Task<ApiResult<AmlakArchiveStoreResultVm>> AmlakArchiveUpdate([FromBody] AmlakArchiveStoreVm param){
            await CheckUserAuth(_db);

            var item = new AmlakArchive();
        
            item.ArchiveCode = param.ArchiveCode;
            item.AmlakCode = param.AmlakCode;
            item.JamCode = param.JamCode;
            item.AreaCode = param.AreaCode;
            item.Section = param.Section;
            item.Plaque1 = param.Plaque1;
            item.Plaque2 = param.Plaque2;
            item.Owner = param.Owner;
            item.Description = param.Description;
            item.Address = param.Address;
            item.Latitude = param.Latitude;
            item.Longitude = param.Longitude;
            _db.Add(item);
            await _db.SaveChangesAsync();

            var result = new AmlakArchiveStoreResultVm();
            result.Id = item.Id;
            result.Message = "با موفقیت انجام شد";
            return Ok(result);
        }
        
        
        [Route("AmlakArchive/Update")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakArchiveUpdate([FromBody] AmlakArchiveUpdateVm param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakArchives.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");

            item.ArchiveCode = param.ArchiveCode;
            item.AmlakCode = param.AmlakCode;
            item.JamCode = param.JamCode;
            item.AreaCode = param.AreaCode;
            item.Section = param.Section;
            item.Plaque1 = param.Plaque1;
            item.Plaque2 = param.Plaque2;
            item.Owner = param.Owner;
            item.Description = param.Description;
            item.Address = param.Address;
            item.Latitude = param.Latitude;
            item.Longitude = param.Longitude;
            await _db.SaveChangesAsync();
        
            return Ok("با موفقیت انجام شد");
        }
        
        
        [Route("AmlakArchive/Upload")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakArchiveUploadFile(AmlakArchiveFileUploadVm fileUpload){
            await CheckUserAuth(_db);

            if (fileUpload.AmlakArchiveId == null)
                return BadRequest(new{ message = "شناسه ملک نامعتبر می باشد" });
        
        
            string fileName = await UploadHelper.UploadFile(fileUpload.FormFile, "AmlakArchives/" + fileUpload.AmlakArchiveId);
            if (fileName != ""){
                var item = new AmlakArchiveFile();
                item.AmlakArchiveId = fileUpload.AmlakArchiveId ?? 0;
                item.FileName = fileName;
                item.FileTitle = fileUpload.FileTitle;
                item.Type = fileUpload.Type;
                // return Helpers.dd(fileUpload.FileTitle);
                _db.Add(item);
                await _db.SaveChangesAsync();
            }
            else{
                return BadRequest(new{ message = "فایل نامعتبر می باشد" });
            }
        
            return Ok("موفق");
        }
        
        
        [Route("AmlakArchive/Files")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakArchiveFilesListVm>>> AmlakArchiveAttachFiles(int AmlakArchiveId){
            await CheckUserAuth(_db);

            if (AmlakArchiveId == 0) BadRequest();
        
            var items = await _db.AmlakArchiveFiles.Where(a => a.AmlakArchiveId == AmlakArchiveId).ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakArchiveFile, AmlakArchiveFilesListVm>(items);
        
        
            foreach (var item in finalItems){
                item.FileName = "/Upload/AmlakArchives/" +item.AmlakArchiveId+"/"+ item.FileName;
            }
            
            return Ok(finalItems);
        }
        
        [Route("AmlakArchive/File/Edit")]
        [HttpPatch]
        public async Task<ApiResult<string>> AmlakArchiveAttachFileEdit(int amlakArchiveFileId,string title){
            await CheckUserAuth(_db);

            if (amlakArchiveFileId == 0) BadRequest();
        
            var item = await _db.AmlakArchiveFiles.Where(a => a.Id == amlakArchiveFileId).FirstOrDefaultAsync();
            if (item == null)
                BadRequest("خطا");

            item.FileTitle = title;
            await _db.SaveChangesAsync();
            
            return Ok("انجام شد");
        }
    }
}