using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class ContractAreaInsertViewModel
    {
        public int ContractId { get; set; }
        public int AreaId { get; set; }
    }
}
