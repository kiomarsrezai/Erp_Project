using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Budget.BudgetEdit
{
    public class BudgetEditUpdateParamViewModel
    {
        public int Id { get; set; }
        public Int64 Decrease { get; set; }
        public Int64 Increase { get; set; }
    }
}
