USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP500_Chart_RevenueKindModal]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP500_Chart_RevenueKindModal]
@yearId int,
@StructureId tinyint
AS
BEGIN
if(@StructureId=3) begin set @StructureId=1  end
if(@StructureId=4) begin set @StructureId=2  end

SELECT        TblAreas.Id as AreaId, TblAreas.AreaNameShort AS AreaName,
ISNULL(der_Revenue.MosavabRevenue, 0) AS MosavabRevenue, 
ISNULL(der_Revenue.ExpenseRevenue, 0) AS ExpenseRevenue,
ISNULL(der_Sale.MosavabSale, 0)AS MosavabSale,
ISNULL(der_Sale.ExpenseSale, 0) AS ExpenseSale,
ISNULL(der_Loan.MosavabLoan, 0) AS MosavabLoan,
ISNULL(der_Loan.ExpenseLoan, 0) AS ExpenseLoan, 
ISNULL(der_DaryaftAzKhazane.MosavabDaryaftAzKhazane, 0) AS MosavabDaryaftAzKhazane,
ISNULL(der_DaryaftAzKhazane.ExpenseDaryaftAzKhazane, 0) AS ExpenseDaryaftAzKhazane, 
ISNULL(der_Revenue.MosavabRevenue, 0) + ISNULL(der_Sale.MosavabSale, 0) + ISNULL(der_Loan.MosavabLoan, 0) AS MosavabKol, 
ISNULL(der_Revenue.ExpenseRevenue, 0) + ISNULL(der_Sale.ExpenseSale, 0) + ISNULL(der_Loan.ExpenseLoan, 0) AS ExpenseKol
FROM            TblAreas LEFT OUTER JOIN
                             (SELECT  tblBudgetDetailProjectArea_2.AreaId, SUM(tblBudgetDetailProjectArea_2.Mosavab) AS MosavabDaryaftAzKhazane, SUM(tblBudgetDetailProjectArea_2.Expense) AS ExpenseDaryaftAzKhazane
                               FROM            TblBudgets AS TblBudgets_2 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_2 ON TblBudgets_2.Id = TblBudgetDetails_2.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_2 ON TblBudgetDetails_2.Id = tblBudgetDetailProject_2.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_2 ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea_2.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS TblCoding_2 ON TblBudgetDetails_2.tblCodingId = TblCoding_2.Id INNER JOIN
                                                         TblAreas AS TblAreas_3 ON TblBudgets_2.TblAreaId = TblAreas_3.Id
                               WHERE (TblBudgets_2.TblYearId = @yearId) AND
							         (TblCoding_2.TblBudgetProcessId = 9) AND
									 (TblAreas_3.StructureId = @StructureId) AND
									 (tblBudgetDetailProjectArea_2.AreaId <> 10)
                               GROUP BY tblBudgetDetailProjectArea_2.AreaId) AS der_DaryaftAzKhazane ON TblAreas.Id = der_DaryaftAzKhazane.AreaId LEFT OUTER JOIN
                             (SELECT  tblBudgetDetailProjectArea_2.AreaId, SUM(tblBudgetDetailProjectArea_2.Mosavab) AS MosavabLoan, SUM(tblBudgetDetailProjectArea_2.Expense) AS ExpenseLoan
                               FROM            TblBudgets AS TblBudgets_2 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_2 ON TblBudgets_2.Id = TblBudgetDetails_2.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_2 ON TblBudgetDetails_2.Id = tblBudgetDetailProject_2.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_2 ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea_2.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS TblCoding_2 ON TblBudgetDetails_2.tblCodingId = TblCoding_2.Id INNER JOIN
                                                         TblAreas AS TblAreas_3 ON TblBudgets_2.TblAreaId = TblAreas_3.Id
                               WHERE  (TblBudgets_2.TblYearId = @yearId) AND
							          (TblCoding_2.TblBudgetProcessId = 1) AND
									  (TblCoding_2.CodingKindId = 3) AND
									  (TblAreas_3.StructureId = @StructureId) AND
									  (tblBudgetDetailProjectArea_2.AreaId <> 10)
                               GROUP BY tblBudgetDetailProjectArea_2.AreaId) AS der_Loan ON TblAreas.Id = der_Loan.AreaId LEFT OUTER JOIN
                             (SELECT  tblBudgetDetailProjectArea_1.AreaId, SUM(tblBudgetDetailProjectArea_1.Mosavab) AS MosavabSale, SUM(tblBudgetDetailProjectArea_1.Expense) AS ExpenseSale
                               FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS TblCoding_1 ON TblBudgetDetails_1.tblCodingId = TblCoding_1.Id INNER JOIN
                                                         TblAreas AS TblAreas_2 ON TblBudgets_1.TblAreaId = TblAreas_2.Id
                               WHERE  (TblBudgets_1.TblYearId = @yearId) AND
							          (TblCoding_1.TblBudgetProcessId = @StructureId) AND
									  (TblCoding_1.CodingKindId = 2) AND
									  (TblAreas_2.StructureId = @StructureId) AND 
                                      (tblBudgetDetailProjectArea_1.AreaId <> 10)
                               GROUP BY tblBudgetDetailProjectArea_1.AreaId) AS der_Sale ON TblAreas.Id = der_Sale.AreaId LEFT OUTER JOIN
                             (SELECT  tblBudgetDetailProjectArea.AreaId, SUM(tblBudgetDetailProjectArea.Mosavab) AS MosavabRevenue, SUM(tblBudgetDetailProjectArea.Expense) AS ExpenseRevenue
                               FROM            TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblAreas AS TblAreas_1 ON TblBudgets.TblAreaId = TblAreas_1.Id
                               WHERE  (TblBudgets.TblYearId = @yearId) AND
							          (tblCoding.TblBudgetProcessId = 1) AND
									  (tblCoding.CodingKindId = 1) AND
									  (TblAreas_1.StructureId = @StructureId) AND
									  (tblBudgetDetailProjectArea.AreaId <> 10)
                               GROUP BY tblBudgetDetailProjectArea.AreaId) AS der_Revenue ON TblAreas.Id = der_Revenue.AreaId
WHERE  (TblAreas.StructureId = @StructureId) AND
       (TblAreas.Id <> 10)
END
GO
