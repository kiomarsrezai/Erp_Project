using Microsoft.AspNetCore.Http;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakInfo {
    public class AmlakInfoFilesBaseModel {
        public int? AmlakInfoId{ get; set; }
        public string? FileTitle{ get; set; }
        public string? Type{ get; set; }
    }


    public class AmlakInfoFilesListVm : AmlakInfoFilesBaseModel {
        public string FileName{ get; set; }
        public int? AttachID{ get; set; }
    }

    public class AmlakInfoFileUploadVm : AmlakInfoFilesBaseModel {
        public IFormFile FormFile{ get; set; }
    }
}