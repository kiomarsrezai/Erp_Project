using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Fetch
{
    public class BudgetMotherIdViewModel
    {
        //public int Id { get; set; }

        public int CodingId { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public Int64 Mosavab { get; set; }
        public Int64 Edit { get; set; }
        public int LevelNumber { get; set; }
        public Int64 Expense { get; set; }
        public bool Show { get; set; }
        public bool Crud { get; set; }
        public bool Mo { get; set; }
        public double? PercentBud { get; set; }

    }

  

}
