using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models.AmlakInfo {
    [Table("tblContractAmlakInfoPrices")]
    public class AmlakInfoContractPrice:BaseModel {
        
        public int ContractId{ get; set; }
        // public AmlakInfoContract Contract{ get; set; }
        public int Year{ get; set; }
        public Int64 Diposit{ get; set; }
        public Int64 Rent{ get; set; }
        
        
    }
    
}