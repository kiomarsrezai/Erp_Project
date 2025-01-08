namespace NewsWebsite.ViewModels.Api.Budget.BudgetSeprator
{
    public class BudgetSepratorAreaProjectModalUpdateViewModel
    {
        public int BudgetDetailPrjectId { get; set; }
        public int ProgramOperationDetailId { get; set; }
        public int fname { get; set; }
    }

    public class CodingUpdateParamViewModel
    {
        public int CodingId { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public int Scope { get; set; }
        public int Stability { get; set; }
        public int PublicConsumptionPercent { get; set; }
        public int PrivateConsumptionPercent { get; set; }
    }
}