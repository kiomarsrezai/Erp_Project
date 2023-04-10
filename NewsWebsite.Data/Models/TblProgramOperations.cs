using System;
using System.Collections.Generic;

namespace NewsWebsite.Data.Models
{
    public partial class TblProgramOperations
    {
        public TblProgramOperations()
        {
            TblProgramOperationDetails = new HashSet<TblProgramOperationDetails>();
        }

        public int Id { get; set; }
        public int? TblAreaId { get; set; }
        public int? TblProgramId { get; set; }

        public virtual TblAreas TblArea { get; set; }
        public virtual TblPrograms TblProgram { get; set; }
        public virtual ICollection<TblProgramOperationDetails> TblProgramOperationDetails { get; set; }
    }
}
