using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models.AmlakPrivate {
    [Table("tblAmlakPrivateTransfer")]
    public class AmlakPrivateTransfer
    {
        public int Id { get; set; } 
        public int AmlakPrivateId { get; set; } 
        public int RecipientType { get; set; } // انتقال به شخص حقیقی/حقوقی
        public string RecipientName { get; set; }  // نام گیرنده/شرکت گیرنده
        public string NationalCode { get; set; }  // کد ملی/شناسه ملی
        public string? Representative { get; set; } // وکیل یا نماینده شرکت
        public string? RecipientPhone { get; set; } // شماره تماس گیرنده
        public string? MunicipalityRepName { get; set; } // نام نماینده شهرداری
        public DateTime LetterDate { get; set; } // تاریخ نامه
        public string LetterNumber { get; set; }  // شماره نامه
        public string? NotaryOfficeNumber { get; set; } // شماره دفترخانه
        public string? NotaryOfficeLocation { get; set; } // محل دفترخانه
        public DateTime? ExitDate { get; set; } // تاریخ خروج
        public int? Reason { get; set; }
        public string? Desc { get; set; }
        public DateTime? UpdatedAt { get; set; } 
        public DateTime? CreatedAt { get; set; } 
        
        
        public virtual AmlakPrivateNew AmlakPrivate{ get; set; }

             
        [NotMapped]
        public string? LetterDateFa{
            get{ return Helpers.MiladiToHejri(LetterDate); }
        }

        [NotMapped]
        public string? ExitDateFa{
            get{ return Helpers.MiladiToHejri(ExitDate); }
        }
   
        [NotMapped]
        public string? UpdatedAtFa{
            get{ return Helpers.MiladiToHejri(UpdatedAt); }
        }
        
        [NotMapped]
        public string? CreatedAtFa{
            get{ return Helpers.MiladiToHejri(CreatedAt); }
        }
        
         
        [NotMapped]
        public string? RecipientTypeText{get{ return Helpers.UC(RecipientType,"transferRecipientType"); }}
         
        [NotMapped]
        public string? ReasonText{get{ return Helpers.UC(Reason,"TransferReasons"); }}
        
    }

    
    
    
//-------------------------------------------------------------------------------------------------
//-------------------------------------------    scopes    ----------------------------------------
//-------------------------------------------------------------------------------------------------


    public static class TransferExtensions {

        public static IQueryable<AmlakPrivateTransfer> AmlakPrivateId(this IQueryable<AmlakPrivateTransfer> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.AmlakPrivateId == value);
            }
            return query;
        }
        public static IQueryable<AmlakPrivateTransfer> RecipientName(this IQueryable<AmlakPrivateTransfer> query, string? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.RecipientName == value);
            }
            return query;
        }
    }
}