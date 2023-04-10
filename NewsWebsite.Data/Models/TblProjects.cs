using System;
using System.Collections.Generic;

namespace NewsWebsite.Data.Models
{
    public partial class TblProjects
    {
        public TblProjects()
        {
            TblProgramOperationDetails = new HashSet<TblProgramOperationDetails>();
        }

        public int Id { get; set; }
        public int? MotherId { get; set; }
        public string ProjectName { get; set; }

        public virtual ICollection<TblProgramOperationDetails> TblProgramOperationDetails { get; set; }
    }
}
