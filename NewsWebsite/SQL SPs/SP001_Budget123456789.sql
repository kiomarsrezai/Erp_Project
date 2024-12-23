USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_Budget123456789]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_Budget123456789]
@YearId int , 
@AreaId int ,
@BudgetProcessId int

AS
BEGIN
declare @s int=1
if(@AreaId = 1)
begin
SELECT        tbl2.CodingId, tblCoding_4.Code, tblCoding_4.Description,tbl2.Mosavab,tbl2.Edit,tblCoding_4.levelNumber , tbl2.Expense , 
tblCoding_4.Show,tblCoding_4.Crud,tblCoding_4.MotherId,isnull(tbl2.CreditAmount,0) as CreditAmount
FROM            (SELECT        CodingId, SUM(Mosavab) AS Mosavab ,Sum(Edit) as Edit, sum(Expense) as Expense , sum(CreditAmount) as CreditAmount
                           FROM            (
-------------------------------------------------------------------------------------------------------

--سطح اول
SELECT        tblCoding_5.MotherId AS CodingId, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense, 
                         ISNULL(der_Supply.CreditAmount, 0) AS CreditAmount
FROM            tblCoding AS tblCoding_2 INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                         tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                         tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                         tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                         tblCoding AS tblCoding_5 ON tblCoding_4.MotherId = tblCoding_5.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT OUTER JOIN
                             (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                                FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                                WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                                GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas.StructureId = @s)
UNION ALL


--	--سطح 2					   
SELECT        tblCoding_4.MotherId AS CodingId, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense, 
                        ISNULL(der_Supply.CreditAmount,0) as CreditAmount
FROM            tblCoding AS tblCoding_2 INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                         tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                         tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                         tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT OUTER JOIN
                             (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                                FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                                WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                                GROUP BY  tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas.StructureId = @s)
 
 UNION ALL

--سطح 3
SELECT        tblCoding_1.MotherId AS CodingId, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense, 
                         der_Supply.CreditAmount
FROM            tblCoding AS tblCoding_2 INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                         tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                         tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT OUTER JOIN
                             (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                                FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                                WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                                GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas.StructureId = @s)
UNION ALL

--		 --سطح 4
SELECT        tblCoding_3.MotherId AS CodingId, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense, 
                         der_Supply.CreditAmount
FROM            tblCoding AS tblCoding_2 INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                         tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT OUTER JOIN
                             (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                                FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                                WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                                GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas.StructureId = @s)
UNION ALL
--سطح 5
SELECT        tblCoding_2.MotherId AS CodingId, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense, 
                         der_Supply.CreditAmount
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblCoding AS tblCoding_2 ON tblCoding.MotherId = tblCoding_2.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT OUTER JOIN
                             (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                                FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                                WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                                GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas.StructureId = @s)
 UNION ALL

--سطح 6
SELECT        tblCoding_3.MotherId AS CodingId, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense, 
                         der_Supply.CreditAmount
FROM            TblBudgets AS TblBudgets_2 INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_2 ON TblBudgets_2.Id = TblBudgetDetails_2.BudgetId INNER JOIN
                         tblCoding AS tblCoding_3 ON TblBudgetDetails_2.tblCodingId = tblCoding_3.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails_2.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT OUTER JOIN
                             (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                                FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                                WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                                GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
WHERE        (TblBudgets_2.TblYearId = @YearId) AND (tblCoding_3.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas.StructureId = @s)
UNION ALL

--سطح 7
SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense, 
                         der_Supply.CreditAmount
FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails_1.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT OUTER JOIN
                             (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                                FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                                WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                                GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas.StructureId = @s)		 
) AS tbl1
                           GROUP BY CodingId
						   having CodingId is not null
						   ) AS tbl2 INNER JOIN
                         tblCoding AS tblCoding_4 ON tbl2.CodingId = tblCoding_4.Id
where  tblCoding_4.Show = 1

ORDER BY tblCoding_4.Code
return
end

if(@AreaId = 10)
begin
SELECT        tbl2.CodingId, tblCoding_4.Code, tblCoding_4.Description,tbl2.Mosavab,tbl2.Edit,tblCoding_4.levelNumber , tbl2.Expense , 
tblCoding_4.Show,tblCoding_4.Crud,tblCoding_4.MotherId,isnull(tbl2.CreditAmount,0) as CreditAmount
FROM            (SELECT        CodingId, SUM(Mosavab) AS Mosavab ,Sum(Edit) as Edit, sum(Expense) as Expense , sum(CreditAmount) as CreditAmount
                           FROM            (
-------------------------------------------------------------------------------------------------------

--سطح اول
SELECT        tblCoding_5.MotherId AS CodingId, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense, 
                         ISNULL(der_Supply.CreditAmount, 0) AS CreditAmount
FROM            tblCoding AS tblCoding_2 INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                         tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                         tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                         tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                         tblCoding AS tblCoding_5 ON tblCoding_4.MotherId = tblCoding_5.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId LEFT OUTER JOIN
                             (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                               WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                               GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)
UNION ALL


--	--سطح 2					   
SELECT        tblCoding_4.MotherId AS CodingId, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense, 
                         ISNULL(der_Supply.CreditAmount, 0) AS CreditAmount
FROM            tblCoding AS tblCoding_2 INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                         tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                         tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                         tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId LEFT OUTER JOIN
                             (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                               WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                               GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)
 UNION ALL

--سطح 3
SELECT        tblCoding_1.MotherId AS CodingId, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense, 
                         der_Supply.CreditAmount
FROM            tblCoding AS tblCoding_2 INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                         tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                         tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId LEFT OUTER JOIN
                             (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                               WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                               GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)
UNION ALL

--		 --سطح 4
SELECT        tblCoding_3.MotherId AS CodingId, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense, 
                         der_Supply.CreditAmount
FROM            tblCoding AS tblCoding_2 INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                         tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId LEFT OUTER JOIN
                             (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                               WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                               GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)
UNION ALL
--سطح 5
SELECT        tblCoding_2.MotherId AS CodingId, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense, 
                         der_Supply.CreditAmount
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblCoding AS tblCoding_2 ON tblCoding.MotherId = tblCoding_2.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId LEFT OUTER JOIN
                             (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                               WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                               GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)
 UNION ALL

--سطح 6
SELECT        tblCoding_3.MotherId AS CodingId, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense, 
                         der_Supply.CreditAmount
FROM            TblBudgets AS TblBudgets_2 INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_2 ON TblBudgets_2.Id = TblBudgetDetails_2.BudgetId INNER JOIN
                         tblCoding AS tblCoding_3 ON TblBudgetDetails_2.tblCodingId = tblCoding_3.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails_2.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId LEFT OUTER JOIN
                             (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                               WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                               GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
WHERE        (TblBudgets_2.TblYearId = @YearId) AND (tblCoding_3.TblBudgetProcessId = @BudgetProcessId)
UNION ALL

--سطح 7
SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense, 
                         der_Supply.CreditAmount
FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails_1.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId LEFT OUTER JOIN
                             (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                         TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                               WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                               GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_1.TblBudgetProcessId = @BudgetProcessId)	 


) AS tbl1
                           GROUP BY CodingId
						   having CodingId is not null
						   ) AS tbl2 INNER JOIN
                         tblCoding AS tblCoding_4 ON tbl2.CodingId = tblCoding_4.Id
where  tblCoding_4.Show = 1

ORDER BY tblCoding_4.Code
return
end



END
GO
