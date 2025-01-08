using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Abstract
{
    public class AbstractViewModel
      {
          public int Id { get; set; }
          public string AreaName { get; set; }
          public long MosavabRevenue { get; set; }
          public long MosavabCurrent { get; set; }
          public long MosavabCivil { get; set; }
          public long Resoures { get; set; }
          public long MosavabFinancial { get; set; }
          public long MosavabSanavati { get; set; }
          public long MosavabPayMotomarkez { get; set; }
          public long MosavabDar_Khazane { get; set; }
          public long MosavabNeyabati { get; set; }
          public long MosavabHagholamal { get; set; }
          public long balanceMosavab { get; set; }
          public long Costs { get; set; }
      }
    
    public class AbstractBalanceViewModel
    {
        public int Id { get; set; }
        public string AreaName { get; set; }
        public int IsSummary { get; set; }
        public long MosavabRevenue { get; set; }
        public long MosavabCurrentCash { get; set; }
        public long MosavabCurrentNonCash { get; set; }
        public long MosavabCivilCash { get; set; }
        public long MosavabCivilNonCash { get; set; }
        public long Resoures { get; set; }
        public long MosavabFinancial { get; set; }
        public long MosavabSanavati { get; set; }
        public long MosavabPayMotomarkez { get; set; }
        public long MosavabDar_Khazane { get; set; }
        public long MosavabNeyabati { get; set; }
        public long MosavabHagholamal { get; set; }
        public long Costs { get; set; }
    }
}
