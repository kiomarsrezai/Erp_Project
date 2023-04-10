using System;
using System.Collections.Generic;

namespace NewsWebsite.Data.Models
{
    public partial class TblYears
    {
        public TblYears()
        {
            TblBudgets = new HashSet<TblBudgets>();
        }

        public int Id { get; set; }
        public int YearName { get; set; }

        public virtual ICollection<TblBudgets> TblBudgets { get; set; }
    }
}
