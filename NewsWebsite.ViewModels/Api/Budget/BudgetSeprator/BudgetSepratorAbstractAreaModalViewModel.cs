using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Budget.BudgetSeprator
{
    public class BudgetSepratorAbstractAreaModalViewModel
    {
        public int side { get; set; }
        public int RevenueKind { get; set; }
        public Int64 Mosavab { get; set; }
        public Int64 Edit { get; set; }
        public Int64 Expense { get; set; }

    }

    public class Param3
    {
        public int YearId { get; set; }
        public int AreaId { get; set; }
    }
}
