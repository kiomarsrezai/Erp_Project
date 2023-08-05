using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class ReciveBankModalViewModel
    {
        public int Id { get; set; }
        public int YearName { get; set; }
        public int MonthId { get; set; }
        public Int64 MonthlyAmount { get; set; }
        public string Description { get; set; }
    }

    public class param33
    {
        public int SuppliersId { get; set; }
        public int ReciveBankId { get; set; }
    }
}
