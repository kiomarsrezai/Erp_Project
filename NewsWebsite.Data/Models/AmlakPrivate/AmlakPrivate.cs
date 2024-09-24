using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Common;
using NewsWebsite.Entities;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models.AmlakPrivate {
    [Table("tblAmlakPrivateNew")]
    public class AmlakPrivateNew:BaseModel {
        public int Id{ get; set; }
        public int AreaId{ get; set; }
        public int OwnerId{ get; set; }
        public string Title{ get; set; }
        public int Masahat{ get; set; }
        public string TypeUsing{ get; set; }
        public int DocumentType{ get; set; }
        public string SadaCode{ get; set; } 
        public string SdiId{ get; set; }
        public string Coordinates{ get; set; }
        public string PredictionUsage{ get; set; } // sell , arrest , special , Participation , separation
        public DateTime? CreatedAt{ get; set; }
        public DateTime? UpdatedAt{ get; set; }
        
        
        public virtual TblAreas Area{ get; set; }
        public virtual TblAreas Owner{ get; set; }

        [NotMapped]
        public string? CreatedAtFa{get{ return Helpers.MiladiToHejri(CreatedAt); }}

        [NotMapped]
        public string? UpdatedAtFa{get{ return Helpers.MiladiToHejri(UpdatedAt); }}
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
        public static IQueryable<AmlakPrivateNew> OwnerId(this IQueryable<AmlakPrivateNew> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.OwnerId == value);
            }
            return query;
        }
        public static IQueryable<AmlakPrivateNew> MasahatFrom(this IQueryable<AmlakPrivateNew> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.Masahat >= value);
            }
            return query;
        }
        public static IQueryable<AmlakPrivateNew> MasahatTo(this IQueryable<AmlakPrivateNew> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.Masahat <= value);
            }
            return query;
        }
        public static IQueryable<AmlakPrivateNew> DocumentType(this IQueryable<AmlakPrivateNew> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.DocumentType <= value);
            }
            return query;
        }
        public static IQueryable<AmlakPrivateNew> TypeUsing(this IQueryable<AmlakPrivateNew> query, string? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => EF.Functions.Like(e.TypeUsing, $"%{value}%"));
            }
            return query;
        }
    }
}