USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetCodingInfoModal_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetCodingInfoModal_Read]
@yearId int ,
@CodingId int
AS
BEGIN
SELECT        TblAreas.StructureId, TblAreas.AreaName, tbl1.Pishnahadi, tbl1.Mosavab, tbl1.EditArea, tbl1.CreditAmount, tbl1.Expense
FROM            (SELECT        tblBudgetDetailProjectArea.AreaId, SUM(tblBudgetDetailProjectArea.Pishnahadi) AS Pishnahadi, SUM(tblBudgetDetailProjectArea.Mosavab) AS Mosavab, SUM(tblBudgetDetailProjectArea.EditArea) AS EditArea, SUM(tblBudgetDetailProjectArea.Supply) AS CreditAmount, 
                                                    SUM(tblBudgetDetailProjectArea.Expense) AS Expense
                          FROM            TblBudgets INNER JOIN
                                                    TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                    tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                    tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                    tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                          WHERE        (TblBudgets.TblYearId = @yearId) AND (TblBudgetDetails.tblCodingId = @CodingId)
                          GROUP BY tblBudgetDetailProjectArea.AreaId) AS tbl1 INNER JOIN
                         TblAreas ON tbl1.AreaId = TblAreas.Id


END
GO
