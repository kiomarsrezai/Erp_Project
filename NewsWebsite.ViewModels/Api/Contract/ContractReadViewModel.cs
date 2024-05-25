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
    }

    public class AmlakInfoContractListViewModel
    {
        public int id { get; set; }
        public string AmlakInfoId { get; set; }
        public string Number { get; set; }
        public string Date { get; set; }
        public string DateShamsi { get; set; }
        public string Description { get; set; }
        public string SupplierFullName { get; set; }
        public string AreaName { get; set; }
        public string EstateInfoName { get; set; }
        public string EstateInfoAddress { get; set; }
        public string DateFrom { get; set; }
        public string DateFromShamsi { get; set; }
        public string DateEnd { get; set; }
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
        public string DoingMethodId { get; set; }
        public float? Masahat  { get; set; }
        public Int64 Surplus { get; set; }
        public bool Final { get; set; }
        public bool IsSubmited { get; set; }
        public int? AreaId { get; set; }
        public int? AmlakId { get; set; }
    }

    public class AmlakInfoContractViewModel
    {
        public int id { get; set; }
        public string AmlakInfoId { get; set; }
        public string Number { get; set; }
        public string Date { get; set; }
        public string DateShamsi { get; set; }
        public string Description { get; set; }
        public int? SuppliersId { get; set; }
        public string AreaName { get; set; }
        public string EstateInfoName { get; set; }
        public string EstateInfoAddress { get; set; }
        public string DateFrom { get; set; }
        public string DateFromShamsi { get; set; }
        public string DateEnd { get; set; }
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
        public float? Masahat { get; set; }
        public Int64 Surplus { get; set; }
        public bool Final { get; set; }
        public bool IsSubmited { get; set; }
        public int? AreaId { get; set; }
        public int? AmlakId { get; set; }
        public long AmountMonth { get; set; }
        public long Zemanat_Price { get; set; }
    }


}

