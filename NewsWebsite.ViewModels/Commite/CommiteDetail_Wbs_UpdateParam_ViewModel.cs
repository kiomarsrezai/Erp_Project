using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Commite
{
    public class CommiteDetail_Wbs_UpdateParam_ViewModel
    {
        public int Id { get; set; }
        public string Description { get; set; }
        public int? ProjectId { get; set; }
        public string DateStart { get; set; }
        public string DateEnd { get; set; }
    }
}
