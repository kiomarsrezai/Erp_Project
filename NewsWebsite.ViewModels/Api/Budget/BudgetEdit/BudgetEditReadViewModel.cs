using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Budget.BudgetEdit
{
    public class BudgetEditReadViewModel
    {
        public int? Id { get; set; }
        public int? BudgetDetailId { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public Int64? MosavabPublic { get; set; }
        public Int64? Expense { get; set; }
        public Int64? Decrease { get; set; }
        public Int64? Increase { get; set; }
        public Int64 Edit { get; set; }
    }
}
