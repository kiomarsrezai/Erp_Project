using System;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakInfo {
    public class AmlakInfoContractBaseModel {
        public int? AreaId{ get; set; }
        public string Number{ get; set; }
        public string Nemayande{ get; set; }
        public string Modir{ get; set; }
        public string Sarparast{ get; set; }
        public string Modat{ get; set; }
        public string ModatValue{ get; set; }
        public string TenderNumber{ get; set; }
        public string TenderDate{ get; set; }
        public string Date{ get; set; }
        public string? Description{ get; set; }
        public int? SuppliersId{ get; set; }
        public string? DoingMethodId{ get; set; }
        public float? Masahat{ get; set; }
        public int? AmlakId{ get; set; }
        public string DateFrom{ get; set; }
        public string DateEnd{ get; set; }
        public string? CurrentStatus{ get; set; }
        public string? Structure{ get; set; }
        public string? Owner{ get; set; }
        public Int64 Amount{ get; set; }
        public Int64 AmountMonth{ get; set; }
        public Int64 Zemanat_Price{ get; set; }
        public string TypeUsing{ get; set; }
    }

    public class AmlakInfoContractListVm : AmlakInfoContractBaseModel {
        public int id{ get; set; }
        public string AmlakInfoId{ get; set; }
        public string DateShamsi{ get; set; }
        public string SupplierFullName{ get; set; }
        public string AreaName{ get; set; }
        public string EstateInfoName{ get; set; }
        public string EstateInfoAddress{ get; set; }
        public string DateFromShamsi{ get; set; }
        public string DateEndShamsi{ get; set; }
        public string ContractType{ get; set; }
        public Int64 Surplus{ get; set; }
        public bool Final{ get; set; }
        public bool IsSubmited{ get; set; }
    }

    public class AmlakInfoContractReadVm : AmlakInfoContractBaseModel {
        public int id{ get; set; }
        public string AmlakInfoId{ get; set; }
        public string DateShamsi{ get; set; }
        public string AreaName{ get; set; }
        public string EstateInfoName{ get; set; }
        public string EstateInfoAddress{ get; set; }
        public string DateFromShamsi{ get; set; }
        public string DateEndShamsi{ get; set; }
        public string ContractType{ get; set; }
        public Int64 Surplus{ get; set; }
        public bool Final{ get; set; }
        public bool IsSubmited{ get; set; }
    }


    public class AmlakInfoContractInsertVm : AmlakInfoContractBaseModel {
    }

    public class AmlakInfoContractUpdateVm : AmlakInfoContractBaseModel {
        public int Id{ get; set; }
    }
}