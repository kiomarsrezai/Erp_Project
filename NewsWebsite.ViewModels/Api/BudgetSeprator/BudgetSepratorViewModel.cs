using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Api.BudgetSeprator
{
    public class BudgetSepratorViewModel
    {
        public int Id { get; set; }

        [Display(Name = "کد")]
        public string Code { get; set; }

        [Display(Name = "عنوان")]
        public string Description { get; set; } 
        
        [Display(Name = "کد حسابداری")]
        public string CodeVaset { get; set; }
        public int CodingId { get; set; }

        [Display(Name = "سطح")]
        public int LevelNumber { get; set; }

        [Display(Name = "مصوب")]
        public Int64 Mosavab { get; set; }

        [Display(Name = "عملکرد")]
        public Int64 Expense { get; set; }
        
        [Display(Name = "تامین اعتبار")]
        public Int64 CreditAmount { get; set; }

        [Display(Name = "% درصد")]
        public double PercentBud { get; set; }

        public bool Crud { get; set; }
        public int budgetProcessId { get; set; }
        public long Edit { get; set; }
    }
    //public enum Sectios
    //{
    //    [Display(Name = "منطقه یک")]
    //    Male = 1,

    //    [Display(Name = "منطقه دو")]
    //    Female = 2
    //}
    //public class CodeAccUpdateViewModel
    //{
    //    public int CodingId { get; set; }

    //    [Display(Name = "کد حسابداری")]
    //    public int CodeVaset { get; set; }


    //}

}
