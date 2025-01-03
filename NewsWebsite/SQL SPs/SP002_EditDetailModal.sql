USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_EditDetailModal]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_EditDetailModal]
@yearId int , 
@areaId int ,
@budgetProcessId int,
@CodingId int
AS
BEGIN
if(@areaId = 10)
begin
SELECT        tbl2.CodingId, tbl2.AreaId, TblAreas_2.AreaNameShort AS AreaName, tblCoding.Code, tblCoding.Description, tbl2.Mosavab, tbl2.EditArea AS Edit, tbl2.Supply, tbl2.Expense, tblCoding.levelNumber, tbl2.NeedEditYearNow
FROM            (SELECT        CodingId, AreaId, SUM(Mosavab) AS Mosavab, SUM(EditArea) AS EditArea, SUM(Supply) AS Supply, SUM(Expense) AS Expense, SUM(NeedEditYearNow) AS NeedEditYearNow
                          FROM            (SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, 
                                                                              tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.NeedEditYearNow
                                                    FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                                              TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                                              tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                                              tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                              TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                                    WHERE   (TblBudgets_1.TblYearId = @yearId) AND
													        (TblAreas.StructureId = 1) AND
															(TblBudgetDetails_1.tblCodingId = @CodingId)
                                                    UNION ALL
                                                    SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, 
                                                                             tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.NeedEditYearNow
                                                    FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                                             TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                                             tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                                             tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                                             tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                             TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                                    WHERE   (TblBudgets_1.TblYearId = @yearId) AND
													        (TblAreas.StructureId = 1) AND
															(tblCoding_1.MotherId = @CodingId)) AS tbl1
                          GROUP BY CodingId, AreaId) AS tbl2 INNER JOIN
                         tblCoding ON tbl2.CodingId = tblCoding.Id INNER JOIN
                         TblAreas AS TblAreas_2 ON tbl2.AreaId = TblAreas_2.Id
ORDER BY tbl2.AreaId, tbl2.CodingId
end

if(@areaId in (1,2,3,4,5,6,7,8,9))
begin
SELECT        tbl2.CodingId, tbl2.AreaId, TblAreas_2.AreaNameShort AS AreaName, tblCoding.Code, tblCoding.Description, tbl2.Mosavab, tbl2.EditArea AS Edit, tbl2.Supply, tbl2.Expense, tblCoding.levelNumber, tbl2.NeedEditYearNow
FROM            (SELECT        CodingId, AreaId, SUM(Mosavab) AS Mosavab, SUM(EditArea) AS EditArea, SUM(Supply) AS Supply, SUM(Expense) AS Expense, SUM(NeedEditYearNow) AS NeedEditYearNow
                          FROM            (SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, 
                         tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.NeedEditYearNow
FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
WHERE        (TblBudgets_1.TblYearId = @yearId) AND (TblBudgetDetails_1.tblCodingId = @CodingId) AND (tblBudgetDetailProjectArea.AreaId = @areaId)
                                                    UNION ALL
                                           SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, 
                         tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.NeedEditYearNow
FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
WHERE        (TblBudgets_1.TblYearId = @yearId) AND  (tblCoding_1.MotherId = @CodingId) AND (tblBudgetDetailProjectArea.AreaId = @areaId)) AS tbl1
                          GROUP BY CodingId, AreaId) AS tbl2 INNER JOIN
                         tblCoding ON tbl2.CodingId = tblCoding.Id INNER JOIN
                         TblAreas AS TblAreas_2 ON tbl2.AreaId = TblAreas_2.Id
ORDER BY tbl2.AreaId, tbl2.CodingId
end
END
GO
