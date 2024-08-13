using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.ViewModels.Api.Contract.AmlakInfo;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakInfo {
    public class AmlakInfoContractPriceVm:BaseModel {
        
        public int ContractId{ get; set; }
        public int Year{ get; set; }
        public Int64 Deposit{ get; set; }
        public Int64 Rent{ get; set; }
    }
    
}