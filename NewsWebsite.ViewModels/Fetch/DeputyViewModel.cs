using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Fetch
{
    public class DeputyViewModel
    {
        public int Id { get; set; }

        public int Row { get; set; }

        [Display(Name = "متولی")]
        public string ProctorName { get; set; }

        [Display(Name = "مصوب هزینه ای")]
        public Int64 MosavabCurrent { get; set; }

        [Display(Name = "مصوب هزینه ای")]
        public string MosavabCurrentStr { get; set; }

        [Display(Name = "مصوب هزینه ای")]
        public Int64 ExpenseCurrent { get; set; }

        [Display(Name = "عملکرد هزینه ای")]
        public string ExpenseCurrentStr { get; set; }

        [Display(Name = "مصوب سرمایه ای")]
        public Int64 MosavabCivil { get; set; }

        [Display(Name = "مصوب سرمایه ای")]
        public string MosavabCivilStr { get; set; }

        [Display(Name = "عملکرد سرمایه ای")]
        public Int64 ExpenseCivil { get; set; }

        [Display(Name = "عملکرد سرمایه ای")]
        public string ExpenseCivilStr { get; set; }

        public double PercentCurrent { get; set; }

        [Display(Name = "جذب هزینه ای")]
        public string PercentCurrentStr { get; set; }

        public double PercentCivil { get; set; } 
      
        [Display(Name = "جذب سرمایه ای")]
        public string PercentCivilStr { get; set; }

        public double PercentTotal { get; set; }
       
        [Display(Name = "جذب کل")]
        public string PercentTotalStr { get; set; }
       
        //[System.Text.Json.Serialization.JsonIgnore]
        //public List<AreaProctorViewModel> areaProctors { get; set; } 
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
