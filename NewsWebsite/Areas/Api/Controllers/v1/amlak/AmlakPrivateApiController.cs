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
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;
using NPOI.SS.Formula.Functions;
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
                        OwnerId = 9, // شهرداری مرکز
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
                .PropertyType(param.PropertyType).Search(param.Search);

            
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


            foreach (var item in items){
                if (item.Area!=null && item.Area.Id == 9){
                    item.Area.AreaName = "شهرداری مرکز";
                }
                if (item.Owner!=null && item.Owner.Id == 9){
                    item.Owner.AreaName = "شهرداری مرکز";
                }
            }
            
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
                row.Add(item.OwnershipValue +" از " +item.OwnershipValueTotal);
                row.Add(item.TransferredFrom);
                row.Add(item.InPossessionOf + '-'  +item.InPossessionOfOther  );
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
                row.Add(item.InternalDateFa);
                row.Add(item.ProductiveAssetStrategies);
                row.Add(item.BuildingStatus);
                row.Add(item.BuildingMasahat);
                row.Add(item.BuildingFloorsNumber);
                row.Add(item.BuildingUsage);
                row.Add(item.MeterNumberGas);
                row.Add(item.MeterNumberWater);
                row.Add(item.MeterNumberElectricity);
                row.Add(item.MeterNumberPhone);
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
            
            if (item.Area!=null && item.Area.Id == 9){
                item.Area.AreaName = "شهرداری مرکز";
            }
            if (item.Owner!=null && item.Owner.Id == 9){
                item.Owner.AreaName = "شهرداری مرکز";
            }
            
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
            item.OwnershipValue=param.OwnershipValue;
            item.OwnershipValueTotal=param.OwnershipValueTotal;
            item.TransferredFrom=param.TransferredFrom;
            item.InPossessionOf=param.InPossessionOf;
            item.InPossessionOfOther=param.InPossessionOfOther;
            item.BlockedStatusSimakUnitWindow=param.BlockedStatusSimakUnitWindow;
            item.Status=param.Status;
            item.Notes=param.Notes;
            item.ArchiveLocation=param.ArchiveLocation;
            item.DocumentSerial=param.DocumentSerial;
            item.DocumentSeries=param.DocumentSeries;
            item.DocumentAlphabet=param.DocumentAlphabet;
            item.PropertyCode=param.PropertyCode;
            item.Year=!string.IsNullOrEmpty(param.InternalDate)?Helpers.MiladiToHejri(param.InternalDate).Substring(0,4):"0"; // todo: : 
            item.EntryDate=param.EntryDate;
            item.InternalDate=!string.IsNullOrEmpty(param.InternalDate) ? DateTime.Parse(param.InternalDate) : (DateTime?)null;
            item.ProductiveAssetStrategies=param.ProductiveAssetStrategies;
            item.BuildingStatus=param.BuildingStatus;
            item.BuildingMasahat=param.BuildingMasahat;
            item.BuildingFloorsNumber=param.BuildingFloorsNumber;
            item.BuildingUsage=param.BuildingUsage;
            item.MeterNumberGas=param.MeterNumberGas;
            item.MeterNumberWater=param.MeterNumberWater;
            item.MeterNumberElectricity=param.MeterNumberElectricity;
            item.MeterNumberPhone=param.MeterNumberPhone;
            item.UpdatedAt = Helpers.GetServerDateTimeType();
            await _db.SaveChangesAsync();

            await SaveLogAsync(_db, item.Id, TargetTypes.AmlakPrivate, "ملک خصوصی ویرایش شد");

            return Ok(item.Id.ToString());
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

            await SaveLogAsync(_db, item.AmlakPrivateId, TargetTypes.AmlakPrivate, "وضعیت سند با شناسه "+item.Id+" اضافه شد");

            
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
                var mainPlateNumber = getCellInt(row,0);
                var subPlateNumber = getCellInt(row,1);
                if (mainPlateNumber==0 && subPlateNumber==0 ) continue;

                // Generate SdiPlateNumber
                var sdiPlateNumber = $"{mainPlateNumber}-{subPlateNumber}";

                // Fetch the existing record from the database
                var existingAmlak = await _db.AmlakPrivateNews
                    .FirstOrDefaultAsync(a => a.SdiPlateNumber == sdiPlateNumber);

                if (existingAmlak != null){


                    var areaId = row.GetCell(2) == null ? 52 : getCellInt(row,2);

                    int ownerId;
                    if (getCell(row, 8) == "شهرداری اهواز"){
                        ownerId = 9;
                    }else{
                        ownerId = getCellInt(row, 8);
                    }
                        

                    var masahat = getCellDouble(row,4);
                    var documentType = Helpers.UCReverse(getCell(row,6),"amlakPrivateDocumentType",0).ToString();
                    
                    // Update the existing record with new values
                    existingAmlak.MainPlateNumber =  getCell(row,0);
                    existingAmlak.SubPlateNumber =  getCell(row,1);
                    existingAmlak.AreaId =  areaId;;
                    existingAmlak.Section =  getCell(row,3);
                    existingAmlak.Masahat =  masahat;;
                    existingAmlak.Address =  getCell(row,5);
                    existingAmlak.DocumentType =  documentType==""?0:int.Parse(documentType);;
                    existingAmlak.UsageOnDocument =  getCell(row,7);
                    existingAmlak.OwnerId =  ownerId;;
                    existingAmlak.PropertyType =  Helpers.UCReverse(getCell(row,9),"amlakPrivatePropertyType").ToString();
                    existingAmlak.OwnershipType =  getCell(row,10);
                    existingAmlak.OwnershipValue = 0D;//getCell(row,11); // todo:
                    existingAmlak.OwnershipValueTotal = 0; // getCell(row,11); todo: 
                    existingAmlak.TransferredFrom =  getCell(row,12);
                    existingAmlak.InPossessionOf = 9; //  getCell(row,13); // todo: 
                    existingAmlak.UsageUrban =  getCell(row,14);
                    existingAmlak.BlockedStatusSimakUnitWindow =  getCell(row,15);
                    existingAmlak.Status =  getCell(row,16);
                    existingAmlak.Notes =  getCell(row,17);
                    existingAmlak.ArchiveLocation =  getCell(row,18);
                    existingAmlak.DocumentSerial =  getCell(row,19);
                    existingAmlak.DocumentSeries =  getCell(row,20);
                    existingAmlak.DocumentAlphabet =  getCell(row,21);
                    existingAmlak.JamCode =  getCell(row,22);
                    existingAmlak.PropertyCode =  getCell(row,23);
                    existingAmlak.Year =  getCell(row,24);
                    existingAmlak.EntryDate =  getCell(row,25);
                    existingAmlak.InternalDate = null; // todo: if(!string.IsNullOrEmpty(getCell(row,26))) Helpers.HejriToMiladiDateTime(getCell(row,26)) else null;
                    existingAmlak.ProductiveAssetStrategies =  getCell(row,45);
                    existingAmlak.SimakCode =  getCell(row,46);

                    // Add to the list of records to update
                    updateCount++;
                    if (param.justValidate == 0){
                        try{
                            await _db.SaveChangesAsync();
                        }catch (Exception e){
                            return BadRequest("خطاااا / "+mainPlateNumber+" / " +  (i+1));
                        }
                    }
                }
                else{
                    notExistCount++;
                    notExistRows=notExistRows+ (i - 1) +",";
                    // not exists
                }
            }
            if (param.justValidate == 1)
                return Ok(updateCount + " ردیف ویرایش خواهد شد و " + notExistCount + " ردیف پیدا نشد" + "\n ردیف ها : "+notExistRows);

            return Ok(updateCount + " ردیف ویرایش شد و " + notExistCount + " ردیف پیدا نشد" + "\n ردیف ها : "+notExistRows);
            
        }

        private string getCell(IRow row, int i){
            if(row.GetCell(i)==null)
                return "";
                
            return row.GetCell(i).ToString();
        }

        private int getCellInt(IRow row, int i){
            if(row.GetCell(i)==null)
                return 0;

            if (int.TryParse(row.GetCell(i).ToString(), out int resInt))
                return resInt;

            return 0;
        }

        private double getCellDouble(IRow row, int i){
            if(row.GetCell(i)==null)
                return 0;

            if (double.TryParse(row.GetCell(i).ToString(), out double resdDouble))
                return resdDouble;

            return 0D;
        }

    }
}