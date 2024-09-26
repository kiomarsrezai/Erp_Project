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
using System.Linq;
using Microsoft.EntityFrameworkCore.Storage;
using NewsWebsite.Data.Models.AmlakPrivate;

namespace NewsWebsite.Areas.Api.Controllers.v1.amlak {
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class ContractAmlakPrivateApiController : EnhancedController {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public ContractAmlakPrivateApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment, ProgramBuddbContext db){
            _config = config;
            _uw = uw;
            _webHostEnvironment = webHostEnvironment;
            _db = db;
        }


        [HttpGet]
        [Route("all_polygon_amlak_472")]
        public async Task<IActionResult> UpdateDataFromSdi_ahvaz_kiosk(){
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

            var filePath = Path.Combine(_webHostEnvironment.WebRootPath, "amlak.json");
            string newmessage = await System.IO.File.ReadAllTextAsync(filePath);


            var respLayer = JsonConvert.DeserializeObject<SdiDto>(newmessage.ToString());

            for (int i = 0; i < respLayer.TotalFeatures; i++){
                var feature = respLayer.Features[i];

                var oldItem = await _db.AmlakPrivateNews.FirstOrDefaultAsync(a => a.SdiId == feature.Id);

                if (oldItem == null){
                    var item = new AmlakPrivateNew{
                        AreaId = feature.Properties.Mantaqe != null ? feature.Properties.Mantaqe.ToInt() : 52,
                        SdiId = feature.Id,
                        Coordinates = feature.Geometry == null ? "[]" : JsonConvert.SerializeObject(feature.Geometry.Coordinates[0]),
                        Masahat = 0,
                        PredictionUsage="",
                        Title = feature.Id,
                        TypeUsing = "",
                        DocumentType = 0,
                        SadaCode = feature.Properties.Pelaksabti,
                        CreatedAt = Helpers.GetServerDateTimeType(),
                        UpdatedAt = Helpers.GetServerDateTimeType(),
                    };
                    _db.Add(item);
                    await _db.SaveChangesAsync();
                }
                else{
                    oldItem.AreaId = feature.Properties.Mantaqe != null ? feature.Properties.Mantaqe.ToInt() : 52;
                    oldItem.Coordinates = feature.Geometry == null ? "[]" : JsonConvert.SerializeObject(feature.Geometry.Coordinates[0]);
                    oldItem.Title = feature.Id;
                    await _db.SaveChangesAsync();
                }
            }


            return Ok("موفق");
        }

        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------


        [Route("AmlakPrivate/List")]
        [HttpGet]
        public async Task<ApiResult<object>> AmlakPrivateList(AmlakPrivateReadInputVm param){
            await CheckUserAuth(_db);

            var builder = _db.AmlakPrivateNews
                .AreaId(param.AreaId).OwnerId(param.OwnerId).TypeUsing(param.TypeUsing)
                .SadaCode(param.SadaCode).SajamCode(param.SajamCode).DocumentType(param.DocumentType)
                .MasahatFrom(param.MasahatFrom).MasahatTo(param.MasahatTo)
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
                    .Page2(param.Page, param.PageRows);
            }
            var items=await builder.ToListAsync();


            
            if (param.Export == 1){
                var fileUrl = ExportExcel(items);
                return Ok(new {fileUrl});
            }
            
            var finalItems = MyMapper.MapTo<AmlakPrivateNew, AmlakPrivateListVm>(items);

