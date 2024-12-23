USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP_501_Tahlile]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_501_Tahlile]
@yearId int
AS
BEGIN
SELECT        d, 
                         CASE WHEN d = 1 THEN 'تا 1 میلیارد تومان' 
						 WHEN d = 2 THEN 'از 1 تا 5 میلیارد تومان' 
						 WHEN d = 3 THEN 'از 5 تا 10 میلیارد تومان' 
						 WHEN d = 4 THEN 'از 10 تا 20 میلیارد تومان' 
						 WHEN d = 5 THEN 'از 20 تا 30 میلیارد تومان'
                          WHEN d = 6 THEN 'از 30 تا 40 میلیارد تومان' 
						  WHEN d = 7 THEN 'از 40 تا 50 میلیارد تومان' 
						  WHEN d = 8 THEN 'از 50 تا 60 میلیارد تومان' 
						  WHEN d = 1 THEN 'از 60 تا 70 میلیارد تومان ' 
						  WHEN d = 10 THEN 'از 70 تا 80 میلیارد تومان'
                          WHEN d = 11 THEN 'از 80 تا 90 میلیارد تومان' 
						  WHEN d = 12 THEN 'از 90  تا 100 میلیارد تومان' 
						  WHEN d = 13 THEN 'از 100 تا 200 میلیارد تومان' 
						  WHEN d = 14 THEN 'از 200  تا 300 میلیارد' WHEN d = 15
                          THEN 'بالای 300 میلیارد تومان' ELSE '.....' END AS dd, Mosavab, Expense, countt
FROM            (SELECT        d, SUM(Mosavab) AS Mosavab, SUM(Expense) AS Expense, COUNT(*) AS countt
                           FROM            (SELECT        CASE WHEN tblBudgetDetailProjectArea.Mosavab >= 0 AND tblBudgetDetailProjectArea.Mosavab <= 10000000000 THEN 1 WHEN tblBudgetDetailProjectArea.Mosavab >= 10000000001 AND 
                                                                               tblBudgetDetailProjectArea.Mosavab <= 50000000000 THEN 2 WHEN tblBudgetDetailProjectArea.Mosavab >= 50000000001 AND 
                                                                               tblBudgetDetailProjectArea.Mosavab <= 100000000000 THEN 3 WHEN tblBudgetDetailProjectArea.Mosavab >= 100000000001 AND 
                                                                               tblBudgetDetailProjectArea.Mosavab <= 200000000000 THEN 4 WHEN tblBudgetDetailProjectArea.Mosavab >= 200000000001 AND 
                                                                               tblBudgetDetailProjectArea.Mosavab <= 300000000000 THEN 5 WHEN tblBudgetDetailProjectArea.Mosavab >= 300000000001 AND 
                                                                               tblBudgetDetailProjectArea.Mosavab <= 400000000000 THEN 6 WHEN tblBudgetDetailProjectArea.Mosavab >= 400000000001 AND 
                                                                               tblBudgetDetailProjectArea.Mosavab <= 500000000000 THEN 7 WHEN tblBudgetDetailProjectArea.Mosavab >= 500000000001 AND 
                                                                               tblBudgetDetailProjectArea.Mosavab <= 600000000000 THEN 8 WHEN tblBudgetDetailProjectArea.Mosavab >= 600000000001 AND 
                                                                               tblBudgetDetailProjectArea.Mosavab <= 700000000000 THEN 9 WHEN tblBudgetDetailProjectArea.Mosavab >= 700000000001 AND 
                                                                               tblBudgetDetailProjectArea.Mosavab <= 800000000000 THEN 10 WHEN tblBudgetDetailProjectArea.Mosavab >= 800000000001 AND 
                                                                               tblBudgetDetailProjectArea.Mosavab <= 900000000000 THEN 11 WHEN tblBudgetDetailProjectArea.Mosavab >= 900000000001 AND 
                                                                               tblBudgetDetailProjectArea.Mosavab <= 1000000000000 THEN 12 WHEN tblBudgetDetailProjectArea.Mosavab >= 1000000000001 AND 
                                                                               tblBudgetDetailProjectArea.Mosavab <= 2000000000000 THEN 13 WHEN tblBudgetDetailProjectArea.Mosavab >= 2000000000001 AND 
                                                                               tblBudgetDetailProjectArea.Mosavab <= 3000000000000 THEN 14 WHEN tblBudgetDetailProjectArea.Mosavab > 3000000000001 THEN 15 ELSE 0 END AS d, tblBudgetDetailProjectArea.Mosavab, 
                                                                               tblBudgetDetailProjectArea.Expense
                                                      FROM            TblBudgets INNER JOIN
                                                                               TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                                               tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                                               tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                               TblCoding ON TblBudgetDetails.tblCodingId = TblCoding.Id
                                                      WHERE (TblBudgets.TblYearId = @yearId) AND
													        (TblCoding.TblBudgetProcessId = 3) AND
															(tblBudgetDetailProjectArea.Mosavab > 0)) AS tbl1
                           GROUP BY d) AS tbl2
ORDER BY d


--SELECT        EstimateAmount, range, countt
--FROM            (SELECT   SUM(EstimateAmount) AS EstimateAmount, range, COUNT(*) AS countt
--                          FROM            (SELECT  EstimateAmount, 
--						                           CASE WHEN EstimateAmount BETWEEN     0      AND 10000000   THEN 10000000 
--						                                WHEN EstimateAmount BETWEEN 10000001   AND 100000000  THEN 100000000
--														WHEN EstimateAmount BETWEEN 100000001  AND 500000000  THEN 500000000
--														WHEN EstimateAmount BETWEEN 500000001  AND 1000000000 THEN 1000000000 
--		                                                WHEN EstimateAmount > 1000000001 then 0														END AS range
--                                                    FROM  tblRequest
--													where AreaId <=9
--													) AS tbl1
--                          GROUP BY range) AS tbl2
--						  order by range
END
GO
