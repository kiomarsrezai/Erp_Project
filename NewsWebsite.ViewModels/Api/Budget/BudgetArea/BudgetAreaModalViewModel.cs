using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Api.Budget.BudgetArea
{
    public class BudgetAreaModalViewModel
    {
        public int Id { get; set; }

        public string AreaNameShort { get; set; }

        public long Mosavab { get; set; }

        public long Edit { get; set; }

        public long Expense { get; set; }

        public double PercentBud { get; set; }
        public long Supply { get; set; }
    }



}
