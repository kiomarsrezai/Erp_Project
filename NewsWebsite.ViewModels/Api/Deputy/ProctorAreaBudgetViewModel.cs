using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Api.Deputy
{
    public class ProctorAreaBudgetViewModel
    {
        public int YearId { get; set; }
        public int ProctorId { get; set; }
        public int AreaId { get; set; }

        [Display(Name = "کد بودجه")]
        public string Code { get; set; }

        [Display(Name = "شرح ردیف")]
        public string Description { get; set; }

        [Display(Name = "مصوب")]
        public Int64 Mosavab { get; set; }

        [Display(Name = "عملکرد")]
        public Int64 Expense{ get; set; }

        [Display(Name = "% جذب")]
        public double Percent { get; set; }
        
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
