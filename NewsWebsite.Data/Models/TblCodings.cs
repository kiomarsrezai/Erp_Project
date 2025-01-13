using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace NewsWebsite.Data.Models
{
        [Table("tblCoding")]
    public partial class TblCodings
    {
        public TblCodings()
        {
            InverseMother = new HashSet<TblCodings>();
            TblBudgetDetails = new HashSet<TblBudgetDetails>();
        }

        public int Id { get; set; }
        public int? MotherId { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public int? LevelNumber { get; set; }
        public int? TblBudgetProcessId { get; set; }
        // public string? CodeAcc { get; set; }
        public int? CodingPbbid { get; set; }
        public string CodePbb { get; set; }

        public virtual TblCodingPbb CodingPbb { get; set; }
        public virtual TblCodings Mother { get; set; }
        public virtual TblBudgetProcess TblBudgetProcess { get; set; }
        public virtual ICollection<TblCodings> InverseMother { get; set; }
        public virtual ICollection<TblBudgetDetails> TblBudgetDetails { get; set; }
    }
}
