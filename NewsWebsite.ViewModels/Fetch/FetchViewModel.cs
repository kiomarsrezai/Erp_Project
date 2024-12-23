﻿using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;
using NPOI.SS.Formula.Functions;

namespace NewsWebsite.ViewModels.Fetch
{
    public class FetchViewModel
    {
        public int Id { get; set; }

        [Display(Name = "کد")]
        public string Code { get; set; }

        [Display(Name = "عنوان")]
        public string Description { get; set; }

        [Display(Name = "سطح")]
        public int LevelNumber { get; set; }
        public int CodingId { get; set; }

        [Display(Name = "مصوب")]
        public Int64 Mosavab { get; set; }

        [Display(Name = "پیشنهادی")]
        public Int64 Pishnahadi { get; set; }

        [Display(Name = "عملکرد")]
        public Int64 Expense { get; set; }

        [Display(Name = "وضعیت تایید")]
        public int ConfirmStatus { get; set; }

        [Display(Name = "تامین اعتبار")]
        public Int64? CreditAmount { get; set; }

        [Display(Name = "% درصد")]
        public double? PercentBud { get; set; }
        
        [Display(Name = "اصلاح بودجه")]
        public Int64? Edit { get; set; }
        public bool Show { get; set; }

        public Int64 TotalMosavab { get; set; }
        public Int64 TotalExpense { get; set; }
        public bool Crud { get; set; }
        public int? MotherId { get; set; }
    }
    public class PishanahadViewModel
    {
        public int CodingId { get; set; }
        
        [Display(Name = "کد")]
        public string Code { get; set; }

        [Display(Name = "عنوان")]
        public string Description { get; set; }

        [Display(Name = "مصوب")]
        public Int64 Mosavab { get; set; }

        [Display(Name = "اصلاح بودجه")]
        public Int64? Edit { get; set; }

        [Display(Name = "تامین اعتبار")]
        public Int64? CreditAmount { get; set; }

        [Display(Name = "عملکرد")]
        public Int64 Expense { get; set; }

        [Display(Name = "پیشنهادی نقدی")]
        public Int64 PishnahadiCash { get; set; }
        
        [Display(Name = "پیشنهادی غیر نقدی")]
        public Int64 PishnahadiNonCash { get; set; }
        
        [Display(Name = "پیشنهادی")]
        public Int64 Pishnahadi { get; set; }

        [Display(Name = "وضعیت تایید")]
        public int ConfirmStatus { get; set; }
        
        [Display(Name = "ردیف مربوط به سال جدید است")]
        public int IsNewYear { get; set; }

        [Display(Name = "نیابت به")]
        public int DelegateTo { get; set; }

        [Display(Name = "نام نیابت به")]
        public string DelegateToName { get; set; }

        [Display(Name = "مبلغ نیابت")]
        public Int64 DelegateAmount { get; set; }

        [Display(Name = "درصد نظارت")]
        public int DelegatePercentage { get; set; }

        [Display(Name = "درصد نظارت")]
        public int ExecutionId { get; set; }

        [Display(Name = "درصد نظارت")]
        public int ProctorId { get; set; }

        [Display(Name = "سطح")]
        public int LevelNumber { get; set; }
        public bool Crud { get; set; }
        public double Percent { get; set; }
        
        [Display(Name = "3 ماهه آخر سال قبل")]
        public Int64 Last3Month { get; set; }
        
        [Display(Name = "9 ماهه اول امسال")]
        public Int64 Last9Month { get; set; }

    }

    public class BalanceViewModel
    {
       public Int64 Balance { get; set; }

    }

    public class PishanahadModalViewModel
    {
        public int CodingId { get; set; }
        public int AreaId { get; set; }
        public string AreaName { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public Int64 Mosavab { get; set; }
        public Int64 Edit { get; set; }
        public Int64 Supply { get; set; }
        public Int64 Expense { get; set; }
        public Int64 BudgetNext { get; set; }
        public string ProctorId { get; set; }
        public string ExecutionId { get; set; }
    }
}
