using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.AspNetCore.Http;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.Public;
using Microsoft.EntityFrameworkCore;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakPrivate {
    [Table("tblAmlakParcel")]
    public class AmlakParcel:BaseModel {
        public string Title{ get; set; }
        public string FileDWG{ get; set; }
        public string FileKrooki{ get; set; }
        public string Type{ get; set; } // municipality ,  archive , contract
        public string Status{ get; set; } // pending , accepted , rejected , removed
        public string Comment{ get; set; }
    }

    
    public class AmlakParcelBaseModel {
        public string Title{ get; set; }
        public string Type{ get; set; } // municipality ,  archive , contract
    }

    public class AmlakParcelListVm : AmlakParcelBaseModel {
        public int Id{ get; set; }
        public string Status{ get; set; } // pending , accepted , rejected , removed
    }

    public class AmlakParcelReadVm : AmlakParcelBaseModel {
        public int Id{ get; set; }
        public string FileDWG{ get; set; }
        public string FileKrooki{ get; set; }
        public string Comment{ get; set; }
        public string Status{ get; set; } // pending , accepted , rejected , removed
    
    }
    public class AmlakParcelStoreVm : AmlakParcelBaseModel {
        public IFormFile FileDWG{ get; set; }
        public IFormFile FileKrooki{ get; set; }
        public string Comment{ get; set; }
    }
    public class AmlakParcelUpdateVm : AmlakParcelBaseModel {
        public int Id{ get; set; }
        public IFormFile? FileDWG{ get; set; }
        public IFormFile? FileKrooki{ get; set; }
        public string Comment{ get; set; }
    
    }
    public class AmlakParcelUpdateStatusVm  {
        public int Id{ get; set; }
        public string Status{ get; set; } // pending , accepted , rejected , removed
        public string Comment{ get; set; } 
    
    }
    public class AmlakParcelReadInputVm : AmlakParcelBaseModel {
    }


}

//-------------------------------------------------------------------------------------------------
//-------------------------------------------    scopes    ----------------------------------------
//-------------------------------------------------------------------------------------------------


public static class AmlakParcelExtensions {

    public static IQueryable<AmlakParcel> Type(this IQueryable<AmlakParcel> query, string? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => e.Type == value);
        }
        return query;
    }
    public static IQueryable<AmlakParcel> Title(this IQueryable<AmlakParcel> query, string? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => EF.Functions.Like(e.Title, $"%{value}%"));
        }
        return query;
    }
}