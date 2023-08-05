using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class AmlakInfoPrivateUpdateViewModel
    {
        public int Id { get; set; }
        public int AreaId { get; set; }
        public string EstateInfoName { get; set; }
        public string EstateInfoAddress { get; set; }
    }
}
