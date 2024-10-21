namespace NewsWebsite.ViewModels.Api.Budget.BudgetSeprator
{
    public class BudgetSepratorAreaAccModalViewModel
    {
        public long Expense { get; set; }
        public string Description { get; set; }
        public string DateSanad { get; set; }
        public string NumberSanad { get; set; }
        public int KindId { get; set; }
        public string programOperationDetailsId { get; set; }
    }

    public class Param10ViewModel
    {
        public int yearId { get; set; }
        public int areaId { get; set; }
        public int codingId { get; set; }
        public int KindId { get; set; }

    }

    public class Param11ViewModel
    {
        public int yearId { get; set; }
        public int areaId { get; set; }
        public int codingId { get; set; }
        public int projectId { get; set; }

    }
}