using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Request
{
    public class RequestAfterInsertViewModel
    {
        public int Id { get; set; }

        public int YearId { get; set; }
        
        public int AreaId { get; set; }
        
        public int ExecuteDepartmanId { get; set; }
        
        public string Users { get; set; }
        public int DoingMethodId { get; set; }
        public string Number { get; set; }
        public string DateS { get; set; }

    }
}
