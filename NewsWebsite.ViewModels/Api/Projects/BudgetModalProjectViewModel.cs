using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Api.Projects
{
    public class BudgetModalProjectViewModel
    {
        public int Id { get; set; }

        public int ProjectId { get; set; }

        public long Mosavab { get; set; }

        public long Edit { get; set; }

        public long Expense { get; set; }

        //public double PercentBud { get; set; }
        public string ProjectCode { get; set; }
        public string ProjectName { get; set; }
        public string AreaName { get; set; }
        public int AreaId { get; set; }
    }



}
