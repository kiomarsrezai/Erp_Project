using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Department
{
    public class DepartmentAcceptorViewModel
    {
        public int Id { get; set; }
        public int? DepartmanId { get; set; }
        public int? AreaId { get; set; }
        public string DepartmentCode { get; set; }
        public string DepartmentName { get; set; }
        public string AreaName { get; set; }
    }
}
