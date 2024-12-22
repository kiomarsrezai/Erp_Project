using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Report
{
    public  class BudgetBookViewModel {
        public Sheet1Data sheet1Data  { get; set; }
    }

    public class Coding
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

        public Dictionary<string, long> Codings { get; set; } = new Dictionary<string, long>();

    }
    
    
    
    
    
    
    public class BudgetBookInputs
    {
        public int YearId { get; set; }
        public int AreaId { get; set; }

    }
}
