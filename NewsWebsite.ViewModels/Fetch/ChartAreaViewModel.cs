using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Fetch
{
    public class ChartAreaViewModel
    {
        [JsonPropertyName("Id")]
        public int Id { get; set; }
        public int Row { get; set; }
        public int YearId { get; set; }
        public int BudgetProcessId { get; set; }
        public int AreaId { get; set; }

        [Display(Name = "مناطق"), JsonPropertyName("مناطق")]
        public string AreaName { get; set; }

        [Display(Name = "مصوب"), JsonPropertyName("مصوب")]
        public Int64 Mosavab { get; set; }

        [Display(Name = "عملکرد"), JsonPropertyName("عملکرد")]
        public Int64 Expense { get; set; }

        [Display(Name = "مصوب روزانه"), JsonPropertyName("مصوب روزانه")]
        public Int64 MosavabDaily { get; set; }

        [Display(Name = "محقق نشده"), JsonPropertyName("محقق نشده")]
        public Int64 NotGet { get; set; }

        [Display(Name = "% جذب مصوب"), JsonPropertyName("% جذب مصوب")]
        public double PercentMosavab { get; set; }
       
        [Display(Name = "% جذب روزانه"), JsonPropertyName("% جذب روزانه")]
        public double PercentMosavabDaily { get; set; }

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
