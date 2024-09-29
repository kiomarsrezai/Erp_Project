using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models.AmlakInfo {
    [Table("tblContractAmlakInfo")]
    public class AmlakInfoContract:BaseModel {
        
        public int AmlakInfoId{ get; set; }
        public int OwnerId{ get; set; }
        public int DoingMethodId{ get; set; }
        public string Number{ get; set; } // Deposit , Rent , license
        public string Date{ get; set; }
        public string Description{ get; set; }
        public DateTime DateFrom{ get; set; }
        public DateTime DateEnd{ get; set; }
        public Int64 ZemanatPrice{ get; set; }
        public string Type{ get; set; }
        public int ModatValue{ get; set; }
        public string Nemayande{ get; set; }
        public string Modir{ get; set; }
        public string Sarparast{ get; set; }
        public string TenderNumber{ get; set; }
        public string TenderDate{ get; set; }
        public DateTime? CreatedAt{ get; set; }
        public DateTime? UpdatedAt{ get; set; }

        
        public ICollection<AmlakInfoContractSupplier> Suppliers{ get; set; }
        public ICollection<AmlakInfoContractPrice> Prices{ get; set; }
        public virtual AmlakInfo AmlakInfo { get; set; }
        public virtual TblAreas Owner { get; set; }
        
        
        [NotMapped]
        public string? DateFa{get{ return Helpers.MiladiToHejri(Date); }}

            [NotMapped]
        public string? TenderDateFa{get{ return Helpers.MiladiToHejri(TenderDate); }}

        
        [NotMapped]
        public string? DateFromFa{get{ return Helpers.MiladiToHejri(DateFrom); }}

        [NotMapped]
        public string? DateEndFa{get{ return Helpers.MiladiToHejri(DateEnd); }}
        
        [NotMapped]
        public string? CreatedAtFa{get{ return Helpers.MiladiToHejri(CreatedAt); }}

        [NotMapped]
        public string? UpdatedAtFa{get{ return Helpers.MiladiToHejri(UpdatedAt); }}
    }
    
    
    public static class AmlakInfoCOntractExtensions {

        public static IQueryable<AmlakInfoContract> AmlakInfoId(this IQueryable<AmlakInfoContract> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.AmlakInfoId == value);
            }
            return query;
        }
        
        public static IQueryable<AmlakInfoContract> OwnerId(this IQueryable<AmlakInfoContract> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.OwnerId == value);
            }
            return query;
        }
    }
}