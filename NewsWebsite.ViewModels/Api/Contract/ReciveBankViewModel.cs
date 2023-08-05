using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class ReciveBankViewModel
    {
        public int Id { get; set; }
        public DateTime? Date { get; set; }
        public string DateShamsi { get; set; }
        public int Number { get; set; }
        public Int64 Amount { get; set; }
    }

    public class param31
    {
        public DateTime Date { get; set; }
    }

}
