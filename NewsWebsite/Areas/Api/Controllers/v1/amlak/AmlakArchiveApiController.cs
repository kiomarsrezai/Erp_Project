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

        [HttpGet]
        [Route("updateFromSdi")]
        public async Task<IActionResult> UpdateDataFromSdiArchive(){
            // var options = new RestClientOptions("https://sdi.ahvaz.ir")
            // {
            //     MaxTimeout = -1,
            // };
            // var client = new RestClient(options);
            // var request = new RestRequest("/geoapi/user/login/", Method.Post);
            // request.AddHeader("content-type", "application/json");
            // request.AddHeader("Accept", "application/json, text/plain, */*");
            // request.AddHeader("Cookie", "cookiesession1=678ADA629490114186F01A0EF409171D; csrftoken=dKwYwwwT5wcj60bhh4ojKy1R4JQrdxD7; sessionid=bsj9qwbunhlpl7bymk7o9uy3x6cr9ubg");
            // var body = @"{" + "\n" +
            // @" ""username"": ""ERP_Fava""," + "\n" +
            // @" ""password"":" + "\n" +
            // @"""123456""," + "\n" +
            // @" ""appId"": ""mobilegis""" + "\n" +
            // @"}";
            // request.AddStringBody(body, DataFormat.Json);
            // RestResponse responselogin = await client.ExecuteAsync(request);
            // var resplogin = JsonConvert.DeserializeObject<ResponseLoginSdiDto>(responselogin.Content.ToString());
            //
            // //var options2 = new RestClientOptions("https://sdi.ahvaz.ir")
            // //{
            // //    MaxTimeout = -1,
            // //};
            // //var client2 = new RestClient(options2);
            // //var request2 = new RestRequest("/geoserver/ows?service=wfs&version=1.0.0&request=GetFeature&typeName=ahvaz_kiosk14000719_8798&srsname=EPSG:4326&outputFormat=application/json&maxFeatures=10000&startIndex=0&authkey="+ resplogin.api_key.ToString(), Method.Get);
            // //request.AddHeader("content-type", "application/json");
            // //request.AddHeader("Accept", "application/json, text/plain, */*");
            // //request.AddHeader("Cookie", "cookiesession1=678ADA629490114186F01A0EF409171D; csrftoken=dKwYwwwT5wcj60bhh4ojKy1R4JQrdxD7; sessionid=bsj9qwbunhlpl7bymk7o9uy3x6cr9ubg");
            // //RestResponse response2 = await client2.ExecuteAsync(request2);
            // ////UTF8Encoding uTF8Encoding = new UTF8Encoding();
            // ////uTF8Encoding.GetBytes(response2.Content.ToString());
            // //byte[] messageBytes = Encoding.UTF8.GetBytes(response2.Content);
            // //string newmessage = Encoding.UTF8.GetString(messageBytes, 0, messageBytes.Length);
            // var options2 = new RestClientOptions("https://sdi.ahvaz.ir")
            // {
            //     MaxTimeout = -1,
            // };
            // var client2 = new RestClient(options2);
            // var request2 = new RestRequest("/geoserver/ows?service=wfs&version=1.0.0&request=GetFeature&typeName=all_polygon_amlak_472&srsname=EPSG:4326&outputFormat=application/json&maxFeatures=10000&startIndex=0&authkey=e434be85d126299659334f104feffb18f51328a6", Method.Post);
            // request2.AddHeader("content-type", "application/json");
            // request2.AddHeader("Accept", "application/json, text/plain, */*");
            // request2.AddHeader("Cookie", "cookiesession1=678ADA629490114186F01A0EF409171D; csrftoken=dKwYwwwT5wcj60bhh4ojKy1R4JQrdxD7; sessionid=bsj9qwbunhlpl7bymk7o9uy3x6cr9ubg");
            // RestResponse response2 = await client2.ExecuteAsync(request2);
            // byte[] messageBytes = Encoding.UTF8.GetBytes(response2.Content);
            // string newmessage = Encoding.UTF8.GetString(messageBytes, 0, messageBytes.Length);

            var filePath = Path.Combine(_webHostEnvironment.WebRootPath, "archive.json");
            string newmessage = await System.IO.File.ReadAllTextAsync(filePath);


            var respLayer = JsonConvert.DeserializeObject<SdiDto>(newmessage.ToString());

            for (int i = 0; i < respLayer.TotalFeatures-1; i++){
                var feature = respLayer.Features[i];

                var oldItem = await _db.AmlakArchives.FirstOrDefaultAsync(a => a.SdiId == feature.Id);

                if (oldItem == null){
                    var item = new AmlakArchive(){
                        AreaId = feature.Properties.Mantaqe != null ? feature.Properties.Mantaqe.ToInt() : 52,
                        SdiId = feature.Id,
                        Coordinates = feature.Geometry == null ? "[]" : JsonConvert.SerializeObject(feature.Geometry.Coordinates[0]),
                        IsSubmitted = 0,
                        CreatedAt = Helpers.GetServerDateTimeType(),
                        UpdatedAt = Helpers.GetServerDateTimeType(),
                    };
                    _db.Add(item);
                    await _db.SaveChangesAsync();
                }
                else{
                    oldItem.Coordinates = feature.Geometry == null ? "[]" : JsonConvert.SerializeObject(feature.Geometry.Coordinates[0]);
                    await _db.SaveChangesAsync();
                }
            }


            return Ok("موفق");
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
                row.Add(item.Plaque1);
                row.Add(item.Plaque2);
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
            item.Plaque1 = param.Plaque1;
            item.Plaque2 = param.Plaque2;
            item.Description = param.Description;
            item.Address = param.Address;
            item.IsSubmitted = 1;
            item.UpdatedAt = Helpers.GetServerDateTimeType();
            await _db.SaveChangesAsync();
        
            return Ok("با موفقیت انجام شد");
        }
        
        
        [Route("Upload")]
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
        
        
        [Route("Files")]
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
        
        [Route("File/Edit")]
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