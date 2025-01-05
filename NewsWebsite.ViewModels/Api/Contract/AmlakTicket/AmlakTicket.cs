using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.AspNetCore.Http;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.Public;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Contract.AmlakAdmin;
using NewsWebsite.ViewModels.Api.Contract.amlakAttachs;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakPrivate {

    
    public class AmlakTicketBaseModel {
        public string Title { get; set; } 
    }

    public class AmlakTicketListVm : AmlakTicketBaseModel {
        public int Id{ get; set; }
        public string UUID { get; set; } 
        public int AdminId { get; set; } 
        public int LastAdminId { get; set; } 
        public string Status{ get; set; } 
        public string StatusText{ get; set; }
        public string StatusColor{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }
        
        public AmlakAdminTicket? Admin{ get; set; }
        public AmlakAdminTicket? LastAdmin{ get; set; }
    }

    public class AmlakTicketReadVm : AmlakTicketBaseModel {
        public int Id{ get; set; }
        public int AdminId { get; set; } 
        public int LastAdminId { get; set; } 
        public List<string> Links { get; set; } 
        public string Status{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }

        public List<AmlakTicketMessageVm> Messages { get; set; } 
        public List<AmlakAdminTicket> Speakers { get; set; } 
    }
    public class AmlakTicketStoreVm : AmlakTicketBaseModel {
        public string Message{ get; set; }
        public int ToAdminId{ get; set; }
        public List<string> Links { get; set; }
        public List<int> CCAdminIds { get; set; }
        public List<IFormFile> Attachments { get; set; }
        
    }
    public class AmlakTicketUpdateStatusVm  {
        public int Id{ get; set; }
        public int Status{ get; set; }
    
    }
    
    
    public class AmlakTicketMessageVm {
        public int Id { get; set; } 
        public int FromId { get; set; } 
        public int ToId { get; set; } 
        public string Message { get; set; } 
        public DateTime? CreatedAt { get; set; } 
        public string CreatedAtFa { get; set; } 
        public List<AmlakAttach> attachments { get; set; } 
    }
    
    public class AmlakTicketMessageStoreVm  {
        public string UUID{ get; set; }
        public string Message{ get; set; }
        public int ToAdminId{ get; set; }
        public List<IFormFile> Attachments { get; set; }
        
    }  
    
    public class AmlakTicketReadInputVm  {
        public string? Title{ get; set; }
        public string? Type{ get; set; }
        
        public int Page{ get; set; } = 1;
        public int PageRows{ get; set; } = 10;
        public string Sort{ get; set; }="Id";
        public string SortType{ get; set; }="desc";
    }

    
    
}