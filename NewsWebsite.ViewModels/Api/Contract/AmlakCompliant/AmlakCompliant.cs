using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.AspNetCore.Http;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Contract.AmlakCompliant;
using NewsWebsite.ViewModels.Api.Contract.AmlakInfo;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakCompliant {
    
    public class AmlakCompliantBaseModel {
        public string Subject{ get; set; }
        public string FileNumber{ get; set; }
        public string Date{ get; set; }
        public string DateFa{ get; set; }
    }

    public class AmlakCompliantListVm : AmlakCompliantBaseModel {
        public int Id{ get; set; }
        public int AmlakInfoId{ get; set; }
        public string Status{ get; set; }
        public string StatusText{ get; set; }
        public string SubjectText{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }

    }

    public class AmlakCompliantReadVm : AmlakCompliantBaseModel {
        public int Id{ get; set; }
        public int AmlakInfoId{ get; set; }
        public string Status{ get; set; }
        public string Description{ get; set; }
        public string Steps{ get; set; }
        public int? SupplierId{ get; set; }
        public int? ContractId{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }

        public AmlakInfoContractListVm Contract{ get; set; }
        public AmlakInfoSupplierUpdateVm Supplier{ get; set; }
    }
    public class AmlakCompliantStoreVm : AmlakCompliantBaseModel {
        public int AmlakInfoId{ get; set; }
        public string Status{ get; set; }
        public string Description{ get; set; }
        public string Steps{ get; set; }
        public int? SupplierId{ get; set; }
        public int? ContractId{ get; set; }
    }
    public class AmlakCompliantUpdateVm : AmlakCompliantBaseModel {
        public int Id{ get; set; }
        public string Description{ get; set; }
        public int? SupplierId{ get; set; }
        public int? ContractId{ get; set; }
        
        
    }
    public class AmlakCompliantUpdateStatusVm  {
        public int Id{ get; set; }
        public string Status{ get; set; }
        public string Steps{ get; set; }
    }
    public class AmlakCompliantReadInputVm  {
        public int AmlakInfoId{ get; set; }
        public int SupplierId{ get; set; }
        public string Subject{ get; set; }
        public string FileNumber{ get; set; }
        public string Status{ get; set; }
        public string Sort{ get; set; }="Id";
        public string SortType{ get; set; }="desc";
    }

    public class AmlakCompliantStoreResultVm {
        public int Id{ get; set; }
        public string Message{ get; set; }
    }

}