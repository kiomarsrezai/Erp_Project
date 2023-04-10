using System;
using System.Collections.Generic;

namespace NewsWebsite.Data.Models
{
    public partial class TblCodingPbb
    {
        public TblCodingPbb()
        {
            InverseMother = new HashSet<TblCodingPbb>();
            TblCodings = new HashSet<TblCodings>();
        }

        public int Id { get; set; }
        public int? MotherId { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public byte? LevelNumber { get; set; }

        public virtual TblCodingPbb Mother { get; set; }
        public virtual ICollection<TblCodingPbb> InverseMother { get; set; }
        public virtual ICollection<TblCodings> TblCodings { get; set; }
    }
}
