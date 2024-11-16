using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Fetch
{
    public class FetchViewModel
    {
        public int Id { get; set; }

        [Display(Name = "کد")]
        public string Code { get; set; }

        [Display(Name = "عنوان")]
        public string Description { get; set; }

        [Display(Name = "سطح")]
        public int LevelNumber { get; set; }
        public int CodingId { get; set; }

        [Display(Name = "مصوب")]
        public Int64 Mosavab { get; set; }

        [Display(Name = "پیشنهادی")]
        public Int64 Pishnahadi { get; set; }

        [Display(Name = "عملکرد")]
        public Int64 Expense { get; set; }

        [Display(Name = "تامین اعتبار")]
        public Int64? CreditAmount { get; set; }

        [Display(Name = "% درصد")]
        public double? PercentBud { get; set; }
        
        [Display(Name = "اصلاح بودجه")]
        public Int64? Edit { get; set; }
        public bool Show { get; set; }

        public Int64 TotalMosavab { get; set; }
        public Int64 TotalExpense { get; set; }
        public bool Crud { get; set; }
        public int? MotherId { get; set; }
    }
    public class PishanahadViewModel
    {
        public int CodingId { get; set; }
        
        [Display(Name = "کد")]
        public string Code { get; set; }

        [Display(Name = "عنوان")]
        public string Description { get; set; }

        [Display(Name = "مصوب")]
        public Int64 Mosavab { get; set; }

        [Display(Name = "اصلاح بودجه")]
        public Int64? Edit { get; set; }

        [Display(Name = "تامین اعتبار")]
        public Int64? CreditAmount { get; set; }

        [Display(Name = "عملکرد")]
        public Int64 Expense { get; set; }

        public Int64 BudgetNext { get; set; }

        [Display(Name = "سطح")]
        public int LevelNumber { get; set; }
        public bool Crud { get; set; }
        public double Percent { get; set; }
    }

    public class BalanceViewModel
    {
       public Int64 Balance { get; set; }

    }

    public class PishanahadModalViewModel
    {
        public int CodingId { get; set; }
        public int AreaId { get; set; }
        public string AreaName { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public Int64 Mosavab { get; set; }
        public Int64 Edit { get; set; }
        public Int64 Supply { get; set; }
        public Int64 Expense { get; set; }
        public Int64 BudgetNext { get; set; }
        public string ProctorId { get; set; }
        public string ExecutionId { get; set; }
    }
}
