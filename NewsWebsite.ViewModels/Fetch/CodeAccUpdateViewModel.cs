using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Fetch
{
    public class CodeAccUpdateViewModel
    {
        [Display(Name = "کلید جدول بودجه")]
        public int Id { get; set; }
        public string IdKol { get; set; }
        public string IdMoein { get; set; }
        public string IdTafsily { get; set; }
        public string IdTafsily5 { get; set; }
        public string IdTafsily6 { get; set; }
        public string Tafsily6Name { get; set; }

        [Display(Name = "شرح حسابداری")]
        public string Name { get; set; }

        [Display(Name = "مرکز هزینه")]
        public string MarkazHazine { get; set; }
        
        [Display(Name ="عملکرد")]
        public Int64 Expense { get; set; }
        public int AreaId { get; set; }


    }
}
