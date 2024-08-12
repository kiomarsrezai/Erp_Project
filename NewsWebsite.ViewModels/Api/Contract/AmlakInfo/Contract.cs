using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.ViewModels.Api.Contract.AmlakInfo;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakInfo {
    
    public class AmlakInfoContractBaseModel {
        // public int? AreaId{ get; set; }
        // public string Number{ get; set; }
        // public string Nemayande{ get; set; }
        // public string Modir{ get; set; }
        // public string Sarparast{ get; set; }
        // public string Modat{ get; set; }
        // public string ModatValue{ get; set; }
        // public string TenderNumber{ get; set; }
        // public string TenderDate{ get; set; }
        // public string Date{ get; set; }
        // public string? Description{ get; set; }
        // public int? SuppliersId{ get; set; }
        // public string? DoingMethodId{ get; set; }
        // public float? Masahat{ get; set; }
        // public int? AmlakId{ get; set; }
        // public string DateFrom{ get; set; }
        // public string DateEnd{ get; set; }
        // public string? CurrentStatus{ get; set; }
        // public string? Structure{ get; set; }
        // public string? Owner{ get; set; }
        // public Int64 Amount{ get; set; }
        // public Int64 AmountMonth{ get; set; }
        // public Int64 Zemanat_Price{ get; set; }
        // public string TypeUsing{ get; set; }
    }

    public class AmlakInfoContractListVm : AmlakInfoContractBaseModel {
        public int Id{ get; set; }
        public string Number{ get; set; } // Deposit , Rent , license
        public int Type{ get; set; }
        public string Date{ get; set; }
        public string Description{ get; set; }
        public int AreaId{ get; set; }
        
    }

    public class AmlakInfoContractReadVm : AmlakInfoContractBaseModel {
        
        public int AmlakInfoId{ get; set; }
        public int AreaId{ get; set; }
        public int DoingMethodId{ get; set; }
        public string Number{ get; set; } // Deposit , Rent , license
        public string Date{ get; set; }
        public string Description{ get; set; }
        public string DateFrom{ get; set; }
        public string DateEnd{ get; set; }
        public Int64 ZemanatPrice{ get; set; }
        public int Type{ get; set; }
        public int ModatValue{ get; set; }
        public string Nemayande{ get; set; }
        public string Modir{ get; set; }
        public string Sarparast{ get; set; }
        public string TenderNumber{ get; set; }
        public string TenderDate{ get; set; }
        
        public ICollection<AmlakInfoContractSupplierVm> Suppliers{ get; set; }
        public ICollection<AmlakInfoContractPriceVm> Prices{ get; set; }
        public AmlakInfoReadContractVm AmlakInfo {get; set; }
        
    }


    public class AmlakInfoContractInsertVm : AmlakInfoContractBaseModel {
    }

    public class AmlakInfoContractUpdateVm : AmlakInfoContractBaseModel {
        public int Id{ get; set; }
    }
}