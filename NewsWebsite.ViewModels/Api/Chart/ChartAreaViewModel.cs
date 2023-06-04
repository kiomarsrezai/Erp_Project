using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Api.Chart
{
    public class ChartAreaViewModel
    {
        public int Id { get; set; }
        public int Row { get; set; }
        public int YearId { get; set; }
        public int BudgetProcessId { get; set; }
        public int AreaId { get; set; }

        [Display(Name = "مناطق")]
        public string AreaName { get; set; }

        [Display(Name = "مصوب")]
        public long Mosavab { get; set; }

        [Display(Name = "عملکرد")]
        public long Expense { get; set; }

        [Display(Name = "مصوب روزانه")]
        public long MosavabDaily { get; set; }

        [Display(Name = "محقق نشده")]
        public long NotGet { get; set; }

        [Display(Name = "% جذب مصوب")]
        public double PercentMosavab { get; set; }

        [Display(Name = "% جذب روزانه")]
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
