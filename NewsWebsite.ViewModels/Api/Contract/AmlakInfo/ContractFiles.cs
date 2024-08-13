using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.AspNetCore.Http;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakInfo {
    
    // Model --------------------------------------------------------------
    [Table("TblContractAttachs")]
    public class AmlakInfoContractFile:BaseModel {
        public int ContractId{ get; set; }
        public string FileName{ get; set; }
        public string FileTitle{ get; set; }
    }

    
    // View Models ---------------------------------------------------------

    public class AmlakInfoContractFilesBaseModel {
        public int? ContractId{ get; set; }
        public string? FileTitle{ get; set; }
    }


    public class AmlakInfoContractFilesListVm : AmlakInfoContractFilesBaseModel {
        public string FileName{ get; set; }
    }

    public class AmlakInfoContractFileUploadVm : AmlakInfoContractFilesBaseModel {
        public IFormFile FormFile{ get; set; }
    }
}