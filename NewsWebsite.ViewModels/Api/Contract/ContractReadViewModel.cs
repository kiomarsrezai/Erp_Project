using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Runtime.Serialization;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class ContractReadViewModel
    {
        public int Id { get; set; }
        public string Number { get; set; }
        public DateTime? Date { get; set; }
        public string DateShamsi { get; set; }
        public string Description { get; set; }
        public int? SuppliersId { get; set; }
        public string SuppliersName { get; set; }
        public DateTime? DateFrom { get; set; }
        public string DateFromShamsi { get; set; }
        public DateTime? DateEnd { get; set; }
        public string DateEndShamsi { get; set; }
        public Int64 Amount { get; set; }
        public int? DoingMethodId { get; set; }
        public Int64 Surplus { get; set; }
        public bool Final { get; set; }

    }

    public class AmlakInfoContractListViewModel
    {
        public int id { get; set; }
        public int? AmlakInfoId { get; set; }
        public string Number { get; set; }
        public DateTime? Date { get; set; }
        public string DateShamsi { get; set; }
        public string Description { get; set; }
        public string SuppliersName { get; set; }
        public string AreaName { get; set; }
        public string EstateInfoName { get; set; }
        public string EstateInfoAddress { get; set; }
        public DateTime? DateFrom { get; set; }
        public string DateFromShamsi { get; set; }
        public DateTime? DateEnd { get; set; }
        public string DateEndShamsi { get; set; }
        public string TypeUsing { get; set; }
        public string ContractType { get; set; }
        public string TenderNumber { get; set; }
        public string TenderDate { get; set; }
        public string Sarparast { get; set; }
        public string Modir { get; set; }
        public string Nemayande { get; set; }
        public string ModatType { get; set; }
        public string ModatValue { get; set; }
        public Int64 Amount { get; set; }
        public int? DoingMethodId { get; set; }
        public float? Masahat  { get; set; }
        public Int64 Surplus { get; set; }
        public bool Final { get; set; }
        public bool IsSubmited { get; set; }

    }



}

