using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;
using System.Xml.Linq;

namespace NewsWebsite.ViewModels.Api.Budget
{
    public class BudgetConnectOutputDTO
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public Int64 Mosavab { get; set; }
        public int ProctorId { get; set; }
        public string ProctorName { get; set; }

    }
}
