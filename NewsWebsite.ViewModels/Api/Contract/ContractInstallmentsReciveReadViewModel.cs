using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class ContractInstallmentsReciveReadViewModel
    {
        public int Id { get; set; }
        public string SuppliersName { get; set; }
        public string Number { get; set; }
        public int YearName { get; set; }
        public int MonthId { get; set; }
        public Int64 ReciveAmount { get; set; }

    }
    public class param32
    {
        public int ReciveBankId { get; set; }
    }

}
