using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.AspNetCore.Http;
using NewsWebsite.Common;
using NewsWebsite.Data.Models.AmlakInfo;
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
        public int? SupplierId{ get; set; }
        public int? ContractId{ get; set; }
        public DateTime? CreatedAt{ get; set; }
        public DateTime? UpdatedAt{ get; set; }

        public AmlakInfoContract? Contract{ get; set; }
        public Supplier? Supplier{ get; set; }
        
        
        [NotMapped]
        public string? DateFa{get{ return Helpers.MiladiToHejri(Date); }}
        
        [NotMapped]
        public string? CreatedAtFa{get{ return Helpers.MiladiToHejri(CreatedAt); }}

        [NotMapped]
        public string? UpdatedAtFa{get{ return Helpers.MiladiToHejri(UpdatedAt); }}
        
        [NotMapped]
        public string? SubjectText{get{ return Helpers.UC(Subject,"compliantSubject"); }}
        
        [NotMapped]
        public string? StatusText{get{ return Helpers.UC(Status,"compliantStatus"); }}
        
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
    public static IQueryable<AmlakCompliant> SupplierId(this IQueryable<AmlakCompliant> query, int? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => e.SupplierId == value);
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