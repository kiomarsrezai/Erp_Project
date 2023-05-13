using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Supply
{
    public class SupplyViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }

    public class SuppliersCoViewModel
    {
        public int Id { get; set; }
        public string CompanyKindName { get; set; }
    }
}
