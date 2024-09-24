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
        public int AreaId{ get; set; }
        public int DoingMethodId{ get; set; }
        public string Number{ get; set; } // Deposit , Rent , license
        public string Date{ get; set; }
        public string Description{ get; set; }
        public string DateFrom{ get; set; }
        public string DateEnd{ get; set; }
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
        
        public static IQueryable<AmlakInfoContract> AreaId(this IQueryable<AmlakInfoContract> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.AreaId == value);
            }
            return query;
        }
    }
}