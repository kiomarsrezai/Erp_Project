using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakPrivate {
    [Table("tblAmlakPrivateDocHistory")]
    public class AmlakPrivateDocHistory:BaseModel {
        public int Id{ get; set; }
        public int AmlakPrivateId{ get; set; }
        public string Type{ get; set; } // general / seizure / license / completion
        public string Status{ get; set; }
        public string Desc{ get; set; }
        public DateTime? Date{ get; set; }
        public string LetterNumber{ get; set; }
        public DateTime? LetterDate{ get; set; }
        
        
        
        
        [NotMapped]
        public string? DateFa{
            get{ return Helpers.MiladiToHejri(Date); }
        }
        
        [NotMapped]
        public string? LetterDateFa{
            get{ return Helpers.MiladiToHejri(LetterDate); }
        }
        
         
        [NotMapped]
        public string? StatusText{get{ return Helpers.UC(Status,Type+"DocumentHistoryStatus"); }}
    }

    
    public class AmlakPrivateDocHistoryBaseModel {
        public int AmlakPrivateId{ get; set; }
        public string Type{ get; set; }
        public string Status{ get; set; }
        public string Desc{ get; set; }
        public string LetterNumber{ get; set; } 
        public string LetterDate{ get; set; } 
    }

    public class AmlakPrivateDocHistoryListVm : AmlakPrivateDocHistoryBaseModel {
        public int Id{ get; set; }
        public string Date{ get; set; } 
        public string DateFa{ get; set; } 
        public string LetterDateFa{ get; set; } 
        public string StatusText{ get; set; }
  
    }


    public class AmlakPrivateDocHistoryStoreVm : AmlakPrivateDocHistoryBaseModel {
    }

    
}

//-------------------------------------------------------------------------------------------------
//-------------------------------------------    scopes    ----------------------------------------
//-------------------------------------------------------------------------------------------------


public static class AmlakDocHistoryExtensions {

    public static IQueryable<AmlakPrivateDocHistory> AmlakPrivateId(this IQueryable<AmlakPrivateDocHistory> query, int? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => e.AmlakPrivateId == value);
        }
        return query;
    }
    public static IQueryable<AmlakPrivateDocHistory> Type(this IQueryable<AmlakPrivateDocHistory> query, string? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => e.Type == value);
        }
        return query;
    }
}