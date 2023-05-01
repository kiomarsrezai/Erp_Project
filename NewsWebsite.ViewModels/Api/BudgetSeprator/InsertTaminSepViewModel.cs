using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.BudgetSeprator
{
    public class InsertTaminSepViewModel
    {
        public int yearId { get; set; }
        public int areaId { get; set; }
        public int budgetProcessId { get; set; }
        public string RequestRefStr { get; set; }
        public string RequestDate { get; set; }
        public Int64 RequestPrice { get; set; }
        public string ReqDesc { get; set; }
        public int codingId { get; set; }
    }
}
