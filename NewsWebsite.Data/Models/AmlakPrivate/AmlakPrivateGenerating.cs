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
        public int Id{ get; set; }
        public int AmlakPrivateId{ get; set; }
        public string MunicipalityActionRequired{ get; set; } // نیاز به اقدام شهرداری
        public string MunicipalityAction{ get; set; } // اقدام شهرداری
        public string MunicipalityActionLetterNumber{ get; set; } // شماره نامه اقدام شهرداری
        public string LegalActionRequired{ get; set; } // نیاز به اقدام حقوقی
        public string LegalAction{ get; set; } // اقدام حقوقی
        public string LegalActionLetterNumber{ get; set; } // شماره نامه حقوقی
        public string UrbanPlanningPermitRequired{ get; set; } // نیاز به پروانه شهرسازی
        public string UrbanPlanningPermitNumber{ get; set; } // شماره پروانه شهرسازی
        public string UrbanPlanningPermitDate{ get; set; } // تاریخ پروانه شهرسازی
        public string DocumentImage{ get; set; } // تصویر سند
        public string ArchitecturalMapImage{ get; set; } // تصویر نقشه معماری
        public string SurveyMapImage{ get; set; } // تصویر نقشه برداری
        public string PermitImage{ get; set; } // تصویر پروانه
        public string MoldReportImage{ get; set; } // تصویر گزارش مولدسازی
        public string ActionHistory{ get; set; } // سابقه اقدام
        public string FollowUpSentTo1{ get; set; } // پیگیری اول ارسال به
        public string LetterNumber1{ get; set; } // شماره نامه اول
        public DateTime? LetterDate1{ get; set; } // تاریخ نامه اول
        public string FollowUpSentTo2{ get; set; } // پیگیری دوم ارسال به
        public string LetterNumber2{ get; set; } // شماره نامه دوم
        public DateTime? LetterDate2{ get; set; } // تاریخ نامه دوم
        public string FollowUpSentTo3{ get; set; } // پیگیری سوم ارسال به
        public string LetterNumber3{ get; set; } // شماره نامه سوم
        public DateTime? LetterDate3{ get; set; } // تاریخ نامه سوم
        public DateTime? CreatedAt{ get; set; }
        public DateTime? UpdatedAt{ get; set; }
        
        
        public virtual AmlakPrivateNew AmlakPrivate{ get; set; }

        [NotMapped]
        public string? CreatedAtFa{get{ return Helpers.MiladiToHejri(CreatedAt); }}

        [NotMapped]
        public string? UpdatedAtFa{get{ return Helpers.MiladiToHejri(UpdatedAt); }}
        
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
        
    }
}