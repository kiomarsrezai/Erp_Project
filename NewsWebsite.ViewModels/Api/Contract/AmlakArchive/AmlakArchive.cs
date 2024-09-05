using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.AspNetCore.Http;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakPrivate {
    [Table("tblAmlakArchive")]
    public class AmlakArchive:BaseModel {
        public int Id{ get; set; }
        public string ArchiveCode{ get; set; }
        public string AmlakCode{ get; set; }
        public string JamCode{ get; set; }
        public string AreaCode{ get; set; }
        public string Section{ get; set; }
        public string Plaque1{ get; set; }
        public string Plaque2{ get; set; }
        public string Owner{ get; set; }
        public string Description{ get; set; }
        public string Address{ get; set; }
        public string Latitude{ get; set; }
        public string Longitude{ get; set; }
    }

    
    public class AmlakArchiveBaseModel {
        public string ArchiveCode{ get; set; }
        public string AmlakCode{ get; set; }
        public string JamCode{ get; set; }
        public string AreaCode{ get; set; }
        public string Section{ get; set; }
        public string Plaque1{ get; set; }
        public string Plaque2{ get; set; }
        public string Owner{ get; set; }
        public string Latitude{ get; set; }
        public string Longitude{ get; set; }
    }

    public class AmlakArchiveListVm : AmlakArchiveBaseModel {
        public int Id{ get; set; }
    }

    public class AmlakArchiveReadVm : AmlakArchiveBaseModel {
        public int Id{ get; set; }
        public string Description{ get; set; }
        public string Address{ get; set; }

    }
    public class AmlakArchiveStoreVm : AmlakArchiveBaseModel {
        public string Address{ get; set; }
        public string Description{ get; set; }
    }
    public class AmlakArchiveUpdateVm : AmlakArchiveBaseModel {
        public int Id{ get; set; }
        public string Address{ get; set; }
        public string Description{ get; set; }
    
    }
    public class AmlakArchiveReadInputVm  {
        public string ArchiveCode{ get; set; }
        public string AmlakCode{ get; set; }
        public string JamCode{ get; set; }
        public string AreaCode{ get; set; }
    }

    public class AmlakArchiveStoreResultVm {
        public int Id{ get; set; }
        public string Message{ get; set; }
    }

}

//-------------------------------------------------------------------------------------------------
//-------------------------------------------    scopes    ----------------------------------------
//-------------------------------------------------------------------------------------------------


public static class AmlakArchiveExtensions {

    public static IQueryable<AmlakArchive> ArchiveCode(this IQueryable<AmlakArchive> query, string? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => e.ArchiveCode == value);
        }
        return query;
    }
    public static IQueryable<AmlakArchive> AmlakCode(this IQueryable<AmlakArchive> query, string? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => e.AmlakCode == value);
        }
        return query;
    }
    public static IQueryable<AmlakArchive> JamCode(this IQueryable<AmlakArchive> query, string? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => e.JamCode == value);
        }
        return query;
    }
    public static IQueryable<AmlakArchive> AreaCode(this IQueryable<AmlakArchive> query, string? value){
        if (BaseModel.CheckParameter(value,0)){
            return query.Where(e => e.AreaCode == value);
        }
        return query;
    }
}