using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Budget
{
    public class BudgetAreaModalViewModel
    {
        public int Id{ get; set; }

        public string AreaName { get; set; }

        public Int64 Mosavab { get; set; }

        public Int64 Edit { get; set; }
        
        public Int64 Expense { get; set; }

        public double PercentBud { get; set; }
        
     


    }

  

}
