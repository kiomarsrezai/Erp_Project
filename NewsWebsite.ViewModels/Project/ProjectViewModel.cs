using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Project
{
    public class ProjectViewModel
    {
        public int Id { get; set; }

        public int? MotherId { get; set; }

        [Display(Name = "عنوان")]
        public string ProjectName { get; set; }

        [Display(Name = "کد پروژه")]
        public string ProjectCode { get; set; }
       
        [Display(Name = "منطقه")]
        public int? AreaId { get; set; }
        public float? Weight { get; set; }

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
