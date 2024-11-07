using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.ViewModels.Api.Contract.AmlakInfo;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.GeneralVm;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakInfo {
    
    public class AmlakInfoContractBaseModel {
        public int OwnerId{ get; set; }
        // public int DoingMethodId{ get; set; }
        public string Number{ get; set; } // Deposit , Rent , license
        public string Date{ get; set; }
        public string Description{ get; set; }
        public Int64 ZemanatPrice{ get; set; }
        public string Type{ get; set; }
        public int ModatValue{ get; set; }
        public string Nemayande{ get; set; }
        public string Modir{ get; set; }
        public string Sarparast{ get; set; }
        public string TenderNumber{ get; set; }
        public string TenderDate{ get; set; }
        
    }

    public class AmlakInfoContractListVm : AmlakInfoContractBaseModel {
        public int Id{ get; set; }
        public int AmlakInfoId{ get; set; }
        public int OwnerId{ get; set; }
        public string DateFa{ get; set; }= "";
        public DateTime DateFrom{ get; set; }
        public DateTime DateEnd{ get; set; }
        public string DateFromFa{ get; set; } = "";
        public string DateEndFa{ get; set; } = "";
        public string TenderDateFa{ get; set; } = "";
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }
        
        public AreaViewModel Owner {get; set; }

    }

    public class AmlakInfoContractReadVm : AmlakInfoContractBaseModel {
        public int AmlakInfoId{ get; set; }
        public int OwnerId{ get; set; }
        public string DateFa{ get; set; }= "";
        public DateTime DateFrom{ get; set; }
        public DateTime DateEnd{ get; set; }
        public string DateFromFa{ get; set; } = "";
        public string DateEndFa{ get; set; } = "";
        public string TenderDateFa{ get; set; } = "";
        public string ZemanatEndDate{ get; set; }
        public string ZemanatEndDateFa{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }

        
        public ICollection<AmlakInfoContractSupplierVm> Suppliers{ get; set; }
        public ICollection<AmlakInfoContractPriceVm> Prices{ get; set; }
        public AmlakInfoReadContractVm AmlakInfo {get; set; }
        public AreaViewModel Owner {get; set; }
        
    }


    public class AmlakInfoContractInsertVm : AmlakInfoContractBaseModel {
        public int AmlakInfoId{ get; set; }
        public int OwnerId{ get; set; }

        // amlak info data
        public double? Masahat{ get; set; }
        // public string? CurrentStatus{ get; set; }
        public string? Structure{ get; set; }
        public string? Owner{ get; set; }
        public string? TypeUsing{ get; set; }
        public string? Code{ get; set; }
        public List<PricesInputVm> Prices{ get; set; }
        public List<int> SupplierIds{ get; set; }
        public string DateFrom{ get; set; }
        public string DateEnd{ get; set; }
        public string ZemanatEndDate{ get; set; }
    }
    
    public class PricesInputVm {
        
        public int Year{ get; set; }
        public Int64 Rent{ get; set; }
        public Int64 Deposit{ get; set; }
        
    }

    public class AmlakInfoContractUpdateVm : AmlakInfoContractBaseModel {
        public int Id{ get; set; }
        public double? Masahat{ get; set; }
        // public string? CurrentStatus{ get; set; }
        public string? Structure{ get; set; }
        public string? Owner{ get; set; }
        public string? TypeUsing{ get; set; }
        public string? Code{ get; set; }
        public List<PricesInputVm> Prices{ get; set; }
        public List<int> SupplierIds{ get; set; }
        public string DateFrom{ get; set; }
        public string DateEnd{ get; set; }
        public string ZemanatEndDate{ get; set; }
    }
}