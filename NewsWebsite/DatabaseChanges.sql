USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_Budget]    Script Date: 11/11/2024 9:38:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP001_Budget]
@YearId int , 
@AreaId int ,
@BudgetProcessId int
AS
BEGIN


declare @s int=1
if(@AreaId = 10)
begin
SELECT        tbl2.CodingId, tblCoding_4.Code, tblCoding_4.Description,tbl2.Pishnahadi,tbl2.Mosavab,tbl2.Edit,tblCoding_4.levelNumber , tbl2.Expense ,
              tblCoding_4.Show,tblCoding_4.Crud,tblCoding_4.MotherId,isnull(tbl2.CreditAmount,0) as CreditAmount
FROM            (SELECT        CodingId, SUM(Pishnahadi) AS Pishnahadi, SUM(Mosavab) AS Mosavab ,Sum(Edit) as Edit, sum(Expense) as Expense , sum(CreditAmount) as CreditAmount
                 FROM            (
-------------------------------------------------------------------------------------------------------

--سطح اول
                                     SELECT        tblCoding_5.MotherId AS CodingId, ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     SELECT        tblCoding_4.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     SELECT        tblCoding_1.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     SELECT        tblCoding_3.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     SELECT        tblCoding_2.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     SELECT        tblCoding_3.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     SELECT        TblBudgetDetails_1.tblCodingId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
--where  tblCoding_4.Show = 1

ORDER BY tblCoding_4.Code
    return
end

if(@AreaId = 37)
begin
SELECT        tbl2.CodingId, tblCoding_4.Code, tblCoding_4.Description,tbl2.Pishnahadi,tbl2.Mosavab,tbl2.Edit,tblCoding_4.levelNumber , tbl2.Expense ,
              tblCoding_4.Show,tblCoding_4.Crud,tblCoding_4.MotherId,isnull(tbl2.CreditAmount,0) as CreditAmount
FROM            (SELECT        CodingId, SUM(Pishnahadi) AS Pishnahadi, SUM(Mosavab) AS Mosavab ,Sum(Edit) as Edit, sum(Expense) as Expense , sum(CreditAmount) as CreditAmount
                 FROM            (
-------------------------------------------------------------------------------------------------------

--سطح اول
                                     SELECT        tblCoding_5.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     SELECT        tblCoding_4.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     SELECT        tblCoding_1.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     SELECT        tblCoding_3.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     SELECT        tblCoding_2.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     SELECT        tblCoding_3.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     SELECT        TblBudgetDetails_1.tblCodingId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
--where  tblCoding_4.Show = 1

ORDER BY tblCoding_4.Code
    return
end

if(@AreaId not in (10,30,31,32,33,34,35,36,37))
begin
SELECT        tbl2.CodingId, tblCoding_4.Code, tblCoding_4.Description,tbl2.Pishnahadi,tbl2.Mosavab,tbl2.Edit,tblCoding_4.levelNumber , tbl2.Expense ,
              tblCoding_4.Show,tblCoding_4.Crud,tblCoding_4.MotherId,isnull(tbl2.CreditAmount,0) as CreditAmount
FROM            (SELECT        CodingId, SUM(Pishnahadi) AS Pishnahadi, SUM(Mosavab) AS Mosavab ,Sum(Edit) as Edit, sum(Expense) as Expense , sum(CreditAmount) as CreditAmount
                 FROM            (
-------------------------------------------------------------------------------------------------------

--سطح اول
                                     SELECT        tblCoding_5.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (tblBudgetDetailProjectArea.AreaId = @AreaId)
                                     UNION ALL


--	--سطح 2					   
                                     SELECT        tblCoding_4.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)AND (tblBudgetDetailProjectArea.AreaId = @AreaId)

                                     UNION ALL

--سطح 3
                                     SELECT        tblCoding_1.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)AND (tblBudgetDetailProjectArea.AreaId = @AreaId)
                                     UNION ALL

--		 --سطح 4
                                     SELECT        tblCoding_3.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)AND (tblBudgetDetailProjectArea.AreaId = @AreaId)
                                     UNION ALL
--سطح 5
                                     SELECT        tblCoding_2.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)AND (tblBudgetDetailProjectArea.AreaId = @AreaId)
                                     UNION ALL

--سطح 6
                                     SELECT        tblCoding_3.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     WHERE        (TblBudgets_2.TblYearId = @YearId) AND (tblCoding_3.TblBudgetProcessId = @BudgetProcessId)AND (tblBudgetDetailProjectArea.AreaId = @AreaId)
                                     UNION ALL

--سطح 7
                                     SELECT        TblBudgetDetails_1.tblCodingId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND (tblBudgetDetailProjectArea.AreaId = @AreaId)
                                 ) AS tbl1
                 GROUP BY CodingId
                 having CodingId is not null
                ) AS tbl2 INNER JOIN
                tblCoding AS tblCoding_4 ON tbl2.CodingId = tblCoding_4.Id
