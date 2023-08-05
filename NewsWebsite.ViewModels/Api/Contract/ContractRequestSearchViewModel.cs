using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class ContractRequestSearchViewModel
    {
        public int Id { get; set; }
        public string DepartmentName { get; set; }
        public string Number { get; set; }
        public DateTime? Date { get; set; }
        public string DateShamsi { get; set; }
        public string Description { get; set; }
    }

    public class ContractRequestSearchParamViewModel
    {
        public int YearId { get; set; }
        public int AreaId{ get; set; }
 
    }
}
