using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models.AmlakInfo {
    [Table("tblContractAmlakInfoNotices")]
    public class AmlakInfoContractNotice:BaseModel {
        
        public int AmlakInfoContractId{ get; set; }
        public int Title{ get; set; } 
        public DateTime? Date{ get; set; }
        public string LetterNumber{ get; set; }
        public string Description{ get; set; }
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
        public string? TitleText{get{ return Helpers.UC(Title,"contractNoticeTitles"); }}

    }
    
    
    public static class AmlakInfoContractNoticeExtensions {

        public static IQueryable<AmlakInfoContractNotice> AmlakInfoContractId(this IQueryable<AmlakInfoContractNotice> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.AmlakInfoContractId == value);
            }
            return query;
        }
        
        
           
        public static IQueryable<AmlakInfoContractNotice> SupplierId(this IQueryable<AmlakInfoContractNotice> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Include(c=>c.AmlakInfoContract)
                    .ThenInclude(c=>c.Suppliers)
                    .ThenInclude(c=>c.Supplier)
                    .Where(c => c.AmlakInfoContract.Suppliers.Any(s => s.Supplier.Id == value));            
            }
            return query;
        }

        
        public static IQueryable<AmlakInfoContractNotice> DateFrom(this IQueryable<AmlakInfoContractNotice> query, DateTime? value){
            if (BaseModel.CheckParameter(value,null)){
                return query.Where(c=>c.Date != null &&  c.Date > value);
            }
            return query;
        }
        
        public static IQueryable<AmlakInfoContractNotice> DateTo(this IQueryable<AmlakInfoContractNotice> query, DateTime? value){
            if (BaseModel.CheckParameter(value,null)){
                return query.Where(c=>c.Date != null &&  c.Date < value);
            }
            return query;
        }
        
        
    }
}