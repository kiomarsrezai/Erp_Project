using NewsWebsite.ViewModels.Api.Budget.BudgetSeprator;
using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Budget.BudgetSeprator
{
    public class AbstractPerformanceMonthlyViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public int? Month { get; set; }
        public Int64? Mosavab { get; set; }
        public Int64? Expense { get; set; }
    }
    public class Param15
    {
        public int YearId { get; set; }
        public int AreaId { get; set; }
        public int budgetProcessId { get; set; }

    }
}

