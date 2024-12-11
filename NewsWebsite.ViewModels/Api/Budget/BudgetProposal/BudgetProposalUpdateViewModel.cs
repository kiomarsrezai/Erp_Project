using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Budget.BudgetProposal
{
    public class BudgetProposalUpdateViewModel
    {
        public int yearId { get; set; }
        public int areaId { get; set; }
        public int budgetProcessId { get; set; }
        public int codingId { get; set; }
        public Int64 PishnahadiCash { get; set; }
        public Int64 PishnahadiNonCash { get; set; }
        public Int64 Pishnahadi { get; set; }
        public string Description { get; set; }
        public int? DelegateTo { get; set; }
        public Int64? DelegateAmount { get; set; }
        public int? DelegatePercentage { get; set; }
        public int ProctorId { get; set; }
        public int ExecutionId { get; set; }
    }
    public class BudgetProposalEditUpdateViewModel
    {
        public int yearId { get; set; }
        public int areaId { get; set; }
        public int budgetProcessId { get; set; }
        public int codingId { get; set; }
        public Int64 BudgetNext { get; set; }
        public string Description { get; set; }
        public int ProctorId { get; set; }
        public int ExecutionId { get; set; }
    }
}
