USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_0]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_0]
@BudgetProcessId int =3,
@yearId int =33
AS
BEGIN
-- ردیف هائی که به اشتباه در اصلاح کاهش یافته است
SELECT        tblBudgetDetailProjectArea.AreaId, tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea AS Edit, ISNULL(der_Supply.CreditAmount, 0) AS supply, 
                         tblBudgetDetailProjectArea.Expense
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.AreaId, TblBudgetDetails_1.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            tblRequestBudget INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblRequestBudget.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea_1.id INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject_1.Id INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON tblBudgetDetailProject_1.BudgetDetailId = TblBudgetDetails_1.Id INNER JOIN
                                                         TblBudgets AS TblBudgets_1 ON TblBudgetDetails_1.BudgetId = TblBudgets_1.Id INNER JOIN
                                                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id
                               WHERE        (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND (TblBudgets_1.TblYearId = @yearId) AND (tblBudgetDetailProjectArea_1.AreaId IN (1, 2, 3, 4, 5, 6, 7, 8, 9))
                               GROUP BY tblBudgetDetailProjectArea_1.AreaId, TblBudgetDetails_1.tblCodingId) AS der_Supply ON tblBudgetDetailProjectArea.AreaId = der_Supply.AreaId AND TblBudgetDetails.tblCodingId = der_Supply.tblCodingId
WHERE        (TblBudgets.TblYearId = @yearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (tblBudgetDetailProjectArea.AreaId IN (1, 2, 3, 4, 5, 6, 7, 8, 9)) AND 
                         (tblBudgetDetailProjectArea.EditArea < ISNULL(der_Supply.CreditAmount, 0) OR
						  tblBudgetDetailProjectArea.EditArea < tblBudgetDetailProjectArea.Expense)
					
ORDER BY tblBudgetDetailProjectArea.AreaId, tblCoding.Code

-- ردیف هائی که هیچ تامین اعتبار و هزینه ای در آن نیست و کاهش  وافزایش نداشته است
SELECT        tblBudgetDetailProjectArea.AreaId, tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea AS Edit, ISNULL(der_Supply.CreditAmount, 0) AS supply, 
                         tblBudgetDetailProjectArea.Expense
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.AreaId, TblBudgetDetails_1.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            tblRequestBudget INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblRequestBudget.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea_1.id INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject_1.Id INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON tblBudgetDetailProject_1.BudgetDetailId = TblBudgetDetails_1.Id INNER JOIN
                                                         TblBudgets AS TblBudgets_1 ON TblBudgetDetails_1.BudgetId = TblBudgets_1.Id INNER JOIN
                                                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id
                               WHERE        (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND (TblBudgets_1.TblYearId = @yearId) AND (tblBudgetDetailProjectArea_1.AreaId IN (1, 2, 3, 4, 5, 6, 7, 8, 9))
                               GROUP BY tblBudgetDetailProjectArea_1.AreaId, TblBudgetDetails_1.tblCodingId) AS der_Supply ON tblBudgetDetailProjectArea.AreaId = der_Supply.AreaId AND TblBudgetDetails.tblCodingId = der_Supply.tblCodingId
WHERE        (TblBudgets.TblYearId = @yearId) AND
(tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
(tblBudgetDetailProjectArea.AreaId IN (1, 2, 3, 4, 5, 6, 7, 8, 9)) AND 
ISNULL(der_Supply.CreditAmount, 0)=0 AND
(tblBudgetDetailProjectArea.Expense)=0AND
(tblBudgetDetailProjectArea.EditArea=tblBudgetDetailProjectArea.Mosavab )AND	
(tblBudgetDetailProjectArea.EditArea>0) AND 
(tblBudgetDetailProjectArea.Mosavab >0)	
ORDER BY tblBudgetDetailProjectArea.Mosavab desc


--ردیف های حذف شده
SELECT        tblBudgetDetailProjectArea.AreaId, tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea AS Edit, ISNULL(der_Supply.CreditAmount, 0) AS supply, 
                         tblBudgetDetailProjectArea.Expense
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.AreaId, TblBudgetDetails_1.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            tblRequestBudget INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblRequestBudget.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea_1.id INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject_1.Id INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON tblBudgetDetailProject_1.BudgetDetailId = TblBudgetDetails_1.Id INNER JOIN
                                                         TblBudgets AS TblBudgets_1 ON TblBudgetDetails_1.BudgetId = TblBudgets_1.Id INNER JOIN
                                                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id
                               WHERE        (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND (TblBudgets_1.TblYearId = @yearId) AND (tblBudgetDetailProjectArea_1.AreaId IN (1, 2, 3, 4, 5, 6, 7, 8, 9))
                               GROUP BY tblBudgetDetailProjectArea_1.AreaId, TblBudgetDetails_1.tblCodingId) AS der_Supply ON tblBudgetDetailProjectArea.AreaId = der_Supply.AreaId AND TblBudgetDetails.tblCodingId = der_Supply.tblCodingId
WHERE        (TblBudgets.TblYearId = 33) AND (tblCoding.TblBudgetProcessId = 3) AND
(tblBudgetDetailProjectArea.AreaId IN (1, 2, 3, 4, 5, 6, 7, 8, 9)) AND (tblBudgetDetailProjectArea.Mosavab <> 0) AND 
                         (tblBudgetDetailProjectArea.EditArea = 0)
ORDER BY  tblBudgetDetailProjectArea.Mosavab DESC

---ردیف های اضافه شده
SELECT        tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.AreaId, der_Supply.CreditAmount, tblBudgetDetailProject.Expense
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id LEFT OUTER JOIN
                             (SELECT        TblBudgetDetails_1.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            tblRequestBudget INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblRequestBudget.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea_1.id INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject_1.Id INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON tblBudgetDetailProject_1.BudgetDetailId = TblBudgetDetails_1.Id INNER JOIN
                                                         TblBudgets AS TblBudgets_1 ON TblBudgetDetails_1.BudgetId = TblBudgets_1.Id INNER JOIN
                                                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id
                               WHERE        (tblCoding_1.TblBudgetProcessId = 3) AND (TblBudgets_1.TblYearId = 33) AND (tblBudgetDetailProjectArea_1.AreaId = 1)
                               GROUP BY TblBudgetDetails_1.tblCodingId) AS der_Supply ON TblBudgetDetails.tblCodingId = der_Supply.tblCodingId
WHERE        (TblBudgets.TblYearId = 33) AND (tblCoding.TblBudgetProcessId = 3) AND
(tblBudgetDetailProjectArea.AreaId IN (1, 2, 3, 4, 5, 6, 7, 8, 9)) AND (tblBudgetDetailProjectArea.Mosavab = 0) AND 
                         (tblBudgetDetailProjectArea.EditArea <> 0)
ORDER BY tblBudgetDetailProjectArea.EditArea DESC

--==========











END
GO
