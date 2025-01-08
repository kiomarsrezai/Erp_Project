using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Budget.BudgetCoding
{
    public class BudgetCodingInsertParamModel
    {
        public int MotherId { get; set; }
        public string code { get; set; }
        public string description { get; set; }
        public bool show { get; set; }
        public bool crud { get; set; }
        public int levelNumber { get; set; }
        public int BudgetProcessId { get; set; }
        public int Scope { get; set; }
        public int Stability { get; set; }
        public int PublicConsumptionPercent { get; set; }
        public int PrivateConsumptionPercent { get; set; }

    }
}
