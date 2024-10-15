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
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Data;
using NewsWebsite.ViewModels;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using System.Linq;
using Microsoft.EntityFrameworkCore.Storage;
using NewsWebsite.Data.Models;
using NewsWebsite.Data.Models.AmlakPrivate;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;

namespace NewsWebsite.Areas.Api.Controllers.v1.amlak {
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class AmlakPrivateApiController : EnhancedController {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public AmlakPrivateApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment, ProgramBuddbContext db){
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
                        SdiPlateNumber = feature.Properties.Pelaksabti,
                        Masahat = 0,
                        PredictionUsage="",
                        Title = feature.Id,
                        TypeUsing = "",
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


            return Ok("موفق");
        }

        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------


        [Route("List")]
        [HttpGet]
        public async Task<ApiResult<object>> AmlakPrivateList(AmlakPrivateReadInputVm param){
            await CheckUserAuth(_db);

            var builder = _db.AmlakPrivateNews
                .AreaId(param.AreaId).OwnerId(param.OwnerId).TypeUsing(param.TypeUsing)
                .SadaCode(param.SadaCode).JamCode(param.JamCode).DocumentType(param.DocumentType)
                .MasahatFrom(param.MasahatFrom).MasahatTo(param.MasahatTo)
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
                row.Add(item.DocumentTypeText);
                row.Add(item.SadaCode);
                row.Add(item.JamCode);
                row.Add(item.SdiId);
                row.Add(item.SimakCode);
                row.Add(item.MainPlateNumber);
                row.Add(item.SubPlateNumber);
                row.Add(item.Section);
                row.Add(item.Address);
                row.Add(item.UsageOnDocument);
                row.Add(item.UsageUrban);
                row.Add(item.PropertyType);
                row.Add(item.OwnershipType);
                row.Add(item.OwnershipPercentage);
                row.Add(item.TransferredFrom);
                row.Add(item.InPossessionOf);
                row.Add(item.BlockedStatusSimakUnitWindow);
                row.Add(item.Status);
                row.Add(item.Notes);
                row.Add(item.ArchiveLocation);
                row.Add(item.DocumentSerial);
                row.Add(item.DocumentSeries);
                row.Add(item.DocumentAlphabet);
                row.Add(item.PropertyCode);
                row.Add(item.Year);
                row.Add(item.EntryDate);
                row.Add(item.InternalDate);
                row.Add(item.ProductiveAssetStrategies);
                row.Add(item.Coordinates);
                row.Add(item.PredictionUsageText);
                row.Add(item.CreatedAtFa);
                row.Add(item.UpdatedAtFa);
                
                finalItems.Add(row);
            }

