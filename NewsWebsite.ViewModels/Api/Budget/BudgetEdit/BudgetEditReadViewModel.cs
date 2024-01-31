using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Budget.BudgetEdit
{
    public class EditReadViewModel
    {
        public int Id { get; set; }
        public string Number { get; set; }
        public string Date { get; set; }
        public string DateShamsi { get; set; }
    }

    public class paramIdViewModel
    {
        public int Id { get; set; }
    }


    public class EditDetailViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public Int64 Mosavab { get; set; }
        public Int64 EditArea { get; set; }
        public Int64 Decrease { get; set; }
        public Int64 Increase { get; set; }
    }
}
