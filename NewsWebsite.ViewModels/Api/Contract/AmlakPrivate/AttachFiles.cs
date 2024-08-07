using Microsoft.AspNetCore.Http;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakPrivate {
    public class AmlakPrivateFilesBaseModel {
        public int? AmlakPrivateId{ get; set; }
        public string? FileTitle{ get; set; }
        public string? Type{ get; set; }
    }


    public class AmlakPrivateFilesListVm : AmlakPrivateFilesBaseModel {
        public string FileName{ get; set; }
        public int? AttachID{ get; set; }
    }

    public class AmlakPrivateFileUploadVm : AmlakPrivateFilesBaseModel {
        public IFormFile FormFile{ get; set; }
    }
}