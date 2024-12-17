using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.FileProviders;
using NewsWebsite.Common;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using Newtonsoft.Json;
using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Data;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using NewsWebsite.Data.Models.AmlakAgreement;
using NewsWebsite.Data.Models.AmlakArchive;
using NewsWebsite.Data.Models.AmlakInfo;
using NewsWebsite.Data.Models.AmlakPrivate;
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using Newtonsoft.Json.Linq;

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
        public async Task<IActionResult> UpdateDataFromSdiAgreement(string type,int fromFile=0){
            switch (type){
                case "token":
                    return Ok(await GetToken());
                
                case "private":
                    return await UpdatePrivate(fromFile);
                
                case "rentableAmlak":
                    return await UpdateKiosk(fromFile);
                
                case "notRentableAmlak":
                    break;
                
                case "archive":
                    return await UpdateArchive(fromFile);
                
                case "agreement":
                    return await UpdateAgreements(fromFile);
            }


            return Ok("موفق");
        }

        // ------------------------------------------------------------------------------------------------------------------------------------------
        // ------------------------------------------------------------------------------------------------------------------------------------------

        private async Task<string> GetToken(){
            HttpClient httpClient = GetClientHttp();
            var requestUri = "geoapi/user/login/";

            var loginData = new{
                username = "ERP_Fava",
                password = "123456",
                appId = "mobilegis"
            };

            var jsonData = JsonConvert.SerializeObject(loginData);
            var content = new StringContent(jsonData, Encoding.UTF8, "application/json");

            var response = await httpClient.PostAsync(requestUri, content);
            if (response.IsSuccessStatusCode){
                var responseContent = await response.Content.ReadAsStringAsync();

                // Parse the JSON response and return the api_key
                var responseJson = JObject.Parse(responseContent);
                return responseJson["api_key"]?.ToString();
            }

            return null;
        }


        private HttpClient GetClientHttp(){
            HttpClient _httpClient = new HttpClient();

            _httpClient.BaseAddress = new Uri("https://sdi.ahvaz.ir/");
            _httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            _httpClient.DefaultRequestHeaders.Add("User-Agent", "HttpClient/1.0");
            return _httpClient;
        }

        // ------------------------------------------------------------------------------------------------------------------------------------------
        // ------------------------------------------------------------------------------------------------------------------------------------------


        private async Task<IActionResult> UpdatePrivate(int fromFile){
            // from File
            string newmessage = "";
            if (fromFile == 1){
                var filePath = Path.Combine(_webHostEnvironment.WebRootPath, "amlak.json");
                newmessage = await System.IO.File.ReadAllTextAsync(filePath);
            }
            else{
                string authKey = await GetToken();
                HttpClient httpClient = GetClientHttp();

                var requestUri =$"geoserver/ows?service=wfs&version=1.0.0&request=GetFeature&typeName=all_amlak_v14030910_4498&srsname=EPSG:4326&outputFormat=application/json&maxFeatures=50000&startIndex=0&authkey={authKey}";
                var response = await httpClient.GetAsync(requestUri);

                if (!response.IsSuccessStatusCode)
                    return BadRequest($"Error: {response.StatusCode} / {authKey}");

                newmessage = await response.Content.ReadAsStringAsync();
            }

            // from API
            
            var respLayer = JsonConvert.DeserializeObject<SdiDto>(newmessage.ToString());

            for (int i = 0; i < respLayer.TotalFeatures; i++){
                var feature = respLayer.Features[i];

                var mainPlateNumber = 0;
                var subPlateNumber = 0;
                var area = 0.0;
                if (feature.Properties.pelak_sabt != null){
                    var plaks = feature.Properties.pelak_sabt.Split("/");
                    try{
                        if (plaks.Length > 0){
                            mainPlateNumber = int.Parse(plaks.GetValue(0).ToString());
                        }
                    }
                    catch (Exception e){
                    }

                    try{
                        if (plaks.Length > 1){
                            subPlateNumber = int.Parse(plaks.GetValue(1).ToString());
                        }
                    }
                    catch (Exception e){
                    }
                }

                if (feature.Properties.shape_area != null){
                    area = (double)feature.Properties.shape_area;
                }

                
                var oldItem = await _db.AmlakPrivateNews.FirstOrDefaultAsync(a => a.MainPlateNumber == mainPlateNumber.ToString() && a.SubPlateNumber==subPlateNumber.ToString());

                if (oldItem == null){
                    var item = new AmlakPrivateNew{
                        AreaId = 52,
                        OwnerId = 9, // شهرداری اهواز
                        SdiId = feature.Id,
                        Coordinates = feature.Geometry == null ? "[]" : JsonConvert.SerializeObject(feature.Geometry.Coordinates[0]),
                        SdiPlateNumber = feature.Properties.pelak_sabt,
                        MainPlateNumber = mainPlateNumber.ToString(),
                        SubPlateNumber = subPlateNumber.ToString(),
                        Masahat = area,
                        Title = feature.Id,
                        CreatedAt = Helpers.GetServerDateTimeType(),
                        UpdatedAt = Helpers.GetServerDateTimeType(),
                    };
                    _db.Add(item);
                    await _db.SaveChangesAsync();
                }
                else{
                    oldItem.Coordinates = feature.Geometry == null ? "[]" : JsonConvert.SerializeObject(feature.Geometry.Coordinates[0]);
                    oldItem.SdiPlateNumber = feature.Properties.pelak_sabt;
                    oldItem.SdiId = feature.Id;
                    await _db.SaveChangesAsync();
                }
            }

            return Ok("ok");
        }
        
        // ------------------------------------------------------------------------------------------------------------------------------------------
        // ------------------------------------------------------------------------------------------------------------------------------------------

        private async Task<IActionResult> UpdateArchive(int fromFile){
            string newmessage="";
            if (fromFile == 1){
                var filePath = Path.Combine(_webHostEnvironment.WebRootPath, "archive.json");
                newmessage = await System.IO.File.ReadAllTextAsync(filePath);

            }
            else{
                
            }

            var respLayer = JsonConvert.DeserializeObject<SdiDto>(newmessage.ToString());

            for (int i = 0; i < respLayer.TotalFeatures; i++){
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
            return Ok("ok");

        }

        // ------------------------------------------------------------------------------------------------------------------------------------------
        // ------------------------------------------------------------------------------------------------------------------------------------------

        private async Task<IActionResult> UpdateAgreements(int fromFile){
            // From File
            string newmessage = "";
            if (fromFile==1){
                var filePath = Path.Combine(_webHostEnvironment.WebRootPath, "Agreement.json");
                newmessage = await System.IO.File.ReadAllTextAsync(filePath);
            }
            else{
                // From API
                string authKey = await GetToken();
                HttpClient httpClient = GetClientHttp();

                var requestUri =$"geoserver/ows?service=wfs&version=1.0.0&request=GetFeature&typeName=tavafoqat1_963&srsname=EPSG:4326&outputFormat=application/json&maxFeatures=50000&startIndex=0&authkey={authKey}";
                var response = await httpClient.GetAsync(requestUri);

                if (!response.IsSuccessStatusCode)
                    return BadRequest($"Error: {response.StatusCode} / {authKey}");

                newmessage = await response.Content.ReadAsStringAsync();

            }
                var respLayer = JsonConvert.DeserializeObject<SdiDto>(newmessage.ToString());


            for (int i = 0; i < respLayer.TotalFeatures; i++){
                var feature = respLayer.Features[i];
                var oldItem = await _db.AmlakAgreements.FirstOrDefaultAsync(a => a.SdiId == feature.Id);

                var mainPlateNumber = 0;
                var subPlateNumber = 0;
                if (feature.Properties.pelak_sabt != null){
                    var plaks = feature.Properties.pelak_sabt.Split("/");
                    try{

                        if (plaks.Length > 0){
                            mainPlateNumber = int.Parse(plaks.GetValue(0).ToString());
                        }
                    }catch (Exception e){
                        
                    }
                    try{
                        if (plaks.Length > 1){
                            subPlateNumber = int.Parse(plaks.GetValue(1).ToString());
                        }
                    }catch (Exception e){
                        
                    }
                }

                
                if (oldItem == null){
                    var item = new AmlakAgreement(){
                        SdiId = feature.Id,
                        Coordinates = feature.Geometry == null ? "[]" : JsonConvert.SerializeObject(feature.Geometry.Coordinates[0]),
                        MainPlateNumber =mainPlateNumber,
                        SubPlateNumber =subPlateNumber,
                        IsSubmitted = 0,
                        CreatedAt = Helpers.GetServerDateTimeType(),
                        UpdatedAt = Helpers.GetServerDateTimeType(),
                    };
                    _db.Add(item);
                    await _db.SaveChangesAsync();

                    await SaveLogAsync(_db, item.Id, TargetTypes.Agreement, "توافق ویرایش شد.");
                }
                // else{
                //     oldItem.Coordinates = feature.Geometry == null ? "[]" : JsonConvert.SerializeObject(feature.Geometry.Coordinates[0]);
                //     await _db.SaveChangesAsync();
                // }
            }
            return Ok("ok");
        }
         private async Task<IActionResult> UpdateKiosk(int fromFile){
            // From File
            string newmessage = "";
            if (fromFile == 1){

                var filePath = Path.Combine(_webHostEnvironment.WebRootPath, "Agreement.json");
                newmessage = await System.IO.File.ReadAllTextAsync(filePath);
            }
            else{
                // From API
                string authKey = await GetToken();
                HttpClient httpClient = GetClientHttp();
        
                var requestUri =$"geoserver/ows?service=wfs&version=1.0.0&request=GetFeature&typeName=ahvaz_kiosk14000719_8798&srsname=EPSG:4326&outputFormat=application/json&maxFeatures=50000&startIndex=0&authkey={authKey}";
                var response = await httpClient.GetAsync(requestUri);
        
                if (!response.IsSuccessStatusCode)
                    return BadRequest($"Error: {response.StatusCode} / {authKey}");
        
                newmessage = await response.Content.ReadAsStringAsync();
            }
            
            var respLayer = JsonConvert.DeserializeObject<SdiDto>(newmessage.ToString());

            for (int i = 0; i < respLayer.TotalFeatures; i++){
                var feature = respLayer.Features[i];

                var mainPlateNumber = 0;
                var subPlateNumber = 0;
                if (feature.Properties.pelak_sabt != null){
                    var plaks = feature.Properties.pelak_sabt.Split("/");
                    try{

                        if (plaks.Length > 0){
                            mainPlateNumber = int.Parse(plaks.GetValue(0).ToString());
                        }
                    }catch (Exception e){
                        
                    }
                    try{
                        if (plaks.Length > 1){
                            subPlateNumber = int.Parse(plaks.GetValue(1).ToString());
                        }
                    }catch (Exception e){
                        
                    }
                }

                
                var oldItem = await _db.AmlakInfos.FirstOrDefaultAsync(a => a.SdiId == feature.Id);

                if (oldItem == null){
                    var item = new AmlakInfo(){
                        SdiId = feature.Id,
                        AreaId = feature.Properties.Mantaqe != null ? feature.Properties.Mantaqe.ToInt() : 52,
                        Coordinates = feature.Geometry == null ? "[]" : JsonConvert.SerializeObject(feature.Geometry.Coordinates[0]),
                        Masahat = 0,
                        AmlakInfoKindId= 3,
                        EstateInfoName = feature.Properties.Name,
                        EstateInfoAddress = feature.Properties.Address,
                        MainPlateNumber =mainPlateNumber.ToString(),
                        SubPlateNumber =subPlateNumber.ToString(),
                        CreatedAt = Helpers.GetServerDateTimeType(),
                        UpdatedAt = Helpers.GetServerDateTimeType(),
                    };
                    _db.Add(item);
                    await _db.SaveChangesAsync();
                    
                    await SaveLogAsync(_db, item.Id, TargetTypes.AmlakInfo, "کیوسک ثبت شد");

                }
                // else{
                //     oldItem.AreaId = feature.Properties.Mantaqe != null ? feature.Properties.Mantaqe.ToInt() : 52;
                //     oldItem.Coordinates = feature.Geometry == null ? "[]" : JsonConvert.SerializeObject(feature.Geometry.Coordinates[0]);
                //     await _db.SaveChangesAsync();
                // }
            }
            
            return Ok("ok");
        }

    }
}