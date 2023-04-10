using System;
using System.Collections.Generic;

namespace NewsWebsite.Data.Models
{
    public partial class TblVasets
    {
        public int VasetId { get; set; }
        public int YearId { get; set; }
        public int AreaId { get; set; }
        public string BudgetCode { get; set; }
        public string Description { get; set; }
        public int KindId { get; set; }
        public long Mosavab { get; set; }
        public long Supply { get; set; }
        public long Takhsis { get; set; }
        public long Expense { get; set; }
    }
}
