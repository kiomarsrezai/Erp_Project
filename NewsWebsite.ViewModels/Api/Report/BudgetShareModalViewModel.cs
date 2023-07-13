using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Report
{
    public class BudgetShareModalViewModel
    {
        public string Number { get; set; }
        public string Date { get; set; }
        public string DateShamsi { get; set; }
        public string Description { get; set; }
        public Int64 CreditAmount { get; set; }
        public double PercentCreditAmount { get; set; }
        public double Percent { get; set; }
        public Int64 Expense { get; set; }
    }

    public class Paream13ViewModel
    {
        public int YearId { get; set; }
        public int AreaId { get; set; }
        public int CodingId { get; set; }
    }

}
