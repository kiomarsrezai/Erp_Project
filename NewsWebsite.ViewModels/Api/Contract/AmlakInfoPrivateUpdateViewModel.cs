using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class AmlakInfoUpdateViewModel
    {
        public int Id { get; set; }
        public int AreaId { get; set; }
        public bool IsSubmited { get; set; }
        public float Masahat { get; set; }
        public int AmlakInfoKindId { get; set; }
        public string EstateInfoName { get; set; }
        public string EstateInfoAddress { get; set; }
    }
}
