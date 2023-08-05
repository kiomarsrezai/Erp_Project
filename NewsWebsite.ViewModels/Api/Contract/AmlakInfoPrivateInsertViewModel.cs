using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class AmlakInfoPrivateInsertViewModel
    {
        public int AreaId { get; set; }
        public int AmlakInfoKindId { get; set; }
        public string EstateInfoName { get; set; }
        public string EstateInfoAddress { get; set; }
    }
}
