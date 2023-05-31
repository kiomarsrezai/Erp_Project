using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.BudgetSeprator
{
    public class ChartBudgetDeviationViewModel
    {
        public string areaname;
        public string code;
        public string description;
        public long mosavab;
        public long expense;
        public double percmosavab;

        [Display(Name = "سال")]
        public string AreaName { get; set; }

        [Display(Name = "منطقه")]
        public int AreaId { get; set; } 
        
        [Display(Name = "نوع بودجه")]
        public int BudgetProcessId { get; set; }
    }
}
