using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Department
{
    public class DepartmentAcceptorUserReadViewModel
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Resposibility { get; set; }
        public int UserId { get; set; }
    }
}
