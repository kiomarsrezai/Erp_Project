using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Common;
using NewsWebsite.Entities;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models.AmlakPrivate {
    [Table("tblAmlakPrivateNew")]
    public class AmlakPrivateNew:BaseModel {
        public int Id{ get; set; }
        public int AreaId{ get; set; }
        public int OwnerId{ get; set; }
        public string Title{ get; set; }
        public double Masahat{ get; set; }
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
        public string OwnershipValueType { get; set; }
        public double OwnershipValue { get; set; }
        public int OwnershipValueTotal { get; set; }
        public string TransferredFrom { get; set; }
        public int InPossessionOf { get; set; }
        public string InPossessionOfOther { get; set; }
        public string BlockedStatusSimakUnitWindow { get; set; }
        public string Status { get; set; }
        public string Notes { get; set; }
        public string ArchiveLocation { get; set; }
        public string DocumentSerial { get; set; }
        public string DocumentSeries { get; set; }
        public string DocumentAlphabet { get; set; }
        public string PropertyCode { get; set; }
        public string Year { get; set; }
        public DateTime? InternalDate { get; set; }
        public DateTime? DocumentDate { get; set; }
        public int? LatestGeneratingDecision { get; set; }
        public int BuildingStatus   { get; set; }
        public int BuildingMasahat   { get; set; }
        public int BuildingFloorsNumber   { get; set; }
        public int BuildingUsage   { get; set; }
        public string MeterNumberGas   { get; set; }
        public string MeterNumberWater   { get; set; }
        public string MeterNumberElectricity   { get; set; }
        public string MeterNumberPhone   { get; set; }
        public int IsTransfered   { get; set; }
        public DateTime? CreatedAt{ get; set; }
        public DateTime? UpdatedAt{ get; set; }
        
        
        public virtual TblAreas Area{ get; set; }
        public virtual TblAreas Owner{ get; set; }
        public virtual ICollection<AmlakPrivateDocHistory> AmlakPrivateDocHistories { get; set; }
        
        [NotMapped]
        public virtual AmlakPrivateDocHistory LastDocHistory { get; set; } 
        [NotMapped]
        public virtual AmlakPrivateDocHistory LastDocHistoryPossession { get; set; }

        [NotMapped]
        public string? CreatedAtFa{get{ return Helpers.MiladiToHejri(CreatedAt); }}

        [NotMapped]
        public string? UpdatedAtFa{get{ return Helpers.MiladiToHejri(UpdatedAt); }}
        [NotMapped]
        public string? InternalDateFa{get{ return Helpers.MiladiToHejri(InternalDate); }}
        [NotMapped]
        public string? DocumentDateFa{get{ return Helpers.MiladiToHejri(DocumentDate); }}
        
        [NotMapped]
        public string? DocumentTypeText{get{ return Helpers.UC(DocumentType,"amlakPrivateDocumentType"); }}  
        [NotMapped]
        public string? PredictionUsageText{get{ return Helpers.UC(PredictionUsage,"amlakPrivatePredictionUsage"); }}
         [NotMapped]
        public string? SectionText{get{ return Helpers.UC(Section,"amlakPrivateSection"); }}
        [NotMapped]
        public string? OwnershipTypeText{get{ return Helpers.UC(OwnershipType,"amlakPrivateOwnershipType"); }} 
         [NotMapped]
        public string? OwnershipValueTypeText{get{ return Helpers.UC(OwnershipValueType,"amlakPrivateOwnershipValueType"); }} 
        [NotMapped]
        public string? BuildingStatusText{get{ return Helpers.UC(BuildingStatus,"amlakPrivateBuildingStatus"); }}
        [NotMapped]
        public string? BuildingUsageText{get{ return Helpers.UC(BuildingUsage,"amlakPrivateBuildingUsage"); }} 
        [NotMapped]
        public string? LatestGeneratingDecisionText{get{ return Helpers.UC(LatestGeneratingDecision,"amlakPrivateGeneratingDecision"); }}  
        [NotMapped]
        public string? UsageUrbanText{get{ return Helpers.UC(UsageUrban,"amlakPrivateUsageUrban"); }}
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
        public static IQueryable<AmlakPrivateNew> OwnershipType(this IQueryable<AmlakPrivateNew> query, string? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.OwnershipType == value);
            }
            return query;
        }
        public static IQueryable<AmlakPrivateNew> UsageUrban(this IQueryable<AmlakPrivateNew> query, string? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => EF.Functions.Like(e.UsageUrban, $"%{value}%"));
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

        public static IQueryable<AmlakPrivateNew> MultiplePlates(this IQueryable<AmlakPrivateNew> query, string? value){
            if (BaseModel.CheckParameter(value, 0)){
                value = value.Replace("/", "-");

                var plates = value.Split(" ")
                    .Select(plate => plate.Split('-'))
                    .Where(parts => parts.Length == 2)
                    .Select(parts => new{ Main = parts[0], Sub = parts[1] })
                    .ToList();

                if (plates.Any()){
                    // Start with an empty query
                    IQueryable<AmlakPrivateNew> filteredQuery = query.Where(e => false);

                    // Add each condition as an OR clause
                    foreach (var plate in plates){
                        var main = plate.Main;
                        var sub = plate.Sub;
                        filteredQuery = filteredQuery.Union(query.Where(e => e.MainPlateNumber == main && e.SubPlateNumber == sub));
                    }

                    return filteredQuery;
                }
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
        
        public static IQueryable<AmlakPrivateNew> LatestGeneratingDecision(this IQueryable<AmlakPrivateNew> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.LatestGeneratingDecision == value);
            }
            return query;
        }
        
        public static IQueryable<AmlakPrivateNew> Search(this IQueryable<AmlakPrivateNew> query, string? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(a=> EF.Functions.Like(a.Title, $"%{value}%") 
                );
            }
            return query;
        }
        public static IQueryable<AmlakPrivateNew> IsSubmitted(this IQueryable<AmlakPrivateNew> query, int? value){
            if (BaseModel.CheckParameter(value,null)){
                if (value == 1){
                    return query.Where(e => e.MainPlateNumber != "0" && e.SubPlateNumber != "0" && e.Address!=null&& e.Address!=""&& e.DocumentType!=0 && e.Masahat!=0D && e.Section!=null && e.Section!="" && e.AreaId!=0 );
                }
                else if (value == 0){
                    return query.Where(e => !(e.MainPlateNumber != "0" && e.SubPlateNumber != "0" && e.Address!=null&& e.Address!=""&& e.DocumentType!=0 && e.Masahat!=0D && e.Section!=null &&  e.Section!="" && e.AreaId!=0 ));
                }
            }
            return query;
        }
        public static IQueryable<AmlakPrivateNew> IsTransfered(this IQueryable<AmlakPrivateNew> query, int? value){
            if (BaseModel.CheckParameter(value,null)){
                    return query.Where(e => e.IsTransfered==value );
            }
            return query;
        }
        
        public static IQueryable<AmlakPrivateNew> HasSdiLayer(this IQueryable<AmlakPrivateNew> query, int? value){
            if (BaseModel.CheckParameter(value,null)){
                if (value == 1){
                    return query.Where(e => e.SdiId!=null );
                }
                else if (value == 0){
                    return query.Where(e => e.SdiId==null );
                }
            }
            return query;
        }
    }
}