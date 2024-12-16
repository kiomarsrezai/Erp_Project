using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.ViewModels.Api.GeneralVm;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakPrivate {
    
    public class AmlakPrivateTransferBaseModel {
        public int AmlakPrivateId { get; set; } 
        public int RecipientType { get; set; } 
        public string RecipientName { get; set; }  
        public string NationalCode { get; set; }  
        public string Representative { get; set; }
        public string RecipientPhone { get; set; }
        public string MunicipalityRepName { get; set; }
        public string LetterDate { get; set; } 
        public string LetterNumber { get; set; }  
        public string NotaryOfficeNumber { get; set; }
        public string NotaryOfficeLocation { get; set; }
        public string ExitDate { get; set; }
    }


    public class AmlakPrivateTransferReadVm : AmlakPrivateTransferBaseModel {
        public AmlakPrivateListVm AmlakPrivate{ get; set; }
        public string CreatedAt { get; set; }
        public string LetterDateFa { get; set; }
        public string ExitDateFa { get; set; }
        public string CreatedAtFa { get; set; }


    }

    public class AmlakPrivateTransferUpdateVm : AmlakPrivateTransferBaseModel {
    }

    public class AmlakPrivateTransferStoreVm : AmlakPrivateTransferBaseModel {
    }
}
