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
        public string Status{ get; set; }
        public string Desc{ get; set; }
        public DateTime Date{ get; set; }
        
        
        
        
        [NotMapped]
        public string? DateFa{
            get{ return Helpers.MiladiToHejri(Date); }
        }
    }

    
    public class AmlakPrivateDocHistoryBaseModel {
        public int AmlakPrivateId{ get; set; }
        public string Status{ get; set; }
        public string Desc{ get; set; }
    }

    public class AmlakPrivateDocHistoryListVm : AmlakPrivateDocHistoryBaseModel {
        public int Id{ get; set; }
        public string Date{ get; set; } 
        public string DateFa{ get; set; } 
        
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
}