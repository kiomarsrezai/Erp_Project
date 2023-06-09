﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Request
{
    public class RequestSearchViewModel
    {
        public int? Id { get; set; }
        public string Employee { get; set; }
        public string Number { get; set; }
        public string Date { get; set; }
        public string Description { get; set; }
        public Int64? EstimateAmount { get; set; }
        public string DateShamsi { get; set; }
    }
}
