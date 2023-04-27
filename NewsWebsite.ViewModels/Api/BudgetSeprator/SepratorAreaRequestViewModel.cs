using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Api.BudgetSeprator
{
    public class SepratorAreaRequestViewModel
    {
        [Display(Name = "شماره")]
        public string Number { get; set; }

        [Display(Name = "عنوان")]
        public string Description { get; set; } 
        
        [Display(Name = "تاریخ")]
        public string Date { get; set; }

        [Display(Name = "مبلغ")]
        public Int64 EstimateAmount { get; set; }
        public int? id { get; set; }

    }
   

}
