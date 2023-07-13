using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Report
{
    public class ProctorAutomationViewModel
    {
        public string Number { get; set; }
        public string Date { get; set; }
        public string DateShamsi { get; set; }
        public string Description { get; set; }
        public Int64? EstimateAmount { get; set; }
        public string Code { get; set; }
        public string title { get; set; }
    }

    public class Param11ViewModel
    {
        public int YearId { get; set; }
        public int AreaId { get; set; }
        public int ProctorId { get; set; }
    }

}
