﻿using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Request
{
    public class RequestBudgetReadTabViewModel
    {
        public int Id { get; set; }
        public string YearName { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public string Project { get; set; }
        public Int64 RequestBudgetAmount { get; set; }
    }
}
