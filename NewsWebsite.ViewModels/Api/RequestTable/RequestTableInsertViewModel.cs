using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.RequestTable
{
    public class RequestTableInsertViewModel
    {

        public int yearId { get; set; }
        
        public int AreaId { get; set; }
        
        public int ExecuteDepartmanId { get; set; }
        
        public int UserId { get; set; }
        
        public int RequestKindId { get; set; }
        
        public int DoingMethodId { get; set; } 
        
        public string Description { get; set; }
        
        public long EstimateAmount { get; set; }

        public int SuppliersId { get; set; }

        public long ResonDoingMethod { get; set; }

    }
}
