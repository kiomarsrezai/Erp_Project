﻿using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class ContractUpdateParamViewModel
    {
        public int Id { get; set; }
        public string Number { get; set; }
        public string Date { get; set; }
        public string Description { get; set; }
        public int SuppliersId { get; set; }
        public string DateFrom { get; set; }
        public string DateEnd { get; set; }
        public int DoingMethodId { get; set; }
        public Int64 Amount { get; set; }
    }
}