            return Ok(new{items=finalItems,pageCount});
        }

        
          
        private static object ExportExcel(List<AmlakPrivateNew> items){
            var finalItems = new List<List<object>>();

            foreach (var item in items){
                var row = new List<object>();
                row.Add(item.Id);
                row.Add(item.Area.AreaName);
                row.Add(item.Owner.AreaName);
                row.Add(item.Title);
                row.Add(item.Masahat);
                row.Add(item.TypeUsing);
                row.Add(item.DocumentType);
                row.Add(item.SadaCode);
                row.Add(item.SajamCode);
                row.Add(item.SdiId);
                row.Add(item.Coordinates);
                row.Add(item.PredictionUsage);
                row.Add(item.CreatedAtFa);
                row.Add(item.UpdatedAtFa);
                
                finalItems.Add(row);
            }

            return Helpers.ExportExcelFile(finalItems, "amlak_private");
        }


        
        [Route("AmlakPrivate/Read")]
        [HttpGet]
        public async Task<ApiResult<AmlakPrivateReadVm>> AmlakPrivateRead(PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakPrivateNews.Id(param.Id)
                .Include(a=>a.Area)
                .Include(a=>a.Owner)
                .FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");
            
            var finalItem = MyMapper.MapTo<AmlakPrivateNew, AmlakPrivateReadVm>(item);

            return Ok(finalItem);
        }


        [Route("AmlakPrivate/Update")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakPrivateUpdate([FromBody] AmlakPrivateUpdateVm param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakPrivateNews.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest(new{ message = "یافت نشد" });

            
            item.AreaId = param.AreaId;
            item.OwnerId = param.OwnerId;
            item.Masahat = param.Masahat;
            item.PredictionUsage = param.PredictionUsage;
            item.Title = param.Title;
            item.TypeUsing = param.TypeUsing;
            item.DocumentType = param.DocumentType;
            item.SadaCode = param.SadaCode;
            item.SajamCode = param.SajamCode;
            item.UpdatedAt = Helpers.GetServerDateTimeType();
            await _db.SaveChangesAsync();

            return Ok(item.Id.ToString());
        }


        [Route("AmlakPrivate/Upload")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakPrivateUploadFile(AmlakPrivateFileUploadVm fileUpload){
            await CheckUserAuth(_db);

            if (fileUpload.AmlakPrivateId == null)
                return BadRequest(new{ message = "شناسه ملک نامعتبر می باشد" });


            string fileName = await UploadHelper.UploadFile(fileUpload.FormFile, "AmlakPrivates/" + fileUpload.AmlakPrivateId);
            if (fileName != ""){
                var item = new AmlakPrivateFile();
                item.AmlakPrivateId = fileUpload.AmlakPrivateId ?? 0;
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

        [Route("AmlakPrivate/Files")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakPrivateFilesListVm>>> AmlakPrivateAttachFiles(int AmlakPrivateId){
            await CheckUserAuth(_db);

            if (AmlakPrivateId == 0) BadRequest();

            var items = await _db.AmlakPrivateFiles.Where(a => a.AmlakPrivateId == AmlakPrivateId).ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakPrivateFile, AmlakPrivateFilesListVm>(items);


            foreach (var item in finalItems){
                item.FileName = "/Upload/AmlakPrivates/" +item.AmlakPrivateId+"/"+ item.FileName;
            }
            
            return Ok(finalItems);
        }
        
        
           
        [Route("AmlakPrivate/File/Edit")]
        [HttpPatch]
        public async Task<ApiResult<string>>AmlakPrivateAttachFileEdit(int fileId,string title){
            await CheckUserAuth(_db);

            if (fileId == 0) BadRequest();
        
            var item = await _db.AmlakPrivateFiles.Where(a => a.Id == fileId).FirstOrDefaultAsync();
            if (item == null)
                BadRequest("خطا");

            item.FileTitle = title;
            await _db.SaveChangesAsync();
            
            return Ok("انجام شد");
        }
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

        [Route("AmlakPrivateDocHistory/List")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakPrivateDocHistoryListVm>>> AmlakPrivateDocHistoryList(int amlakPrivateId){
            await CheckUserAuth(_db);

            var items = await _db.AmlakPrivateDocHistories.AmlakPrivateId(amlakPrivateId).OrderByDescending(a=>a.Id).ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakPrivateDocHistory, AmlakPrivateDocHistoryListVm>(items);

            return Ok(finalItems);
        }

        [Route("AmlakPrivateDocHistory/Store")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakPrivateDocHistoryStore( AmlakPrivateDocHistoryStoreVm param){
            await CheckUserAuth(_db);

            var item = new AmlakPrivateDocHistory();
            item.AmlakPrivateId = param.AmlakPrivateId;
            item.Status = param.Status;
            item.Desc = param.Desc;
            item.Date = Helpers.GetServerDateTimeType();
            _db.Add(item);
            await _db.SaveChangesAsync();

            return Ok("موفق");
        }

         
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

        [Route("AmlakPrivate/Report")]
        [HttpPost]
        public async Task<ApiResult<object>> AmlakPrivateReport( AmlakPrivateDocHistoryStoreVm param){
            await CheckUserAuth(_db);

            var areaStats = await _db.AmlakPrivateNews
                .GroupBy(x => x.AreaId)
                .Select(g => new 
                { 
                    Value = g.Key, 
                    Count = g.Count(),
                    Percentage = (double)g.Count() / _db.AmlakPrivateNews.Count() * 100
                })
                .ToListAsync();

            var ownerStats = await _db.AmlakPrivateNews
                .GroupBy(x => x.OwnerId)
                .Select(g => new 
                { 
                    Value = g.Key, 
                    Count = g.Count(),
                    Percentage = (double)g.Count() / _db.AmlakPrivateNews.Count() * 100
                })
                .ToListAsync();

            
            var documentTypeStats = await _db.AmlakPrivateNews
                .GroupBy(x => x.DocumentType)
                .Select(g => new 
                { 
                    Value = g.Key, 
                    Count = g.Count(),
                    Percentage = (double)g.Count() / _db.AmlakPrivateNews.Count() * 100
                })
                .ToListAsync();

            
            var usageStats = await _db.AmlakPrivateNews
                .GroupBy(x => x.PredictionUsage)
                .Select(g => new 
                { 
                    Value = g.Key, 
                    Count = g.Count(),
                    Percentage = (double)g.Count() / _db.AmlakPrivateNews.Count() * 100
                })
                .ToListAsync();


            return Ok(new{areaStats,ownerStats,documentTypeStats,usageStats});
        }


    }
}