using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Fetch
{
    public class FetchDataBudgetViewModel
    {
        public int AreaId { get; set; }

        [Display(Name = "کد بودجه")]
        public string Code { get; set; }

        [Display(Name = "شرح ردیف")]
        public string Description { get; set; }

        [Display(Name = "سطح")]
        public int LevelNumber { get; set; }

        [Display(Name = "مصوب")]
        public Int64 Mosavab { get; set; }

        [Display(Name = "عملکرد")]
        public Int64 Expense { get; set; }

    }

  

}
