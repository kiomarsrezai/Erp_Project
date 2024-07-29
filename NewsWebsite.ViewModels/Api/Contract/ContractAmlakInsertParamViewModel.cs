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
        public float? Masahat { get; set; }
        public string? CurrentStatus { get; set; }
        public string? Structure { get; set; }
        public string? Owner { get; set; }
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
    public class ContractAmlakUpdateParamViewModel
    {
        public int Id { get; set; }
        public int AreaId { get; set; }
        public string Number { get; set; }
        public string Date { get; set; }
        public string Description { get; set; }
        public int SuppliersId { get; set; }
        public int? DoingMethodId { get; set; }
        public int AmlakId { get; set; }
        public float? Masahat { get; set; }
        public string? CurrentStatus { get; set; }
        public string? Structure { get; set; }
        public string? Owner { get; set; }
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

    public class ContractAmlakDeleteParamViewModel
    {
        public int ContractId { get; set;}
        public int AmlakId { get; set; }
    }


    }
