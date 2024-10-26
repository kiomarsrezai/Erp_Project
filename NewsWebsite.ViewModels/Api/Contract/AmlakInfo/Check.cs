using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.ViewModels.Api.Contract.AmlakInfo;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.GeneralVm;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakInfo {
    
    public class AmlakInfoContractCheckBaseModel {
        public string Number{ get; set; } // Deposit , Rent , license
        public string Date{ get; set; }
        public string Amount{ get; set; }
        public string Description{ get; set; }
    }

    public class AmlakInfoContractCheckListVm : AmlakInfoContractCheckBaseModel {
        public int Id{ get; set; }
        public int AmlakInfoContractId{ get; set; }
        public int IsPassed{ get; set; }
        public string DateFa{ get; set; }

        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }
    }


    public class AmlakInfoContractCheckInsertVm : AmlakInfoContractCheckBaseModel {
        public int AmlakInfoContractId{ get; set; }
    }

    public class AmlakInfoContractCheckUpdateVm : AmlakInfoContractCheckBaseModel {
        public int Id{ get; set; }

    }
    
        
    public class AmlakInfoContractCheckListInputVm  {
        public int contractId{ get; set; }
        public int? IsPassed{ get; set; }
        public int page{ get; set; } = 1;
        public int pageRows{ get; set; } = 10;
        public string sort{ get; set; } = "Id";
        public string sortType{ get; set; } = "desc";
    }
}