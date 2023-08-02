using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Report
{
    public class AbstractPerformanceBudgetViewModel
    {
        public int Id { get; set; }
        public string AreaName { get; set; }
        public Int64 MosavabRevenue { get; set; }
        public Int64 ExpenseMonthRevenue { get; set; }
        public double PercentRevenue { get; set; }


        public Int64 MosavabCurrent { get; set; }
        public Int64 ExpenseMonthCurrent { get; set; }
        public double PercentCurrent { get; set; }

        public Int64 MosavabCivil { get; set; }
        public Int64 CreditAmountCivil { get; set; }
        public double PercentCreditCivil { get; set; }
        
        public Int64 ExpenseCivil { get; set; }
        public double PercentCivil { get; set; }

        public Int64 MosavabFinancial { get; set; }
        public Int64 ExpenseFinancial { get; set; }
        public double PercentFinancial { get; set; }

        public Int64 MosavabSanavati { get; set; }
        public Int64 ExpenseSanavati { get; set; }
        public double PercentSanavati { get; set; }

        public Int64 MosavabPayMotomarkez { get; set; }
        public Int64 ExpensePayMotomarkez { get; set; }
        public double PercentPayMotomarkez { get; set; }

        public Int64 MosavabDar_Khazane { get; set; }
        public Int64 ExpenseDar_Khazane { get; set; }
        public double PercentDar_Khazane { get; set; }

        public Int64 MosavabNeyabati { get; set; }
        public Int64 ExpenseNeyabati { get; set; }
        public double PercentNeyabati { get; set; }

        public Int64 Resoures { get; set; }
        public Int64 balance { get; set; }

    }

    public class ParamViewModel
    {
        public int YearId { get; set; }
        public int StructureId { get; set; }
        public int MonthId { get; set; }
    }
}
