using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Report
{
    public class ChartBudgetDeviationViewModel
    {
        public string AreaName { get; set; }
        public string code { get; set; }
        public string description { get; set; }
        public long mosavab { get; set; }
        public long expense { get; set; }
        public double percmosavab { get; set; }

    }
}
