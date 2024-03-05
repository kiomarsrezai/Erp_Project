using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class ContractAmlakInsertParamViewModel
    {
        public int AreaId { get; set; }
        public string Number { get; set; }
        public string Date { get; set; }
        public string Description { get; set; }
        public int SuppliersId { get; set; }
        public int? DoingMethodId { get; set; }
        public int AmlakId { get; set; }
        public string DateFrom { get; set; }
        public string DateEnd { get; set; }
        public Int64 Amount { get; set; }
     }

    public class ContractAmlakDeleteParamViewModel
    {
        public int ContractId { get; set;}
        public int AmlakId { get; set; }
    }


    }