--where  tblCoding_4.Show = 1

ORDER BY tblCoding_4.Code
    return
END

if(@AreaId  in (30,31,32,33,34,35,36))
begin

declare @Execute tinyint 
if(@AreaId=30) begin set @Execute = 4  end -- معاونت شهر سازی
if(@AreaId=31) begin set @Execute = 10 end -- معاونت فنی عمرانی
if(@AreaId=32) begin set @Execute = 2  end --معاونت حمل و نقل 
if(@AreaId=33) begin set @Execute = 1  end --معاونت خدمات شهری
if(@AreaId=34) begin set @Execute = 3  end --معاونت فرهنگی
if(@AreaId=35) begin set @Execute =  7 end --معاونت مالی اقتصادی
if(@AreaId=36) begin set @Execute = 6  end --معاونت برنامه ریزی

SELECT        tbl2.CodingId, tblCoding_4.Code, tblCoding_4.Description,tbl2.Pishnahadi,tbl2.Mosavab,tbl2.Edit,tblCoding_4.levelNumber , tbl2.Expense ,
              tblCoding_4.Show,tblCoding_4.Crud,tblCoding_4.MotherId,isnull(tbl2.CreditAmount,0) as CreditAmount
FROM            (SELECT        CodingId, SUM(Pishnahadi) AS Pishnahadi, SUM(Mosavab) AS Mosavab ,Sum(Edit) as Edit, sum(Expense) as Expense , sum(CreditAmount) as CreditAmount
                 FROM            (
-------------------------------------------------------------------------------------------------------

--سطح اول
                                     SELECT        tblCoding_5.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
                                         (tblBudgetDetailProjectArea.AreaId = 9) AND
                                         (tblCoding.ExecuteId = @Execute)
                                     UNION ALL


--	--سطح 2					   
                                     SELECT        tblCoding_4.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId)AND
                                         (tblBudgetDetailProjectArea.AreaId  = 9) AND
                                         (tblCoding.ExecuteId = @Execute)

                                     UNION ALL

--سطح 3
                                     SELECT        tblCoding_1.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId)AND
                                         (tblBudgetDetailProjectArea.AreaId = 9) AND
                                         (tblCoding.ExecuteId = @Execute)
                                     UNION ALL

--		 --سطح 4
                                     SELECT        tblCoding_3.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId)AND
                                         (tblBudgetDetailProjectArea.AreaId = 9) AND
                                         (tblCoding.ExecuteId = @Execute)
                                     UNION ALL
--سطح 5
                                     SELECT        tblCoding_2.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId)AND
                                         (tblBudgetDetailProjectArea.AreaId = 9) AND
                                         (tblCoding.ExecuteId = @Execute)
                                     UNION ALL

--سطح 6
                                     SELECT        tblCoding_3.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     WHERE        (TblBudgets_2.TblYearId = @YearId) AND
                                         (tblCoding_3.TblBudgetProcessId = @BudgetProcessId)AND
                                         (tblBudgetDetailProjectArea.AreaId = 9) AND
                                         (tblCoding_3.ExecuteId = @Execute)
                                     UNION ALL

