using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Organization
{
    public class OrganizationUpdateViewModel
    {
        public int Id { get; set; }
        public int? MotherId { get; set; }
        public string DepartmentCode { get; set; }
        public string DepartmentName { get; set; }
        

    }
}
