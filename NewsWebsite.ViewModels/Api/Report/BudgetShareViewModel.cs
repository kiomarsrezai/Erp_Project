using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Report
{
    public class BudgetShareViewModel
    {
        public string AreaName { get; set; }
        public string code { get; set; }
        public string description { get; set; }
        public long mosavab { get; set; }
        public long CreditAmount { get; set; }
        public double PercentCreditAmount { get; set; }
        public long expense { get; set; }
        public double Percent { get; set; }
    }

    public class Paream12ViewModel
    {
        public int yearId { get; set; }
        public int areaId { get; set; }
       // public int kindId { get; set; }
        public int BudgetProcessId { get; set; }


    }
}
