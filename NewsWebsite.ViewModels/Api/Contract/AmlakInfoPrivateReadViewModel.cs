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
        public string AmlakInfolate { get; set; }
        public string AmlakInfolong { get; set; }
        public string AmlakInfoId { get; set; }
    }

    public class LoginParamModelFromSdi
    {
        public string userId { get; set; }
        public string id { get; set; }
        public string title { get; set; }
        public string completed { get; set; }
    }
}
