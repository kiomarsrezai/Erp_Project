using System;
using System.Collections.Generic;

namespace NewsWebsite.Data.Models
{
    public partial class TblProgramOperationDetails
    {
        public TblProgramOperationDetails()
        {
            TblBudgetDetailProject = new HashSet<TblBudgetDetailProject>();
        }

        public int Id { get; set; }
        public int? TblProgramOperationId { get; set; }
        public int? TblProjectId { get; set; }
        public int? TblBudgetDetailProjectId { get; set; }

        public virtual TblBudgetDetailProject TblBudgetDetailProjectNavigation { get; set; }
        public virtual TblProgramOperations TblProgramOperation { get; set; }
        public virtual TblProjects TblProject { get; set; }
        public virtual ICollection<TblBudgetDetailProject> TblBudgetDetailProject { get; set; }
    }
}
