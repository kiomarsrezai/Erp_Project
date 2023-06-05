using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.RequestTable
{
    public class RequestTableUpdateViewModel
    {

        public int Id { get; set; }
        public double Quantity { get; set; }
        public Int64 Price { get; set; }
        public string scale { get; set; }
        public string Description { get; set; }
        public string OthersDescription { get; set; }

    }
}
