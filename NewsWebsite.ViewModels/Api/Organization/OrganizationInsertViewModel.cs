using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Organization
{
    public class OrganizationInsertViewModel
    {
        public int? MotherId { get; set; }
        public int AreaId { get; set; }

    }
}
