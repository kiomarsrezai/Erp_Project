namespace NewsWebsite.ViewModels.Api.Budget.BudgetSeprator
{
    public class BudgetPrposalModalViewModel
    {
        public long Expense { get; set; }
        public string Description { get; set; }
        public string DateSanad { get; set; }
        public string NumberSanad { get; set; }
        public int KindId { get; set; }
    }

    public class BudgetPrposalInsertModalViewModel
    {
        public int yearId { get; set; }
        public int areaId { get; set; }
        public int codingId { get; set; }
        public int budgetProcessId { get; set; }

    }

}