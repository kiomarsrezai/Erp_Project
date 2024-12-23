USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP500_Chart_Ravand]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP500_Chart_Ravand]
@areaId int,
@BudgetProcessId int
AS
BEGIN
if(@areaId not in (10,37))
begin
SELECT        tbl1.TblYearId as YearId, TblYears.YearName, tbl1.Mosavab, 999999999 AS Edit, tbl1.Expense
FROM            (SELECT        TblBudgets.TblYearId, SUM(tblBudgetDetailProjectArea.Mosavab) AS Mosavab, SUM(tblBudgetDetailProjectArea.Expense) AS Expense
                          FROM            TblBudgets INNER JOIN
                                                    TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                    tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                    tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                    tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                          WHERE        (tblBudgetDetailProjectArea.AreaId = @areaId) AND
						               (tblCoding.TblBudgetProcessId = @BudgetProcessId)
                          GROUP BY TblBudgets.TblYearId) AS tbl1 INNER JOIN
                         TblYears ON tbl1.TblYearId = TblYears.Id
ORDER BY tbl1.TblYearId
return
end

if(@areaId = 10)
begin
SELECT        tbl1.TblYearId AS YearId, TblYears.YearName, tbl1.Mosavab, tbl1.Edit, tbl1.Expense
FROM            (SELECT        TblBudgets.TblYearId, SUM(tblBudgetDetailProjectArea.Mosavab) AS Mosavab, SUM(tblBudgetDetailProjectArea.EditArea) AS Edit, SUM(tblBudgetDetailProjectArea.Expense) AS Expense
                          FROM            TblBudgets INNER JOIN
                                                    TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                    tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                    tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                    tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                    TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                          WHERE        (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas.StructureId = 1)
                          GROUP BY TblBudgets.TblYearId) AS tbl1 INNER JOIN
                         TblYears ON tbl1.TblYearId = TblYears.Id
ORDER BY YearId
return
end

if(@areaId = 37)
begin
SELECT        tbl1.TblYearId AS YearId, TblYears.YearName, tbl1.Mosavab, tbl1.Edit, tbl1.Expense
FROM            (SELECT        TblBudgets.TblYearId, SUM(tblBudgetDetailProjectArea.Mosavab) AS Mosavab, SUM(tblBudgetDetailProjectArea.EditArea) AS Edit, SUM(tblBudgetDetailProjectArea.Expense) AS Expense
                          FROM            TblBudgets INNER JOIN
                                                    TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                    tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                    tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                    tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                          WHERE        (tblCoding.TblBudgetProcessId = @BudgetProcessId)
                          GROUP BY TblBudgets.TblYearId) AS tbl1 INNER JOIN
                         TblYears ON tbl1.TblYearId = TblYears.Id
ORDER BY YearId
return
end
END
GO
