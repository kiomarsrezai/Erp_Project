using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models.AmlakArchive {
    
    [Table("tblAmlakArchive")]
    public class AmlakArchive:BaseModel {
        public int Id{ get; set; }
        public string SdiId{ get; set; }
        public int IsSubmitted{ get; set; }
        public int AreaId{ get; set; }
        public int OwnerId{ get; set; }
        public string Title{ get; set; }
        public string ArchiveCode{ get; set; }
        public string AmlakCode{ get; set; }
        public string Section{ get; set; }
        public string Plaque1{ get; set; }
        public string Plaque2{ get; set; }
        public string Description{ get; set; }
        public string Address{ get; set; }
        public string Coordinates{ get; set; }
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
        public static IQueryable<AmlakArchive> AreaId(this IQueryable<AmlakArchive> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.AreaId == value);
            }
            return query;
        }
        public static IQueryable<AmlakArchive> OwnerId(this IQueryable<AmlakArchive> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.OwnerId == value);
            }
            return query;
        }
        public static IQueryable<AmlakArchive> IsSubmitted(this IQueryable<AmlakArchive> query, int? value){
            if (BaseModel.CheckParameter(value,null)){
                return query.Where(e => e.IsSubmitted == value);
            }
            return query;
        }
        public static IQueryable<AmlakArchive> Search(this IQueryable<AmlakArchive> query, string? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(a => EF.Functions.Like(a.Address, $"%{value}%") ||
                                        EF.Functions.Like(a.Title, $"%{value}%") ||
                                        EF.Functions.Like(a.Description, $"%{value}%"));
            }
            return query;
        }
    }
}