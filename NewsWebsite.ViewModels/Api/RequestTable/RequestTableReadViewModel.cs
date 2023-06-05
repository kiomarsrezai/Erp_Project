using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.RequestTable
{
    public class RequestTableReadViewModel
    {
        public int Id { get; set; }
        public string Description { get; set; }
        public float? Quantity { get; set; }
        public string Scale { get; set; }
        public Int64 Price { get; set; }
        public Int64 Amount { get; set; }
        public string OthersDescription { get; set; }

    }
}
