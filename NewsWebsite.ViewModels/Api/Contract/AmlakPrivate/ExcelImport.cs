using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.AspNetCore.Http;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakPrivate {
    
    
    public class ExcelImportInputVm {
        public int? justCheck{ get; set; }
        public IFormFile FormFile{ get; set; }
    }


}