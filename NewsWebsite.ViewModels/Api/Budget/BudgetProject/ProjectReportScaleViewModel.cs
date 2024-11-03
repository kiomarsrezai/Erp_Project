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
    
    
    
    public class ProgramBudgetReadViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        public string Mosavab { get; set; }
        public string ProgramDetailsId { get; set; }
        public string ProgramCode { get; set; }
        public string ProgramName { get; set; }
        public string ProgramColor { get; set; }
        public string BDPAId { get; set; }
    }

    public class ProgramDetailsReadViewModel
    {
        public string Code { get; set; }
        public string Name1 { get; set; }
        public string Name2 { get; set; }
        public string Name3 { get; set; }
        public string Color { get; set; }
    }

}