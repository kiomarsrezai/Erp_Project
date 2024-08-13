using Microsoft.AspNetCore.Http;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakInfo {
    public class ContractFilesBaseModel1 {
        public int? ContractId{ get; set; }
        public string? FileTitle{ get; set; }
    }

    public class ContractFilesListVm1 : ContractFilesBaseModel1 {
        public string FileName{ get; set; }
        public int? AttachID{ get; set; }
    }

    public class ContractFileUploadVm1 : ContractFilesBaseModel1 {
        public IFormFile FormFile{ get; set; }
    }
}