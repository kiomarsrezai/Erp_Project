using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models.AmlakInfo {
    [Table("tblContractAmlakInfoSupplier")]
    public class AmlakInfoContractSupplier:BaseModel {
        
        public int ContractId{ get; set; }
        public AmlakInfoContract Contract{ get; set; }
        public int SupplierId{ get; set; }
        public Supplier Supplier{ get; set; }
    }
    
}