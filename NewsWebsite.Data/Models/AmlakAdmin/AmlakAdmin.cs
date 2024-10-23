using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models.AmlakAdmin {
    
    [Table("tblAmlakAdmin")]
    public class AmlakAdmin:BaseModel {
        public string FirstName{ get; set; }
        public string LastName{ get; set; }
        public string UserName{ get; set; }
        public string PhoneNumber{ get; set; }
        public string Bio{ get; set; }
        public string AmlakLisence{ get; set; }
        public string Password { get; set; }
        public string Token { get; set; }
        public DateTime? CreatedAt{ get; set; }
        public DateTime? UpdatedAt{ get; set; }
        
        [NotMapped]
        public string? CreatedAtFa{get{ return Helpers.MiladiToHejri(CreatedAt); }}

        [NotMapped]
        public string? UpdatedAtFa{get{ return Helpers.MiladiToHejri(UpdatedAt); }}
    }
//-------------------------------------------------------------------------------------------------
//-------------------------------------------    scopes    ----------------------------------------
//-------------------------------------------------------------------------------------------------


    public static class AmlakAdminExtensions {

        
        public static IQueryable<AmlakAdmin> Search(this IQueryable<AmlakAdmin> query, string? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(a => EF.Functions.Like(a.UserName, $"%{value}%") ||
                                        EF.Functions.Like(a.FirstName, $"%{value}%") ||
                                        EF.Functions.Like(a.LastName, $"%{value}%"));
            }
            return query;
        }
    }
}