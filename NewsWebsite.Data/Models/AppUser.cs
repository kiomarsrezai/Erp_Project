using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models {
    
    [Table("AppUsers")]
    public class AppUser {
        public int Id{ get; set; }
        public string PasswordHash{ get; set; }
        public string FirstName{ get; set; }
        public string LastName{ get; set; }
        public string UserName{ get; set; }
        public string Bio{ get; set; }
        public string Lisence{ get; set; }
        public string Token{ get; set; }
        public byte IsActive{ get; set; }
    }
//-------------------------------------------------------------------------------------------------
//-------------------------------------------    scopes    ----------------------------------------
//-------------------------------------------------------------------------------------------------


}