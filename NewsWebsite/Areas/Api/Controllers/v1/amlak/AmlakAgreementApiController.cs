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
using NewsWebsite.Data.Models.AmlakAgreement;
using NewsWebsite.ViewModels.Api.Contract.AmlakAgreement;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;

namespace NewsWebsite.Areas.Api.Controllers.v1.amlak {
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class AmlakAgreementApiController : EnhancedController {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public AmlakAgreementApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment, ProgramBuddbContext db){
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
        public async Task<IActionResult> UpdateDataFromSdiAgreement(){
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

            var filePath = Path.Combine(_webHostEnvironment.WebRootPath, "Agreement.json");
            string newmessage = await System.IO.File.ReadAllTextAsync(filePath);


            var respLayer = JsonConvert.DeserializeObject<SdiDto>(newmessage.ToString());

            for (int i = 0; i < respLayer.TotalFeatures-1; i++){
                var feature = respLayer.Features[i];
                var oldItem = await _db.AmlakAgreements.FirstOrDefaultAsync(a => a.SdiId == feature.Id);

                if (oldItem == null){
                    var item = new AmlakAgreement(){
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
        public async Task<ApiResult<object>> AmlakAgreementList(AmlakAgreementReadInputVm param){
            await CheckUserAuth(_db);

            var builder = _db.AmlakAgreements
                .ContractParty(param.ContractParty)
                .Search(param.Search);

            var pageCount = (int)Math.Ceiling((await builder.IsSubmitted(1).CountAsync())/Convert.ToDouble(param.PageRows));
            
            
            if (param.Export == 1){
                param.Page = 1;
                param.PageRows = 100000;
            }
            if (param.ForMap == 0){
                builder = builder
                    .IsSubmitted(1)
                    .OrderBy(param.Sort,param.SortType)
                    .Page2(param.Page, param.PageRows);
            }
            var items = await builder.ToListAsync();
            
             
            if (param.Export == 1){
                var fileUrl = ExportExcel(items);
                return Ok(new {fileUrl});
            }
            
            var finalItems = MyMapper.MapTo<AmlakAgreement, AmlakAgreementListVm>(items);
        
            return Ok(new{items=finalItems,pageCount});
        }
        
        
          
        private static object ExportExcel(List<AmlakAgreement> items){
            var finalItems = new List<List<object>>();

            foreach (var item in items){
                var row = new List<object>();
                row.Add(item.Id);
                row.Add(item.SdiId);
                row.Add(item.IsSubmitted);
                row.Add(item.Title);
                row.Add(item.DateFa);
                row.Add(item.ContractParty);
                row.Add(item.AmountMunicipality);
                row.Add(item.AmountContractParty);
                row.Add(item.DateFromFa);
                row.Add(item.DateToFa);
                row.Add(item.Description);
                row.Add(item.Coordinates);
                row.Add(item.Address);
                row.Add(item.CreatedAtFa);
                row.Add(item.UpdatedAtFa);
                finalItems.Add(row);
            }

            return Helpers.ExportExcelFile(finalItems, "amlak_Agreement");
        }


        
        [Route("Read")]
        [HttpGet]
        public async Task<ApiResult<AmlakAgreementReadVm>> AmlakAgreementRead(PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakAgreements.Id(param.Id)
                .FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");
            
            var finalItem = MyMapper.MapTo<AmlakAgreement, AmlakAgreementReadVm>(item);
        
            return Ok(finalItem);
        }
        
        
        
        [Route("Update")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakAgreementUpdate([FromBody] AmlakAgreementUpdateVm param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakAgreements.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");

            item.Title = param.Title;
            item.Date = DateTime.Parse(param.Date);
            item.ContractParty = param.ContractParty;
            item.AmountMunicipality = param.AmountMunicipality;
            item.AmountContractParty = param.AmountContractParty;
            item.DateFrom = !string.IsNullOrEmpty(param.DateFrom) ? DateTime.Parse(param.DateFrom) : (DateTime?)null;
            item.DateTo = !string.IsNullOrEmpty(param.DateTo) ? DateTime.Parse(param.DateTo) : (DateTime?)null;
            item.Description = param.Description;
            item.Address = param.Description;
            item.IsSubmitted = 1;
            item.UpdatedAt = Helpers.GetServerDateTimeType();
            await _db.SaveChangesAsync();
        
            return Ok("با موفقیت انجام شد");
        }
        
        
        [Route("Upload")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakAgreementUploadFile(AmlakAgreementFileUploadVm fileUpload){
            await CheckUserAuth(_db);

            if (fileUpload.AmlakAgreementId == null)
                return BadRequest(new{ message = "شناسه ملک نامعتبر می باشد" });
        
        
            string fileName = await UploadHelper.UploadFile(fileUpload.FormFile, "AmlakAgreements/" + fileUpload.AmlakAgreementId);
            if (fileName != ""){
                var item = new AmlakAgreementFile();
                item.AmlakAgreementId = fileUpload.AmlakAgreementId ?? 0;
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
        public async Task<ApiResult<List<AmlakAgreementFilesListVm>>> AmlakAgreementAttachFiles(int amlakAgreementId){
            await CheckUserAuth(_db);

            if (amlakAgreementId == 0) BadRequest();
        
            var items = await _db.AmlakAgreementFiles.Where(a => a.AmlakAgreementId == amlakAgreementId).ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakAgreementFile, AmlakAgreementFilesListVm>(items);
        
        
            foreach (var item in finalItems){
                item.FileName = "/Upload/AmlakAgreements/" +item.AmlakAgreementId+"/"+ item.FileName;
            }
            
            return Ok(finalItems);
        }
        
        [Route("File/Edit")]
        [HttpPatch]
        public async Task<ApiResult<string>> AmlakAgreementAttachFileEdit(int amlakAgreementFileId,string title){
            await CheckUserAuth(_db);

            if (amlakAgreementFileId == 0) BadRequest();
        
            var item = await _db.AmlakAgreementFiles.Where(a => a.Id == amlakAgreementFileId).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("خطا");

            item.FileTitle = title;
            await _db.SaveChangesAsync();
            
            return Ok("انجام شد");
        }
    }
}