USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_Abstract_PerformanceMonthly]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_Abstract_PerformanceMonthly]
@YearId int,
@AreaId int,
@budgetProcessId tinyint
AS
BEGIN
declare @StructureId tinyint = (select StructureId from TblAreas where id=@AreaId) 
declare @YearName int=(select YearName from TblYears where id = @YearId)
if(@StructureId = 1)
begin
SELECT        tblCoding.Id, tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, der_month.Month, der_month.Expense
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id LEFT OUTER JOIN
                             (SELECT        CodingId, Month, SUM(Expense) AS Expense
                               FROM            (SELECT        TblBudgetDetails_5.tblCodingId AS CodingId, ABS(tblSanadDetail_MD_1.Bestankar - tblSanadDetail_MD_1.Bedehkar) AS Expense, CASE WHEN tblSanad_MD_1.SanadDateS >= '1402/01/01' AND 
                         tblSanad_MD_1.SanadDateS <= '1402/01/31' THEN 1 WHEN tblSanad_MD_1.SanadDateS >= '1402/02/01' AND tblSanad_MD_1.SanadDateS <= '1402/02/31' THEN 2 WHEN tblSanad_MD_1.SanadDateS >= '1402/03/01' AND 
                         tblSanad_MD_1.SanadDateS <= '1402/03/31' THEN 3 WHEN tblSanad_MD_1.SanadDateS >= '1402/04/01' AND tblSanad_MD_1.SanadDateS <= '1402/04/31' THEN 4 WHEN tblSanad_MD_1.SanadDateS >= '1402/05/01' AND 
                         tblSanad_MD_1.SanadDateS <= '1402/05/31' THEN 5 WHEN tblSanad_MD_1.SanadDateS >= '1402/06/01' AND tblSanad_MD_1.SanadDateS <= '1402/06/31' THEN 6 WHEN tblSanad_MD_1.SanadDateS >= '1402/07/01' AND 
                         tblSanad_MD_1.SanadDateS <= '1402/07/30' THEN 7 WHEN tblSanad_MD_1.SanadDateS >= '1402/08/01' AND tblSanad_MD_1.SanadDateS <= '1402/08/30' THEN 8 WHEN tblSanad_MD_1.SanadDateS >= '1402/09/01' AND 
                         tblSanad_MD_1.SanadDateS <= '1402/09/30' THEN 9 WHEN tblSanad_MD_1.SanadDateS >= '1402/10/01' AND tblSanad_MD_1.SanadDateS <= '1402/10/30' THEN 10 WHEN tblSanad_MD_1.SanadDateS >= '1402/11/01' AND 
                         tblSanad_MD_1.SanadDateS <= '1402/11/30' THEN 11 WHEN tblSanad_MD_1.SanadDateS >= '1402/12/01' AND tblSanad_MD_1.SanadDateS <= '1402/12/30' THEN 12 ELSE 0 END AS Month
FROM            olden.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                         olden.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.AreaId = tblSanadDetail_MD_1.AreaId AND 
                         tblSanad_MD_1.YearName = tblSanadDetail_MD_1.YearName INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_5 INNER JOIN
                         TblBudgets AS TblBudgets_5 ON TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id INNER JOIN
                         tblBudgetDetailProject AS tblBudgetDetailProject_5 ON TblBudgetDetails_5.Id = tblBudgetDetailProject_5.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_5 ON tblBudgetDetailProject_5.Id = tblBudgetDetailProjectArea_5.BudgetDetailProjectId INNER JOIN
                         tblCoding AS tblCoding_5 ON TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id INNER JOIN
                         TblCodingsMapSazman AS TblCodingsMapSazman_1 ON tblCoding_5.Id = TblCodingsMapSazman_1.CodingId AND tblBudgetDetailProjectArea_5.AreaId = TblCodingsMapSazman_1.AreaId ON 
                         tblSanadDetail_MD_1.CodeVasetShahrdari = TblCodingsMapSazman_1.CodeVasetShahrdari AND tblSanadDetail_MD_1.AreaId = TblCodingsMapSazman_1.AreaId
WHERE        (TblBudgets_5.TblYearId = @YearId) AND (TblCodingsMapSazman_1.CodeVasetShahrdari IS NOT NULL) AND (tblCoding_5.TblBudgetProcessId = @budgetProcessId) AND (TblCodingsMapSazman_1.YearId = @YearId) AND 
                         (tblSanadDetail_MD_1.YearName = @YearName) AND (tblBudgetDetailProjectArea_5.AreaId = @AreaId) AND (TblCodingsMapSazman_1.AreaId = @AreaId) AND (tblSanadDetail_MD_1.AreaId = @AreaId) AND 
                         (tblSanad_MD_1.AreaId = @AreaId) AND (tblSanad_MD_1.YearName = @YearName)) AS tbl1
       GROUP BY CodingId, Month) AS der_month ON TblBudgetDetails.tblCodingId = der_month.CodingId
WHERE  (tblCoding.TblBudgetProcessId = @budgetProcessId) AND
       (TblBudgets.TblYearId = @YearId) AND
	   (tblBudgetDetailProjectArea.AreaId = @AreaId)
