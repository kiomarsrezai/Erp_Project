using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Commite
{
    public class CommiteDetailEstimateReadViewModel
    {
        public int Id { get; set; }
        public string Description { get; set; }
        public double Quantity { get; set; }
        public Int64 Price { get; set; }
        public Int64 Amount { get; set; }
    }
}
