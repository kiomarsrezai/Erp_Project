using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class ContractRequestReadViewModel
    {
        public int Id { get; set; }
        public string YearName { get; set; }
        public string AreaName { get; set; }
        public string Number { get; set; }
        public string Date { get; set; }
        public string DateShamsi { get; set; }
        public string Description { get; set; }
  
    }
}
