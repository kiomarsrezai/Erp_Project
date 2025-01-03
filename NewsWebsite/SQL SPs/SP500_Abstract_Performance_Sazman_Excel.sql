USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP500_Abstract_Performance_Sazman_Excel]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP500_Abstract_Performance_Sazman_Excel]
@yearId int , 
@areaId int ,
@budgetProcessId int,
@MonthId tinyint
AS
BEGIN
declare @YearName nvarchar(10) =cast((select YearName from TblYears where id = @YearId)as nvarchar(10))
declare @MonthName nvarchar(10)

if(@MonthId =1)  begin set @MonthName='01' end
if(@MonthId =2)  begin set @MonthName='02' end
if(@MonthId =3)  begin set @MonthName='03' end
if(@MonthId =4)  begin set @MonthName='04' end
if(@MonthId =5)  begin set @MonthName='05' end
if(@MonthId =6)  begin set @MonthName='06' end
if(@MonthId =7)  begin set @MonthName='07' end
if(@MonthId =8)  begin set @MonthName='08' end
if(@MonthId =9)  begin set @MonthName='09' end
if(@MonthId =10) begin set @MonthName='10' end
if(@MonthId =11) begin set @MonthName='11' end
if(@MonthId =12) begin set @MonthName='12' end

declare @Datestart nvarchar(10)=@YearName+'/'+'01/01'
declare @DateEnd nvarchar(10)
if(@MonthId<=6)	                begin  set @DateEnd = @YearName+'/'+@MonthName+'/31' end
if(@MonthId in (7,8,9,10,11))	begin  set @DateEnd = @YearName+'/'+@MonthName+'/31' end
if(@MonthId =12)	            begin  set @DateEnd = @YearName+'/'+@MonthName+'/29' end

SELECT        tbl2.CodingId, tblCoding_4.Code , tblCoding_4.Description,tbl2.Mosavab,tbl2.Edit,tbl2.CreditAmount

,tblCoding_4.levelNumber ,tbl2.ExpenseMonth

