﻿using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Budget
{
    public class BudgetModalCodingViewModel
    {
        public int Id { get; set; }

        [Display(Name = "کد")]
        public string Code { get; set; }

        [Display(Name = "عنوان")]
        public string Description { get; set; }

        //[Display(Name = "سطح")]
        //public int LevelNumber { get; set; }
        //public int CodingId { get; set; }

        [Display(Name = "مصوب")]
        public Int64 Mosavab { get; set; }

        [Display(Name = "اصلاح بودجه")]
        public Int64 Edit { get; set; }
        
        [Display(Name = "عملکرد")]
        public Int64 Expense { get; set; }

        [Display(Name = "% درصد")]
        public double PercentBud { get; set; }
        
     


    }

  

}