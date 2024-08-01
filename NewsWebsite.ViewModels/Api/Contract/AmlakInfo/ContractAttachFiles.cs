using Microsoft.AspNetCore.Http;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakInfo {
    public class ContractFilesBaseModel {
        public int? ContractId{ get; set; }
        public string? FileTitle{ get; set; }
    }

    public class ContractFilesListVm : ContractFilesBaseModel {
        public string FileName{ get; set; }
        public int? AttachID{ get; set; }
    }

    public class ContractFileUploadVm : ContractFilesBaseModel {
        public IFormFile FormFile{ get; set; }
    }
}