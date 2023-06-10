using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Report
{
    public class Chart_RevenueKindModalViewModel
    {
        public int AreaId { get; set; }
        public string AreaName { get; set; }
        public Int64 MosavabRevenue { get; set; }
        public Int64 ExpenseRevenue { get; set; }
        public Int64 MosavabSale { get; set; }
        public Int64 ExpenseSale { get; set; }
        public Int64 MosavabLoan { get; set; }
        public Int64 ExpenseLoan { get; set; }
        public Int64 MosavabDaryaftAzKhazane { get; set; }
        public Int64 ExpenseDaryaftAzKhazane { get; set; }
        public Int64 MosavabKol { get; set; }
        public Int64 ExpenseKol { get; set; }
        public double percentRevenue { get; set; }
        public double percentSale { get; set; }
        public double percentLoan { get; set; }
        public double percentDaryaftAzKhazane { get; set; }
        public double percentKol { get; set; }
    }
}

