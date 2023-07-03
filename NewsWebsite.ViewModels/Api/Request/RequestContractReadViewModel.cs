using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Request
{
    public class RequestContractReadViewModel
    {
        public int Id { get; set; }
        public string Number { get; set; }
        public string Date { get; set; }
        public string DateShamsi { get; set; }
        public string Description { get; set; }
        public string SuppliersName { get; set; }
    }
}

