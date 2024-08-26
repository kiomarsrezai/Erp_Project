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
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;

namespace NewsWebsite.Areas.Api.Controllers.v1 {
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class AmlakParcelApiController : ControllerBase {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public AmlakParcelApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment, ProgramBuddbContext db){
            _config = config;
            _uw = uw;
            _webHostEnvironment = webHostEnvironment;
            _db = db;
        }


        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------


        [Route("AmlakParcel/List")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakParcelListVm>>> AmlakParcelList(AmlakParcelReadInputVm param){
            var items = await _db.AmlakParcels.Type(param.Type).ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakParcel, AmlakParcelListVm>(items);

            return Ok(finalItems);
        }

        [Route("AmlakParcel/Read")]
        [HttpGet]
        public async Task<ApiResult<AmlakParcelReadVm>> AmlakParcelRead(PublicParamIdViewModel param){
            var item = await _db.AmlakParcels.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");
            
            var finalItem = MyMapper.MapTo<AmlakParcel, AmlakParcelReadVm>(item);

            
            finalItem.FileKrooki = "/Upload/AmlakParcels/" +finalItem.Id+"/"+ item.FileKrooki;
            finalItem.FileDWG = "/Upload/AmlakParcels/" +finalItem.Id+"/"+ item.FileDWG;

            
            return Ok(finalItem);
        }


        [Route("AmlakParcel/Store")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakParcelStore( AmlakParcelStoreVm param){
            if (!UploadHelper.CheckFileType(param.FileDWG, "dwg"))
                return BadRequest("پسوند فایل DWG نادرست می باشد");
            if (!UploadHelper.CheckFileType(param.FileKrooki,"jpg,jpeg,png,gif,bmp"))
                return BadRequest("فایل کروکی باید عکس باشد");
                
            var item = new AmlakParcel();
            item.Title = param.Title;
            item.Type = param.Type + "";
            item.Status = "Pending";
            item.Comment = "";
            _db.Add(item);
            await _db.SaveChangesAsync();

            item.FileDWG = await UploadHelper.UploadFile(param.FileDWG, "AmlakParcels/" + item.Id,"dwg");
            item.FileKrooki= await UploadHelper.UploadFile(param.FileKrooki, "AmlakParcels/" + item.Id);
            await _db.SaveChangesAsync();
            
            return Ok("با موفقیت انجام شد");
        }

        
        [Route("AmlakParcel/Update")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakParcelUpdate( AmlakParcelUpdateVm param){
            
            if (param.FileDWG!=null && !UploadHelper.CheckFileType(param.FileDWG, "dwg"))
                return BadRequest("پسوند فایل DWG نادرست می باشد");
            
            if (param.FileKrooki!=null && !UploadHelper.CheckFileType(param.FileKrooki,"jpg,jpeg,png,gif,bmp"))
                return BadRequest("فایل کروکی باید عکس باشد");
            
            var item = await _db.AmlakParcels.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");

            item.Title = param.Title;
            item.Type = param.Type + "";
            item.Status = "Pending";
            item.Comment = item.Comment+ "\n"+param.Comment;

            if (param.FileDWG != null){
                var oldFile = item.FileDWG;
                item.FileDWG = await UploadHelper.UploadFile(param.FileDWG, "AmlakParcels/" + item.Id,"dwg");
                UploadHelper.DeleteFile(oldFile, "AmlakParcels/"+item.Id);
            }
            if (param.FileKrooki != null){
                var oldFile = item.FileKrooki;
                item.FileKrooki = await UploadHelper.UploadFile(param.FileKrooki, "AmlakParcels/" + item.Id);
                UploadHelper.DeleteFile(oldFile, "AmlakParcels/"+item.Id);
            }
            await _db.SaveChangesAsync();

            return Ok("با موفقیت انجام شد");
        }
        
        [Route("AmlakParcel/Status")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakParcelUpdateStatus( AmlakParcelUpdateStatusVm param){
            
            var item = await _db.AmlakParcels.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");

            item.Status = param.Status;
            item.Comment = item.Comment+"\n"+param.Comment;
            await _db.SaveChangesAsync();

            return Ok("با موفقیت انجام شد");
        }
        
        
    }
}