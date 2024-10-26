using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models.AmlakInfo {
    [Table("tblContractAmlakInfoChecks")]
    public class AmlakInfoContractCheck:BaseModel {
        
        public int AmlakInfoContractId{ get; set; }
        public string Number{ get; set; } // Deposit , Rent , license
        public DateTime? Date{ get; set; }
        public string Amount{ get; set; }
        public string Description{ get; set; }
        public int IsPassed{ get; set; }
        public DateTime? CreatedAt{ get; set; }
        public DateTime? UpdatedAt{ get; set; }

        
        public virtual AmlakInfoContract AmlakInfoContract { get; set; }
        
        [NotMapped]
        public string? DateFa{get{ return Helpers.MiladiToHejri(Date); }}

        [NotMapped]
        public string? CreatedAtFa{get{ return Helpers.MiladiToHejri(CreatedAt); }}

        [NotMapped]
        public string? UpdatedAtFa{get{ return Helpers.MiladiToHejri(UpdatedAt); }}
        
        [NotMapped]
        public string? IsPassedText{get{ return Helpers.UC(IsPassed,"contractCheckIsPassed"); }}

    }
    
    
    public static class AmlakInfoContractCheckExtensions {

        public static IQueryable<AmlakInfoContractCheck> AmlakInfoContractId(this IQueryable<AmlakInfoContractCheck> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.AmlakInfoContractId == value);
            }
            return query;
        }
        
        public static IQueryable<AmlakInfoContractCheck> IsPassed(this IQueryable<AmlakInfoContractCheck> query, int? value){
            if (BaseModel.CheckParameter(value,null)){
                return query.Where(e => e.IsPassed == value);
            }
            return query;
        }
        
    }
}