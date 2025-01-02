using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Public;
using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Data;
using NewsWebsite.ViewModels;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using System.Linq;
using System.Net.Http;
using NewsWebsite.Data.Models;
using NewsWebsite.Data.Models.AmlakPrivate;
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;
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
        private static readonly HttpClient _httpClient = new HttpClient();


        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------


        [Route("List")]
        [HttpGet]
        public async Task<ApiResult<object>> AmlakPrivateList(AmlakPrivateReadInputVm param){
            await CheckUserAuth(_db);

            var builder = _db.AmlakPrivateNews
                .AreaId(param.AreaId).OwnerId(param.OwnerId).UsageUrban(param.UsageUrban)
                .SadaCode(param.SadaCode).JamCode(param.JamCode).DocumentType(param.DocumentType)
                .MasahatFrom(param.MasahatFrom).MasahatTo(param.MasahatTo)
                .MainPlateNumber(param.MainPlateNumber).SubPlateNumber(param.SubPlateNumber)
                .MultiplePlates(param.MultiplePlates)
                .PropertyType(param.PropertyType).Search(param.Search).IsSubmitted(param.IsSubmitted)
                .HasSdiLayer(param.HasSdiLayer).IsTransfered(param.IsTransfered)
                .LatestGeneratingDecision(param.LatestGeneratingDecision);

            
            var pageCount = (int)Math.Ceiling((await builder.CountAsync())/Convert.ToDouble(param.PageRows));

            
            if (param.Export == 1 || param.ExportKMZ == 1){
                param.Page = 1;
                param.PageRows = 100000;
            }

            dynamic items;
            if (param.ForMap == 0){
                builder = builder
                    .Include(a => a.Area)
                    .Include(a => a.Owner)
                    .Select(ap => new AmlakPrivateNew
                        {
                            Id = ap.Id,
                            AreaId = ap.AreaId,
                            OwnerId = ap.OwnerId,
                            Title = ap.Title,
                            PredictionUsage = ap.PredictionUsage,
                            SadaCode = ap.SadaCode,
                            JamCode = ap.JamCode,
                            Masahat = ap.Masahat,
                            DocumentType = ap.DocumentType,
                            MainPlateNumber = ap.MainPlateNumber,
                            SubPlateNumber = ap.SubPlateNumber,
                            Section = ap.Section,
                            PropertyType = ap.PropertyType,
                            UsageUrban = ap.UsageUrban,
                            OwnershipValue = ap.OwnershipValue,
                            OwnershipValueTotal = ap.OwnershipValueTotal,
                            Area = ap.Area,
                            Owner = ap.Owner,
                            LastDocHistory = ap.AmlakPrivateDocHistories
                                .Where(dh => dh.Type == "general")
                                .OrderByDescending(dh => dh.Id)
                                .FirstOrDefault(),
                            LastDocHistoryPossession = ap.AmlakPrivateDocHistories
                                .Where(dh => dh.Type == "possession")
                                .OrderByDescending(dh => dh.Id)
                                .FirstOrDefault()
                        })
                    .OrderBy(param.Sort,param.SortType)
                    .Page2(param.Page, param.PageRows)
                    ;
                items=await builder!.ToListAsync();

            }
            else{
                items=await builder.ToListAsync();
            }

            foreach (var item in items){
                if (item.Area!=null && item.Area.Id == 9){
                    item.Area.AreaName = "شهرداری اهواز";
                }
                if (item.Owner!=null && item.Owner.Id == 9){
                    item.Owner.AreaName = "شهرداری اهواز";
                }
            }
        
            if (param.Export == 1){
                var fileUrl = ExportExcel(items);
                return Ok(new {fileUrl});
            }
            if (param.ExportKMZ == 1){
                var fileUrl = ExportKmz(items);
                return Ok(new {fileUrl});
            }
        
            var finalItems = MyMapper.MapTo<AmlakPrivateNew, AmlakPrivateListVm>(items);

            // return Ok(new{items,pageCount});
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
                row.Add(item.DocumentTypeText);
                row.Add(item.SadaCode);
                row.Add(item.JamCode);
                row.Add(item.SdiId);
                row.Add(item.SimakCode);
                row.Add(item.MainPlateNumber);
                row.Add(item.SubPlateNumber);
                row.Add(item.SectionText);
                row.Add(item.Address);
                row.Add(item.UsageOnDocument);
                row.Add(item.UsageUrbanText);
                row.Add(item.PropertyType);
                row.Add(item.OwnershipTypeText);
                row.Add(item.OwnershipValueTypeText);
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
                row.Add(item.InternalDateFa);
                row.Add(item.LatestGeneratingDecisionText);
                row.Add(item.BuildingStatusText);
                row.Add(item.BuildingMasahat);
                row.Add(item.BuildingFloorsNumber);
                row.Add(item.BuildingUsageText);
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

        private static object ExportKmz(List<AmlakPrivateNew> items){
            var list = new List<Helpers.KMZVM>();
            foreach (var item in items){
                list.Add(new Helpers.KMZVM{Name = "id:" + item.Id, Coordinates = item.Coordinates });
            }
            
            return Helpers.ExportKmzFile(list,"amlak_private"); 
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
                item.Area.AreaName = "شهرداری اهواز";
            }
            if (item.Owner!=null && item.Owner.Id == 9){
                item.Owner.AreaName = "شهرداری اهواز";
            }
            
            var finalItem = MyMapper.MapTo<AmlakPrivateNew, AmlakPrivateReadVm>(item);

            return Ok(finalItem);
        }


        [Route("Store")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakPrivateStore([FromBody] AmlakPrivateUpdateVm param){
            await CheckUserAuth(_db);

            var item0 = await _db.AmlakPrivateNews.MainPlateNumber(param.MainPlateNumber).SubPlateNumber(param.SubPlateNumber).FirstOrDefaultAsync();
            if (item0 != null)
                return BadRequest(new{ message = "این پلاک اصلی و فرعی قبلا ثبت شده است" });


            var item = new AmlakPrivateNew();
            item.AreaId = param.AreaId;
            item.OwnerId = param.OwnerId;
            item.Masahat = param.Masahat;
            item.PredictionUsage = param.PredictionUsage;
            item.Title = param.Title;
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
            item.OwnershipValueType=param.OwnershipValueType;
            item.OwnershipValue=param.OwnershipValue;
            item.OwnershipValueTotal=param.OwnershipValueTotal;
            item.TransferredFrom=param.TransferredFrom;
            item.InPossessionOf=param.InPossessionOf;
            item.InPossessionOfOther=param.InPossessionOfOther;
            item.BlockedStatusSimakUnitWindow=param.BlockedStatusSimakUnitWindow;
            item.Status=param.Status;
            item.ArchiveLocation=param.ArchiveLocation;
            item.DocumentSerial=param.DocumentSerial;
            item.DocumentSeries=param.DocumentSeries;
            item.DocumentAlphabet=param.DocumentAlphabet;
            item.PropertyCode=param.PropertyCode;
            item.Year=!string.IsNullOrEmpty(param.InternalDate)?Helpers.MiladiToHejri(param.InternalDate).Substring(0,4):"0"; // todo: : 
            item.InternalDate=!string.IsNullOrEmpty(param.InternalDate) ? DateTime.Parse(param.InternalDate) : (DateTime?)null;
            item.DocumentDate=!string.IsNullOrEmpty(param.DocumentDate) ? DateTime.Parse(param.DocumentDate) : (DateTime?)null;
            // item.LatestGeneratingDecision=param.LatestGeneratingDecision;
            item.BuildingStatus=param.BuildingStatus;
            item.BuildingMasahat=param.BuildingMasahat;
            item.BuildingFloorsNumber=param.BuildingFloorsNumber;
            item.BuildingUsage=param.BuildingUsage;
            item.MeterNumberGas=param.MeterNumberGas;
            item.MeterNumberWater=param.MeterNumberWater;
            item.MeterNumberElectricity=param.MeterNumberElectricity;
            item.MeterNumberPhone=param.MeterNumberPhone;
            item.UpdatedAt = Helpers.GetServerDateTimeType();
            item.CreatedAt = Helpers.GetServerDateTimeType();
            _db.Add(item);
            await _db.SaveChangesAsync();

            await SaveLogAsync(_db, item.Id, TargetTypes.AmlakPrivate, "ملک خصوصی ثبت شد");

            return Ok(item.Id.ToString());
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
            item.OwnershipValueType=param.OwnershipValueType;
            item.OwnershipValue=param.OwnershipValue;
            item.OwnershipValueTotal=param.OwnershipValueTotal;
            item.TransferredFrom=param.TransferredFrom;
            item.InPossessionOf=param.InPossessionOf;
            item.InPossessionOfOther=param.InPossessionOfOther;
            item.BlockedStatusSimakUnitWindow=param.BlockedStatusSimakUnitWindow;
            item.Status=param.Status;
            item.ArchiveLocation=param.ArchiveLocation;
            item.DocumentSerial=param.DocumentSerial;
            item.DocumentSeries=param.DocumentSeries;
            item.DocumentAlphabet=param.DocumentAlphabet;
            item.PropertyCode=param.PropertyCode;
            item.Year=!string.IsNullOrEmpty(param.InternalDate)?Helpers.MiladiToHejri(param.InternalDate).Substring(0,4):"0"; // todo: : 
            item.InternalDate=!string.IsNullOrEmpty(param.InternalDate) ? DateTime.Parse(param.InternalDate) : (DateTime?)null;
            item.DocumentDate=!string.IsNullOrEmpty(param.DocumentDate) ? DateTime.Parse(param.DocumentDate) : (DateTime?)null;
            // item.LatestGeneratingDecision=param.LatestGeneratingDecision;
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

        
        
        [Route("UpdateNote")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakPrivateUpdateNote([FromBody] AmlakPrivateUpdateNoteVm param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakPrivateNews.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest(new{ message = "یافت نشد" });

            item.Notes=param.Notes;
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
        public async Task<ApiResult<List<AmlakPrivateDocHistoryListVm>>> AmlakPrivateDocHistoryList(int amlakPrivateId,string type){
            await CheckUserAuth(_db);

            var items = await _db.AmlakPrivateDocHistories.AmlakPrivateId(amlakPrivateId).Type(type).OrderByDescending(a=>a.Id).ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakPrivateDocHistory, AmlakPrivateDocHistoryListVm>(items);

            return Ok(finalItems);
        }

        [Route("DocHistory/Store")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakPrivateDocHistoryStore( AmlakPrivateDocHistoryStoreVm param){
            await CheckUserAuth(_db);
            
            if (param.Type != "general" && param.Type != "seizure" && param.Type != "license" && param.Type != "completion"&& param.Type != "possession"){
                return BadRequest("این نوع مجاز نمی باشد");
            }
            
            // var item = new AmlakPrivateDocHistory();
            // item.AmlakPrivateId = param.AmlakPrivateId;
            // item.Type = param.Type;
            // item.Status = param.Status;
            // item.Desc = param.Desc;
            // item.LetterDate =!string.IsNullOrEmpty( param.LetterDate) ? DateTime.Parse( param.LetterDate) : (DateTime?)null;;
            // item.LetterNumber = param.LetterNumber;
            // item.PersonType = param.PersonType;
            // item.PersonName = param.PersonName;
            // item.Date = Helpers.GetServerDateTimeType();
            // _db.Add(item);
            // await _db.SaveChangesAsync();
            //
            // await SaveLogAsync(_db, item.AmlakPrivateId, TargetTypes.AmlakPrivate, "وضعیت سند با شناسه "+item.Id+" اضافه شد");
            var item= await DoAmlakPrivateDocHistoryStore(_db,param);
            await SaveLogAsync(_db, item.AmlakPrivateId, TargetTypes.AmlakPrivate, "وضعیت سند با شناسه "+item.Id+" اضافه شد");

            return Ok("موفق");
        }

         
        public static async Task<AmlakPrivateDocHistory> DoAmlakPrivateDocHistoryStore(ProgramBuddbContext _db, AmlakPrivateDocHistoryStoreVm param){
            
            var item = new AmlakPrivateDocHistory();
            item.AmlakPrivateId = param.AmlakPrivateId;
            item.Type = param.Type;
            item.Status = param.Status;
            item.Desc = param.Desc;
            item.LetterDate =!string.IsNullOrEmpty( param.LetterDate) ? DateTime.Parse( param.LetterDate) : (DateTime?)null;;
            item.LetterNumber = param.LetterNumber;
            item.PersonType = param.PersonType;
            item.PersonName = param.PersonName;
            item.Date = Helpers.GetServerDateTimeType();
            _db.Add(item);
            await _db.SaveChangesAsync();

            
            return item;
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
                .GroupBy(x => x.LatestGeneratingDecision)
                .Select(g => new 
                { 
                    Label = Helpers.UC(g.Key,"amlakPrivateGeneratingDecision"), 
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
        
        
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------

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

            var areas = _db.TblAreas.ToDictionary(a => a.AreaName, a => a.Id);
            for (int i = 0; i <= sheet.LastRowNum; i++){
                IRow row = sheet.GetRow(i);
                if (row == null) continue;
                if (row.Cells.All(d => d.CellType == CellType.Blank)) continue;

                // Read data from the Excel sheet
                var mainPlateNumber = getCellInt(row,0);
                var subPlateNumber = getCellInt(row,1);
                if (mainPlateNumber==0 && subPlateNumber==0 ) continue;

                // Fetch the existing record from the database
                var existingAmlak = await _db.AmlakPrivateNews
                    .FirstOrDefaultAsync(a => a.MainPlateNumber == mainPlateNumber.ToString() && a.SubPlateNumber==subPlateNumber.ToString());

                var isNew = 0;
                if (existingAmlak == null){
                    existingAmlak = new AmlakPrivateNew();
                    isNew = 1;
                }


                    var areaId = 0;
                    if (getCell(row, 7) == "شهرداری اهواز"){
                        areaId = 9;
                    }else{
                        if (!areas.TryGetValue(getCell(row, 7), out areaId))
                            areaId = 52;
                    }
                    
                    var ownerId = 0;
                    if (getCell(row, 14) == "شهرداری اهواز"){
                        ownerId = 9;
                    }else{
                        if (!areas.TryGetValue(getCell(row, 14), out ownerId))
                            ownerId = 52;
                    }

                    
                    // Update the existing record with new values
                    existingAmlak.MainPlateNumber =  getCell(row,0);
                    existingAmlak.SubPlateNumber =  getCell(row,1);
                    existingAmlak.Address =  getCell(row,2);
                    existingAmlak.DocumentType = int.Parse(Helpers.UCReverse(getCell(row,3),"amlakPrivateDocumentType",0).ToString());
                    existingAmlak.PropertyType =  Helpers.UCReverse(getCell(row,4),"amlakPrivatePropertyType").ToString();
                    existingAmlak.Masahat =  getCellDouble(row,5);;
                    existingAmlak.Section =  Helpers.UCReverse(getCell(row,6),"amlakPrivateSection",10).ToString();
                    existingAmlak.AreaId =  areaId;;
                    existingAmlak.InternalDate = null; // todo: if(!string.IsNullOrEmpty(getCell(row,26))) Helpers.HejriToMiladiDateTime(getCell(row,26)) else null;
                    existingAmlak.DocumentDate = null; // todo: if(!string.IsNullOrEmpty(getCell(row,26))) Helpers.HejriToMiladiDateTime(getCell(row,26)) else null;
                    existingAmlak.Year =  "0";
                    existingAmlak.ArchiveLocation =  getCell(row,10);
                    existingAmlak.DocumentSerial =  getCell(row,11);
                    existingAmlak.DocumentSeries =  getCell(row,12);
                    existingAmlak.DocumentAlphabet =  getCell(row,13);
                    existingAmlak.OwnerId =  ownerId;;
                    existingAmlak.OwnershipType =  Helpers.UCReverse(getCell(row,15),"amlakPrivateOwnershipType",0).ToString();
                    existingAmlak.OwnershipValueType =  Helpers.UCReverse(getCell(row,16),"amlakPrivateOwnershipValueType",0).ToString();
                    existingAmlak.OwnershipValue = getCellDouble(row,17);
                    existingAmlak.OwnershipValueTotal = getCellInt(row,18);
                    existingAmlak.BuildingStatus =  int.Parse(Helpers.UCReverse(getCell(row,19),"amlakPrivateBuildingStatus",0).ToString());
                    existingAmlak.BuildingMasahat = getCellInt(row, 20);
                    existingAmlak.BuildingFloorsNumber = getCellInt(row, 21);
                    existingAmlak.BuildingUsage =  int.Parse(Helpers.UCReverse(getCell(row,22),"amlakPrivateBuildingUsage",0).ToString());
                    // existingAmlak. =  getCell(row,23);
                    // existingAmlak. =  getCell(row,24);
                    existingAmlak.MeterNumberWater =  getCell(row,25);
                    existingAmlak.MeterNumberGas =  getCell(row,26);
                    existingAmlak.MeterNumberElectricity =  getCell(row,27);
                    existingAmlak.MeterNumberPhone =  getCell(row,28);
                    existingAmlak.UsageOnDocument =  getCell(row,29);
                    existingAmlak.UsageUrban =  Helpers.UCReverse(getCell(row,30),"amlakPrivateUsageUrban",0).ToString();
                    existingAmlak.SadaCode =  getCell(row,31);
                    existingAmlak.JamCode =  getCell(row,32);
                    existingAmlak.SimakCode =  getCell(row,33);
                    existingAmlak.PropertyCode =  getCell(row,34);
                    existingAmlak.BlockedStatusSimakUnitWindow =  getCell(row,35);
                    existingAmlak.Status =  getCell(row,36);
                    existingAmlak.Notes =  getCell(row,37);
                    existingAmlak.TransferredFrom =  getCell(row,39);
                    existingAmlak.InPossessionOf = 9;  
                    existingAmlak.LatestGeneratingDecision =  int.Parse(Helpers.UCReverse(getCell(row,41),"amlakPrivatePredictionUsage",0).ToString());


                    if (isNew == 1){
                        notExistCount++;
                        notExistRows=notExistRows+ (i - 1) +",";
                        if (param.justValidate == 0){
                            try{
                                _db.Add(existingAmlak);
                                await _db.SaveChangesAsync();
                            }catch (Exception e){
                                return BadRequest("خطاااا / "+mainPlateNumber+"-"+subPlateNumber+" / " +  (i+1) + e.InnerException);
                            }
                        }
                    }
                    else{
                        updateCount++;
                        if (param.justValidate == 0){
                            try{
                                await _db.SaveChangesAsync();
                            }catch (Exception e){
                                return BadRequest("خطاااا / "+mainPlateNumber+"-"+subPlateNumber+" / " +  (i+1) + e.InnerException);
                            }
                        }
                        
                    }
                    
                  
                    // not exists
            }
            if (param.justValidate == 1)
                return Ok(updateCount + " ردیف ویرایش خواهد شد و " + notExistCount + " ردیف پیدا نشد که اضافه خواهد شد" + "- ردیف ها : "+notExistRows);

            
            return Ok(updateCount + " ردیف ویرایش شد و " + notExistCount + " ردیف پیدا نشد که اضافه شد" + "- ردیف ها : "+notExistRows);
            
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