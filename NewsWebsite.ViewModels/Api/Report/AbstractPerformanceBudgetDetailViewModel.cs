using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Report
{
    public class AbstractPerformanceBudgetDetailViewModel
    {
        public string Code { get; set; }
        public string Description { get; set; }
        public Int64 Mosavab { get; set; }
        public Int64 Expense { get; set; }
        public double Percent { get; set; }
    }

    public class ParamsViewModel
    {
        public string ColumnName { get; set; }
        public int AreaId { get; set; }
        public int YearId { get; set; }

    }
}
