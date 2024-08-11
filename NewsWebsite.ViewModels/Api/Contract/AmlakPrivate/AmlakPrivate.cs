using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakPrivate {
    [Table("tblAmlakPrivateNew")]
    public class AmlakPrivateNew:BaseModel {
        public int Id{ get; set; }
        public int AreaId{ get; set; }
        public string Masahat{ get; set; }
        public string Title{ get; set; }
        public string TypeUsing{ get; set; }
        public string SadaCode{ get; set; } 
        public string SdiId{ get; set; }
        public string Coordinates{ get; set; }
    }

    
    public class AmlakPrivateBaseModel {
        public int Id{ get; set; }
        public int AreaId{ get; set; }
        public string Title{ get; set; }
        public string SadaCode{ get; set; } 
    }

    public class AmlakPrivateListVm : AmlakPrivateBaseModel {
        public string SdiId{ get; set; }
        public string Coordinates{ get; set; }
    }

    public class AmlakPrivateReadVm : AmlakPrivateBaseModel {
        public string SdiId{ get; set; }
        public string Coordinates{ get; set; }
        public string Masahat{ get; set; }
        public string TypeUsing{ get; set; }
    }

    public class AmlakPrivateUpdateVm : AmlakPrivateBaseModel {
        public string Masahat{ get; set; }
        public string TypeUsing{ get; set; }
    }


    public class AmlakPrivateReadInputVm {
        public int AreaId{ get; set; }
        public string Masahat{ get; set; }
        public string TypeUsing{ get; set; }
    }

    
    

}

//-------------------------------------------------------------------------------------------------
//-------------------------------------------    scopes    ----------------------------------------
//-------------------------------------------------------------------------------------------------


public static class AmlakExtensions {

    public static IQueryable<AmlakPrivateNew> AreaId(this IQueryable<AmlakPrivateNew> query, int? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => e.AreaId == value);
        }
        return query;
    }
}