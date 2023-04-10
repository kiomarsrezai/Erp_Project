using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Fetch
{
    public class VasetSazmanhaViewModel
    {
        public int Id { get; set; }

        [Display(Name = "کد")]
        public string Code { get; set; }

        [Display(Name = "عنوان")]
        public string Description { get; set; }

        [Display(Name = "مصوب")]
        public Int64 Mosavab { get; set; }
        
        [Display(Name = "کد حسابداری")]
        public string CodeAcc { get; set; }
       
        [Display(Name = "شرح حسابداری")]
        public string TitleAcc { get; set; } 

        [Display(Name = "سطح")]
        public int LevelNumber { get; set; }

        [Display(Name = "% تسهیم")]
        public double PercentBud { get; set; }

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
