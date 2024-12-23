USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP005_Report_ProjectScale]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP005_Report_ProjectScale]
@yearId int ,
@areaId int ,
@scaleId tinyint
AS
BEGIN
if(@areaId<>10)
begin
SELECT        tbl2.TblProjectId AS ProjectId, tbl2.AreaId, TblAreas.AreaNameShort AS AreaName, TblProjects.ProjectCode, TblProjects.ProjectName, tbl2.Mosavab, tbl2.Edit, tbl2.Supply, tbl2.Expense, tbl2.BudgetNext
FROM            (SELECT        TblProjectId, AreaId, SUM(Mosavab) AS Mosavab, SUM(EditArea) AS Edit, SUM(Supply) AS Supply, SUM(Expense) AS Expense, SUM(BudgetNext) AS BudgetNext
                          FROM            (SELECT        TblProgramOperationDetails.TblProjectId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, 
                                                                              tblBudgetDetailProjectArea.Expense, 0 AS BudgetNext
                                                    FROM            TblBudgets INNER JOIN
                                                                              TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                                              tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                                              tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                              TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id INNER JOIN
                                                                              tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                                              TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id
                                                    WHERE  (TblBudgets.TblYearId = @yearId - 1) AND
													       (tblBudgetDetailProjectArea.AreaId = @areaId) AND
														   (tblCoding.TblBudgetProcessId = 3) AND
														   (TblProjects.ProjectScaleId = @scaleId)
                                                    UNION ALL
                                                    SELECT        TblProgramOperationDetails_1.TblProjectId, tblBudgetDetailProjectArea_1.AreaId, 0 AS Mosavab, 0 AS EditArea, 0 AS Supply, 0 AS Expense, tblBudgetDetailProjectArea_1.Pishnahadi AS Expr1
                                                    FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                                             TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                                             tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                                             tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                                             TblProgramOperationDetails AS TblProgramOperationDetails_1 ON tblBudgetDetailProject_1.ProgramOperationDetailsId = TblProgramOperationDetails_1.Id INNER JOIN
                                                                             tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                                             TblProjects ON TblProgramOperationDetails_1.TblProjectId = TblProjects.Id
                                                    WHERE   (TblBudgets_1.TblYearId = @yearId) AND
													        (tblBudgetDetailProjectArea_1.AreaId = @areaId) AND
															(tblCoding_1.TblBudgetProcessId = 3) AND
															(TblProjects.ProjectScaleId = @scaleId)
															) AS tbl1
                          GROUP BY TblProjectId, AreaId) AS tbl2 INNER JOIN
                         TblProjects ON tbl2.TblProjectId = TblProjects.Id INNER JOIN
                         TblAreas ON tbl2.AreaId = TblAreas.Id
return
end

if(@areaId=10)
begin
SELECT        tbl2.TblProjectId AS ProjectId, tbl2.AreaId, TblAreas_1.AreaNameShort AS AreaName, TblProjects.ProjectCode, TblProjects.ProjectName, tbl2.Mosavab, tbl2.Edit, tbl2.Supply, tbl2.Expense, tbl2.BudgetNext
FROM            (SELECT        TblProjectId, AreaId, SUM(Mosavab) AS Mosavab, SUM(EditArea) AS Edit, SUM(Supply) AS Supply, SUM(Expense) AS Expense, SUM(BudgetNext) AS BudgetNext
                          FROM            (SELECT        TblProgramOperationDetails.TblProjectId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, 
                                                                              tblBudgetDetailProjectArea.Expense, 0 AS BudgetNext
                                                    FROM            TblBudgets INNER JOIN
                                                                              TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                                              tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                                              tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                              TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id INNER JOIN
                                                                              tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                                              TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id INNER JOIN
                                                                              TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id
                                                    WHERE   (TblBudgets.TblYearId = @yearId - 1) AND
													        (tblCoding.TblBudgetProcessId = 3) AND
															(TblAreas.StructureId = 1) AND
															(TblProjects.ProjectScaleId = @scaleId)
                                                    UNION ALL
                                                    SELECT        TblProgramOperationDetails_1.TblProjectId, tblBudgetDetailProjectArea_1.AreaId, 0 AS Mosavab, 0 AS EditArea, 0 AS Supply, 0 AS Expense, tblBudgetDetailProjectArea_1.Pishnahadi AS Expr1
                                                    FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                                             TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                                             tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                                             tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                                             TblProgramOperationDetails AS TblProgramOperationDetails_1 ON tblBudgetDetailProject_1.ProgramOperationDetailsId = TblProgramOperationDetails_1.Id INNER JOIN
                                                                             tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                                             TblAreas AS TblAreas_2 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_2.Id INNER JOIN
                                                                             TblProjects ON TblProgramOperationDetails_1.TblProjectId = TblProjects.Id
                                                    WHERE   (TblBudgets_1.TblYearId = @yearId) AND
													        (tblCoding_1.TblBudgetProcessId = 3) AND
															(TblAreas_2.StructureId = 1) AND
															(TblProjects.ProjectScaleId = @scaleId)
															) AS tbl1
                          GROUP BY TblProjectId, AreaId) AS tbl2 INNER JOIN
                         TblProjects ON tbl2.TblProjectId = TblProjects.Id INNER JOIN
                         TblAreas AS TblAreas_1 ON tbl2.AreaId = TblAreas_1.Id
return
end

END
GO
