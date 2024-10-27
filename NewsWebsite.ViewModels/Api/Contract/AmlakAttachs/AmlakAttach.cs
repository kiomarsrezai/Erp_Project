using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.AspNetCore.Http;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.amlakAttachs {
    
    // Model --------------------------------------------------------------
    [Table("TblAmlakAttachs")]
    public class AmlakAttach:BaseModel {
        public int Id{ get; set; }
        public string TargetType{ get; set; }
        public int TargetId{ get; set; }
        public string FileName{ get; set; }
        public string FileTitle{ get; set; }
        public string Type{ get; set; }
    }

    
    // View Models ---------------------------------------------------------

    public class AmlakAttachsBaseModel {
        public string? TargetType{ get; set; }
        public int? TargetId{ get; set; }
        public string? FileTitle{ get; set; }
        public string? Type{ get; set; }
    }


    public class AmlakAttachsListVm : AmlakAttachsBaseModel {
        public int Id{ get; set; }
        public string FileName{ get; set; }
    }

    public class AmlakAttachUploadVm : AmlakAttachsBaseModel {
        public IFormFile FormFile{ get; set; }
    }
    
    
    
    public static class AmlakAttachsExtensions {

        public static IQueryable<AmlakAttach> Type(this IQueryable<AmlakAttach> query, string? value){
            if (BaseModel.CheckParameter(value,"")){
                return query.Where(e => e.Type == value);
            }
            return query;
        }
    }
}