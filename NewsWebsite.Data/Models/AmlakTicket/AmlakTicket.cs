using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Public;
using Newtonsoft.Json;

namespace NewsWebsite.Data.Models.AmlakTicket {
    [Table("tblAmlakTicket")]
    public class AmlakTicket:BaseModel
    {
        public string Title { get; set; } 
        public int AdminId { get; set; } 
        public int LastAdminId { get; set; } 
        public int Status { get; set; } 
        public DateTime? UpdatedAt { get; set; } 
        public DateTime? CreatedAt { get; set; } 
        
        private string _linksJson;
        [Column("Links")] // Explicitly set the database column name
        public string LinksJson
        {
            get => _linksJson;
            set => _linksJson = value;
        }

        public virtual AmlakAdmin.AmlakAdmin Admin{ get; set; }
        public virtual AmlakAdmin.AmlakAdmin LastAdmin{ get; set; }

   
        [NotMapped]
        public string? UpdatedAtFa{
            get{ return Helpers.MiladiToHejri(UpdatedAt); }
        }
        
        [NotMapped]
        public string? CreatedAtFa{
            get{ return Helpers.MiladiToHejri(CreatedAt); }
        }
        
        [NotMapped]
        public string? StatusText{get{ return Helpers.UC(Status,"ticketStatus"); }}
        
        
        [NotMapped] // Prevent EF from mapping this property directly
        public List<string> Links
        {
            get => string.IsNullOrEmpty(_linksJson)
                ? new List<string>()
                : JsonConvert.DeserializeObject<List<string>>(_linksJson);

            set => _linksJson = JsonConvert.SerializeObject(value);
        }
    }

    
    
    
//-------------------------------------------------------------------------------------------------
//-------------------------------------------    scopes    ----------------------------------------
//-------------------------------------------------------------------------------------------------


    public static class TicketExtensions {

        public static IQueryable<AmlakTicket> AdminId(this IQueryable<AmlakTicket> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.AdminId == value);
            }
            return query;
        }
        public static IQueryable<AmlakTicket> LastAdminId(this IQueryable<AmlakTicket> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.LastAdminId == value);
            }
            return query;
        }
    }
}