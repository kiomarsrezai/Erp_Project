using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.AspNetCore.Http;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakPrivate {
    
    // Model --------------------------------------------------------------
    [Table("TblAmlakPrivateAttachs")]
    public class AmlakPrivateFile:BaseModel {
        public int AmlakPrivateId{ get; set; }
        public string FileName{ get; set; }
        public string FileTitle{ get; set; }
        public string Type{ get; set; }
    }

    
    // View Models ---------------------------------------------------------
    
    public class AmlakPrivateFilesBaseModel {
        public int? AmlakPrivateId{ get; set; }
        public string? FileTitle{ get; set; }
        public string? Type{ get; set; }
    }


    public class AmlakPrivateFilesListVm : AmlakPrivateFilesBaseModel {
        public int? Id{ get; set; }
        public string FileName{ get; set; }
    }

    public class AmlakPrivateFileUploadVm : AmlakPrivateFilesBaseModel {
        public IFormFile FormFile{ get; set; }
    }
}