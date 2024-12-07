using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace NewsWebsite.Data.Models
{
    [Table("tblBudgetAreaShare")]
    public partial class TblBudgetAreaShare
    {
        public int Id { get; set; }
        public int? AreaId { get; set; }
        public int? YearId { get; set; }
        public string? Type { get; set; } // pishnahadi / edit
        public long? ShareProcessId1 { get; set; }
        public long? ShareProcessId2 { get; set; }
        public long? ShareProcessId3 { get; set; }
        public long? ShareProcessId4 { get; set; }

        public virtual TblAreas? Area { get; set; }
        public virtual TblYears? Year { get; set; }
    }
}
