using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class ContractInstallmentsInsertViewModel
    {
        public int ContractId { get; set; }
        public string Date { get; set; }
        public Int64 Amount { get; set; }
        public int Month { get; set; }
        public int YearName { get; set; }
    }
}
