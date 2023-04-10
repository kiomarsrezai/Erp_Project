using System;
using System.Collections.Generic;

namespace NewsWebsite.Data.Models
{
    public partial class TblBudgetDetails
    {
        public TblBudgetDetails()
        {
            TblBudgetDetailProject = new HashSet<TblBudgetDetailProject>();
        }

        public int Id { get; set; }
        public int? TblBudgetId { get; set; }
        public int? TblCodingId { get; set; }

        public virtual TblBudgets TblBudget { get; set; }
        public virtual TblCodings TblCoding { get; set; }
        public virtual ICollection<TblBudgetDetailProject> TblBudgetDetailProject { get; set; }
    }
}
