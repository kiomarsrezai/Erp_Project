using System;
using System.Collections.Generic;

namespace NewsWebsite.Data.Models
{
    public partial class TblBudgetDetailProjectArea
    {
        public int Id { get; set; }
        public int BudgetDetailProjectId { get; set; }
        public int AreaId { get; set; }
        public long Mosavab { get; set; }
        public long Supply { get; set; }
        public long Takhsis { get; set; }
        public long Expense { get; set; }

        public virtual TblAreas Area { get; set; }
        public virtual TblBudgetDetailProject BudgetDetailProject { get; set; }
    }
}
