USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP500_TestBudget1402]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP500_TestBudget1402]

AS
BEGIN
--مقایسه دو جدول detail  and budgetdetailProject
SELECT        tblCoding.Code, tblCoding.Description, TblBudgetDetails.MosavabPublic,
derivedtbl_1.Mosavabproject, TblBudgetDetails.MosavabPublic - derivedtbl_1.Mosavabproject AS Expr1
FROM            TblBudgetDetails INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id LEFT OUTER JOIN
                             (SELECT        BudgetDetailId, SUM(Mosavab) AS Mosavabproject
                               FROM            tblBudgetDetailProject AS tblBudgetDetailProject_1
                               GROUP BY BudgetDetailId) AS derivedtbl_1 ON TblBudgetDetails.Id = derivedtbl_1.BudgetDetailId
WHERE        (tblCoding.TblBudgetProcessId IN (2)) AND (TblBudgets.TblYearId = 33) --AND (TblBudgets.TblAreaId = 10)
and isnull(TblBudgetDetails.MosavabPublic,0) - isnull(derivedtbl_1.Mosavabproject,0)<>0
--==========================
--مقایسه دو جدول detailproject  and detailprojectArea
SELECT        tblCoding.Code, tblCoding.Description, tblBudgetDetailProject.Mosavab, derivedtbl_1.MosavabArea
FROM            tblBudgetDetailProject INNER JOIN
                         TblBudgetDetails ON tblBudgetDetailProject.BudgetDetailId = TblBudgetDetails.Id INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id LEFT OUTER JOIN
                             (SELECT        BudgetDetailProjectId, SUM(Mosavab) AS MosavabArea
                               FROM            tblBudgetDetailProjectArea
                               GROUP BY BudgetDetailProjectId) AS derivedtbl_1 ON tblBudgetDetailProject.Id = derivedtbl_1.BudgetDetailProjectId
WHERE        (tblCoding.TblBudgetProcessId IN (3)) AND (TblBudgets.TblYearId = 33) --AND (TblBudgets.TblAreaId = 10)
and isnull(tblBudgetDetailProject.Mosavab,0)- isnull(derivedtbl_1.MosavabArea,0)<>0
ORDER BY tblCoding.Code


declare @Hcode nvarchar(30)='121207'

SELECT        CAST(tblBudgetDetailProject.Id AS nvarchar(10)) + ',' AS Id ,
 TblBudgetDetails.Id  as BudgetDetailsId, 
tblBudgetDetailProject.Mosavab, tblCoding.Code, tblCoding.Description, 
                         TblBudgetDetails.MosavabPublic, TblBudgets.TblAreaId
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id LEFT OUTER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId
WHERE        (TblBudgets.TblYearId = 33) AND (tblCoding.Code = @Hcode) AND (tblCoding.TblBudgetProcessId = 2)


--update tblBudgetDetailProject
--set BudgetDetailId = 12975
--		where id in (SELECT  tblBudgetDetailProject.Id  
--						FROM            TblBudgets INNER JOIN
--													TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--													tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id LEFT OUTER JOIN
--													tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId
--						WHERE (TblBudgets.TblYearId = 33) AND
--						      (tblCoding.Code = @Hcode) AND
--							  (tblCoding.TblBudgetProcessId = 2))


END
GO
