USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP502_OnlyPerformance12345678910]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP502_OnlyPerformance12345678910]
@YearId int
AS
BEGIN

SELECT        TblAreas.Id, TblAreas.AreaName, 
isnull(der_Revenue.PerformanceRevenue,0) as PerformanceRevenue, 
isnull(der_Current.PerformanceCurrent,0) as PerformanceCurrent, 
isnull(der_Civil.PerformanceCivil,0) as PerformanceCivil, 
isnull(der_Financial.PerformanceFinancial,0) as PerformanceFinancial,
0 as TaahodatGhati,
isnull(der_Revenue.PerformanceRevenue,0)-isnull(der_Current.PerformanceCurrent,0)-isnull(der_Civil.PerformanceCivil,0)-
isnull(der_Financial.PerformanceFinancial,0) as balance

FROM            TblAreas LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea_3.AreaId, SUM(tblBudgetDetailProjectArea_3.Expense) AS PerformanceFinancial
                                FROM            TblBudgets AS TblBudgets_3 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_3 ON TblBudgets_3.Id = TblBudgetDetails_3.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_3 ON TblBudgetDetails_3.Id = tblBudgetDetailProject_3.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_3 ON tblBudgetDetailProject_3.Id = tblBudgetDetailProjectArea_3.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_3 ON TblBudgetDetails_3.tblCodingId = tblCoding_3.Id
                                WHERE (TblBudgets_3.TblYearId = @YearId) AND
								      (tblCoding_3.TblBudgetProcessId = 4)
                                GROUP BY tblBudgetDetailProjectArea_3.AreaId) AS der_Financial ON TblAreas.Id = der_Financial.AreaId LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea_2.AreaId, SUM(tblBudgetDetailProjectArea_2.Expense) AS PerformanceCivil
                                FROM            TblBudgets AS TblBudgets_2 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_2 ON TblBudgets_2.Id = TblBudgetDetails_2.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_2 ON TblBudgetDetails_2.Id = tblBudgetDetailProject_2.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_2 ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea_2.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_2 ON TblBudgetDetails_2.tblCodingId = tblCoding_2.Id
                                WHERE (TblBudgets_2.TblYearId = @YearId) AND
								      (tblCoding_2.TblBudgetProcessId = 3)
                                GROUP BY tblBudgetDetailProjectArea_2.AreaId) AS der_Civil ON TblAreas.Id = der_Civil.AreaId LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.AreaId, SUM(tblBudgetDetailProjectArea_1.Expense) AS PerformanceCurrent
                                FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id
                                WHERE (TblBudgets_1.TblYearId = @YearId) AND
								      (tblCoding_1.TblBudgetProcessId = 2)
                                GROUP BY tblBudgetDetailProjectArea_1.AreaId) AS der_Current ON TblAreas.Id = der_Current.AreaId LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea.AreaId, SUM(tblBudgetDetailProjectArea.Expense) AS PerformanceRevenue
                                FROM            TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                                WHERE (TblBudgets.TblYearId = @YearId) AND
								      (tblCoding.TblBudgetProcessId = 1)
                                GROUP BY tblBudgetDetailProjectArea.AreaId) AS der_Revenue ON TblAreas.Id = der_Revenue.AreaId
WHERE        (TblAreas.StructureId = 1)









END
GO
