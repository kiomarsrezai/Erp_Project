using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.RequestTable
{
    public class RequestTableInsertViewModel
    {
        public int RequestId { get; set; }
        
        public float Quantity { get; set; }
        
        public long Price { get; set; } 
        
        public string Description { get; set; }
        
        public string OthersDescription { get; set; }


    }
}
