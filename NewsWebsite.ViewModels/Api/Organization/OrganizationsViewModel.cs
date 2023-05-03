using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Organization
{
    public class OrganizationsViewModel
    {
        public int Id { get; set; }
        public int MotherId { get; set; }
        public string OrgCode { get; set; }
        public string OrgName { get; set; }
        

    }
}
