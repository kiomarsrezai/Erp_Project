using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Public
{
    public class PublicParamIdViewModel
    {
        public int Id { get; set; }
    }
    
    public class AmlakInfoSerachParamDto
    {
        public int? AreaId { get; set; }
        public int? AmlakInfoKindId { get; set; }
    }

    public class GetListContractAttachFiles
    {

        public string FileName { get; set; }
        public int? AttachID { get; set; }
        public int? ContractId { get; set; }
    }
}
