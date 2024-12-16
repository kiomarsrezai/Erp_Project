using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakPrivate {

    
    public class AmlakPrivateDocHistoryBaseModel {
        public int AmlakPrivateId{ get; set; }
        public string Type{ get; set; }
        public string Status{ get; set; }
        public string Desc{ get; set; }
        public string LetterNumber{ get; set; } 
        public string LetterDate{ get; set; } 
        public int? PersonType{ get; set; } 
        public string? PersonName{ get; set; } 
    }

    public class AmlakPrivateDocHistoryListVm : AmlakPrivateDocHistoryBaseModel {
        public int Id{ get; set; }
        public string Date{ get; set; } 
        public string DateFa{ get; set; } 
        public string LetterDateFa{ get; set; } 
        public string StatusText{ get; set; }
        public string PersonTypeText{ get; set; }
  
    }

    public class AmlakPrivateDocHistoryVm  {
        public string Status{ get; set; }
        public string StatusText{ get; set; }
  
    }


    public class AmlakPrivateDocHistoryStoreVm : AmlakPrivateDocHistoryBaseModel {
    }

    
}
