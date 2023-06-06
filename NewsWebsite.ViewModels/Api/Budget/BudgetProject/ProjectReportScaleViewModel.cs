namespace NewsWebsite.ViewModels.Api.Budget.BudgetProject
{
    public class ProgramOperationViewModel
    {
        public int Id { get; set; }
        public int ProjectId { get; set; }
        public string ProjectCode { get; set; }
        public string ProjectName { get; set; }
        public int? ProjectScaleId { get; set; }
        public string ProjectScaleName { get; set; }
    }

    public class ProjectReportScaleViewModel
    {
        public int ProjectId { get; set; }
        public long Mosavab { get; set; }
        public long Expense { get; set; }
        public string ProjectCode { get; set; }
        public string ProjectName { get; set; }
    }

    public class ProgramOperationUpdateViewModel
    {
        public int ProjectId { get; set; }
        public int ScaleId { get; set; }
        public string ProjectName { get; set; }

    }
    public class ProjectScaleComViewModel
    {
        public int Id { get; set; }
        public string ProjectScaleName { get; set; }
    }
}