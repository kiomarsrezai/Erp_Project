using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Api.BudgetSeprator
{
    public class BudgetSepTaminModal2ViewModel
    {

        [Display(Name = "کد")]
        public string BodgetId { get; set; }

        [Display(Name = "عنوان")]
        public string BodgetDesc { get; set; }

        [Display(Name = "تاریخ درخواست")]
        public string RequestDate { get; set; }

        [Display(Name = "شرح تامین اعتبار")]
        public string ReqDesc { get; set; }

        [Display(Name = "شماره درخواست")]
        public string RequestRefStr { get; set; }

        [Display(Name = "مبلغ")]
        public long RequestPrice { get; set; }
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
