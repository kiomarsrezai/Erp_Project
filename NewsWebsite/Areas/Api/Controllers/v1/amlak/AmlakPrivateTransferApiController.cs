using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Public;
using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Data;
using NewsWebsite.ViewModels;
using NewsWebsite.Data.Models.AmlakPrivate;
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;

namespace NewsWebsite.Areas.Api.Controllers.v1.amlak {
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class AmlakPrivateTransferApiController : EnhancedController {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public AmlakPrivateTransferApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment, ProgramBuddbContext db){
            _config = config;
            _uw = uw;
            _webHostEnvironment = webHostEnvironment;
            _db = db;
        }


        [Route("Read")]
        [HttpGet]
        public async Task<ApiResult<AmlakPrivateTransferReadVm>> AmlakPrivateTransferRead(PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakPrivateTransfers.AmlakPrivateId(param.Id)
                .FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");
            
            var finalItem = MyMapper.MapTo<AmlakPrivateTransfer, AmlakPrivateTransferReadVm>(item);

            return Ok(finalItem);
        }


        [Route("Update")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakPrivateTransferUpdate([FromBody] AmlakPrivateTransferUpdateVm param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakPrivateTransfers.AmlakPrivateId(param.AmlakPrivateId).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest(new{ message = "یافت نشد" });

            item.RecipientType = param.RecipientType;
            item.RecipientName = param.RecipientName;
            item.NationalCode = param.NationalCode;
            item.Representative = param.Representative;
            item.RecipientPhone = param.RecipientPhone;
            item.MunicipalityRepName = param.MunicipalityRepName;
            if (!string.IsNullOrEmpty(param.LetterDate)) item.LetterDate = DateTime.Parse(param.LetterDate);
            item.LetterNumber = param.LetterNumber;
            item.NotaryOfficeNumber = param.NotaryOfficeNumber;
            item.NotaryOfficeLocation = param.NotaryOfficeLocation;
            if (!string.IsNullOrEmpty(param.ExitDate)) item.ExitDate = DateTime.Parse(param.ExitDate);
            item.UpdatedAt = Helpers.GetServerDateTimeType();
            await _db.SaveChangesAsync();

            
            var amlakPrivate = _db.AmlakPrivateNews.FirstOrDefault(c => c.Id == param.AmlakPrivateId);
            if (amlakPrivate != null){
                amlakPrivate.IsTransfered =1 ;
                await _db.SaveChangesAsync();
            }


            await SaveLogAsync(_db, (int)item.Id, TargetTypes.Transfer, "اطلاعات خروج املاک اختصاصی با شناسه ملک "+item.AmlakPrivateId+" ویرایش شد");

            return Ok(item.Id.ToString());
        }


        [Route("Create")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakPrivateTransferCreate([FromBody] AmlakPrivateTransferStoreVm param){
            await CheckUserAuth(_db);

            var item0 = await _db.AmlakPrivateTransfers.AmlakPrivateId(param.AmlakPrivateId).FirstOrDefaultAsync();
            if (item0 != null)
                return BadRequest(new{ message = "قبلا ثبت شده است" });

            
            var item = new AmlakPrivateTransfer();
            item.AmlakPrivateId = param.AmlakPrivateId;
            item.RecipientType = param.RecipientType;
            item.RecipientName = param.RecipientName;
            item.NationalCode = param.NationalCode;
            item.Representative = param.Representative;
            item.RecipientPhone = param.RecipientPhone;
            item.MunicipalityRepName = param.MunicipalityRepName;
            if (!string.IsNullOrEmpty(param.LetterDate)) item.LetterDate = DateTime.Parse(param.LetterDate);
            item.LetterNumber = param.LetterNumber;
            item.NotaryOfficeNumber = param.NotaryOfficeNumber;
            item.NotaryOfficeLocation = param.NotaryOfficeLocation;
            if (!string.IsNullOrEmpty(param.ExitDate)) item.ExitDate = DateTime.Parse(param.ExitDate);
            item.CreatedAt = Helpers.GetServerDateTimeType();
            item.UpdatedAt = Helpers.GetServerDateTimeType();
            _db.Add(item);
            await _db.SaveChangesAsync();

            var amlakPrivate = _db.AmlakPrivateNews.FirstOrDefault(c => c.Id == param.AmlakPrivateId);
            if (amlakPrivate != null){
                amlakPrivate.IsTransfered =1 ;
                await _db.SaveChangesAsync();
            }
            await SaveLogAsync(_db, item.Id, TargetTypes.Transfer, "اطلاعات خروج املاک اختصاصی با شناسه ملک "+item.AmlakPrivateId+" ثبت شد");

            var item2=await AmlakPrivateApiController.DoAmlakPrivateDocHistoryStore(_db,new AmlakPrivateDocHistoryStoreVm{
                AmlakPrivateId=param.AmlakPrivateId,
                Type="general",
                Status="15",
                Desc="رکورد خودکار به جهت ثبت خروج سند",
                LetterNumber=param.LetterNumber,
                LetterDate=param.LetterDate,
                PersonType=null,
                PersonName=null
            });
            
            await SaveLogAsync(_db, item2.AmlakPrivateId, TargetTypes.AmlakPrivate, "وضعیت سند با شناسه "+item2.Id+" اضافه شد");

            return Ok("ثبت شد");
        }


    }
}