using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Report
{
    public class BudgetDeviationViewModel
    {
        public string AreaName { get; set; }
        public string code { get; set; }
        public string description { get; set; }
        public Int64 mosavab { get; set; }
        public Int64 Edit { get; set; }
        public Int64 CreditAmount { get; set; }
        public double PercentCreditAmount { get; set; }
        public Int64 expense { get; set; }
        public double percmosavab { get; set; }

    }

    public class Param20ViewModel
    {
        public int yearId { get; set; }
        public int areaId { get; set; }
  

    }

  
}
