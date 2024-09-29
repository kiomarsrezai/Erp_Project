using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.AspNetCore.Http;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Contract.AmlakCompliant;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakCompliant {
    [Table("tblAmlakCompliant")]
    public class AmlakCompliant:BaseModel {
        public int AmlakInfoId{ get; set; }
        public string Subject{ get; set; }
        public string Description{ get; set; }
        public string FileNumber{ get; set; }
        public string Status{ get; set; } // 
        public string Date{ get; set; }
        public string Steps{ get; set; }
        public DateTime? CreatedAt{ get; set; }
        public DateTime? UpdatedAt{ get; set; }

        
        
        [NotMapped]
        public string? DateFa{get{ return Helpers.MiladiToHejri(Date); }}
        
        [NotMapped]
        public string? CreatedAtFa{get{ return Helpers.MiladiToHejri(CreatedAt); }}

        [NotMapped]
        public string? UpdatedAtFa{get{ return Helpers.MiladiToHejri(UpdatedAt); }}
        
    }

    
    public class AmlakCompliantBaseModel {
        public string Subject{ get; set; }
        public string FileNumber{ get; set; }
        public string Date{ get; set; }
        public string DateFa{ get; set; }
    }

    public class AmlakCompliantListVm : AmlakCompliantBaseModel {
        public int Id{ get; set; }
        public int AmlakInfoId{ get; set; }
        public string Status{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }

    }

    public class AmlakCompliantReadVm : AmlakCompliantBaseModel {
        public int Id{ get; set; }
        public int AmlakInfoId{ get; set; }
        public string Status{ get; set; }
        public string Description{ get; set; }
        public string Steps{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }

    }
    public class AmlakCompliantStoreVm : AmlakCompliantBaseModel {
        public int AmlakInfoId{ get; set; }
        public string Status{ get; set; }
        public string Description{ get; set; }
        public string Steps{ get; set; }

    }
    public class AmlakCompliantUpdateVm : AmlakCompliantBaseModel {
        public int Id{ get; set; }
        public string Description{ get; set; }
    }
    public class AmlakCompliantUpdateStatusVm  {
        public int Id{ get; set; }
        public string Status{ get; set; }
        public string Steps{ get; set; }
    }
    public class AmlakCompliantReadInputVm  {
        public int AmlakInfoId{ get; set; }
        public string Subject{ get; set; }
        public string FileNumber{ get; set; }
        public string Status{ get; set; }
    }

    public class AmlakCompliantStoreResultVm {
        public int Id{ get; set; }
        public string Message{ get; set; }
    }

}

//-------------------------------------------------------------------------------------------------
//-------------------------------------------    scopes    ----------------------------------------
//-------------------------------------------------------------------------------------------------


public static class AmlakCompliantExtensions {

    public static IQueryable<AmlakCompliant> AmlakInfoId(this IQueryable<AmlakCompliant> query, int? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => e.AmlakInfoId == value);
        }
        return query;
    }
    public static IQueryable<AmlakCompliant> Subject(this IQueryable<AmlakCompliant> query, string? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => e.Subject == value);
        }
        return query;
    }
    public static IQueryable<AmlakCompliant> FileNumber(this IQueryable<AmlakCompliant> query, string? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => e.FileNumber == value);
        }
        return query;
    }
    public static IQueryable<AmlakCompliant> Status(this IQueryable<AmlakCompliant> query, string? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => e.Status == value);
        }
        return query;
    }
}