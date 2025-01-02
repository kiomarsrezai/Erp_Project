using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models.AmlakTicket {
    [Table("tblAmlakTicketAdmin")]
    public class AmlakTicketAdmin:BaseModel
    {
        public int TicketId { get; set; } 
        public int AdminId { get; set; } 
        public int Type { get; set; }  // 1:sender, 2:receiver, 3:cc
        
        public virtual AmlakTicket Ticket{ get; set; }
        public virtual AmlakAdmin.AmlakAdmin Admin{ get; set; }

   
        [NotMapped]
        public string? TypeText{get{ return Helpers.UC(Type,"ticketAdminType"); }}
    }

    
    
    
//-------------------------------------------------------------------------------------------------
//-------------------------------------------    scopes    ----------------------------------------
//-------------------------------------------------------------------------------------------------


    public static class AmlakTicketAdminExtensions {

        public static IQueryable<AmlakTicketAdmin> TicketId(this IQueryable<AmlakTicketAdmin> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.TicketId == value);
            }
            return query;
        }
        public static IQueryable<AmlakTicketAdmin> AdminId(this IQueryable<AmlakTicketAdmin> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.AdminId == value);
            }
            return query;
        }
    }
}