using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Budget.BudgetEdit
{
    public class EditParamViewModel
    {
        public int yearId { get; set; }
        public int areaId { get; set; }
        public int budgetProcessId { get; set; }
    }

    public class EditrowViewModel
    {
        public int CodingId { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public Int64 Mosavab { get; set; }
        public Int64 Supply { get; set; }
        public Int64 Expense { get; set; }
        public Int64 NeedEditYearNow { get; set; }
        public int levelNumber { get; set; }
        public bool Crud { get; set; }
        public Int64 Edit { get; set; }
        public string executionName { get; set; }
        public Int64 ExecutionId { get; set; }
        public string proctorName { get; set; }
        public Int64 ProctorId { get; set; }
    }
 
}
