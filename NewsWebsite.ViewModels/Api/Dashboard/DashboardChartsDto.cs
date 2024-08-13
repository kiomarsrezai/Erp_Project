using NewsWebsite.ViewModels.Api.Contract;
using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Dashboard
{


    public class DashboardResponse
    {
        public int Id { get; set; }
        public string AreaName { get; set; }
        public Int64 MosavabDramad { get; set; }
        public Int64 ExpenseMonthDramad { get; set; }
        public double PercentDramad { get; set; }

        public Int64 MosavabCurrent { get; set; }
        public Int64 TaminEtebarCurrent { get; set; }
        public double PercentTaminEtebarCurrent { get; set; }
        public Int64 ExpenseMonthCurrent { get; set; }
        public double PercentCurrent { get; set; }

        public Int64 MosavabTamalokSaramye { get; set; }
        public Int64 TaminEtebarAmountTamalokSarmaye { get; set; }
        public double PercentTaminEtebarTamalokSarmaye { get; set; }

        public Int64 ExpenseTamalokSarmaye { get; set; }
        public double PercentExpenseTamalokSarmaye { get; set; }
        public double PercentTamalokSarmaye { get; set; }

        public Int64 MosavabTamalokMali { get; set; }
        public Int64 TaminEtebarTamalokMali { get; set; }
        public double PercentTaminEtebarTamalokMali { get; set; }
        public Int64 ExpenseTamalokMali { get; set; }
        public double PercentExpenseTamalokMali { get; set; }
        public double PercentTamalokMali { get; set; }

       

        public Int64 Manabe { get; set; }
      //  public Int64 balance { get; set; }

    }

    public class stractResult
    {
        public string monutnow { get; set; }
        public List<DashboardResponse> response { get; set; }

    }

    }
