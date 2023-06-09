﻿using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;
namespace NewsWebsite.ViewModels.Api.Request
{
    public class RequestsViewModel
    {
        public int Id { get; set; }
        public int YearId { get; set; }
        public int AreaId { get; set; }
        public int? DepartmentId { get; set; }
        public string Employee { get; set; }
        public int? DoingMethodId { get; set; }
        public string Users { get; set; }
        public string Number { get; set; }

        [JsonIgnore]
        [DataType(DataType.Date)]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:MM/dd/yyyy}")]
        public DateTime Date { get; set; }
        
        public string DateShamsi { get; set; }
        public string Description { get; set; }
        public long EstimateAmount { get; set; }
        public string ResonDoingMethod { get; set; }
        public int RequestKindId { get; set; }
        public int? SuppliersId { get; set; }
        public string SuppliersName { get; set; }

    }
}
