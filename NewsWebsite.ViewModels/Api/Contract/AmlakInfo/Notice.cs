using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.ViewModels.Api.Contract.AmlakInfo;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.GeneralVm;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakInfo {
    
    public class AmlakInfoContractNoticeBaseModel {
        public int Title{ get; set; } // Deposit , Rent , license
        public string Date{ get; set; }
        public string LetterNumber{ get; set; }
        public string Description{ get; set; }
    }

    public class AmlakInfoContractNoticeListVm : AmlakInfoContractNoticeBaseModel {
        public int Id{ get; set; }
        public int AmlakInfoContractId{ get; set; }

        public string DateFa{ get; set; }
        public string TitleText{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }
    }


    public class AmlakInfoContractNoticeInsertVm : AmlakInfoContractNoticeBaseModel {
        public int AmlakInfoContractId{ get; set; }
    }

    public class AmlakInfoContractNoticeUpdateVm : AmlakInfoContractNoticeBaseModel {
        public int Id{ get; set; }
    }
    
        
    public class AmlakInfoContractNoticeListInputVm  {
        public int ContractId{ get; set; }
        public int SupplierId{ get; set; }
        public int Page{ get; set; } = 1;
        public int PageRows{ get; set; } = 250;
        public DateTime? DateFrom{ get; set; }
        public DateTime? DateTo{ get; set; }
        public string Sort{ get; set; } = "Id";
        public string SortType{ get; set; } = "desc";
    }
}