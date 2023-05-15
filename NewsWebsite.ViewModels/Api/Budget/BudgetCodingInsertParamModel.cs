using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Budget
{
    public class BudgetCodingInsertParamModel
    {
        public int MotherId { get; set; }
        public string code { get; set; }
        public string description { get; set; }
        public bool show { get; set; }
        public bool crud { get; set; }
        public int levelNumber { get; set; }

    }
}
