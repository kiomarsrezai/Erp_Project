using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Request
{
    public class RequestReadParamViewModel
    {
        [Required(ErrorMessage = "وارد نمودن {0} الزامی است.")]
        public int RequestId { get; set; }
        
    }
}
