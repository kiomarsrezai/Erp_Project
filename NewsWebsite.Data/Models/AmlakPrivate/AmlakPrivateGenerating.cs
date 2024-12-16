using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Common;
using NewsWebsite.Entities;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models.AmlakPrivate {
    [Table("tblAmlakPrivateGenerating")]
    public class AmlakPrivateGenerating:BaseModel {
        public int? AmlakPrivateId{ get; set; }
        public int? Decision { get; set; } // تصمیم شورای سیاست گذاری املاک
        public string? DecisionLetterNumber { get; set; } // شماره نامه تصویو شورا
        public DateTime? DecisionLetterDate { get; set; } // تاریخ تصمیم شورا
        public int? MunicipalityActionRequired{ get; set; } // نیاز به اقدام شهرداری
        public int? MunicipalityAction{ get; set; } // اقدام شهرداری
        public string? MunicipalityActionLetterNumber{ get; set; } // شماره نامه اقدام شهرداری
        public int? LegalActionRequired{ get; set; } // نیاز به اقدام حقوقی
        public string? LegalAction{ get; set; } // اقدام حقوقی
        public string? LegalActionLetterNumber{ get; set; } // شماره نامه حقوقی
        public int? UrbanPlanningPermitRequired{ get; set; } // نیاز به پروانه شهرسازی
        public string? UrbanPlanningPermitNumber{ get; set; } // شماره پروانه شهرسازی
        public DateTime? UrbanPlanningPermitDate{ get; set; } // تاریخ پروانه شهرسازی
        public DateTime? UrbanPlanningPermitLetterDate{ get; set; } // تاریخ نامه شهرسازی
        public string? DocumentImage{ get; set; } // تصویر سند
        public string? ArchitecturalMapImage{ get; set; } // تصویر نقشه معماری
        public string? SurveyMapImage{ get; set; } // تصویر نقشه برداری
        public string? PermitImage{ get; set; } // تصویر پروانه
        public string? MoldReportImage{ get; set; } // تصویر گزارش مولدسازی
        public int? ActionHistory{ get; set; } // سابقه اقدام
        public int? FollowUpSentTo1{ get; set; } // پیگیری اول ارسال به
        public string? LetterNumber1{ get; set; } // شماره نامه اول
        public DateTime? LetterDate1{ get; set; } // تاریخ نامه اول
        public int? FollowUpSentTo2{ get; set; } // پیگیری دوم ارسال به
        public string? LetterNumber2{ get; set; } // شماره نامه دوم
        public DateTime? LetterDate2{ get; set; } // تاریخ نامه دوم
        public int? FollowUpSentTo3{ get; set; } // پیگیری سوم ارسال به
        public string? LetterNumber3{ get; set; } // شماره نامه سوم
        public DateTime? LetterDate3{ get; set; } // تاریخ نامه سوم
        public DateTime? CreatedAt{ get; set; }
        public DateTime? UpdatedAt{ get; set; }
        
        
        public virtual AmlakPrivateNew AmlakPrivate{ get; set; }

        [NotMapped]
        public string? CreatedAtFa{get{ return Helpers.MiladiToHejri(CreatedAt); }}

        [NotMapped]
        public string? UpdatedAtFa{get{ return Helpers.MiladiToHejri(UpdatedAt); }}
        
        [NotMapped]
        public string? UrbanPlanningPermitDateFa{get{ return Helpers.MiladiToHejri(UrbanPlanningPermitDate); }}
        
        [NotMapped]
        public string? UrbanPlanningPermitLetterDateFa{get{ return Helpers.MiladiToHejri(UrbanPlanningPermitLetterDate); }}
        
        [NotMapped]
        public string? DecisionLetterDateFa{get{ return Helpers.MiladiToHejri(DecisionLetterDate); }}
        
        [NotMapped]
        public string? LetterDate1Fa{get{ return Helpers.MiladiToHejri(LetterDate1); }}
        
        [NotMapped]
        public string? LetterDate2Fa{get{ return Helpers.MiladiToHejri(LetterDate2); }}
        
        [NotMapped]
        public string? LetterDate3Fa{get{ return Helpers.MiladiToHejri(LetterDate3); }}
        
        [NotMapped]
        public string? DecisionText{get{ return Helpers.UC(Decision,"amlakPrivateGeneratingDecision"); }}
        
        [NotMapped]
        public string? MunicipalityActionRequiredText{get{ return Helpers.UC(MunicipalityActionRequired,"hasOrNotHas"); }}
         
        [NotMapped]
        public string? MunicipalityActionText{get{ return Helpers.UC(MunicipalityAction,"amlakPrivateGeneratingMunicipalityAction"); }}
        
        [NotMapped]
        public string? LegalActionRequiredText{get{ return Helpers.UC(LegalActionRequired,"hasOrNotHas"); }}
         
        [NotMapped]
        public string? UrbanPlanningPermitRequiredText{get{ return Helpers.UC(UrbanPlanningPermitRequired,"hasOrNotHas"); }}
         
        [NotMapped]
        public string? ActionHistoryText{get{ return Helpers.UC(ActionHistory,"amlakPrivateGeneratingActionHistory"); }}
         
        [NotMapped]
        public string? FollowUpSentTo1Text{get{ return Helpers.UC(FollowUpSentTo1,"amlakPrivateGeneratingFollowUpSentTo"); }}
          
        [NotMapped]
        public string? FollowUpSentTo2Text{get{ return Helpers.UC(FollowUpSentTo2,"amlakPrivateGeneratingFollowUpSentTo"); }}
          
        [NotMapped]
        public string? FollowUpSentTo3Text{get{ return Helpers.UC(FollowUpSentTo3,"amlakPrivateGeneratingFollowUpSentTo"); }}
        
        
    }
    
    //-------------------------------------------------------------------------------------------------
//-------------------------------------------    scopes    ----------------------------------------
//-------------------------------------------------------------------------------------------------


    public static class AmlakPrivateGeneratingExtensions {

        public static IQueryable<AmlakPrivateGenerating> AmlakPrivateId(this IQueryable<AmlakPrivateGenerating> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.AmlakPrivateId == value);
            }
            return query;
        }
        
        public static IQueryable<AmlakPrivateGenerating> Decision(this IQueryable<AmlakPrivateGenerating> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.Decision == value);
            }
            return query;
        }
        public static IQueryable<AmlakPrivateGenerating> MainPlateNumber(this IQueryable<AmlakPrivateGenerating> query, string? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.AmlakPrivate.MainPlateNumber == value);
            }
            return query;
        }        
        public static IQueryable<AmlakPrivateGenerating> SubPlateNumber(this IQueryable<AmlakPrivateGenerating> query, string? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.AmlakPrivate.SubPlateNumber == value);
            }
            return query;
        }
        
    }
}