using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Commite
{
    public class CommiteViewModel
    {
        public int Id { get; set; }
        public int? Row { get; set; }
        public int? ProjectId { get; set; }
        public string Description { get; set; }
        public string ProjectName { get; set; }

    }
}
