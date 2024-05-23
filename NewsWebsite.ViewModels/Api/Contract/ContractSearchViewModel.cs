using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class ContractSearchViewModel
    {
        public int Id { get; set; }
        public string Number { get; set; }
        public DateTime? Date { get; set; }
        public string DateShamsi { get; set; }
        public string Description { get; set; }
        public string SuppliersName { get; set; }
        public string AreaId { get; set; }
        public int SuppliersId { get; set; }
        public int? DoingMethodId { get; set; }
        public int AmlakId { get; set; }
        public float? Masahat { get; set; }
        public string DateFrom { get; set; }
        public string DateEnd { get; set; }
        public Int64 Amount { get; set; }
        public Int64 AmountMonth { get; set; }
        public Int64 Zemanat_Price { get; set; }
        public string Modat { get; set; }
        public string Nemayande { get; set; }
        public string Modir { get; set; }
        public string Sarparast { get; set; }
        public string TenderNumber { get; set; }
        public string TenderDate { get; set; }
        public string TypeUsing { get; set; }
        public int ModatValue { get; set; }

    }
}
