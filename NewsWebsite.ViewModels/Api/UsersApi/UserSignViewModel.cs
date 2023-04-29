using NewsWebsite.Entities.identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.UsersApi
{
    public class UserSignViewModel
    {
        public string token { get; set; }
        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int SectionId { get; set; }
        public string SectionName { get; set; }

    }
}
