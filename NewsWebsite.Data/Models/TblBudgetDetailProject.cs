using System;
using System.Collections.Generic;

namespace NewsWebsite.Data.Models
{
    public partial class TblBudgetDetailProject
    {
        public TblBudgetDetailProject()
        {
            TblBudgetDetailProjectArea = new HashSet<TblBudgetDetailProjectArea>();
            TblProgramOperationDetails = new HashSet<TblProgramOperationDetails>();
        }

        public int Id { get; set; }
        public int TblBudgetDetailId { get; set; }
        public int? ProgramOperationDetailsId { get; set; }
        public long Mosavab { get; set; }
        public long Supply { get; set; }
        public long Takhsis { get; set; }
        public long Expense { get; set; }

        public virtual TblProgramOperationDetails ProgramOperationDetails { get; set; }
        public virtual TblBudgetDetails TblBudgetDetail { get; set; }
        public virtual ICollection<TblBudgetDetailProjectArea> TblBudgetDetailProjectArea { get; set; }
        public virtual ICollection<TblProgramOperationDetails> TblProgramOperationDetails { get; set; }
    }
}
