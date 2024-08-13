using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.ViewModels.Api.Contract.AmlakInfo;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakInfo {
    public class AmlakInfoContractSupplierVm:BaseModel {
        
        public int ContractId{ get; set; }
        // public AmlakInfoContractListVm Contract{ get; set; }
        public int SupplierId{ get; set; }
        public AmlakInfoSupplierContractReadVm Supplier{ get; set; }
    }
    
}