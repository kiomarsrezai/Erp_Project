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
    public class AmlakPrivateGeneratingApiController : EnhancedController {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public AmlakPrivateGeneratingApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment, ProgramBuddbContext db){
            _config = config;
            _uw = uw;
            _webHostEnvironment = webHostEnvironment;
            _db = db;
        }


        [Route("List")]
        [HttpGet]
        public async Task<ApiResult<object>> AmlakPrivateGeneratingList(AmlakPrivateGeneratingReadInputVm param){
            await CheckUserAuth(_db);

            var builder = _db.AmlakPrivateGeneratings.AmlakPrivateId(param.AmlakPrivateId);

            var pageCount = (int)Math.Ceiling((await builder.CountAsync()) / Convert.ToDouble(param.PageRows));
            var items = await builder.OrderBy(param.Sort, param.SortType).Page2(param.Page, param.PageRows).ToListAsync();
            var finalItems = MyMapper.MapTo<AmlakPrivateGenerating, AmlakPrivateGeneratingListVm>(items);
            return Ok(new{ items = finalItems, pageCount });
        }

        
          
        [Route("Read")]
        [HttpGet]
        public async Task<ApiResult<AmlakPrivateGeneratingReadVm>> AmlakPrivateGeneratingRead(PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakPrivateGeneratings.Id(param.Id)
                .Include(c=>c.AmlakPrivate)
                .FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");
            
            var finalItem = MyMapper.MapTo<AmlakPrivateGenerating, AmlakPrivateGeneratingReadVm>(item);

            return Ok(finalItem);
        }


        [Route("Update")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakPrivateGeneratingUpdate([FromBody] AmlakPrivateGeneratingUpdateVm param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakPrivateGeneratings.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest(new{ message = "یافت نشد" });

            item.Decision = param.Decision;
            item.DecisionLetterNumber = param.DecisionLetterNumber;
            if (!string.IsNullOrEmpty(param.DecisionLetterDate)) item.DecisionLetterDate = DateTime.Parse(param.DecisionLetterDate);
            item.MunicipalityActionRequired = param.MunicipalityActionRequired;
            item.MunicipalityAction = param.MunicipalityAction;
            item.MunicipalityActionLetterNumber = param.MunicipalityActionLetterNumber;
            item.LegalActionRequired = param.LegalActionRequired;
            item.LegalAction = param.LegalAction;
            item.LegalActionLetterNumber = param.LegalActionLetterNumber;
            item.UrbanPlanningPermitRequired = param.UrbanPlanningPermitRequired;
            item.UrbanPlanningPermitNumber = param.UrbanPlanningPermitNumber;
            if (!string.IsNullOrEmpty(param.UrbanPlanningPermitDate)) item.UrbanPlanningPermitDate = DateTime.Parse(param.UrbanPlanningPermitDate);
            item.DocumentImage=param.DocumentImage;
            item.ArchitecturalMapImage=param.ArchitecturalMapImage;
            item.SurveyMapImage=param.SurveyMapImage;
            item.PermitImage=param.PermitImage;
            item.MoldReportImage=param.MoldReportImage;
            item.ActionHistory=param.ActionHistory;
            item.FollowUpSentTo1=param.FollowUpSentTo1;
            item.LetterNumber1=param.LetterNumber1;
            if (!string.IsNullOrEmpty(param.LetterDate1)) item.LetterDate1 = DateTime.Parse(param.LetterDate1);
            item.FollowUpSentTo2=param.FollowUpSentTo2;
            item.LetterNumber2=param.LetterNumber2;
            if (!string.IsNullOrEmpty(param.LetterDate2)) item.LetterDate2 = DateTime.Parse(param.LetterDate2);
            item.FollowUpSentTo3=param.FollowUpSentTo3;
            item.LetterNumber3=param.LetterNumber3;
            if (!string.IsNullOrEmpty(param.LetterDate3)) item.LetterDate3 = DateTime.Parse(param.LetterDate3);
            item.UpdatedAt = Helpers.GetServerDateTimeType();
            await _db.SaveChangesAsync();

            var amlakPrivate = _db.AmlakPrivateNews.FirstOrDefault(c => c.Id == item.AmlakPrivateId);
            if (amlakPrivate != null){
                var lastDecision = await _db.AmlakPrivateGeneratings.AmlakPrivateId(item.AmlakPrivateId).OrderByDescending(c=>c.Id).FirstOrDefaultAsync();
                amlakPrivate.LatestGeneratingDecision =lastDecision.Decision ;
                await _db.SaveChangesAsync();
            }
            
            await SaveLogAsync(_db, (int)item.AmlakPrivateId, TargetTypes.AmlakPrivate, "مولدسازی با شناسه "+item.Id+" ویرایش شد");

            return Ok(item.Id.ToString());
        }


        [Route("Create")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakPrivateGeneratingCreate([FromBody] AmlakPrivateGeneratingStoreVm param){
            await CheckUserAuth(_db);

            var item = new AmlakPrivateGenerating();
            item.Decision = param.Decision;
            item.DecisionLetterNumber = param.DecisionLetterNumber;
            if (!string.IsNullOrEmpty(param.DecisionLetterDate)) item.DecisionLetterDate = DateTime.Parse(param.DecisionLetterDate);
            item.AmlakPrivateId = param.AmlakPrivateId;
            item.MunicipalityActionRequired = param.MunicipalityActionRequired;
            item.MunicipalityAction = param.MunicipalityAction;
            item.MunicipalityActionLetterNumber = param.MunicipalityActionLetterNumber;
            item.LegalActionRequired = param.LegalActionRequired;
            item.LegalAction = param.LegalAction;
            item.LegalActionLetterNumber = param.LegalActionLetterNumber;
            item.UrbanPlanningPermitRequired = param.UrbanPlanningPermitRequired;
            item.UrbanPlanningPermitNumber = param.UrbanPlanningPermitNumber;
            if (!string.IsNullOrEmpty(param.UrbanPlanningPermitDate)) item.UrbanPlanningPermitDate = DateTime.Parse(param.UrbanPlanningPermitDate);
            item.DocumentImage=param.DocumentImage;
            item.ArchitecturalMapImage=param.ArchitecturalMapImage;
            item.SurveyMapImage=param.SurveyMapImage;
            item.PermitImage=param.PermitImage;
            item.MoldReportImage=param.MoldReportImage;
            item.ActionHistory=param.ActionHistory;
            item.FollowUpSentTo1=param.FollowUpSentTo1;
            item.LetterNumber1=param.LetterNumber1;
            if (!string.IsNullOrEmpty(param.LetterDate1)) item.LetterDate1 = DateTime.Parse(param.LetterDate1);
            item.FollowUpSentTo2=param.FollowUpSentTo2;
            item.LetterNumber2=param.LetterNumber2;
            if (!string.IsNullOrEmpty(param.LetterDate2)) item.LetterDate2 = DateTime.Parse(param.LetterDate2);
            item.FollowUpSentTo3=param.FollowUpSentTo3;
            item.LetterNumber3=param.LetterNumber3;
            if (!string.IsNullOrEmpty(param.LetterDate3)) item.LetterDate3 = DateTime.Parse(param.LetterDate3);
            item.CreatedAt = Helpers.GetServerDateTimeType();
            item.UpdatedAt = Helpers.GetServerDateTimeType();
            _db.Add(item);
            await _db.SaveChangesAsync();

            var amlakPrivate = _db.AmlakPrivateNews.FirstOrDefault(c => c.Id == param.AmlakPrivateId);
            if (amlakPrivate != null){
                amlakPrivate.LatestGeneratingDecision =param.Decision ;
                await _db.SaveChangesAsync();
            }

            
            await SaveLogAsync(_db, (int)item.AmlakPrivateId, TargetTypes.AmlakPrivate, "مولدسازی با شناسه "+item.Id+" اضافه شد");

            
            return Ok(item.Id.ToString());
        }


    }
}