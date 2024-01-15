using System;

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
        public int AreaId { get; set; }
        public string AreaName { get; set; }
        public string ProjectCode { get; set; }
        public string ProjectName { get; set; }
        public Int64 Mosavab { get; set; }
        public Int64 Edit { get; set; }
        public Int64 Supply { get; set; }
        public Int64 Expense { get; set; }
        public Int64 BudgetNext { get; set; }
  
    }

    public class ProjectReportScaleBudgetViewModel
    {
        public string Code { get; set; }
        public string Description { get; set; }
        public Int64 Mosavab { get; set; }
        public Int64 Edit { get; set; }
        public Int64 Supply { get; set; }
        public Int64 Expense { get; set; }

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