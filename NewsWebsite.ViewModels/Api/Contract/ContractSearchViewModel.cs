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
        public int AreaId { get; set; }
        public int SuppliersId { get; set; }
        public int? DoingMethodId { get; set; }
        public string DateFrom { get; set; }
        public string DateEnd { get; set; }
        public Int64 Amount { get; set; }
        public int Type { get; set; }
        public string CodeBaygani { get; set; }
        public string ModatType { get; set; }
        public string ModatValue { get; set; }
        public int RequestID { get; set; }
        public string Zemanat_Number { get; set; }
        public Int64 Zemanat_Price { get; set; }
        public string Zemanat_Date { get; set; }
        public string Zemanat_Bank { get; set; }
        public string Zemanat_Shobe { get; set; }
        public string Zemanat_ModatValue { get; set; }
        public string Zemanat_ModatType { get; set; }
        public string Zemanat_EndDate { get; set; }
        public string Zemanat_Type { get; set; }
        public long Surplus { get; set; }
        public bool Final { get; set; }
    }
}
