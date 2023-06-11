using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Project
{
    public class ProjectTableReadViewModel
    {
        public int Id { get; set; }
        public string ProjectCode { get; set; }
        public string ProjectName { get; set; }
        public string DateFrom { get; set; }
        public string DateEnd { get; set; }
        public string AreaArray { get; set; }
        public int ProjectScaleId { get; set; }
        public string ProjectScaleName { get; set; }
       }

    public class ProjectTableReadParamViewModel
    {
        public int AreaId { get; set; }
  
    }




}
