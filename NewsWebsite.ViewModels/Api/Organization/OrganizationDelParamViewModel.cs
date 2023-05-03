using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Organization
{
    public class OrganizationDelParamViewModel
    {
        [Required(ErrorMessage = "وارد نمودن {0} الزامی است.")]
        public int Id { get; set; }

    }
}
