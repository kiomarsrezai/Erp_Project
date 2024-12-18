USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_AbstractArea]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_AbstractArea]
@yearId int ,
@areaId int
AS
BEGIN

SELECT    1 AS Side, tblCodingKind.CodingKindName AS Description, tbl1.Mosavab, tbl1.Edit, tbl1.Expense
FROM            (SELECT        tblCoding.CodingKindId, SUM(tblBudgetDetailProjectArea.Mosavab) AS Mosavab, SUM(tblBudgetDetailProjectArea.EditArea) AS Edit, SUM(tblBudgetDetailProjectArea.Expense) AS Expense
                          FROM            TblBudgets INNER JOIN
                                                    TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                    tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                    tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                    tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                          WHERE        (tblCoding.TblBudgetProcessId = 1) AND
						    (TblBudgets.TblYearId = @yearId) AND (tblBudgetDetailProjectArea.AreaId = @areaId)
                          GROUP BY tblCoding.CodingKindId) AS tbl1 INNER JOIN
                         tblCodingKind ON tbl1.CodingKindId = tblCodingKind.Id
union all
SELECT        side, RevenueKind, Mosavab, Edit, Expense
FROM            (SELECT        11 AS side, 'کسر : سهم خزانه متمرکز'as RevenueKind, SUM(tblBudgetDetailProjectArea.Mosavab) AS Mosavab, SUM(tblBudgetDetailProjectArea.EditArea) AS Edit, SUM(tblBudgetDetailProjectArea.Expense) AS Expense
                          FROM            TblBudgets INNER JOIN
                                                    TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                    tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                    tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                    tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                          WHERE   (tblCoding.TblBudgetProcessId = 8) AND
						          (TblBudgets.TblYearId = @yearId) AND
								  (tblBudgetDetailProjectArea.AreaId = @areaId) 
                          GROUP BY tblCoding.CodingKindId) AS tbl1
union all
SELECT        side, RevenueKind, Mosavab, Edit, Expense
FROM            (SELECT        111 AS side, 'اضافه :  منابع انتقالی خزانه متمرکز'as RevenueKind, SUM(tblBudgetDetailProjectArea.Mosavab) AS Mosavab, SUM(tblBudgetDetailProjectArea.EditArea) AS Edit, SUM(tblBudgetDetailProjectArea.Expense) AS Expense
                          FROM            TblBudgets INNER JOIN
                                                    TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                    tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                    tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                    tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                          WHERE   (tblCoding.TblBudgetProcessId = 10) AND
						          (TblBudgets.TblYearId = @yearId) AND
								  (tblBudgetDetailProjectArea.AreaId = @areaId) 
                          GROUP BY tblCoding.CodingKindId) AS tbl1

union all
SELECT        side, RevenueKind, Mosavab, Edit, Expense
FROM            (SELECT    1111 AS side, 'اضافه :  منابع انتقالی نیابتی'as RevenueKind, SUM(tblBudgetDetailProjectArea.Mosavab) AS Mosavab, SUM(tblBudgetDetailProjectArea.EditArea) AS Edit, SUM(tblBudgetDetailProjectArea.Expense) AS Expense
                          FROM            TblBudgets INNER JOIN
                                                    TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                    tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                    tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                    tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                          WHERE   (tblCoding.TblBudgetProcessId = 9) AND
						          (TblBudgets.TblYearId = @yearId) AND
								  (tblBudgetDetailProjectArea.AreaId = @areaId) 
                          GROUP BY tblCoding.CodingKindId) AS tbl1

union all
SELECT        side, RevenueKind, Mosavab, Edit, Expense
FROM            (SELECT        2 AS side,CASE WHEN tblCoding.TblBudgetProcessId = 2 THEN 'هزینه های عمومی' 
										      WHEN tblCoding.TblBudgetProcessId = 3 THEN 'تملک دارائی های سرمایه ای' 
											  WHEN tblCoding.TblBudgetProcessId = 4 THEN 'تملک دارائی های مالی'
											  WHEN tblCoding.TblBudgetProcessId = 5 THEN 'دیون قطعی سنواتی'  
                                              ELSE '' END AS RevenueKind, SUM(tblBudgetDetailProjectArea.Mosavab) AS Mosavab, SUM(tblBudgetDetailProjectArea.EditArea) AS Edit, SUM(tblBudgetDetailProjectArea.Expense) AS Expense
                          FROM            TblBudgets INNER JOIN
                                                    TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                    tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                    tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                    tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                          WHERE  (tblCoding.TblBudgetProcessId in (2,3,4,5)) AND
						         (TblBudgets.TblYearId = @yearId) AND
								 (tblBudgetDetailProjectArea.AreaId = @areaId) 								
                          GROUP BY tblCoding.TblBudgetProcessId) AS tbl1
END
GO
