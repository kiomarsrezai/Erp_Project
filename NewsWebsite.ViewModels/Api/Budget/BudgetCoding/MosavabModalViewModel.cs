using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Budget.BudgetCoding
{
    public class MosavabModalViewModel
    {
        public string Code { get; set; }
        public string Description { get; set; }
        public int BudgetDetailId { get; set; }
        public Int64 MosavabPublic { get; set; }
        public int BudgetDetailProjectId { get; set; }
        public Int64 MosavabProject { get; set; }
        public int BudgetDetailProjectAreaId { get; set; }
        public Int64 MosavabArea { get; set; }
    }
}

