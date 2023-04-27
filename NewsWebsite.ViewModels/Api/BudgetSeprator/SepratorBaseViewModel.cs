using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.BudgetSeprator
{
    public class SepratorBaseViewModel
    {
        [Display(Name = "سال")]
        public int YearId { get; set; }

        [Display(Name = "منطقه")]
        public int AreaId { get; set; } 
        
        [Display(Name = "نوع بودجه")]
        public int BudgetProcessId { get; set; }
    }
}
