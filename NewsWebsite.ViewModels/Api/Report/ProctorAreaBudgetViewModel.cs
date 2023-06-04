using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Api.Report
{
    public class ProctorAreaBudgetViewModel
    {
        public int YearId { get; set; }
        public int ProctorId { get; set; }
        public int AreaId { get; set; }

        public string Code { get; set; }

        public string Description { get; set; }
        public long Mosavab { get; set; }

        public long Expense { get; set; }

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
