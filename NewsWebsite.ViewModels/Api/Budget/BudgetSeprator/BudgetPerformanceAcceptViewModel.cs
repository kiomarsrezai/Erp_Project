using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Budget.BudgetSeprator
{
    public class BudgetPerformanceAcceptViewModel
    {
        public int Id { get; set; }
        public string AreaName { get; set; }
        public int UserId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Responsibility { get; set; }
        public string Date { get; set; }
        public string DateShamsi { get; set; }
    }

    public class Param14
    {
        public int YearId { get; set; }
        public int MonthId { get; set; }
    }
}
