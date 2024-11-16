using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Budget.BudgetCoding
{
    public class BudgetCodingInfoModalReadViewModal
    {
        public int StructureId { get; set; }
        public string AreaName { get; set; }
        public Int64? Pishnahadi { get; set; }
        public Int64? Mosavab { get; set; }
        public Int64? EditArea { get; set; }
        public Int64? CreditAmount { get; set; }
        public Int64? Expense { get; set; }
    }

    public class ParamViewModal
    {
        public int YearId { get; set; }
        public int CodingId { get; set; }
    }

}
