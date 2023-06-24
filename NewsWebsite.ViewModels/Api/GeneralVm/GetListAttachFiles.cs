using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace NewsWebsite.ViewModels.Api.GeneralVm
{
    public class GetListAttachFiles
    {
        public int ProjectCode { get; set; }

        public string FileName { get; set; }
        public int FileDetailId { get; set; }
        public int ProjectId { get; set; }
    }
}
