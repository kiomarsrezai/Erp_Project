using System;
using System.Collections.Generic;

namespace NewsWebsite.Data.Models
{
    public partial class TblAreas
    {
        public TblAreas()
        {
            TblBudgetDetailProjectArea = new HashSet<TblBudgetDetailProjectArea>();
            TblBudgets = new HashSet<TblBudgets>();
            TblProgramOperations = new HashSet<TblProgramOperations>();
        }

        public int Id { get; set; }
        public string AreaName { get; set; }
        public int StructureId { get; set; }
        public string AreaNameShort { get; set; }

        public virtual ICollection<TblBudgetDetailProjectArea> TblBudgetDetailProjectArea { get; set; }
        public virtual ICollection<TblBudgets> TblBudgets { get; set; }
        public virtual ICollection<TblProgramOperations> TblProgramOperations { get; set; }
    }
}
