using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class AmlakInfoPrivateReadViewModel
    {
        public int Id { get; set; }
        public int AreaId { get; set; }
        public int AmlakInfoKindId { get; set; }
        public string AreaName { get; set; }
        public string AmlakInfoKindName { get; set; }
        public string EstateInfoName { get; set; }
        public string EstateInfoAddress { get; set; }
    }
}