--سطح 7
                                     SELECT        TblBudgetDetails_1.tblCodingId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
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
                                     WHERE        (TblBudgets_1.TblYearId = @YearId) AND
                                         (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND
                                         (tblBudgetDetailProjectArea.AreaId = 9) AND
                                         (tblCoding_1.ExecuteId = @Execute)
                                 ) AS tbl1
                 GROUP BY CodingId
                 having CodingId is not null
                ) AS tbl2 INNER JOIN
                tblCoding AS tblCoding_4 ON tbl2.CodingId = tblCoding_4.Id
--where  tblCoding_4.Show = 1

ORDER BY tblCoding_4.Code
    return
END

END




-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------




USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetCodingInfoModal_Read]    Script Date: 11/11/2024 9:40:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP001_BudgetCodingInfoModal_Read]
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


-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------




USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal3Area_Read]    Script Date: 11/11/2024 9:45:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP001_BudgetModal3Area_Read]
@yearId int ,
@areaPublicId int,
@areaId int ,
@projectId int,
@codingId int
AS
BEGIN

SELECT        tblBudgetDetailProjectArea.id, TblAreas.AreaNameShort as AreaName, tblBudgetDetailProjectArea.Pishnahadi, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense,
              TblProgramOperations.TblAreaId
FROM            TblBudgets INNER JOIN
                TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id INNER JOIN
                TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id INNER JOIN
                TblProgramOperationDetails AS TblProgramOperationDetails_1 ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails_1.Id INNER JOIN
                TblProgramOperations ON TblProgramOperationDetails_1.TblProgramOperationId = TblProgramOperations.Id
WHERE  (TblBudgets.TblYearId = @yearId) AND
  -- (TblBudgets.TblAreaId = @areaPublicId) AND
    (TblProgramOperationDetails.TblProjectId = @projectId) AND
    (TblBudgetDetails.tblCodingId = @codingId) AND
    (TblProgramOperations.TblAreaId = @areaId)


END


-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------




USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal3Area_Update]    Script Date: 11/11/2024 11:15:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP001_BudgetModal3Area_Update]
@Id int,
@Pishnahadi bigint,
@Mosavab bigint,
@EditArea bigint
AS
BEGIN
 declare @BudgetNext bigint = @Mosavab
 declare @YearId int =(SELECT   top(1)     TblBudgets.TblYearId
								FROM            TblBudgets INNER JOIN
														 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
														 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
														 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
								WHERE        (tblBudgetDetailProjectArea.id = @Id))



declare @AreaId int =(SELECT   top(1)   tblBudgetDetailProjectArea.AreaId
								FROM    TblBudgets INNER JOIN
									   	TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
										tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
										tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
								WHERE  (tblBudgetDetailProjectArea.id = @Id))

declare @CodingId int =(SELECT   top(1)   TblBudgetDetails.tblCodingId
								FROM    TblBudgets INNER JOIN
									   	TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
										tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
										tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
								WHERE  (tblBudgetDetailProjectArea.id = @Id))


declare @BudgetProcessId int = (select TblBudgetProcessId from tblCoding where id = @CodingId)



 declare @MosavabAgo bigint =(SELECT   Mosavab
								FROM      tblBudgetDetailProjectArea
								WHERE     (id = @Id))

