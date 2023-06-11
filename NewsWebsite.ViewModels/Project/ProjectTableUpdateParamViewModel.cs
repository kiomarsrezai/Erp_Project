using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;

namespace NewsWebsite.ViewModels.Project
{
    public class ProjectTableUpdateParamViewModel
    {
        public int Id { get; set; }
        public string ProjectCode { get; set; }
        public string ProjectName { get; set; }
        public string DateFrom { get; set; }
        public string DateEnd { get; set; }
        public int ProjectScaleId { get; set; }
        public string AreaArray { get; set; }



    }
}
