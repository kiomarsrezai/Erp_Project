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
        public Int64 MosavabPayMotomarkez { get; set; }
        public Int64 MosavabDar_Khazane { get; set; }
        public Int64 Resoures { get; set; }
        public Int64 ExpenseRevenue { get; set; }
        public Int64 ExpensePayMotomarkez { get; set; }
        public Int64 ExpenseDar_Khazane { get; set; }
        public Int64 MosavabCurrent { get; set; }
        public Int64 ExpenseCurrent { get; set; }
        public Int64 MosavabCivil { get; set; }
        public Int64 ExpenseCivil { get; set; }
        public Int64 MosavabFinancial { get; set; }
        public Int64 ExpenseFinancial { get; set; }
        public Int64 MosavabSanavati { get; set; }
        public Int64 ExpenseSanavati { get; set; }

    }

    public class ParamViewModel
    {
        public int YearId { get; set; }
        public int StructureId { get; set; }
    }
    }
