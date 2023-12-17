using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Report
{
    public class RequestAnalyzeViewModel
    {
        public int RequestRef { get; set; }
        public string ConfirmDocNo { get; set; }
        public string RequestRefStr { get; set; }
        public string RequestDate { get; set; }
        public string ReqDesc { get; set; }
        public Int64 RequestPrice { get; set; }
        public Int64 CnfirmedPrice { get; set; }
        public Int64 Diff { get; set; }
        public int SectionId { get; set; }
    }

    public class RequestAnalyzeParam
    {
        public int AreaId { get; set; }
        public int KindId { get; set; }
    }

}
