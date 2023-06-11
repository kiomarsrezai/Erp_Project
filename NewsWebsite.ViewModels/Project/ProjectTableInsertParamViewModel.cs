using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Project
{
    public class ProjectTableInsertParamViewModel
    {
        public string ProjectCode { get; set; }
        public string ProjectName { get; set; }
        public string DateFrom { get; set; }
        public string DateEnd { get; set; }
        public string AreaArray { get; set; }
        public int ProjectScaleId { get; set; }

    }
}
