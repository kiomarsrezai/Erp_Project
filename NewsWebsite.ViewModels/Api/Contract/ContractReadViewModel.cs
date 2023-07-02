using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class ContractReadViewModel
    {
        public int Id { get; set; }
        public string Number { get; set; }
        public string Date { get; set; }
        public string DateShamsi { get; set; }
        public string Description { get; set; }
        public int SuppliersId { get; set; }
        public string SuppliersName { get; set; }
        public string DateFrom { get; set; }
        public string DateFromShamsi { get; set; }
        public string DateEnd { get; set; }
        public string DateEndShamsi { get; set; }
        public Int64 Amount { get; set; }
        public int DoingMethodId { get; set; }
        public Int64 Surplus { get; set; }
        public bool Final { get; set; }
    }
}