declare @Revenue bigint = (SELECT    sum(tblBudgetDetailProjectArea.Mosavab)
								FROM  TblBudgets INNER JOIN
									  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
								WHERE  (TblBudgets.TblYearId = @yearId) AND
								       (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
									   (tblCoding.TblBudgetProcessId = 1))
 --declare @Revenue bigint 
 --if(@AreaId = 1) begin set @Revenue =  4600000000000  end
 --if(@AreaId = 2) begin set @Revenue =  12000000000000 end
 --if(@AreaId = 3) begin set @Revenue =  7300000000000  end
 --if(@AreaId = 4) begin set @Revenue =  6000000000000  end
 --if(@AreaId = 5) begin set @Revenue =  3000000000000  end
 --if(@AreaId = 6) begin set @Revenue =  1842000000000  end
 --if(@AreaId = 7) begin set @Revenue =  4000000000000  end
 --if(@AreaId = 8) begin set @Revenue =  5200000000000  end
   

declare @Current bigint = (SELECT   sum(tblBudgetDetailProjectArea.Mosavab)
								FROM  TblBudgets INNER JOIN
									  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
							   WHERE (TblBudgets.TblYearId = @yearId) AND
							         (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
									 (tblCoding.TblBudgetProcessId = 2))  
   
 

 --if(@AreaId = 1) begin set @Current =  4600000000000  end
 --if(@AreaId = 2) begin set @Current =  4250000000000  end
 --if(@AreaId = 3) begin set @Current =  3740000000000  end
 --if(@AreaId = 4) begin set @Current =  3015000000000  end
 --if(@AreaId = 5) begin set @Current =  2420000000000  end
 --if(@AreaId = 6) begin set @Current =  2680000000000  end
 --if(@AreaId = 7) begin set @Current =  2750000000000  end
 --if(@AreaId = 8) begin set @Current =  2750000000000  end 
  

 

declare @Civil bigint = (SELECT    sum(tblBudgetDetailProjectArea.Mosavab)
							FROM   TblBudgets INNER JOIN
								   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
								   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
								   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
								   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
					       WHERE  (TblBudgets.TblYearId = @yearId) AND
						          (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
								  (tblCoding.TblBudgetProcessId = 3))   
   
declare @Motomarkez bigint = (SELECT   sum(tblBudgetDetailProjectArea.Mosavab)
								FROM   TblBudgets INNER JOIN
									   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
								WHERE (TblBudgets.TblYearId = @yearId) AND
									  (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
									  (tblCoding.TblBudgetProcessId = 8))     
   
   
declare @Komak bigint = (SELECT  sum(tblBudgetDetailProjectArea.Mosavab)
								FROM   TblBudgets INNER JOIN
									   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
								WHERE (TblBudgets.TblYearId = @yearId) AND
									  (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
									  (tblCoding.TblBudgetProcessId = 10))     
   
   


declare @Balance bigint = isnull(@Revenue,0) - isnull(@Current,0) - isnull(@Civil,0) - isnull(@Motomarkez,0) + isnull(@Komak,0) + isnull(@MosavabAgo,0)-isnull(@BudgetNext,0)

--if(@AreaId <=8 AND @Balance<0 AND @BudgetProcessId=3 and @Mosavab>@MosavabAgo and @YearId=34)
--begin
--   select ' به مبلغ '+dbo.seprator(cast(@Balance as nvarchar(100)))+' منفی می شود ' as Message_DB
--	return
--end

--===============کنترل بودجه معاونت ها
 	declare @ExecuteId int =(SELECT     tblCoding.ExecuteId
									FROM   TblBudgets INNER JOIN
										   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
										   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
										   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
										   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
									WHERE (tblBudgetDetailProjectArea.id = @Id))
if(@AreaId = 9)
begin  
	declare @CivilExecute bigint
	if(@ExecuteId = 4 ) begin set @CivilExecute = 650000000000   end-- شهر سازی
	if(@ExecuteId = 10) begin set @CivilExecute = 15000000000000 end-- معاونت فنی عمرانی
	if(@ExecuteId = 2)  begin set @CivilExecute = 6800000000000  end -- حمل و نقل و ترافیک
	if(@ExecuteId = 1)  begin set @CivilExecute = 3200000000000  end--خدمات شهری
	if(@ExecuteId = 3)  begin set @CivilExecute = 1190000000000  end -- فرهنگی
	if(@ExecuteId = 7)  begin set @CivilExecute =       0        end -- مالی اقتصادی
	if(@ExecuteId = 6)  begin set @CivilExecute =       0        end--برنامه ریزی


select @Civil = (SELECT  SUM(tblBudgetDetailProjectArea.Mosavab) AS Expr1
                 FROM TblBudgets INNER JOIN
                      TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                      tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                      tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                      tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                 WHERE (TblBudgets.TblYearId = @yearId) AND
                     (tblBudgetDetailProjectArea.AreaId = 9) AND
                     (tblCoding.TblBudgetProcessId = 3) AND
                     (tblCoding.ExecuteId = @ExecuteId))

declare  @Balance2 bigint  = @CivilExecute - isnull(@Civil,0) + isnull(@MosavabAgo,0)-isnull(@BudgetNext,0)
--if(@Balance2<0 AND @Mosavab>@MosavabAgo and @YearId = 34)
--begin
-- select ' به مبلغ '+dbo.seprator(cast(@Balance2 as nvarchar(100)))+' منفی می شود ' as Message_DB
--return
--end

end




 DECLARE @areaShare Bigint;
 DECLARE @currentPishnahadi Bigint;
 DECLARE @currentMosavab Bigint;
 DECLARE @currentEdit Bigint;
 DECLARE @sql NVARCHAR(MAX);

 SET @sql = N'SELECT TOP(1) @areaShare = ShareProcessId' + CAST(@budgetProcessId AS NVARCHAR(10)) + ' FROM tblBudgetAreaShare WHERE AreaId = '+CAST(@areaId AS NVARCHAR(10))+' AND YearId = '+CAST(@yearId AS NVARCHAR(10))+';';

-- Execute dynamic SQL and retrieve the value into @areaShare
EXEC sp_executesql @sql, N'@areaShare INT OUTPUT', @areaShare OUTPUT;



 SET @currentPishnahadi= (select Pishnahadi from tblBudgetDetailProjectArea where id = @Id)
--  SET @currentMosavab= (select Mosavab from tblBudgetDetailProjectArea where id = @Id)
--  SET @currentEdit= (select EditArea from tblBudgetDetailProjectArea where id = @Id)

 declare @currentSumPishnahadi Bigint =(SELECT  sum(tblBudgetDetailProjectArea.Pishnahadi)
                           FROM     TblBudgets INNER JOIN
                                    TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                    tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                    tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                    tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                           WHERE   (tblCoding.TblBudgetProcessId = @budgetProcessId) AND
                               (TblBudgets.TblYearId =@yearId) AND
                               (tblBudgetDetailProjectArea.AreaId =@AreaId))

--  declare @currentSumMosavab Bigint =(SELECT  sum(tblBudgetDetailProjectArea.Mosavab)
--                            FROM     TblBudgets INNER JOIN
--                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
--                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
--                            WHERE   (tblCoding.TblBudgetProcessId = @budgetProcessId) AND
--                                (TblBudgets.TblYearId =@yearId) AND
--                                (tblBudgetDetailProjectArea.AreaId =@AreaId))
-- 
--  declare @currentSumEdit Bigint =(SELECT  sum(tblBudgetDetailProjectArea.EditArea)
--                            FROM     TblBudgets INNER JOIN
--                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
--                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
--                            WHERE   (tblCoding.TblBudgetProcessId = @budgetProcessId) AND
--                                (TblBudgets.TblYearId =@yearId) AND
--                                (tblBudgetDetailProjectArea.AreaId =@AreaId))

 if(@areaShare is not null and @areaShare<@currentSumPishnahadi-@currentPishnahadi+@Pishnahadi)
begin
select CONCAT('خطا بودجه پیشنهادی - سهم منطقه ',@areaShare,' ریال می باشد و تنها',(@areaShare-@currentSumPishnahadi),'ریال آزاد می باشد') as Message_DB
    return
end
     
--  if(@areaShare is not null and @areaShare<@currentSumMosavab-@currentMosavab+@Mosavab)
--      begin
--          select CONCAT('خطا بودجه مصوب - سهم منطقه ',@areaShare,' ریال می باشد و تنها',(@areaShare-@currentSumMosavab),'ریال آزاد می باشد') as Message_DB
--          return
--      end
--      
--      

--  if(@areaShare is not null and @areaShare<@currentSumEdit-@currentEdit+@EditArea)
--      begin
--          select CONCAT('خطا بودجه پیشنهادی - سهم منطقه ',@areaShare,' ریال می باشد و تنها',(@areaShare-@currentSumEdit),'ریال آزاد می باشد') as Message_DB
--          return
--      end
     
     
--if(@YearId in (33,34))
--begin
update tblBudgetDetailProjectArea
set Pishnahadi = @Pishnahadi,
    Mosavab = @Mosavab,
    EditArea = @EditArea
where id = @Id
--return
--end



--if(@YearId Not in (33,34))
--begin
--      update tblBudgetDetailProjectArea
--	   set --Mosavab = @Mosavab,
--		  --EditArea = @EditArea,
--		  Expense = @Mosavab
--		  where id = @Id
--END



END


