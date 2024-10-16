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
        public double Masahat{ get; set; }
        public string TypeUsing{ get; set; }
        public int DocumentType{ get; set; }
        public string SadaCode{ get; set; } 
        public string JamCode{ get; set; } 
        public string SimakCode { get; set; }
        public string SdiId{ get; set; }
        public string SdiPlateNumber{ get; set; }
        public string Coordinates{ get; set; }
        public string PredictionUsage{ get; set; } // sell , arrest , special , Participation , separation
        public string MainPlateNumber { get; set; }
        public string SubPlateNumber { get; set; }
        public string Section { get; set; }
        public string Address { get; set; }
        public string UsageOnDocument { get; set; }
        public string UsageUrban { get; set; }
        public string PropertyType { get; set; }
        public string OwnershipType { get; set; }
        public string OwnershipPercentage { get; set; }
        public string TransferredFrom { get; set; }
        public string InPossessionOf { get; set; }
        public string BlockedStatusSimakUnitWindow { get; set; }
        public string Status { get; set; }
        public string Notes { get; set; }
        public string ArchiveLocation { get; set; }
        public string DocumentSerial { get; set; }
        public string DocumentSeries { get; set; }
        public string DocumentAlphabet { get; set; }
        public string PropertyCode { get; set; }
        public string Year { get; set; }
        public string EntryDate { get; set; }
        public string InternalDate { get; set; }
        public string ProductiveAssetStrategies { get; set; }
        public DateTime? CreatedAt{ get; set; }
        public DateTime? UpdatedAt{ get; set; }
        
        
        public virtual TblAreas Area{ get; set; }
        public virtual TblAreas Owner{ get; set; }

        [NotMapped]
        public string? CreatedAtFa{get{ return Helpers.MiladiToHejri(CreatedAt); }}

        [NotMapped]
        public string? UpdatedAtFa{get{ return Helpers.MiladiToHejri(UpdatedAt); }}
        
        [NotMapped]
        public string? DocumentTypeText{get{ return Helpers.UC(DocumentType,"amlakPrivateDocumentType"); }}  
        [NotMapped]
        public string? PredictionUsageText{get{ return Helpers.UC(PredictionUsage,"amlakPrivatePredictionUsage"); }}
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
        public static IQueryable<AmlakPrivateNew> MasahatFrom(this IQueryable<AmlakPrivateNew> query, double? value){
            if (BaseModel.CheckParameter(value,0d)){
                return query.Where(e => e.Masahat >= value);
            }
            return query;
        }
        public static IQueryable<AmlakPrivateNew> MasahatTo(this IQueryable<AmlakPrivateNew> query, double? value){
            if (BaseModel.CheckParameter(value,0d)){
                return query.Where(e => e.Masahat <= value);
            }
            return query;
        }
        public static IQueryable<AmlakPrivateNew> DocumentType(this IQueryable<AmlakPrivateNew> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.DocumentType == value);
            }
            return query;
        }
        public static IQueryable<AmlakPrivateNew> TypeUsing(this IQueryable<AmlakPrivateNew> query, string? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => EF.Functions.Like(e.TypeUsing, $"%{value}%"));
            }
            return query;
        }
        public static IQueryable<AmlakPrivateNew> SadaCode(this IQueryable<AmlakPrivateNew> query, string? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.SadaCode == value);
            }
            return query;
        }
        public static IQueryable<AmlakPrivateNew> MainPlateNumber(this IQueryable<AmlakPrivateNew> query, string? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.MainPlateNumber == value);
            }
            return query;
        }
        public static IQueryable<AmlakPrivateNew> SubPlateNumber(this IQueryable<AmlakPrivateNew> query, string? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.SubPlateNumber == value);
            }
            return query;
        }
        public static IQueryable<AmlakPrivateNew> JamCode(this IQueryable<AmlakPrivateNew> query, string? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.JamCode == value);
            }
            return query;
        }
        
        public static IQueryable<AmlakPrivateNew> PropertyType(this IQueryable<AmlakPrivateNew> query, int? value){
            if (BaseModel.CheckParameter(value,null)){
                return query.Where(e => e.PropertyType == value.ToString());
            }
            return query;
        }
        
        public static IQueryable<AmlakPrivateNew> Search(this IQueryable<AmlakPrivateNew> query, string? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(a=> EF.Functions.Like(a.Title, $"%{value}%") || 
                                      EF.Functions.Like(a.TypeUsing, $"%{value}%")
                );
            }
            return query;
        }
    }
}