FROM            (SELECT        CodingId, isnull(SUM(Mosavab),0) AS Mosavab, isnull(SUM(EditArea),0) AS Edit , 
isnull(sum(CreditAmount),0) as CreditAmount,
isnull(sum(ExpenseMonth),0) as ExpenseMonth

                           FROM            (

--سطح اول
SELECT        tblCoding_5.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, der_Supply.CreditAmount, der_PerformanceMonth.ExpenseMonth
FROM            tblCoding AS tblCoding_2 INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                         tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                         tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                         tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                         tblCoding AS tblCoding_5 ON tblCoding_4.MotherId = tblCoding_5.Id INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId LEFT OUTER JOIN
                             (
				 SELECT        CodingId, SUM(ExpenseMonth) AS ExpenseMonth
                               FROM            (SELECT        TblBudgetDetails_5.tblCodingId AS CodingId, CASE WHEN tblCoding_5.TblBudgetProcessId IN (1, 9) THEN olden.tblSanadDetail_MD.Bestankar - olden.tblSanadDetail_MD.Bedehkar WHEN tblCoding_5.TblBudgetProcessId IN (2,
                          3, 4, 5) THEN olden.tblSanadDetail_MD.Bedehkar - olden.tblSanadDetail_MD.Bestankar ELSE 0 END AS ExpenseMonth
FROM            olden.tblSanad_MD INNER JOIN
                         olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId AND 
                         olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_5 INNER JOIN
                         TblBudgets AS TblBudgets_5 ON TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id INNER JOIN
                         tblBudgetDetailProject AS tblBudgetDetailProject_5 ON TblBudgetDetails_5.Id = tblBudgetDetailProject_5.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_5 ON tblBudgetDetailProject_5.Id = tblBudgetDetailProjectArea_5.BudgetDetailProjectId INNER JOIN
                         tblCoding AS tblCoding_5 ON TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding_5.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.AreaId = TblCodingsMapSazman.AreaId AND 
                         olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc
WHERE     (TblBudgets_5.TblYearId = @yearId) AND
          (tblBudgetDetailProjectArea_5.AreaId = @areaId) AND
		  (TblCodingsMapSazman.YearId = @yearId) AND
		  (olden.tblSanadDetail_MD.YearName = @YearName) AND 
          (olden.tblSanad_MD.SanadDateS BETWEEN @Datestart AND @DateEnd) AND
		  (TblCodingsMapSazman.CodeAcc IS NOT NULL) AND
		  (olden.tblSanad_MD.YearName = @YearName) AND 
          (olden.tblSanad_MD.AreaId = @areaId) AND
		  (olden.tblSanadDetail_MD.AreaId = @areaId) AND
		  (olden.tblSanad_MD.YearName = @YearName) AND
		  (olden.tblSanadDetail_MD.YearName = @YearName) AND 
          (TblCodingsMapSazman.AreaId = @areaId) AND
		  (tblCoding_5.TblBudgetProcessId = @budgetProcessId)) AS tbl1
                               GROUP BY CodingId
							   ) AS der_PerformanceMonth ON TblBudgetDetails.tblCodingId = der_PerformanceMonth.CodingId LEFT OUTER JOIN
                             (SELECT        TblBudgetDetails_1.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         tblRequest ON tblRequestBudget.RequestId = tblRequest.Id
                               WHERE  (TblBudgets_1.TblYearId = @YearId) AND
							          (tblBudgetDetailProjectArea_1.AreaId = @AreaId) AND
									  (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND
									  (tblRequest.DateS BETWEEN @Datestart AND @DateEnd)
                               GROUP BY TblBudgetDetails_1.tblCodingId) AS der_Supply ON TblBudgetDetails.tblCodingId = der_Supply.tblCodingId
WHERE  (TblBudgets.TblYearId = @YearId) AND
       (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
	   (tblCoding.TblBudgetProcessId = @BudgetProcessId)
UNION ALL

--	--سطح 2					   
SELECT        tblCoding_4.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, der_Supply.CreditAmount, der_PerformanceMonth.ExpenseMonth
FROM            tblCoding AS tblCoding_2 INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                         tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                         tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                         tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId LEFT OUTER JOIN
                             (
							 SELECT        CodingId, SUM(ExpenseMonth) AS ExpenseMonth
                               FROM            (SELECT        TblBudgetDetails_5.tblCodingId AS CodingId, CASE WHEN tblCoding_5.TblBudgetProcessId IN (1, 9) THEN olden.tblSanadDetail_MD.Bestankar - olden.tblSanadDetail_MD.Bedehkar WHEN tblCoding_5.TblBudgetProcessId IN (2,
                          3, 4, 5) THEN olden.tblSanadDetail_MD.Bedehkar - olden.tblSanadDetail_MD.Bestankar ELSE 0 END AS ExpenseMonth
FROM            olden.tblSanad_MD INNER JOIN
                         olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId AND 
                         olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_5 INNER JOIN
                         TblBudgets AS TblBudgets_5 ON TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id INNER JOIN
                         tblBudgetDetailProject AS tblBudgetDetailProject_5 ON TblBudgetDetails_5.Id = tblBudgetDetailProject_5.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_5 ON tblBudgetDetailProject_5.Id = tblBudgetDetailProjectArea_5.BudgetDetailProjectId INNER JOIN
                         tblCoding AS tblCoding_5 ON TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding_5.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.AreaId = TblCodingsMapSazman.AreaId AND 
                         olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc
WHERE  (TblBudgets_5.TblYearId = @yearId) AND
       (tblBudgetDetailProjectArea_5.AreaId = @areaId) AND
	   (TblCodingsMapSazman.YearId = @yearId) AND
	   (olden.tblSanadDetail_MD.YearName = @YearName) AND 
       (olden.tblSanad_MD.SanadDateS BETWEEN @Datestart AND @DateEnd) AND
	   (TblCodingsMapSazman.CodeAcc IS NOT NULL) AND
	   (olden.tblSanad_MD.YearName = @YearName) AND
	   (olden.tblSanad_MD.AreaId = @areaId) AND
	   (olden.tblSanadDetail_MD.AreaId = @areaId) AND
	   (olden.tblSanad_MD.YearName = @YearName) AND
	   (olden.tblSanadDetail_MD.YearName = @YearName) AND
	   (tblCoding_5.TblBudgetProcessId = @budgetProcessId) AND
    -- (TblCodingsMapSazman.YearName = @YearName) AND
	   (TblCodingsMapSazman.AreaId = @areaId)) AS tbl1
                               GROUP BY CodingId
							   ) AS der_PerformanceMonth ON TblBudgetDetails.tblCodingId = der_PerformanceMonth.CodingId LEFT OUTER JOIN
                             (SELECT        TblBudgetDetails_1.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_5 ON TblBudgetDetails_1.tblCodingId = tblCoding_5.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         tblRequest ON tblRequestBudget.RequestId = tblRequest.Id
                               WHERE  (TblBudgets_1.TblYearId = @YearId) AND
							          (tblBudgetDetailProjectArea_1.AreaId = @AreaId) AND
									  (tblCoding_5.TblBudgetProcessId = @BudgetProcessId) AND
									  (tblRequest.DateS BETWEEN @Datestart AND @DateEnd)
                               GROUP BY TblBudgetDetails_1.tblCodingId) AS der_Supply ON TblBudgetDetails.tblCodingId = der_Supply.tblCodingId
WHERE  (TblBudgets.TblYearId = @YearId) AND
       (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
       (tblCoding.TblBudgetProcessId = @BudgetProcessId)
UNION ALL

----سطح 3
SELECT        tblCoding_1.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, der_Supply.CreditAmount, der_PerformanceMonth.ExpenseMonth
FROM            tblCoding AS tblCoding_2 INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                         tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                         tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId LEFT OUTER JOIN
                             (
							 SELECT        CodingId, SUM(ExpenseMonth) AS ExpenseMonth
                               FROM            (SELECT        TblBudgetDetails_5.tblCodingId AS CodingId, CASE WHEN tblCoding_5.TblBudgetProcessId IN (1, 9) THEN olden.tblSanadDetail_MD.Bestankar - olden.tblSanadDetail_MD.Bedehkar WHEN tblCoding_5.TblBudgetProcessId IN (2,
                          3, 4, 5) THEN olden.tblSanadDetail_MD.Bedehkar - olden.tblSanadDetail_MD.Bestankar ELSE 0 END AS ExpenseMonth
FROM            olden.tblSanad_MD INNER JOIN
                         olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId AND 
                         olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_5 INNER JOIN
                         TblBudgets AS TblBudgets_5 ON TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id INNER JOIN
                         tblBudgetDetailProject AS tblBudgetDetailProject_5 ON TblBudgetDetails_5.Id = tblBudgetDetailProject_5.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_5 ON tblBudgetDetailProject_5.Id = tblBudgetDetailProjectArea_5.BudgetDetailProjectId INNER JOIN
                         tblCoding AS tblCoding_5 ON TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding_5.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.AreaId = TblCodingsMapSazman.AreaId AND 
                         olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc
WHERE (TblBudgets_5.TblYearId = @yearId) AND
      (tblBudgetDetailProjectArea_5.AreaId = @areaId) AND
	  (TblCodingsMapSazman.YearId = @yearId) AND
	  (olden.tblSanadDetail_MD.YearName = @YearName) AND 
      (olden.tblSanad_MD.SanadDateS BETWEEN @Datestart AND @DateEnd) AND
	  (TblCodingsMapSazman.CodeAcc IS NOT NULL) AND
	  (olden.tblSanad_MD.YearName = @YearName) AND
	  (olden.tblSanad_MD.AreaId = @areaId) AND
	  (olden.tblSanadDetail_MD.AreaId = @areaId) AND
	  (olden.tblSanad_MD.YearName = @YearName) AND
	  (olden.tblSanadDetail_MD.YearName = @YearName) AND
	  (tblCoding_5.TblBudgetProcessId = @budgetProcessId) AND
   -- (TblCodingsMapSazman.YearName = @YearName) AND
	  (TblCodingsMapSazman.AreaId = @areaId)) AS tbl1
                               GROUP BY CodingId
							   ) AS der_PerformanceMonth ON TblBudgetDetails.tblCodingId = der_PerformanceMonth.CodingId LEFT OUTER JOIN
                             (SELECT        TblBudgetDetails_1.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_4 ON TblBudgetDetails_1.tblCodingId = tblCoding_4.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         tblRequest ON tblRequestBudget.RequestId = tblRequest.Id
                               WHERE  (TblBudgets_1.TblYearId = @YearId) AND
							          (tblBudgetDetailProjectArea_1.AreaId = @AreaId) AND
									  (tblCoding_4.TblBudgetProcessId = @BudgetProcessId) AND
									  (tblRequest.DateS BETWEEN @Datestart AND @DateEnd)
                               GROUP BY TblBudgetDetails_1.tblCodingId) AS der_Supply ON TblBudgetDetails.tblCodingId = der_Supply.tblCodingId
WHERE        (TblBudgets.TblYearId = @YearId) AND
(tblBudgetDetailProjectArea.AreaId = @AreaId) AND
(tblCoding.TblBudgetProcessId = @BudgetProcessId)
UNION ALL
--سطح 4
SELECT        tblCoding_3.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, der_Supply.CreditAmount, der_PerformanceMonth.ExpenseMonth
FROM            tblCoding AS tblCoding_2 INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                         tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId LEFT OUTER JOIN
                             (
							 SELECT        CodingId, SUM(ExpenseMonth) AS ExpenseMonth
                               FROM            (SELECT        TblBudgetDetails_5.tblCodingId AS CodingId, CASE WHEN tblCoding_5.TblBudgetProcessId IN (1, 9) THEN olden.tblSanadDetail_MD.Bestankar - olden.tblSanadDetail_MD.Bedehkar WHEN tblCoding_5.TblBudgetProcessId IN (2,
                          3, 4, 5) THEN olden.tblSanadDetail_MD.Bedehkar - olden.tblSanadDetail_MD.Bestankar ELSE 0 END AS ExpenseMonth
FROM            olden.tblSanad_MD INNER JOIN
                         olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId AND 
                         olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_5 INNER JOIN
                         TblBudgets AS TblBudgets_5 ON TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id INNER JOIN
                         tblBudgetDetailProject AS tblBudgetDetailProject_5 ON TblBudgetDetails_5.Id = tblBudgetDetailProject_5.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_5 ON tblBudgetDetailProject_5.Id = tblBudgetDetailProjectArea_5.BudgetDetailProjectId INNER JOIN
                         tblCoding AS tblCoding_5 ON TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding_5.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.AreaId = TblCodingsMapSazman.AreaId AND 
                         olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc
WHERE   (TblBudgets_5.TblYearId = @yearId) AND
        (tblBudgetDetailProjectArea_5.AreaId = @areaId) AND
		(TblCodingsMapSazman.YearId = @yearId) AND
		(olden.tblSanadDetail_MD.YearName = @YearName) AND 
        (olden.tblSanad_MD.SanadDateS BETWEEN @Datestart AND @DateEnd) AND
		(TblCodingsMapSazman.CodeAcc IS NOT NULL) AND
		(olden.tblSanad_MD.YearName = @YearName) AND
		(olden.tblSanad_MD.AreaId = @areaId) AND
		(olden.tblSanadDetail_MD.AreaId = @areaId) AND
		(olden.tblSanad_MD.YearName = @YearName) AND
		(olden.tblSanadDetail_MD.YearName = @YearName) AND
		(tblCoding_5.TblBudgetProcessId = @budgetProcessId) AND
        (TblCodingsMapSazman.AreaId = @areaId)) AS tbl1
                               GROUP BY CodingId
							   ) AS der_PerformanceMonth ON TblBudgetDetails.tblCodingId = der_PerformanceMonth.CodingId LEFT OUTER JOIN
                             (SELECT        TblBudgetDetails_1.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         tblRequest ON tblRequestBudget.RequestId = tblRequest.Id
                               WHERE   (TblBudgets_1.TblYearId = @YearId) AND
							           (tblBudgetDetailProjectArea_1.AreaId = @AreaId) AND
									   (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND
									   (tblRequest.DateS BETWEEN @Datestart AND @DateEnd)
                               GROUP BY TblBudgetDetails_1.tblCodingId) AS der_Supply ON TblBudgetDetails.tblCodingId = der_Supply.tblCodingId
WHERE  (TblBudgets.TblYearId = @YearId) AND
       (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
       (tblCoding.TblBudgetProcessId = @BudgetProcessId)
UNION ALL
--سطح 5
SELECT        tblCoding_2.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea,der_Supply.CreditAmount, der_PerformanceMonth.ExpenseMonth
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblCoding AS tblCoding_2 ON tblCoding.MotherId = tblCoding_2.Id INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId LEFT OUTER JOIN
                             (
							 SELECT        CodingId, SUM(ExpenseMonth) AS ExpenseMonth
                               FROM            (SELECT        TblBudgetDetails_5.tblCodingId AS CodingId, CASE WHEN tblCoding_5.TblBudgetProcessId IN (1, 9) THEN olden.tblSanadDetail_MD.Bestankar - olden.tblSanadDetail_MD.Bedehkar WHEN tblCoding_5.TblBudgetProcessId IN (2,
                          3, 4, 5) THEN olden.tblSanadDetail_MD.Bedehkar - olden.tblSanadDetail_MD.Bestankar ELSE 0 END AS ExpenseMonth
FROM            olden.tblSanad_MD INNER JOIN
                         olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId AND 
                         olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_5 INNER JOIN
                         TblBudgets AS TblBudgets_5 ON TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id INNER JOIN
                         tblBudgetDetailProject AS tblBudgetDetailProject_5 ON TblBudgetDetails_5.Id = tblBudgetDetailProject_5.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_5 ON tblBudgetDetailProject_5.Id = tblBudgetDetailProjectArea_5.BudgetDetailProjectId INNER JOIN
                         tblCoding AS tblCoding_5 ON TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding_5.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.AreaId = TblCodingsMapSazman.AreaId AND 
                         olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc
WHERE   (TblBudgets_5.TblYearId = @yearId) AND
        (tblBudgetDetailProjectArea_5.AreaId = @areaId) AND
		(TblCodingsMapSazman.YearId = @yearId) AND
		(olden.tblSanadDetail_MD.YearName = @YearName) AND 
        (olden.tblSanad_MD.SanadDateS BETWEEN @Datestart AND @DateEnd) AND
		(TblCodingsMapSazman.CodeAcc IS NOT NULL) AND
		(olden.tblSanad_MD.YearName = @YearName) AND
		(olden.tblSanad_MD.AreaId = @areaId) AND
		(olden.tblSanadDetail_MD.AreaId = @areaId) AND
		(olden.tblSanad_MD.YearName = @YearName) AND
		(olden.tblSanadDetail_MD.YearName = @YearName) AND
		(tblCoding_5.TblBudgetProcessId = @budgetProcessId) AND
        (TblCodingsMapSazman.AreaId = @areaId)) AS tbl1
                               GROUP BY CodingId
							   ) AS der_PerformanceMonth ON TblBudgetDetails.tblCodingId = der_PerformanceMonth.CodingId LEFT OUTER JOIN
                             (SELECT        TblBudgetDetails_1.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         tblRequest ON tblRequestBudget.RequestId = tblRequest.Id
                               WHERE  (TblBudgets_1.TblYearId = @YearId) AND
							          (tblBudgetDetailProjectArea_1.AreaId = @AreaId) AND
									  (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND
									  (tblRequest.DateS BETWEEN @Datestart AND @DateEnd)
                               GROUP BY TblBudgetDetails_1.tblCodingId) AS der_Supply ON TblBudgetDetails.tblCodingId = der_Supply.tblCodingId
WHERE    (TblBudgets.TblYearId = @YearId) AND
         (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
		 (tblCoding.TblBudgetProcessId = @BudgetProcessId)

UNION ALL
--سطح 6
SELECT        tblCoding_3.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, der_Supply.CreditAmount, der_PerformanceMonth.ExpenseMonth
FROM            TblBudgets AS TblBudgets_2 INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_2 ON TblBudgets_2.Id = TblBudgetDetails_2.BudgetId INNER JOIN
                         tblCoding AS tblCoding_3 ON TblBudgetDetails_2.tblCodingId = tblCoding_3.Id INNER JOIN
                         tblBudgetDetailProject AS tblBudgetDetailProject_2 ON TblBudgetDetails_2.Id = tblBudgetDetailProject_2.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId LEFT OUTER JOIN
                             (
							 SELECT        CodingId, SUM(ExpenseMonth) AS ExpenseMonth
                               FROM            (SELECT        TblBudgetDetails_5.tblCodingId AS CodingId, CASE WHEN tblCoding_5.TblBudgetProcessId IN (1, 9) THEN olden.tblSanadDetail_MD.Bestankar - olden.tblSanadDetail_MD.Bedehkar WHEN tblCoding_5.TblBudgetProcessId IN (2,
                          3, 4, 5) THEN olden.tblSanadDetail_MD.Bedehkar - olden.tblSanadDetail_MD.Bestankar ELSE 0 END AS ExpenseMonth
FROM            olden.tblSanad_MD INNER JOIN
                         olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId AND 
                         olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_5 INNER JOIN
                         TblBudgets AS TblBudgets_5 ON TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id INNER JOIN
                         tblBudgetDetailProject AS tblBudgetDetailProject_5 ON TblBudgetDetails_5.Id = tblBudgetDetailProject_5.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_5 ON tblBudgetDetailProject_5.Id = tblBudgetDetailProjectArea_5.BudgetDetailProjectId INNER JOIN
                         tblCoding AS tblCoding_5 ON TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding_5.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.AreaId = TblCodingsMapSazman.AreaId AND 
                         olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc
WHERE   (TblBudgets_5.TblYearId = @yearId) AND
        (tblBudgetDetailProjectArea_5.AreaId = @areaId) AND
		(TblCodingsMapSazman.YearId = @yearId) AND
		(olden.tblSanadDetail_MD.YearName = @YearName) AND 
        (olden.tblSanad_MD.SanadDateS BETWEEN @Datestart AND @DateEnd) AND
		(TblCodingsMapSazman.CodeAcc IS NOT NULL) AND
		(olden.tblSanad_MD.YearName = @YearName) AND
		(olden.tblSanad_MD.AreaId = @areaId)AND
		(olden.tblSanadDetail_MD.AreaId = @areaId) AND
		(olden.tblSanad_MD.YearName = @YearName) AND
		(olden.tblSanadDetail_MD.YearName = @YearName) AND
		(tblCoding_5.TblBudgetProcessId = @budgetProcessId) AND
        (TblCodingsMapSazman.AreaId = @areaId)) AS tbl1
                               GROUP BY CodingId
     					   ) AS der_PerformanceMonth ON TblBudgetDetails_2.tblCodingId = der_PerformanceMonth.CodingId LEFT OUTER JOIN
                             (SELECT        TblBudgetDetails.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         tblRequest ON tblRequestBudget.RequestId = tblRequest.Id
                               WHERE (TblBudgets.TblYearId = @YearId) AND
							         (tblBudgetDetailProjectArea_1.AreaId = @AreaId) AND
									 (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
									 (tblRequest.DateS BETWEEN @Datestart AND @DateEnd)
                               GROUP BY TblBudgetDetails.tblCodingId) AS der_Supply ON TblBudgetDetails_2.tblCodingId = der_Supply.tblCodingId
WHERE   (TblBudgets_2.TblYearId = @YearId) AND
        (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
		(tblCoding_3.TblBudgetProcessId = @BudgetProcessId)

UNION ALL
--سطح 7
SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea,  der_Supply.CreditAmount, 
                         der_PerformanceMonth.ExpenseMonth
FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId LEFT OUTER JOIN
                             (
 						 SELECT        CodingId, SUM(ExpenseMonth) AS ExpenseMonth
                               FROM            (SELECT        TblBudgetDetails_5.tblCodingId AS CodingId, CASE WHEN tblCoding_5.TblBudgetProcessId IN (1, 9) THEN olden.tblSanadDetail_MD.Bestankar - olden.tblSanadDetail_MD.Bedehkar WHEN tblCoding_5.TblBudgetProcessId IN (2,
                          3, 4, 5) THEN olden.tblSanadDetail_MD.Bedehkar - olden.tblSanadDetail_MD.Bestankar ELSE 0 END AS ExpenseMonth
FROM            olden.tblSanad_MD INNER JOIN
                         olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId AND 
                         olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_5 INNER JOIN
                         TblBudgets AS TblBudgets_5 ON TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id INNER JOIN
                         tblBudgetDetailProject AS tblBudgetDetailProject_5 ON TblBudgetDetails_5.Id = tblBudgetDetailProject_5.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_5 ON tblBudgetDetailProject_5.Id = tblBudgetDetailProjectArea_5.BudgetDetailProjectId INNER JOIN
                         tblCoding AS tblCoding_5 ON TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding_5.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.AreaId = TblCodingsMapSazman.AreaId AND 
                         olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc
WHERE   (TblBudgets_5.TblYearId = @yearId) AND
        (tblBudgetDetailProjectArea_5.AreaId = @areaId) AND
		(TblCodingsMapSazman.YearId = @yearId) AND
		(olden.tblSanadDetail_MD.YearName = @YearName) AND 
        (olden.tblSanad_MD.SanadDateS BETWEEN @Datestart AND @DateEnd) AND
		(TblCodingsMapSazman.CodeAcc IS NOT NULL) AND
		(olden.tblSanad_MD.YearName = @YearName) AND
		(olden.tblSanad_MD.AreaId = @areaId)AND
		(olden.tblSanadDetail_MD.AreaId = @areaId) AND
		(olden.tblSanad_MD.YearName = @YearName) AND
		(olden.tblSanadDetail_MD.YearName = @YearName) AND
		(tblCoding_5.TblBudgetProcessId = @budgetProcessId) AND
        (TblCodingsMapSazman.AreaId = @areaId)) AS tbl1
                               GROUP BY CodingId
							   ) AS der_PerformanceMonth ON TblBudgetDetails_1.tblCodingId = der_PerformanceMonth.CodingId LEFT OUTER JOIN
                             (SELECT        TblBudgetDetails.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         tblRequest ON tblRequestBudget.RequestId = tblRequest.Id
                               WHERE (TblBudgets.TblYearId = @YearId) AND
							         (tblBudgetDetailProjectArea_1.AreaId = @AreaId) AND
							         (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
									 (tblRequest.DateS BETWEEN @Datestart AND @DateEnd)
                               GROUP BY TblBudgetDetails.tblCodingId) AS der_Supply ON TblBudgetDetails_1.tblCodingId = der_Supply.tblCodingId
WHERE   (TblBudgets_1.TblYearId = @YearId) AND
        (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
		(tblCoding_1.TblBudgetProcessId = @BudgetProcessId)) AS tbl1
                           GROUP BY CodingId) AS tbl2 INNER JOIN
                         tblCoding AS tblCoding_4 ON tbl2.CodingId = tblCoding_4.Id
						 where tblCoding_4.Show = 1
ORDER BY  tblCoding_4.Code,tblCoding_4.levelNumber
END
GO
