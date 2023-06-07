using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Commite
{
    internal class CommiteDetailInsertViewModel
    {
    }

    public class CommiteDetailInsertParamViewModel
    {
        public int Row { get; set; }
        public int CommiteId { get; set; }
        public string Description { get; set; }
        public int? ProjectId { get; set; }

    }
}
