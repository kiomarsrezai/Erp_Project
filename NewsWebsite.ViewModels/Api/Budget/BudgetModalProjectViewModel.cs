using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Budget
{
    public class BudgetModalProjectViewModel
    {
        public int Id{ get; set; }

        public int ProjectId { get; set; }

        public Int64 Mosavab { get; set; }

        public Int64 Edit { get; set; }
        
        public Int64 Expense { get; set; }

        public double PercentBud { get; set; }
        
     


    }

  

}
