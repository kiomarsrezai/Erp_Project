using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.UsersApi
{
    public class EmployeeInsertViewModel
    {
        public int Id { get; set; }
        public string UserName { get; set; }
        public string PhoneNumber { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int Gender { get; set; }
        public string Bio { get; set; }
    }
}
