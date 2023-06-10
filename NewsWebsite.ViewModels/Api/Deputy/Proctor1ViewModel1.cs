using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace NewsWebsite.ViewModels.Api.Deputy
{
    public class ProctorParamViewModel
    {
        public int yearId { get; set; }

        public int? proctorId { get; set; }
        public int? areaId { get; set; }
        public int? budgetprocessId { get; set; }


    }
    public class Proctor1ViewModel1
    {
        public int Id { get; set; }

        [Display(Name = "متولی")]
        public string ProctorName { get; set; }

        [Display(Name = "مصوب هزینه ای")]
        public Int64 MosavabCurrent { get; set; }

        //[Display(Name = "مصوب هزینه ای")]
        //public string MosavabCurrentStr { get; set; }

        [Display(Name = "عملکرد هزینه ای")]
        public Int64 ExpenseCurrent { get; set; }

        //[Display(Name = "عملکرد هزینه ای")]
        //public string ExpenseCurrentStr { get; set; }

        [Display(Name = "مصوب سرمایه ای")]
        public Int64 MosavabCivil { get; set; }

        //[Display(Name = "مصوب سرمایه ای")]
        //public string MosavabCivilStr { get; set; }

        [Display(Name = "عملکرد سرمایه ای")]
        public Int64 ExpenseCivil { get; set; }

        //[Display(Name = "عملکرد سرمایه ای")]
        //public string ExpenseCivilStr { get; set; }

        public double PercentCurrent { get; set; }

        //[Display(Name = "جذب هزینه ای")]
        //public string PercentCurrentStr { get; set; }

        public double PercentCivil { get; set; }

        //[Display(Name = "جذب سرمایه ای")]
        //public string PercentCivilStr { get; set; }

        public double PercentTotal { get; set; }

        //[Display(Name = "جذب کل")]
        //public string PercentTotalStr { get; set; }

        //[System.Text.Json.Serialization.JsonIgnore]
        //public List<AreaProctorViewModel> areaProctors { get; set; } 
    }
    public class AreaProctorViewModel
    {
        public int AreaId { get; set; }

        [Display(Name = "منطقه")]
        public string AreaName { get; set; }

        [Display(Name = "مصوب هزینه ای")]
        public Int64 MosavabCurrent { get; set; }

        [Display(Name = "عملکرد هزینه ای")]
        public Int64 ExpenseCurrent { get; set; }

        [Display(Name = "مصوب سرمایه ای")]
        public Int64 MosavabCivil { get; set; }

        [Display(Name = "عملکرد سرمایه ای")]
        public Int64 ExpenseCivil { get; set; }

        public double PercentCurrent { get; set; }

        public double PercentCivil { get; set; }

        public double PercentTotal { get; set; }


    }
    public class ProctorAreaBudgetViewModel
    {
        public string Code { get; set; }

        public string Description { get; set; }

        public Int64 Mosavab { get; set; }

        public Int64 Expense { get; set; }

        public double Percent { get; set; }


    }


}
