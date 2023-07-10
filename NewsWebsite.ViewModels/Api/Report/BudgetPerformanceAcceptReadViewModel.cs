using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Report
{
    public class BudgetPerformanceAcceptReadViewModel
    {
        public int Id { get; set; }
        public string AreaName { get; set; }
        public int? UserId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Responsibility { get; set; }
        public string Date { get; set; }
        public string DateShamsi { get; set; }
    }

    public class Param2ViewModel
    {
        public int YearId { get; set; }
        public int MonthId { get; set; }

    }


    
}
