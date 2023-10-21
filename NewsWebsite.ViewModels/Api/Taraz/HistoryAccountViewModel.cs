using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Taraz
{
    public class HistoryAccountViewModel
    {
        public int IdSanad { get; set; }
        public string SanadDate { get; set; }
        public string SanadDateShamsi { get; set; }
        public int IdKol { get; set; }
        public int IdMoien { get; set; }
        public string Description { get; set; }
        public Int64 Bedehkar { get; set; }
        public Int64 Bestankar { get; set; }
        public string AtfCh { get; set; }
        public string AtfDt { get; set; }
        public string AtfDtShamsi { get; set; }
    }

    public class Param100
    {
        public int IdTafsil { get; set; }
        public int AreaId { get; set; }
 
    }


}
