using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Report
{
    public  class BudgetBookViewModel {
        public Sheet1Data sheet1Data  { get; set; }
    }

    public class Sheet1Data
    {
        public Int64 M_Resources { get; set; }
        public Int64 M_Khazane { get; set; }
        public Int64 M_Costs { get; set; }
        public Int64 P_Resources { get; set; }
        public Int64 P_Khazane { get; set; }
        public Int64 P_Costs { get; set; }

    }
    
    
    
    
    
    
    public class BudgetBookInputs
    {
        public int YearId { get; set; }
        public int AreaId { get; set; }

    }
}
