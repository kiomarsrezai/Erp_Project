using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models.AmlakTicket {
    [Table("tblAmlakTicketMessage")]
    public class AmlakTicketMessage:BaseModel
    {
        public int TicketId { get; set; } 
        public int FromId { get; set; } 
        public int ToId { get; set; } 
        public string Message { get; set; } 
        public DateTime? CreatedAt { get; set; } 
        
        
        public virtual AmlakAdmin.AmlakAdmin From{ get; set; }
        public virtual AmlakAdmin.AmlakAdmin To{ get; set; }

   
        [NotMapped]
        public string? CreatedAtFa{
            get{ return Helpers.MiladiToHejri(CreatedAt); }
        }
        
    }

    
    
    
//-------------------------------------------------------------------------------------------------
//-------------------------------------------    scopes    ----------------------------------------
//-------------------------------------------------------------------------------------------------


    public static class TicketMessageExtensions {

        public static IQueryable<AmlakTicketMessage> TicketId(this IQueryable<AmlakTicketMessage> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.TicketId == value);
            }
            return query;
        }
        public static IQueryable<AmlakTicketMessage> FromId(this IQueryable<AmlakTicketMessage> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.FromId == value);
            }
            return query;
        }
        public static IQueryable<AmlakTicketMessage> ToId(this IQueryable<AmlakTicketMessage> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.ToId == value);
            }
            return query;
        }
    }
}