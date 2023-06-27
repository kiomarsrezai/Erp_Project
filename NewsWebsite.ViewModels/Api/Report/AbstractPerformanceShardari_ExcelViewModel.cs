using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Report
{
    public class AbstractPerformanceShardari_ExcelViewModel
    {
        public string Code { get; set; }
        public string Description { get; set; }
        public Int64 Mosavab { get; set; }
        public Int64 Edit { get; set; }
        public Int64 CreditAmount { get; set; }
        public int levelNumber { get; set; }
        public Int64 ExpenseMonth { get; set; }
        public double Percent { get; set; }
    }

    public class Param1ViewModel
    {
        public int YearId { get; set; }
        public int AreaId { get; set; }
        public int MonthId { get; set; }
        public int budgetProcessId { get; set; }
    }
}

