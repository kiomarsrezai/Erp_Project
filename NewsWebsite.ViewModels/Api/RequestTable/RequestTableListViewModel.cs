using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.RequestTable
{
    public class RequestTableListViewModel
    {
        public int Id { get; set; }

        [Display(Name = "سال")]
        public int YearId { get; set; }
        
        [Display(Name = "منطقه")]
        public int AreaId { get; set; }
        
        [Display(Name = "واحد درخواست کننده")]
        public int ExecuteDepartmanId { get; set; }
        
        [Display(Name = "کاربر")]
        public string Users { get; set; }
        public int DoingMethodId { get; set; }
        public string Number { get; set; }
        public string Date { get; set; }
        public string DateS { get; set; }
        public string Description { get; set; }
        public long EstimateAmount { get; set; }
        public string ResonDoingMethod { get; set; }

    }
}
