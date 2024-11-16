using Microsoft.AspNetCore.Identity;
using NewsWebsite.Entities.identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.UserManager
{
    public class UserInsertViewModel
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime? BirthDate { get; set; }
        public string UserName{ get; set; }
        public DateTime? RegisterDateTime { get; set; }
        public bool IsActive { get; set; }
        public GenderType Gender { get; set; }
        public string Bio { get; set; }
        //public string Lisence { get; set; }
        public int SectionId { get; set; }
        //public string Token { get; set; }
        public string PhoneNumber { get; set; }

    }
public class UserUpdateViewModel
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime? BirthDate { get; set; }
        public string UserName{ get; set; }
        public DateTime? RegisterDateTime { get; set; }
        public bool IsActive { get; set; }
        public GenderType Gender { get; set; }
        public string Bio { get; set; }
        //public string Lisence { get; set; }
        public int SectionId { get; set; }
        //public string Token { get; set; }
        public string PhoneNumber { get; set; }

    }

}
