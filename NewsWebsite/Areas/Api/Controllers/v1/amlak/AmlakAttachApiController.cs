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
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Data;
using NewsWebsite.ViewModels;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using System.Linq;
using NewsWebsite.ViewModels.Api.Contract.amlakAttachs;

namespace NewsWebsite.Areas.Api.Controllers.v1.amlak {
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class AmlakAttachApiController : EnhancedController {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public AmlakAttachApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment, ProgramBuddbContext db){
            _config = config;
            _uw = uw;
            _webHostEnvironment = webHostEnvironment;
            _db = db;
        }


        [Route("Upload")]
        [HttpPost]
        public async Task<ApiResult<string>> UploadFile(AmlakAttachUploadVm fileUpload){
            await CheckUserAuth(_db);

            if (fileUpload.TargetId == null || fileUpload.TargetType == null)
                return BadRequest(new{ message = "شناسه ملک نامعتبر می باشد" });
 
            // todo:check existing in DB

            string fileName = await UploadHelper.UploadFile(fileUpload.FormFile, fileUpload.TargetType+"/" + fileUpload.TargetId);
            if (fileName != ""){
                var item = new AmlakAttach();
                item.TargetType = fileUpload.TargetType;
                item.TargetId = fileUpload.TargetId ?? 0;
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

        [Route("Files")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakAttachsListVm>>> ListFiles(int targetId,string targetType,string? type=null){
            await CheckUserAuth(_db);

            if (targetId == 0 || targetType == null)
                return BadRequest(new{ message = "شناسه ملک نامعتبر می باشد" });


            var items = await _db.AmlakAttachs
                .Where(a => a.TargetType == targetType)
                .Where(a => a.TargetId == targetId)
                .Type(type)
                .ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakAttach, AmlakAttachsListVm>(items);


            foreach (var item in finalItems){
                item.FileName = "/Upload/"+targetType+"/" +targetId+"/"+ item.FileName;
            }
            
            return Ok(finalItems);
        }
        
        
           
        [Route("File/Edit")]
        [HttpPatch]
        public async Task<ApiResult<string>>EditFile(int fileId,string title){
            await CheckUserAuth(_db);

            if (fileId == 0) BadRequest();
        
            var item = await _db.AmlakAttachs.Where(a => a.Id == fileId).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("خطا");

            item.FileTitle = title;
            await _db.SaveChangesAsync();
            
            return Ok("انجام شد");
        }

           
        [Route("File/Delete")]
        [HttpDelete]
        public async Task<ApiResult<string>>EditDelete(int fileId){
            await CheckUserAuth(_db);

            if (fileId == 0) BadRequest();
        
            var item = await _db.AmlakAttachs.Where(a => a.Id == fileId).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("خطا");

            UploadHelper.DeleteFile(item.FileName, item.TargetType + "/" + item.TargetId);
            _db.Remove(item);
            await _db.SaveChangesAsync();
            
            return Ok("انجام شد");
        }

    }
}