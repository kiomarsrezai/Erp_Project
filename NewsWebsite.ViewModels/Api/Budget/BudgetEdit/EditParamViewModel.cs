﻿using System;
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
        public Int64 NeesEditYearNow { get; set; }
        public int levelNumber { get; set; }
        public int Crud { get; set; }
        public Int64 Edit { get; set; }
    }
 
}