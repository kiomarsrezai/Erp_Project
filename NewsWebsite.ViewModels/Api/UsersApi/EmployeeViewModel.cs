using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.UsersApi
{
    public class EmployeeViewModel
    {
        public int Id { get; set; }
        public string UserName { get; set; }
        public string NormalizedUserName { get; set; }
        public string Email { get; set; }
        public string NormalizedEmail { get; set; }
        public string PhoneNumber { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string BirthDate { get; set; }
        public bool IsActive { get; set; }
        public int Gender { get; set; }
        public string Bio { get; set; }
    }
}
