using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.AspNetCore.Http;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.GeneralVm;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakAgreement {
    
    public class AmlakAgreementBaseModel {
        public int Id{ get; set; }
        public string Title{ get; set; }
        public string ContractParty{ get; set; }
    }

    public class AmlakAgreementListVm : AmlakAgreementBaseModel {
        public int IsSubmitted{ get; set; }
        public string Coordinates{ get; set; }
        public DateTime Date{ get; set; }
        public string DateFa{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }
        
    }

    public class AmlakAgreementReadVm : AmlakAgreementBaseModel {
        public string Description{ get; set; }
        public string Address{ get; set; }
        public string AmountMunicipality{ get; set; }
        public string AmountContractParty{ get; set; }
        public int IsSubmitted{ get; set; }
        public string Coordinates{ get; set; }
        public DateTime? Date{ get; set; }
        public DateTime? DateFrom{ get; set; }
        public DateTime? DateTo{ get; set; }
        public string DateFa{ get; set; }
        public string DateFromFa{ get; set; }
        public string DateToFa{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }

         

    }
    public class AmlakAgreementUpdateVm : AmlakAgreementBaseModel {
        public string AmountMunicipality{ get; set; }
        public string AmountContractParty{ get; set; }
        public string Description{ get; set; }
        public string Address{ get; set; }
        public string Date{ get; set; }
        public string DateFrom{ get; set; }
        public string DateTo{ get; set; }
    
    }
    public class AmlakAgreementReadInputVm  {
        public string ContractParty{ get; set; }
        public string Search{ get; set; }
        
        public int ForMap{ get; set; } = 0;
        public int Export{ get; set; } = 0;
        public int Page{ get; set; } = 1;
        public int PageRows{ get; set; } = 10;
        public string Sort{ get; set; }="Id";
        public string SortType{ get; set; }="desc";
    }

    public class AmlakAgreementStoreResultVm {
        public int Id{ get; set; }
        public string Message{ get; set; }
    }

}