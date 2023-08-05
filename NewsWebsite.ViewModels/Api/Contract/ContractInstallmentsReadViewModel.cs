using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class ContractInstallmentsReadViewModel
    {
        public int Id { get; set; }
        public string InstallmentsDate { get; set; }
        public string DateShamsi { get; set; }
        public Int64 MonthlyAmount { get; set; }
    }

    public class Param30
    {
        public int ContractId { get; set; }
    }

}
