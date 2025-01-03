USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP004_BudgetProposal_Chart_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP004_BudgetProposal_Chart_Read]
@CodingId int 
AS
BEGIN
SELECT        TblYears.YearName, tbl1.Mosavab, tbl1.Edit, tbl1.Expense
FROM            (SELECT        TblBudgets.TblYearId, SUM(tblBudgetDetailProjectArea.Mosavab) AS Mosavab, SUM(tblBudgetDetailProjectArea.EditArea) AS Edit, SUM(tblBudgetDetailProjectArea.Expense) AS Expense
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE        (TblBudgetDetails.tblCodingId = @CodingId)
GROUP BY TblBudgets.TblYearId) AS tbl1 INNER JOIN
                         TblYears ON tbl1.TblYearId = TblYears.Id
ORDER BY TblYears.YearName
--SELECT        TblYears.YearName, tbl1.Mosavab, tbl1.Edit, tbl1.Expense
--FROM            (SELECT        TblBudgets.TblYearId, SUM(tblBudgetDetailProjectArea.Mosavab) AS Mosavab, SUM(tblBudgetDetailProjectArea.EditArea) AS Edit, SUM(tblBudgetDetailProjectArea.Expense) AS Expense
--                          FROM            TblBudgets INNER JOIN
--                                                    TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--                                                    tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--                                                    tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
--                          WHERE        (TblBudgetDetails.tblCodingId IN
--                                                        (SELECT        HistoryId
--                                                          FROM            tblCodingHistory
--                                                          WHERE        (CodingId = @CodingId)))
--                          GROUP BY TblBudgets.TblYearId) AS tbl1 INNER JOIN
--                         TblYears ON tbl1.TblYearId = TblYears.Id
--ORDER BY TblYears.YearName




END
GO
