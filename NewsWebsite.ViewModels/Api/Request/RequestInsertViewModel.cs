using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Request
{
    public class RequestInsertViewModel
    {
        [Required(ErrorMessage = "وارد نمودن {0} الزامی است.")]
        [Display(Name = "سال")]
        public int YearId { get; set; }
        
        [Required(ErrorMessage = "وارد نمودن {0} الزامی است.")]
        [Display(Name = "منطقه")]
        public int AreaId { get; set; }
        
        [Required(ErrorMessage = "وارد نمودن {0} الزامی است.")]
        [Display(Name = "واحد درخواست کننده")]
        public int ExecuteDepartmanId { get; set; }
        
        [Required(ErrorMessage = "وارد نمودن {0} الزامی است.")]
        [Display(Name = "کاربر")]
        public int UserId { get; set; }

    }
}
