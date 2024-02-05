using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Budget.BudgetEdit
{
    public class EditDetailModalParamViewModel
    {
        public int yearId { get; set; }
        public int areaId { get; set; }
        public int budgetProcessId { get; set; }
        public int CodingId { get; set; }
    }

    public  class EditDetailModalViewModel
    {
        public int CodingId { get; set; }
        public int AreaId { get; set; }
        public string AreaName { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public Int64 Mosavab { get; set; }
        public Int64 Supply { get; set; }
        public Int64 Expense { get; set; }
        public Int64 NeedEditYearNow { get; set; }
        public Int64 Edit { get; set; }
        public int levelNumber { get; set; }
    }


}
