using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Report
{
    public  class ComparErpAndTaminViewModel
    {
        public int AreaId { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public Int64 Mosavab { get; set; }
        public Int64 Edit { get; set; }
        public Int64 Supply { get; set; }
        public Int64 Expense { get; set; }
        public Int64 Total_Res { get; set; }
        public Int64 Diff { get; set; }
    }

    public class param100
    {
        public int YearId { get; set; }
        public int AreaId { get; set; }
        public int BudgetProcessId { get; set; }
        public int Number { get; set; }

    }
}
