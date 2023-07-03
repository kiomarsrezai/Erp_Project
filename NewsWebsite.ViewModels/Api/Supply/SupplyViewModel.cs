using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Supply
{
    public class SupplyViewModel
    {
        public int Id { get; set; }
        public string SuppliersName { get; set; }
        public string Bank { get; set; }
        public string Branch { get; set; }
        public string NumberBank { get; set; }




    }

    public class SuppliersCoViewModel
    {
        public int Id { get; set; }
        public string CompanyKindName { get; set; }
    }
}
