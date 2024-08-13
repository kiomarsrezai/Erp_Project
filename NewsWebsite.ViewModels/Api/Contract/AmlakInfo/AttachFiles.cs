using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.AspNetCore.Http;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakInfo {
    
    // Model --------------------------------------------------------------
    [Table("TblAmlakInfoAttachs")]
    public class AmlakInfoFile:BaseModel {
        public int AmlakInfoId{ get; set; }
        public string FileName{ get; set; }
        public string FileTitle{ get; set; }
        public string Type{ get; set; }
    }

    
    // View Models ---------------------------------------------------------

    public class AmlakInfoFilesBaseModel {
        public int? AmlakInfoId{ get; set; }
        public string? FileTitle{ get; set; }
        public string? Type{ get; set; }
    }


    public class AmlakInfoFilesListVm : AmlakInfoFilesBaseModel {
        public string FileName{ get; set; }
    }

    public class AmlakInfoFileUploadVm : AmlakInfoFilesBaseModel {
        public IFormFile FormFile{ get; set; }
    }
}