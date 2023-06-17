namespace NewsWebsite.ViewModels.Api.Budget.BudgetSeprator
{
    public class BudgetSepratorAreaAccModalViewModel
    {
        public long Expense { get; set; }
        public string Description { get; set; }
        public string DateSanad { get; set; }
        public int? NumberSanad { get; set; }
        public int KindId { get; set; }
    }

    public class ParamViewModel
    {
        public int yearId { get; set; }
        public int areaId { get; set; }
        public int codingId { get; set; }
        public int KindId { get; set; }

    }
}