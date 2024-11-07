using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models.AmlakInfo {
    [Table("tblContractAmlakInfoChecks")]
    public class AmlakInfoContractCheck:BaseModel {
        
        public int AmlakInfoContractId{ get; set; }
        public string Number{ get; set; } // Deposit , Rent , license
        public DateTime? Date{ get; set; }
        public string Amount{ get; set; }
        public string Issuer{ get; set; }
        public string IssuerBank{ get; set; }
        public string Description{ get; set; }
        public int PassStatus{ get; set; }
        public int CheckType{ get; set; }
        public int IsSubmitted{ get; set; }
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
        public string? PassStatusText{get{ return Helpers.UC(PassStatus,"contractCheckPassStatus"); }}

        [NotMapped]
        public string? CheckTypeText{get{ return Helpers.UC(CheckType,"contractCheckType"); }}


    }
    
    
    public static class AmlakInfoContractCheckExtensions {

        public static IQueryable<AmlakInfoContractCheck> AmlakInfoContractId(this IQueryable<AmlakInfoContractCheck> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.AmlakInfoContractId == value);
            }
            return query;
        }
        
        public static IQueryable<AmlakInfoContractCheck> PassStatus(this IQueryable<AmlakInfoContractCheck> query, int? value){
            if (BaseModel.CheckParameter(value,null)){
                return query.Where(e => e.PassStatus == value);
            }
            return query;
        }
        
        public static IQueryable<AmlakInfoContractCheck> CheckType(this IQueryable<AmlakInfoContractCheck> query, int? value){
            if (BaseModel.CheckParameter(value,null)){
                return query.Where(e => e.CheckType == value);
            }
            return query;
        }
        
        public static IQueryable<AmlakInfoContractCheck> IsSubmitted(this IQueryable<AmlakInfoContractCheck> query, int? value){
            if (BaseModel.CheckParameter(value,null)){
                return query.Where(e => e.IsSubmitted == value);
            }
            return query;
        }
        
           
        public static IQueryable<AmlakInfoContractCheck> OwnerId(this IQueryable<AmlakInfoContractCheck> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Include(c=>c.AmlakInfoContract).Where(e => e.AmlakInfoContract.OwnerId == value);
            }
            return query;
        }

        
        public static IQueryable<AmlakInfoContractCheck> DateFrom(this IQueryable<AmlakInfoContractCheck> query, DateTime? value){
            if (BaseModel.CheckParameter(value,null)){
                return query.Where(c=>c.Date != null &&  c.Date > value);
            }
            return query;
        }
        
        public static IQueryable<AmlakInfoContractCheck> DateTo(this IQueryable<AmlakInfoContractCheck> query, DateTime? value){
            if (BaseModel.CheckParameter(value,null)){
                return query.Where(c=>c.Date != null &&  c.Date < value);
            }
            return query;
        }
        
        
    }
}