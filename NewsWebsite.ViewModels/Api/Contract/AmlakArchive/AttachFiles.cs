using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.AspNetCore.Http;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakArchive {
    
    // Model --------------------------------------------------------------
    [Table("TblAmlakArchiveAttachs")]
    public class AmlakArchiveFile:BaseModel {
        public int AmlakArchiveId{ get; set; }
        public string FileName{ get; set; }
        public string FileTitle{ get; set; }
        public string Type{ get; set; }
    }

    
    // View Models ---------------------------------------------------------

    public class AmlakArchiveFilesBaseModel {
        public int? AmlakArchiveId{ get; set; }
        public string? FileTitle{ get; set; }
        public string? Type{ get; set; }
    }


    public class AmlakArchiveFilesListVm : AmlakArchiveFilesBaseModel {
        public int Id{ get; set; }
        public string FileName{ get; set; }
    }

    public class AmlakArchiveFileUploadVm : AmlakArchiveFilesBaseModel {
        public IFormFile FormFile{ get; set; }
    }
    public class AmlakArchiveFileUploadVm2  {
        public int? AmlakArchiveId{ get; set; }
        public string? Type{ get; set; }
        public List<IFormFile> FormFiles{ get; set; }
    }
}