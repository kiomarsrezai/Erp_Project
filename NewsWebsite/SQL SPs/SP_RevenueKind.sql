USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP_RevenueKind]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_RevenueKind]
@yearId int
AS
BEGIN
SELECT        TblAreas.Id, TblAreas.AreaNameShort AS AreaName, der_Revenue.MosavabRevenue, der_Revenue.ExpenseRevenue, der_Sale.MosavabSale, der_Sale.ExpenseSale, der_Loan.MosavabLoan, der_Loan.ExpenseLoan, 
                         der_DaryaftAzKhazane.MosavabDaryaftAzKhazane, der_DaryaftAzKhazane.ExpenseDaryaftAzKhazane, der_Current.MosavabCurrent, der_Current.ExpenseCurrent, der_Civil.MosavabCivil, der_Civil.ExpenseCivil, der_Financial.MosavabFinancial, 
                         der_Financial.ExpenseFinancial, der_Motomarkez.MosavabMotomarkez , der_Motomarkez.ExpenseMotomarkez --, der_MoharekTosea.MosavabMoharkTosea, der_MoharekTosea.ExpenseMoharkTosea
FROM            TblAreas LEFT OUTER JOIN
           --                  (SELECT        tblBudgetDetailProjectArea_3.AreaId, SUM(tblBudgetDetailProjectArea_3.Mosavab) AS MosavabMoharkTosea, SUM(tblBudgetDetailProjectArea_3.Expense) AS ExpenseMoharkTosea
           --                     FROM            TblBudgets AS TblBudgets_3 INNER JOIN
           --                                              TblBudgetDetails AS TblBudgetDetails_3 ON TblBudgets_3.Id = TblBudgetDetails_3.BudgetId INNER JOIN
           --                                              tblBudgetDetailProject AS tblBudgetDetailProject_3 ON TblBudgetDetails_3.Id = tblBudgetDetailProject_3.BudgetDetailId INNER JOIN
           --                                              tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_3 ON tblBudgetDetailProject_3.Id = tblBudgetDetailProjectArea_3.BudgetDetailProjectId INNER JOIN
           --                                              tblCoding AS TblCoding_3 ON TblBudgetDetails_3.tblCodingId = TblCoding_3.Id
           --                     WHERE (TblBudgets_3.TblYearId = @yearId) AND
								   --   (TblCoding_3.TblBudgetProcessId = 1) AND
									  --(TblCoding_3.CodingKindId = 11)
           --                     GROUP BY tblBudgetDetailProjectArea_3.AreaId) AS der_MoharekTosea ON TblAreas.Id = der_MoharekTosea.AreaId LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea_3.AreaId, SUM(tblBudgetDetailProjectArea_3.Mosavab) AS MosavabMotomarkez, SUM(tblBudgetDetailProjectArea_3.Expense) AS ExpenseMotomarkez
                                FROM            TblBudgets AS TblBudgets_3 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_3 ON TblBudgets_3.Id = TblBudgetDetails_3.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_3 ON TblBudgetDetails_3.Id = tblBudgetDetailProject_3.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_3 ON tblBudgetDetailProject_3.Id = tblBudgetDetailProjectArea_3.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS TblCoding_3 ON TblBudgetDetails_3.tblCodingId = TblCoding_3.Id
                                WHERE  (TblBudgets_3.TblYearId = @yearId) AND
								       (TblCoding_3.TblBudgetProcessId = 8) 
                                GROUP BY tblBudgetDetailProjectArea_3.AreaId) AS der_Motomarkez ON TblAreas.Id = der_Motomarkez.AreaId LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea_3.AreaId, SUM(tblBudgetDetailProjectArea_3.Mosavab) AS MosavabFinancial, SUM(tblBudgetDetailProjectArea_3.Expense) AS ExpenseFinancial
                                FROM            TblBudgets AS TblBudgets_3 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_3 ON TblBudgets_3.Id = TblBudgetDetails_3.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_3 ON TblBudgetDetails_3.Id = tblBudgetDetailProject_3.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_3 ON tblBudgetDetailProject_3.Id = tblBudgetDetailProjectArea_3.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS TblCoding_3 ON TblBudgetDetails_3.tblCodingId = TblCoding_3.Id
                                WHERE        (TblBudgets_3.TblYearId = @yearId) AND (TblCoding_3.TblBudgetProcessId = 4)
                                GROUP BY tblBudgetDetailProjectArea_3.AreaId) AS der_Financial ON TblAreas.Id = der_Financial.AreaId LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea_3.AreaId, SUM(tblBudgetDetailProjectArea_3.Mosavab) AS MosavabCivil, SUM(tblBudgetDetailProjectArea_3.Expense) AS ExpenseCivil
                                FROM            TblBudgets AS TblBudgets_3 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_3 ON TblBudgets_3.Id = TblBudgetDetails_3.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_3 ON TblBudgetDetails_3.Id = tblBudgetDetailProject_3.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_3 ON tblBudgetDetailProject_3.Id = tblBudgetDetailProjectArea_3.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS TblCoding_3 ON TblBudgetDetails_3.tblCodingId = TblCoding_3.Id
                                WHERE        (TblBudgets_3.TblYearId = @yearId) AND (TblCoding_3.TblBudgetProcessId = 3)
                                GROUP BY tblBudgetDetailProjectArea_3.AreaId) AS der_Civil ON TblAreas.Id = der_Civil.AreaId LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea_3.AreaId, SUM(tblBudgetDetailProjectArea_3.Mosavab) AS MosavabCurrent, SUM(tblBudgetDetailProjectArea_3.Expense) AS ExpenseCurrent
                                FROM            TblBudgets AS TblBudgets_3 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_3 ON TblBudgets_3.Id = TblBudgetDetails_3.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_3 ON TblBudgetDetails_3.Id = tblBudgetDetailProject_3.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_3 ON tblBudgetDetailProject_3.Id = tblBudgetDetailProjectArea_3.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS TblCoding_3 ON TblBudgetDetails_3.tblCodingId = TblCoding_3.Id
                                WHERE  (TblBudgets_3.TblYearId = @yearId) AND
								       (TblCoding_3.TblBudgetProcessId = 2)
                                GROUP BY tblBudgetDetailProjectArea_3.AreaId) AS der_Current ON TblAreas.Id = der_Current.AreaId LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea_3.AreaId, SUM(tblBudgetDetailProjectArea_3.Mosavab) AS MosavabDaryaftAzKhazane, SUM(tblBudgetDetailProjectArea_3.Expense) AS ExpenseDaryaftAzKhazane
                                FROM            TblBudgets AS TblBudgets_3 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_3 ON TblBudgets_3.Id = TblBudgetDetails_3.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_3 ON TblBudgetDetails_3.Id = tblBudgetDetailProject_3.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_3 ON tblBudgetDetailProject_3.Id = tblBudgetDetailProjectArea_3.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS TblCoding_3 ON TblBudgetDetails_3.tblCodingId = TblCoding_3.Id
                                WHERE  (TblBudgets_3.TblYearId = @yearId) AND
								       (TblCoding_3.TblBudgetProcessId = 9) 
                                GROUP BY tblBudgetDetailProjectArea_3.AreaId) AS der_DaryaftAzKhazane ON TblAreas.Id = der_DaryaftAzKhazane.AreaId LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea_2.AreaId, SUM(tblBudgetDetailProjectArea_2.Mosavab) AS MosavabLoan, SUM(tblBudgetDetailProjectArea_2.Expense) AS ExpenseLoan
                                FROM            TblBudgets AS TblBudgets_2 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_2 ON TblBudgets_2.Id = TblBudgetDetails_2.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_2 ON TblBudgetDetails_2.Id = tblBudgetDetailProject_2.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_2 ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea_2.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS TblCoding_2 ON TblBudgetDetails_2.tblCodingId = TblCoding_2.Id
                                WHERE  (TblBudgets_2.TblYearId = @yearId) AND
								       (TblCoding_2.TblBudgetProcessId = 1) AND
									   (TblCoding_2.CodingKindId = 3)
                                GROUP BY tblBudgetDetailProjectArea_2.AreaId) AS der_Loan ON TblAreas.Id = der_Loan.AreaId LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.AreaId, SUM(tblBudgetDetailProjectArea_1.Mosavab) AS MosavabSale, SUM(tblBudgetDetailProjectArea_1.Expense) AS ExpenseSale
                                FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS TblCoding_1 ON TblBudgetDetails_1.tblCodingId = TblCoding_1.Id
                                WHERE   (TblBudgets_1.TblYearId = @yearId) AND
								        (TblCoding_1.TblBudgetProcessId = 1) AND
										(TblCoding_1.CodingKindId = 2)
                                GROUP BY tblBudgetDetailProjectArea_1.AreaId) AS der_Sale ON TblAreas.Id = der_Sale.AreaId LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea.AreaId, SUM(tblBudgetDetailProjectArea.Mosavab) AS MosavabRevenue, SUM(tblBudgetDetailProjectArea.Expense) AS ExpenseRevenue
                                FROM            TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                                WHERE  (TblBudgets.TblYearId = @yearId) AND
								       (tblCoding.TblBudgetProcessId = 1) AND
									   (tblCoding.CodingKindId = 1)
                                GROUP BY tblBudgetDetailProjectArea.AreaId) AS der_Revenue ON TblAreas.Id = der_Revenue.AreaId
WHERE        (TblAreas.Id <> 10)
END
GO
