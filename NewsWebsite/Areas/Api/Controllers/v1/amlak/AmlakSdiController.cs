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
using System.Text;
using NewsWebsite.Data.Models.AmlakAgreement;
using NewsWebsite.Data.Models.AmlakArchive;
using NewsWebsite.Data.Models.AmlakPrivate;
using NewsWebsite.ViewModels.Api.Contract.AmlakAgreement;
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;

namespace NewsWebsite.Areas.Api.Controllers.v1.amlak {
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class AmlakSdiController : EnhancedController {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public AmlakSdiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment, ProgramBuddbContext db){
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
        public async Task<IActionResult> UpdateDataFromSdiAgreement(string type){
            await ConnectSdi();

            switch (type){
                case "private":
                    await UpdatePrivate();
                    break;
                case "rentableAmlak":
                    break;
                case "notRentableAmlak":
                    break;
                case "archive":
                    await UpdateArchive();
                    break;
                case "agreement":
                    await UpdateAgreements();
                    break;
            }


            return Ok("موفق");
        }


        private async Task<string> ConnectSdi(){
            var options = new RestClientOptions("https://sdi.ahvaz.ir"){
                MaxTimeout = -1,
            };
            var client = new RestClient(options);
            var request = new RestRequest("/geoapi/user/login/", Method.Post);
            request.AddHeader("content-type", "application/json");
            request.AddHeader("Accept", "application/json, text/plain, */*");
            request.AddHeader("Cookie", "cookiesession1=678ADA629490114186F01A0EF409171D; csrftoken=dKwYwwwT5wcj60bhh4ojKy1R4JQrdxD7; sessionid=bsj9qwbunhlpl7bymk7o9uy3x6cr9ubg");
            var body = @"{" + "\n" +
                       @" ""username"": ""ERP_Fava""," + "\n" +
                       @" ""password"":" + "\n" +
                       @"""123456""," + "\n" +
                       @" ""appId"": ""mobilegis""" + "\n" +
                       @"}";
            request.AddStringBody(body, DataFormat.Json);
            RestResponse responselogin = await client.ExecuteAsync(request);
            var resplogin = JsonConvert.DeserializeObject<ResponseLoginSdiDto>(responselogin.Content.ToString());

            //var options2 = new RestClientOptions("https://sdi.ahvaz.ir")
            //{
            //    MaxTimeout = -1,
            //};
            //var client2 = new RestClient(options2);
            //var request2 = new RestRequest("/geoserver/ows?service=wfs&version=1.0.0&request=GetFeature&typeName=ahvaz_kiosk14000719_8798&srsname=EPSG:4326&outputFormat=application/json&maxFeatures=10000&startIndex=0&authkey="+ resplogin.api_key.ToString(), Method.Get);
            //request.AddHeader("content-type", "application/json");
            //request.AddHeader("Accept", "application/json, text/plain, */*");
            //request.AddHeader("Cookie", "cookiesession1=678ADA629490114186F01A0EF409171D; csrftoken=dKwYwwwT5wcj60bhh4ojKy1R4JQrdxD7; sessionid=bsj9qwbunhlpl7bymk7o9uy3x6cr9ubg");
            //RestResponse response2 = await client2.ExecuteAsync(request2);
            ////UTF8Encoding uTF8Encoding = new UTF8Encoding();
            ////uTF8Encoding.GetBytes(response2.Content.ToString());
            //byte[] messageBytes = Encoding.UTF8.GetBytes(response2.Content);
            //string newmessage = Encoding.UTF8.GetString(messageBytes, 0, messageBytes.Length);
            var options2 = new RestClientOptions("https://sdi.ahvaz.ir"){
                MaxTimeout = -1,
            };
            var client2 = new RestClient(options2);
            var request2 = new RestRequest(
                "/geoserver/ows?service=wfs&version=1.0.0&request=GetFeature&typeName=all_polygon_amlak_472&srsname=EPSG:4326&outputFormat=application/json&maxFeatures=10000&startIndex=0&authkey=e434be85d126299659334f104feffb18f51328a6",
                Method.Post);
            request2.AddHeader("content-type", "application/json");
            request2.AddHeader("Accept", "application/json, text/plain, */*");
            request2.AddHeader("Cookie", "cookiesession1=678ADA629490114186F01A0EF409171D; csrftoken=dKwYwwwT5wcj60bhh4ojKy1R4JQrdxD7; sessionid=bsj9qwbunhlpl7bymk7o9uy3x6cr9ubg");
            RestResponse response2 = await client2.ExecuteAsync(request2);
            byte[] messageBytes = Encoding.UTF8.GetBytes(response2.Content);
            string newmessage = Encoding.UTF8.GetString(messageBytes, 0, messageBytes.Length);

            return newmessage;
        }

        private async Task UpdatePrivate(){
            var filePath = Path.Combine(_webHostEnvironment.WebRootPath, "amlak.json");
            string newmessage = await System.IO.File.ReadAllTextAsync(filePath);


            var respLayer = JsonConvert.DeserializeObject<SdiDto>(newmessage.ToString());

            for (int i = 0; i < respLayer.TotalFeatures; i++){
                var feature = respLayer.Features[i];

                var oldItem = await _db.AmlakPrivateNews.FirstOrDefaultAsync(a => a.SdiId == feature.Id);

                if (oldItem == null){
                    var item = new AmlakPrivateNew{
                        AreaId = feature.Properties.Mantaqe != null ? feature.Properties.Mantaqe.ToInt() : 52,
                        OwnerId = 9, // شهرداری مرکز
                        SdiId = feature.Id,
                        Coordinates = feature.Geometry == null ? "[]" : JsonConvert.SerializeObject(feature.Geometry.Coordinates[0]),
                        SdiPlateNumber = feature.Properties.Pelaksabti,
                        Masahat = 0,
                        PredictionUsage = "",
                        Title = feature.Id,
                        DocumentType = 0,
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
        }

        private async Task UpdateArchive(){
            var filePath = Path.Combine(_webHostEnvironment.WebRootPath, "archive.json");
            string newmessage = await System.IO.File.ReadAllTextAsync(filePath);


            var respLayer = JsonConvert.DeserializeObject<SdiDto>(newmessage.ToString());

            for (int i = 0; i < respLayer.TotalFeatures - 1; i++){
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

                    await SaveLogAsync(_db, item.Id, TargetTypes.Archive, "آرشیو ثبت شد.");
                }
                else{
                    oldItem.Coordinates = feature.Geometry == null ? "[]" : JsonConvert.SerializeObject(feature.Geometry.Coordinates[0]);
                    await _db.SaveChangesAsync();
                }
            }
        }

        private async Task UpdateAgreements(){
            var filePath = Path.Combine(_webHostEnvironment.WebRootPath, "Agreement.json");
            string newmessage = await System.IO.File.ReadAllTextAsync(filePath);


            var respLayer = JsonConvert.DeserializeObject<SdiDto>(newmessage.ToString());

            for (int i = 0; i < respLayer.TotalFeatures - 1; i++){
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

                    await SaveLogAsync(_db, item.Id, TargetTypes.Agreement, "توافق ویرایش شد.");
                }
                else{
                    oldItem.Coordinates = feature.Geometry == null ? "[]" : JsonConvert.SerializeObject(feature.Geometry.Coordinates[0]);
                    await _db.SaveChangesAsync();
                }
            }
        }
    }
}