            return Helpers.ExportExcelFile(finalItems, "amlak_private");
        }


        
        [Route("Read")]
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


        [Route("Update")]
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
            item.JamCode = param.JamCode;
            item.SimakCode=param.SimakCode;
            item.MainPlateNumber=param.MainPlateNumber;
            item.SubPlateNumber=param.SubPlateNumber;
            item.Section=param.Section;
            item.Address=param.Address;
            item.UsageOnDocument=param.UsageOnDocument;
            item.UsageUrban=param.UsageUrban;
            item.PropertyType=param.PropertyType;
            item.OwnershipType=param.OwnershipType;
            item.OwnershipPercentage=param.OwnershipPercentage;
            item.TransferredFrom=param.TransferredFrom;
            item.InPossessionOf=param.InPossessionOf;
            item.BlockedStatusSimakUnitWindow=param.BlockedStatusSimakUnitWindow;
            item.Status=param.Status;
            item.Notes=param.Notes;
            item.ArchiveLocation=param.ArchiveLocation;
            item.DocumentSerial=param.DocumentSerial;
            item.DocumentSeries=param.DocumentSeries;
            item.DocumentAlphabet=param.DocumentAlphabet;
            item.PropertyCode=param.PropertyCode;
            item.Year=param.Year;
            item.EntryDate=param.EntryDate;
            item.InternalDate=param.InternalDate;
            item.ProductiveAssetStrategies=param.ProductiveAssetStrategies;
            item.UpdatedAt = Helpers.GetServerDateTimeType();
            await _db.SaveChangesAsync();

            return Ok(item.Id.ToString());
        }


        [Route("Upload")]
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

        [Route("Files")]
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
        
        
           
        [Route("File/Edit")]
        [HttpPatch]
        public async Task<ApiResult<string>>AmlakPrivateAttachFileEdit(int fileId,string title){
            await CheckUserAuth(_db);

            if (fileId == 0) BadRequest();
        
            var item = await _db.AmlakPrivateFiles.Where(a => a.Id == fileId).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("خطا");

            item.FileTitle = title;
            await _db.SaveChangesAsync();
            
            return Ok("انجام شد");
        }
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

        [Route("DocHistory/List")]
        [HttpGet]
        public async Task<ApiResult<List<AmlakPrivateDocHistoryListVm>>> AmlakPrivateDocHistoryList(int amlakPrivateId){
            await CheckUserAuth(_db);

            var items = await _db.AmlakPrivateDocHistories.AmlakPrivateId(amlakPrivateId).OrderByDescending(a=>a.Id).ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakPrivateDocHistory, AmlakPrivateDocHistoryListVm>(items);

            return Ok(finalItems);
        }

        [Route("DocHistory/Store")]
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

        [Route("Report")]
        [HttpPost]
        public async Task<ApiResult<object>> AmlakPrivateReport( ){
            await CheckUserAuth(_db);

            var charts = new List<object>();
            var owners = await _db.TblAreas.ToListAsync();

            var data1 = await _db.AmlakPrivateNews
                .GroupBy(x => x.AreaId)
                .Select(g => new 
                { 
                    Label = GetAreaName(owners,g.Key) ,
                    Count = g.Count(),
                })
                .ToListAsync();
            charts.Add(new {name="املاک اختصاصی به تفکیک مناطق",type="pie",items=data1});
            
            

            var data2 = await _db.AmlakPrivateNews
                .GroupBy(x => x.OwnerId)
                .Select(g => new 
                { 
                    Label = GetAreaName(owners,g.Key) ,
                    Count = g.Count(),
                })
                .ToListAsync();

            charts.Add(new {name="املاک اختصاصی به تفکیک مالک",type="pie",items=data2});

            var data3 = await _db.AmlakPrivateNews
                .GroupBy(x => x.DocumentType)
                .Select(g => new 
                { 
                    Label = Helpers.UC(g.Key,"amlakPrivateDocumentType"), 
                    Count = g.Count(),
                })
                .ToListAsync();
            charts.Add(new {name="املاک اختصاصی به تفکیک نوع سند",type="pie",items=data3});

            
            var data4 = await _db.AmlakPrivateNews
                .GroupBy(x => x.PredictionUsage)
                .Select(g => new 
                { 
                    Label = g.Key, 
                    Count = g.Count(),
                })
                .ToListAsync();
            charts.Add(new {name="املاک اختصاصی به تفکیک نوع کاربری",type="pie",items=data4});

            
            
            var data5 = await _db.AmlakPrivateNews
                .GroupBy(x => x.Year)
                .Select(g => new 
                { 
                    Label = g.Key, 
                    Count = g.Count(),
                })
                .ToListAsync();
            charts.Add(new {name="وضعیت دریافت سند به تفکیک سال",type="pie",items=data5});

   
            var data8 = await _db.AmlakPrivateNews
                .GroupBy(x => x.ProductiveAssetStrategies)
                .Select(g => new 
                { 
                    Label = g.Key, 
                    Count = g.Count(),
                })
                .ToListAsync();
            charts.Add(new {name="وضعیت به تفکیک راهبرد مولد سازی",type="pie",items=data8});

   
            
            var data6 = await _db.AmlakPrivateNews
                .GroupBy(x => x.PropertyType)
                .Select(g => new 
                { 
                    Label = Helpers.UC(g.Key,"amlakPrivatePropertyType"), 
                    Count = g.Count(),
                })
                .ToListAsync();
            charts.Add(new {name="وضعیت اسناد به تفکیک نوع ملک",type="pie",items=data6});

            

            var data7 = new List<object>();
            data7.Add(new {Label="ثبت شده",Count=_db.AmlakPrivateNews.Count(x => !string.IsNullOrEmpty(x.SadaCode))});
            data7.Add(new {Label="ثبت نشده",Count=_db.AmlakPrivateNews.Count(x => string.IsNullOrEmpty(x.SadaCode))});
            charts.Add(new {name="وضعیت سامانه سادا",type="pie",items=data7});


            return Ok(new{charts});
        }


        private static string GetAreaName(List<TblAreas> owners , int Id){
            foreach (var owner in owners){
                {
                    if (owner.Id == Id)
                        return owner.AreaName;
                }
                
            }

            return Id.ToString();
        }
        
        [Route("import")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakPrivateUpdate(ExcelImportInputVm param){
            await CheckUserAuth(_db);

            if (param.File == null)
                return BadRequest(new{ message = "لطفا فایل خود را انتخاب نمایید" });

            IFormFile file =param.File;
            string folderName = "tmp";
            string webRootPath = "wwwroot";
            string newPath = Path.Combine(webRootPath, folderName);
            if (!Directory.Exists(newPath)){
                Directory.CreateDirectory(newPath);
            }


            ISheet sheet;
            string fullPath = Path.Combine(newPath, file.FileName);
            using var stream = new FileStream(fullPath, FileMode.Create);
            file.CopyTo(stream);
            stream.Position = 0;
            XSSFWorkbook hssfwb = new XSSFWorkbook(stream);
            sheet = hssfwb.GetSheetAt(0);
            
            var updateCount = 0;
            var notExistCount = 0;
            var notExistRows = "";

            for (int i = 2; i <= sheet.LastRowNum; i++){
                IRow row = sheet.GetRow(i);
                if (row == null) continue;
                if (row.Cells.All(d => d.CellType == CellType.Blank)) continue;


                // Read data from the Excel sheet
                var MainPlateNumber = getCellInt(row,0);
                var SubPlateNumber = getCellInt(row,1);
                if (MainPlateNumber==0 && SubPlateNumber==0 ) continue;

                // Generate SdiPlateNumber
                var SdiPlateNumber = $"{MainPlateNumber}-{SubPlateNumber}";

                // Fetch the existing record from the database
                var existingAmlak = await _db.AmlakPrivateNews
                    .FirstOrDefaultAsync(a => a.SdiPlateNumber == SdiPlateNumber);

                if (existingAmlak != null){


                    var AreaId = int.Parse(row.GetCell(2).ToString()) == null ? 52 : int.Parse(row.GetCell(2).ToString());

                    var OwnerId = 0;
                    if (row.GetCell(8).ToString() == null){
                        OwnerId = 0;
                    }else if (row.GetCell(8).ToString() == "شهرداری اهواز"){
                        OwnerId = 9;
                    }else{
                        OwnerId= int.Parse(row.GetCell(8).ToString()!);
                    }
                    

                    var masahat = double.Parse(row.GetCell(4).ToString()) == null ? 0 : double.Parse(row.GetCell(4).ToString());
                    var DocumentType = int.Parse(Helpers.UCReverse(row.GetCell(6).ToString(),"amlakPrivateDocumentType",0).ToString());
                    
                    // Update the existing record with new values
                    existingAmlak.MainPlateNumber =  row.GetCell(0).ToString();;
                    existingAmlak.SubPlateNumber =  row.GetCell(1).ToString();;
                    existingAmlak.AreaId =  AreaId;;
                    existingAmlak.Section =  row.GetCell(3).ToString();;
                    existingAmlak.Masahat =  masahat;;
                    existingAmlak.Address =  row.GetCell(5).ToString();;
                    existingAmlak.DocumentType =  DocumentType;;
                    existingAmlak.UsageOnDocument =  row.GetCell(7).ToString();;
                    existingAmlak.OwnerId =  OwnerId;;
                    existingAmlak.PropertyType =  Helpers.UCReverse(row.GetCell(9).ToString(),"amlakPrivatePropertyType").ToString();;
                    existingAmlak.OwnershipType =  row.GetCell(10).ToString();;
                    existingAmlak.OwnershipPercentage =  row.GetCell(11).ToString();;
                    existingAmlak.TransferredFrom =  row.GetCell(12).ToString();;
                    existingAmlak.InPossessionOf =  row.GetCell(13).ToString();;
                    existingAmlak.UsageUrban =  row.GetCell(14).ToString();;
                    existingAmlak.BlockedStatusSimakUnitWindow =  row.GetCell(15).ToString();;
                    existingAmlak.Status =  row.GetCell(16).ToString();;
                    existingAmlak.Notes =  row.GetCell(17).ToString();;
                    existingAmlak.ArchiveLocation =  row.GetCell(18).ToString();;
                    existingAmlak.DocumentSerial =  row.GetCell(19).ToString();;
                    existingAmlak.DocumentSeries =  row.GetCell(20).ToString();;
                    existingAmlak.DocumentAlphabet =  row.GetCell(21).ToString();;
                    existingAmlak.JamCode =  row.GetCell(22).ToString();;
                    existingAmlak.PropertyCode =  row.GetCell(23).ToString();;
                    existingAmlak.Year =  row.GetCell(24).ToString();;
                    existingAmlak.EntryDate =  row.GetCell(25).ToString();;
                    existingAmlak.InternalDate =  row.GetCell(26).ToString();;
                    existingAmlak.ProductiveAssetStrategies =  row.GetCell(45).ToString();;
                    existingAmlak.SimakCode =  row.GetCell(46).ToString();;

                    // Add to the list of records to update
                    updateCount++;
                    if (param.justValidate == 0){
                        await _db.SaveChangesAsync();
                    }
                }
                else{
                    notExistCount++;
                    notExistRows=notExistRows+SubPlateNumber+",";
                    // not exists
                }
            }
            if (param.justValidate == 1)
                return Ok(updateCount + " ردیف ویرایش خواهد شد و " + notExistCount + " ردیف پیدا نشد" + "\n ردیف ها : "+notExistRows);

            return Ok(updateCount + " ردیف ویرایش شد و " + notExistCount + " ردیف پیدا نشد" + "\n ردیف ها : "+notExistRows);
            
        }

        private int getCellInt(IRow row, int i){
            if(row.GetCell(i).ToString()==null)
                return 0;
                
            return int.Parse(row.GetCell(i).ToString());
        }

    }
}