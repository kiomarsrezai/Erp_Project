using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Budget.BudgetCoding
{
    public class MosavabManualUpdateViewModel
    {
        public int BudgetDetailId { get; set; }
         public int BudgetDetailProjectId { get; set; }
        public int BudgetDetailProjectAreaId { get; set; }
        public Int64 Mosavab { get; set; }

    }
}
