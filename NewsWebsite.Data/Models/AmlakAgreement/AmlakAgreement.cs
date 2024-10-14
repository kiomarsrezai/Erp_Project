using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models.AmlakAgreement {
    
    [Table("tblAmlakAgreement")]
    public class AmlakAgreement:BaseModel {
        public string SdiId{ get; set; }
        public int IsSubmitted{ get; set; }
        public string Title{ get; set; }
        public DateTime? Date{ get; set; }
        public string ContractParty{ get; set; }
        public string AmountMunicipality{ get; set; }
        public string AmountContractParty{ get; set; }
        public DateTime? DateFrom{ get; set; }
        public DateTime? DateTo{ get; set; }
        public string Description{ get; set; }
        public string Coordinates{ get; set; }
        public string Address{ get; set; }
        public DateTime? CreatedAt{ get; set; }
        public DateTime? UpdatedAt{ get; set; }
        
        
        
        [NotMapped]
        public string? DateFa{get{ return Helpers.MiladiToHejri(Date); }}
        
        [NotMapped]
        public string? DateFromFa{get{ return Helpers.MiladiToHejri(DateFrom); }}
        
        [NotMapped]
        public string? DateToFa{get{ return Helpers.MiladiToHejri(DateTo); }}
        
        [NotMapped]
        public string? CreatedAtFa{get{ return Helpers.MiladiToHejri(CreatedAt); }}

        [NotMapped]
        public string? UpdatedAtFa{get{ return Helpers.MiladiToHejri(UpdatedAt); }}

    }
//-------------------------------------------------------------------------------------------------
//-------------------------------------------    scopes    ----------------------------------------
//-------------------------------------------------------------------------------------------------


    public static class AmlakAgreementExtensions {

        public static IQueryable<AmlakAgreement> IsSubmitted(this IQueryable<AmlakAgreement> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(a => a.IsSubmitted==value);
            }
            return query;
        }
        public static IQueryable<AmlakAgreement> ContractParty(this IQueryable<AmlakAgreement> query, string? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(a => EF.Functions.Like(a.ContractParty, $"%{value}%"));
            }
            return query;
        }
        
        public static IQueryable<AmlakAgreement> Search(this IQueryable<AmlakAgreement> query, string? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(a => EF.Functions.Like(a.Description, $"%{value}%") ||
                                        EF.Functions.Like(a.Title, $"%{value}%") ||
                                        EF.Functions.Like(a.ContractParty, $"%{value}%"));
            }
            return query;
        }
    }
}