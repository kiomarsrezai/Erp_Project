using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Request
{
    public class RequestSearchParamViewModel
    {
        [Display(Name = "سال")]
        public int YearId { get; set; }
        
        [Display(Name = "منطقه")]
        public int AreaId { get; set; }
        
        [Display(Name = "واحد درخواست کننده")]
        public int DepartmentId { get; set; }

    }
}