return
end

if(@StructureId = 2)
begin
SELECT        tblCoding.Id, tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, der_month.Month, der_month.Expense
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id LEFT OUTER JOIN
                             (SELECT        CodingId, Month, SUM(Expense) AS Expense
                               FROM            (SELECT        TblBudgetDetails_5.tblCodingId AS CodingId, abs(tblSanadDetail_MD_1.Bestankar - tblSanadDetail_MD_1.Bedehkar) AS Expense, 
							                           CASE WHEN tblSanad_MD_1.SanadDateS >= '1402/01/01' AND tblSanad_MD_1.SanadDateS <= '1402/01/31' THEN 1 
													        WHEN tblSanad_MD_1.SanadDateS >= '1402/02/01' AND tblSanad_MD_1.SanadDateS <= '1402/02/31' THEN 2 
															WHEN tblSanad_MD_1.SanadDateS >= '1402/03/01' AND tblSanad_MD_1.SanadDateS <= '1402/03/31' THEN 3 
															WHEN tblSanad_MD_1.SanadDateS >= '1402/04/01' AND tblSanad_MD_1.SanadDateS <= '1402/04/31' THEN 4 
															WHEN tblSanad_MD_1.SanadDateS >= '1402/05/01' AND tblSanad_MD_1.SanadDateS <= '1402/05/31' THEN 5 
															WHEN tblSanad_MD_1.SanadDateS >= '1402/06/01' AND tblSanad_MD_1.SanadDateS <= '1402/06/31' THEN 6 
															WHEN tblSanad_MD_1.SanadDateS >= '1402/07/01' AND tblSanad_MD_1.SanadDateS <= '1402/07/30' THEN 7 
															WHEN tblSanad_MD_1.SanadDateS >= '1402/08/01' AND tblSanad_MD_1.SanadDateS <= '1402/08/30' THEN 8 
															WHEN tblSanad_MD_1.SanadDateS >= '1402/09/01' AND tblSanad_MD_1.SanadDateS <= '1402/09/30' THEN 9 
															WHEN tblSanad_MD_1.SanadDateS >= '1402/10/01' AND tblSanad_MD_1.SanadDateS <= '1402/10/30' THEN 10 
															WHEN tblSanad_MD_1.SanadDateS >= '1402/11/01' AND tblSanad_MD_1.SanadDateS <= '1402/11/30' THEN 11 
															WHEN tblSanad_MD_1.SanadDateS >= '1402/12/01' AND tblSanad_MD_1.SanadDateS <= '1402/12/30' THEN 12 
															ELSE 0 END AS Month
                                                         FROM            TblBudgetDetails AS TblBudgetDetails_5 INNER JOIN
                                                                                   TblBudgets AS TblBudgets_5 ON TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND 
                                                                                   TblBudgetDetails_5.BudgetId = TblBudgets_5.Id INNER JOIN
                                                                                   tblBudgetDetailProject AS tblBudgetDetailProject_5 ON TblBudgetDetails_5.Id = tblBudgetDetailProject_5.BudgetDetailId INNER JOIN
                                                                                   tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_5 ON tblBudgetDetailProject_5.Id = tblBudgetDetailProjectArea_5.BudgetDetailProjectId INNER JOIN
                                                                                   tblCoding AS tblCoding_5 ON TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id INNER JOIN
                                                                                   TblCodingsMapSazman AS TblCodingsMapSazman_1 ON tblCoding_5.Id = TblCodingsMapSazman_1.CodingId AND tblBudgetDetailProjectArea_5.AreaId = TblCodingsMapSazman_1.AreaId INNER JOIN
                                                                                   olden.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON TblCodingsMapSazman_1.CodeAcc = tblSanadDetail_MD_1.CodeVasetSazman INNER JOIN
                                                                                   olden.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.AreaId = tblSanad_MD_1.AreaId AND 
                                                                                   tblSanadDetail_MD_1.YearName = tblSanad_MD_1.YearName
                                                         WHERE  (TblBudgets_5.TblYearId = @YearId) AND
														        (TblCodingsMapSazman_1.CodeAcc IS NOT NULL) AND
																(tblCoding_5.TblBudgetProcessId = @budgetProcessId) AND
																(TblCodingsMapSazman_1.YearId = @YearId) AND 
                                                                (tblSanadDetail_MD_1.YearName = @YearName) AND
																(tblBudgetDetailProjectArea_5.AreaId = @AreaId) AND
																(TblCodingsMapSazman_1.AreaId = @AreaId) AND
																(tblSanadDetail_MD_1.AreaId = @AreaId) AND 
                                                                (tblSanad_MD_1.AreaId = @AreaId) AND
																(tblSanad_MD_1.YearName = @YearName)) AS tbl1
                               GROUP BY CodingId, Month) AS der_month ON TblBudgetDetails.tblCodingId = der_month.CodingId
WHERE  (tblCoding.TblBudgetProcessId = @budgetProcessId) AND
       (TblBudgets.TblYearId = @YearId) AND
	   (tblBudgetDetailProjectArea.AreaId = @AreaId)
return
end


END
GO
