using System;
using System.Collections.Generic;

namespace NewsWebsite.Data.Models
{
    public partial class TblBudgets
    {
        public TblBudgets()
        {
            TblBudgetDetails = new HashSet<TblBudgetDetails>();
        }

        public int Id { get; set; }
        public int? TblYearId { get; set; }
        public int? TblAreaId { get; set; }

        public virtual TblAreas TblArea { get; set; }
        public virtual TblYears TblYear { get; set; }
        public virtual ICollection<TblBudgetDetails> TblBudgetDetails { get; set; }
    }
}
