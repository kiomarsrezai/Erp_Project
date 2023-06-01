using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Budget.BudgetSeprator
{
    public class InsertTaminSepViewModel
    {
        public int yearId { get; set; }
        public int areaId { get; set; }
        public int budgetProcessId { get; set; }
        public string RequestRefStr { get; set; }
        public string RequestDate { get; set; }
        public long RequestPrice { get; set; }
        public string ReqDesc { get; set; }
        public int codingId { get; set; }
    }
}
