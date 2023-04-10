using System;
using System.Collections.Generic;

namespace NewsWebsite.Data.Models
{
    public partial class TblBudgetProcess
    {
        public TblBudgetProcess()
        {
            TblCodings = new HashSet<TblCodings>();
        }

        public int Id { get; set; }
        public string ProcessName { get; set; }

        public virtual ICollection<TblCodings> TblCodings { get; set; }
    }
}
