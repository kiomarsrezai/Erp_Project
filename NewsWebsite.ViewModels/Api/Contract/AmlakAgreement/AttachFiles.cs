using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.AspNetCore.Http;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakAgreement {
    
    // Model --------------------------------------------------------------
    [Table("TblAmlakAgreementAttachs")]
    public class AmlakAgreementFile:BaseModel {
        public int AmlakAgreementId{ get; set; }
        public string FileName{ get; set; }
        public string FileTitle{ get; set; }
        public string Type{ get; set; }
    }

    
    // View Models ---------------------------------------------------------

    public class AmlakAgreementFilesBaseModel {
        public int? AmlakAgreementId{ get; set; }
        public string? FileTitle{ get; set; }
        public string? Type{ get; set; }
    }


    public class AmlakAgreementFilesListVm : AmlakAgreementFilesBaseModel {
        public int Id{ get; set; }
        public string FileName{ get; set; }
    }

    public class AmlakAgreementFileUploadVm : AmlakAgreementFilesBaseModel {
        public IFormFile FormFile{ get; set; }
    }
    public class AmlakAgreementFileUploadVm2  {
        public int? AmlakAgreementId{ get; set; }
        public string? Type{ get; set; }
        public List<IFormFile> FormFiles{ get; set; }
    }
}