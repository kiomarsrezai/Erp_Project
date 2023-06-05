using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Request
{
    public class RequestSearchViewModel
    {
        public int Id { get; set; }
        public string Employee { get; set; }
        public string Number { get; set; }
        public string Date { get; set; }
        public string Description { get; set; }
        public long? EstimateAmount { get; set; }

    }
}
