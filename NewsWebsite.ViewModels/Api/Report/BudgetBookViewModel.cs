using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Report
{
    public  class BudgetBookViewModel {
        public Sheet1Data sheet1Data  { get; set; }
    }

    public class ReportCoding
    {
        public List<CodingAmount> CodeAmounts { get; set; }
    }
    public class CodingAmount
    {
        public string Code { get; set; }
        public Int64 Pishnahadi { get; set; }
        public Int64 Mosavab { get; set; }
    }

    
    public class Sheet1Data
    {
        public Int64 M_Resources { get; set; }
        public Int64 M_Khazane { get; set; }
        public Int64 M_Costs { get; set; }
        public Int64 P_Resources { get; set; }
        public Int64 P_Khazane { get; set; }
        public Int64 P_Costs { get; set; }

        public ReportCoding ReportCodings { get; set; }

    }
    
    
    public class Sheet3Data
    {
        public List<Sheet3DataSingle> dataList { get; set; }

    }
    
    public class Sheet3DataSingle
    {
        
        public string CodingId { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public Int64 MosavabLastYear { get; set; }
        public Int64 Mosavab { get; set; }
        public Int64 Edit { get; set; }
        public Int64 CreditAmount { get; set; }
        public Int64 Expense { get; set; }
        public Int64 PishnahadiCash { get; set; }
        public Int64 PishnahadiNonCash { get; set; }
        public Int64 Pishnahadi { get; set; }
        public int levelNumber { get; set; }
        public int Crud { get; set; }
        public int ConfirmStatus { get; set; }
        public int isNewYear { get; set; }
        public int ProctorId { get; set; }
        public int ExecutionId { get; set; }
        public Int64 Last3Month { get; set; }
        public Int64 Last9Month { get; set; }
    }

    
    
    
    
    public class BudgetBookInputs
    {
        public int YearId { get; set; }
        public int AreaId { get; set; }

    }
}
