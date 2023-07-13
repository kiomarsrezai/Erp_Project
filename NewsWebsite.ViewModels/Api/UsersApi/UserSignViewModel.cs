using NewsWebsite.Entities.identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.UsersApi
{
    public class UserSignViewModel
    {
        public int Id { get; set; }
        public string Token { get; set; }
        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Lisence { get; set; }
        public int SectionId { get; set; }
        public string SectionName { get; set; }
        
        [Display(Name ="سمت")]
        public string Bio { get; set; }
        public string DateNow { get; set; }

    }
}
