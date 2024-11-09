using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.AspNetCore.Http;
using NewsWebsite.Common;
using NewsWebsite.Data.Models.AmlakInfo;
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakLog {
    [Table("tblAmlakLogs")]
    public class AmlakLog:BaseModel {
        public int TargetId{ get; set; }
        public TargetTypes TargetType{ get; set; }
        public DateTime? Date{ get; set; }
        public int AdminId{ get; set; }
        public string Description{ get; set; }

        public Data.Models.AmlakAdmin.AmlakAdmin Admin{ get; set; }
        
        [NotMapped]
        public string? DateFa{get{ return Helpers.MiladiToHejri(Date); }}
        
        [NotMapped]
        public string? TargetTypeText{get{ return Helpers.UC(TargetType.ToString(),"logTargetType"); }}

        [NotMapped]
        public string? TargetUrlPrefix{get{ return Helpers.UC(TargetType.ToString(),"logTargetUrlPrefix"); }}

    }


    public enum TargetTypes {
        AmlakInfo=1,
        AmlakPrivate=2,
        Contract=3,
        Agreement=4,
        Archive=5,
        Parcel=6,
        Supplier=7,
        Admin=8,
    
    }
}

//-------------------------------------------------------------------------------------------------
//-------------------------------------------    scopes    ----------------------------------------
//-------------------------------------------------------------------------------------------------


public static class AmlakLogExtensions {

    public static IQueryable<AmlakLog> TargetId(this IQueryable<AmlakLog> query, int? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => e.TargetId == value);
        }
        return query;
    }
    public static IQueryable<AmlakLog> TargetType(this IQueryable<AmlakLog> query, int? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => e.TargetType == (TargetTypes)Enum.ToObject(typeof(TargetTypes), value));
            ;
        }
        return query;
    }
    public static IQueryable<AmlakLog> AdminId(this IQueryable<AmlakLog> query, int? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => e.AdminId == value);
        }
        return query;
    }
}