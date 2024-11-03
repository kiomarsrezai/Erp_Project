using System;
using System.Collections.Generic;

namespace NewsWebsite.Data.Models
{
    public partial class TblProgramDetails
    {

        public int Id { get; set; }
        public int ProgramId { get; set; }
        public int YearId { get; set; }
        public int MotherId { get; set; }
        public int LevelNumber { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string Color { get; set; }

    }
}
