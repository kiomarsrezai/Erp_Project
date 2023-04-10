using System;
using System.Collections.Generic;

namespace NewsWebsite.Data.Models
{
    public partial class TblPrograms
    {
        public TblPrograms()
        {
            TblProgramOperations = new HashSet<TblProgramOperations>();
        }

        public int Id { get; set; }
        public string ProgramName { get; set; }

        public virtual ICollection<TblProgramOperations> TblProgramOperations { get; set; }
    }
}
