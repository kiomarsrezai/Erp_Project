-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP004_BudgetProposal_Modal_Read]
    @yearId int,
    @areaId int,
    @budgetProcessId int,
    @CodingId int
AS
BEGIN
    if(@areaId = 10)
begin
SELECT        tbl2.CodingId, tbl2.AreaId, TblAreas_2.AreaNameShort AS AreaName, tblCoding.Code, tblCoding.Description, tbl2.Mosavab, tbl2.EditArea AS Edit, tbl2.Supply, tbl2.Expense, tbl2.BudgetNext, tblCoding.levelNumber
FROM            (SELECT        CodingId, AreaId, SUM(Mosavab) AS Mosavab, SUM(EditArea) AS EditArea, SUM(Supply) AS Supply, SUM(Expense) AS Expense, SUM(BudgetNext) AS BudgetNext
                 FROM            (SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense, 0 AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                  WHERE   (TblBudgets_1.TblYearId = @yearId - 1) AND
                                      (TblAreas.StructureId = 1) AND
                                      (TblBudgetDetails_1.tblCodingId = @CodingId)
                                  UNION ALL
                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense, 0 AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                  WHERE   (TblBudgets_1.TblYearId = @yearId - 1) AND
                                      (TblAreas.StructureId = 1) AND
                                      (tblCoding_1.MotherId = @CodingId)
                                  UNION ALL

                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId,0 as Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense,  tblBudgetDetailProjectArea.Pishnahadi AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                  WHERE   (TblBudgets_1.TblYearId = @yearId ) AND
                                      (TblAreas.StructureId = 1) AND
                                      (TblBudgetDetails_1.tblCodingId = @CodingId)


                                  union all



                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea_1.AreaId, 0 AS Mosavab, 0 AS EditArea, 0 AS supply, 0 AS Expense, tblBudgetDetailProjectArea_1.Mosavab AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                  TblAreas AS TblAreas_1 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_1.Id
                                  WHERE   (TblBudgets_1.TblYearId = @yearId) AND
                                      (TblAreas_1.StructureId = 1) AND
                                      (tblCoding_1.MotherId = @CodingId)) AS tbl1
                 GROUP BY CodingId, AreaId) AS tbl2 INNER JOIN
                tblCoding ON tbl2.CodingId = tblCoding.Id INNER JOIN
                TblAreas AS TblAreas_2 ON tbl2.AreaId = TblAreas_2.Id
ORDER BY tbl2.AreaId, tbl2.CodingId
end

    if(@areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29) )
begin
SELECT        tbl2.CodingId, tbl2.AreaId, TblAreas_2.AreaNameShort AS AreaName, tblCoding.Code, tblCoding.Description, tbl2.Mosavab, tbl2.EditArea AS Edit, tbl2.Supply, tbl2.Expense, tbl2.BudgetNext, tblCoding.levelNumber
FROM            (SELECT        CodingId, AreaId, SUM(Mosavab) AS Mosavab, SUM(EditArea) AS EditArea, SUM(Supply) AS Supply, SUM(Expense) AS Expense, SUM(BudgetNext) AS BudgetNext
                 FROM            (SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense, 0 AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
                                  WHERE   (TblBudgets_1.TblYearId = @yearId - 1) AND
                                      (TblBudgetDetails_1.tblCodingId = @CodingId) AND
                                      (tblBudgetDetailProjectArea.AreaId = @areaId)
                                  UNION ALL
                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense, 0 AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
                                  WHERE    (TblBudgets_1.TblYearId = @yearId - 1) AND
                                      (tblCoding_1.MotherId = @CodingId) AND
                                      (tblBudgetDetailProjectArea.AreaId = @areaId)
                                  UNION ALL
                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId,0 as Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense,  tblBudgetDetailProjectArea.Pishnahadi AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                  WHERE   (TblBudgets_1.TblYearId = @yearId ) AND
                                      (tblBudgetDetailProjectArea.AreaId = @areaId)AND
                                      (TblBudgetDetails_1.tblCodingId = @CodingId)
                                  union all
                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea_1.AreaId, 0 AS Mosavab, 0 AS EditArea, 0 AS supply, 0 AS Expense, tblBudgetDetailProjectArea_1.Pishnahadi AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId
                                  WHERE   (TblBudgets_1.TblYearId = @yearId) AND
                                      (tblCoding_1.MotherId = @CodingId) AND
                                      (tblBudgetDetailProjectArea_1.AreaId = @areaId)) AS tbl1
                 GROUP BY CodingId, AreaId) AS tbl2 INNER JOIN
                tblCoding ON tbl2.CodingId = tblCoding.Id INNER JOIN
                TblAreas AS TblAreas_2 ON tbl2.AreaId = TblAreas_2.Id
ORDER BY tbl2.AreaId, tbl2.CodingId
end

    if(@areaId in (30,31,32,33,34,35,36,42,43,44,53) )
begin
            declare @ExecuteId tinyint
            if(@areaId = 30) begin set @areaId=9  set @ExecuteId = 4  end
            if(@areaId = 31) begin set @areaId=9  set @ExecuteId = 10 end
            if(@areaId = 32) begin set @areaId=9  set @ExecuteId = 2  end
            if(@areaId = 33) begin set @areaId=9  set @ExecuteId = 1  end
            if(@areaId = 34) begin set @areaId=9  set @ExecuteId = 3  end
            if(@areaId = 35) begin set @areaId=9  set @ExecuteId = 7  end
            if(@areaId = 36) begin set @areaId=9  set @ExecuteId = 6  end
            if(@areaId = 42) begin set @areaId=9  set @ExecuteId = 12 end
            if(@areaId = 43) begin set @areaId=9  set @ExecuteId = 11 end
            if(@areaId = 44) begin set @areaId=9  set @ExecuteId = 13 end
            if(@areaId = 53) begin set @areaId=9  set @ExecuteId = 14 end

SELECT        tbl2.CodingId, tbl2.AreaId, TblAreas_2.AreaNameShort AS AreaName, tblCoding.Code, tblCoding.Description, tbl2.Mosavab, tbl2.EditArea AS Edit, tbl2.Supply, tbl2.Expense, tbl2.BudgetNext, tblCoding.levelNumber
FROM            (SELECT        CodingId, AreaId, SUM(Mosavab) AS Mosavab, SUM(EditArea) AS EditArea, SUM(Supply) AS Supply, SUM(Expense) AS Expense, SUM(BudgetNext) AS BudgetNext
                 FROM            (SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense, 0 AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  tblCoding ON TblBudgetDetails_1.tblCodingId = tblCoding.Id
                                  WHERE   (TblBudgets_1.TblYearId = @yearId - 1) AND
                                      (TblBudgetDetails_1.tblCodingId = @CodingId) AND
                                      (tblBudgetDetailProjectArea.AreaId = @areaId) AND
                                      (tblCoding.ExecuteId = @ExecuteId)
                                  UNION ALL
                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense, 0 AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
                                  WHERE   (TblBudgets_1.TblYearId = @yearId - 1) AND
                                      (tblCoding_1.MotherId = @CodingId) AND
                                      (tblBudgetDetailProjectArea.AreaId = @areaId) AND
                                      (tblCoding_1.ExecuteId = @ExecuteId)
                                  UNION ALL
                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, 0 as Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.Pishnahadi AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  tblCoding ON TblBudgetDetails_1.tblCodingId = tblCoding.Id
                                  WHERE   (TblBudgets_1.TblYearId = @yearId) AND
                                      (TblBudgetDetails_1.tblCodingId = @CodingId) AND
                                      (tblBudgetDetailProjectArea.AreaId = @areaId) AND
                                      (tblCoding.ExecuteId = @ExecuteId)
                                  UNION ALL
                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea_1.AreaId, 0 AS Mosavab, 0 AS EditArea, 0 AS supply, 0 AS Expense, tblBudgetDetailProjectArea_1.Pishnahadi AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId
                                  WHERE   (TblBudgets_1.TblYearId = @yearId) AND
                                      (tblCoding_1.MotherId = @CodingId) AND
                                      (tblBudgetDetailProjectArea_1.AreaId = @areaId) AND
                                      (tblCoding_1.ExecuteId = @ExecuteId)) AS tbl1
                 GROUP BY CodingId, AreaId) AS tbl2 INNER JOIN
                tblCoding ON tbl2.CodingId = tblCoding.Id INNER JOIN
                TblAreas AS TblAreas_2 ON tbl2.AreaId = TblAreas_2.Id
ORDER BY tbl2.AreaId, tbl2.CodingId
end

    if(@areaId =37)--کل شهرداری و ماده 54 و 84
begin
SELECT        tbl2.CodingId, tbl2.AreaId, TblAreas_2.AreaNameShort AS AreaName, tblCoding.Code, tblCoding.Description, tbl2.Mosavab, tbl2.EditArea AS Edit, tbl2.Supply, tbl2.Expense, tbl2.BudgetNext, tblCoding.levelNumber
FROM            (SELECT        CodingId, AreaId, SUM(Mosavab) AS Mosavab, SUM(EditArea) AS EditArea, SUM(Supply) AS Supply, SUM(Expense) AS Expense, SUM(BudgetNext) AS BudgetNext
                 FROM            (SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense, 0 AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
                                  WHERE    (TblBudgets_1.TblYearId = @yearId - 1) AND
                                      (TblBudgetDetails_1.tblCodingId = @CodingId)
                                  UNION ALL
                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense, 0 AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
                                  WHERE    (TblBudgets_1.TblYearId = @yearId - 1) AND
                                      (tblCoding_1.MotherId = @CodingId)
                                  UNION ALL
                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, 0 AS Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.Pishnahadi AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
                                  WHERE    (TblBudgets_1.TblYearId = @yearId) AND
                                      (TblBudgetDetails_1.tblCodingId = @CodingId)
                                  UNION ALL
                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea_1.AreaId, 0 AS Mosavab, 0 AS EditArea, 0 AS supply, 0 AS Expense, tblBudgetDetailProjectArea_1.Pishnahadi AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId
                                  WHERE    (TblBudgets_1.TblYearId = @yearId) AND
                                      (tblCoding_1.MotherId = @CodingId)) AS tbl1
                 GROUP BY CodingId, AreaId) AS tbl2 INNER JOIN
                tblCoding ON tbl2.CodingId = tblCoding.Id INNER JOIN
                TblAreas AS TblAreas_2 ON tbl2.AreaId = TblAreas_2.Id
ORDER BY tbl2.AreaId, tbl2.CodingId
end

    if(@areaId = 39)
begin
SELECT        tbl2.CodingId, tbl2.AreaId, TblAreas_2.AreaNameShort AS AreaName, tblCoding.Code, tblCoding.Description, tbl2.Mosavab, tbl2.EditArea AS Edit, tbl2.Supply, tbl2.Expense, tbl2.BudgetNext, tblCoding.levelNumber
FROM            (SELECT        CodingId, AreaId, SUM(Mosavab) AS Mosavab, SUM(EditArea) AS EditArea, SUM(Supply) AS Supply, SUM(Expense) AS Expense, SUM(BudgetNext) AS BudgetNext
                 FROM            (SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense, 0 AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                  WHERE   (TblBudgets_1.TblYearId = @yearId - 1) AND
                                      (TblAreas.StructureId = 2) AND
                                      (TblBudgetDetails_1.tblCodingId = @CodingId)
                                  UNION ALL
                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense, 0 AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                  WHERE   (TblBudgets_1.TblYearId = @yearId - 1) AND
                                      (TblAreas.StructureId = 2) AND
                                      (tblCoding_1.MotherId = @CodingId)
                                  UNION ALL

                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId,0 as Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense,  tblBudgetDetailProjectArea.Pishnahadi AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                  WHERE   (TblBudgets_1.TblYearId = @yearId ) AND
                                      (TblAreas.StructureId = 2) AND
                                      (TblBudgetDetails_1.tblCodingId = @CodingId)


                                  union all



                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea_1.AreaId, 0 AS Mosavab, 0 AS EditArea, 0 AS supply, 0 AS Expense, tblBudgetDetailProjectArea_1.Pishnahadi AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                  TblAreas AS TblAreas_1 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_1.Id
                                  WHERE   (TblBudgets_1.TblYearId = @yearId) AND
                                      (TblAreas_1.StructureId = 2) AND
                                      (tblCoding_1.MotherId = @CodingId)) AS tbl1
                 GROUP BY CodingId, AreaId) AS tbl2 INNER JOIN
                tblCoding ON tbl2.CodingId = tblCoding.Id INNER JOIN
                TblAreas AS TblAreas_2 ON tbl2.AreaId = TblAreas_2.Id
ORDER BY tbl2.AreaId, tbl2.CodingId
end

    if(@areaId = 40)
begin
SELECT        tbl2.CodingId, tbl2.AreaId, TblAreas_2.AreaNameShort AS AreaName, tblCoding.Code, tblCoding.Description, tbl2.Mosavab, tbl2.EditArea AS Edit, tbl2.Supply, tbl2.Expense, tbl2.BudgetNext, tblCoding.levelNumber
FROM            (SELECT        CodingId, AreaId, SUM(Mosavab) AS Mosavab, SUM(EditArea) AS EditArea, SUM(Supply) AS Supply, SUM(Expense) AS Expense, SUM(BudgetNext) AS BudgetNext
                 FROM            (SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense, 0 AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                  TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblAreasTogether.YearId=TblBudgets_1.TblYearId
                                  WHERE   (TblBudgets_1.TblYearId = @yearId - 1) AND
                                      (TblAreasTogether.ToGetherBudget = 10) AND
                                      (TblBudgetDetails_1.tblCodingId = @CodingId)
                                  UNION ALL
                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense, 0 AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                  TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblAreasTogether.YearId=TblBudgets_1.TblYearId
                                  WHERE   (TblBudgets_1.TblYearId = @yearId - 1) AND
                                      (TblAreasTogether.ToGetherBudget = 10) AND
                                      (tblCoding_1.MotherId = @CodingId)
                                  UNION ALL

                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId,0 as Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense,  tblBudgetDetailProjectArea.Pishnahadi AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                  TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblAreasTogether.YearId=TblBudgets_1.TblYearId
                                  WHERE   (TblBudgets_1.TblYearId = @yearId ) AND
                                      (TblAreasTogether.ToGetherBudget = 10) AND
                                      (TblBudgetDetails_1.tblCodingId = @CodingId)


                                  union all



                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea_1.AreaId, 0 AS Mosavab, 0 AS EditArea, 0 AS supply, 0 AS Expense, tblBudgetDetailProjectArea_1.Pishnahadi AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                  TblAreas AS TblAreas_1 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_1.Id LEFT JOIN
                                                  TblAreasTogether ON TblAreasTogether.AreaId = TblAreas_1.Id AND TblAreasTogether.YearId=TblBudgets_1.TblYearId
                                  WHERE   (TblBudgets_1.TblYearId = @yearId) AND
                                      (TblAreasTogether.ToGetherBudget = 10) AND
                                      (tblCoding_1.MotherId = @CodingId)) AS tbl1
                 GROUP BY CodingId, AreaId) AS tbl2 INNER JOIN
                tblCoding ON tbl2.CodingId = tblCoding.Id INNER JOIN
                TblAreas AS TblAreas_2 ON tbl2.AreaId = TblAreas_2.Id
ORDER BY tbl2.AreaId, tbl2.CodingId
end

    if(@areaId in (45,46))--منابع انسانی -- پشتیبانی
begin
SELECT        tbl2.CodingId, tbl2.AreaId, TblAreas_2.AreaNameShort AS AreaName, tblCoding.Code, tblCoding.Description, tbl2.Mosavab, tbl2.EditArea AS Edit, tbl2.Supply, tbl2.Expense, tbl2.BudgetNext, tblCoding.levelNumber
FROM            (SELECT        CodingId, AreaId, SUM(Mosavab) AS Mosavab, SUM(EditArea) AS EditArea, SUM(Supply) AS Supply, SUM(Expense) AS Expense, SUM(BudgetNext) AS BudgetNext
                 FROM            (SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense, 0 AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
                                  WHERE    (TblBudgets_1.TblYearId = @yearId - 1) AND
                                      (TblBudgetDetails_1.tblCodingId = @CodingId)
                                  UNION ALL
                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense, 0 AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
                                  WHERE    (TblBudgets_1.TblYearId = @yearId - 1) AND
                                      (tblCoding_1.MotherId = @CodingId)
                                  UNION ALL
                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.AreaId, 0 AS Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.Pishnahadi AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
                                  WHERE    (TblBudgets_1.TblYearId = @yearId) AND
                                      (TblBudgetDetails_1.tblCodingId = @CodingId)
                                  UNION ALL
                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea_1.AreaId, 0 AS Mosavab, 0 AS EditArea, 0 AS supply, 0 AS Expense, tblBudgetDetailProjectArea_1.Pishnahadi AS BudgetNext
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId
                                  WHERE    (TblBudgets_1.TblYearId = @yearId) AND
                                      (tblCoding_1.MotherId = @CodingId)) AS tbl1
                 GROUP BY CodingId, AreaId) AS tbl2 INNER JOIN
                tblCoding ON tbl2.CodingId = tblCoding.Id INNER JOIN
                TblAreas AS TblAreas_2 ON tbl2.AreaId = TblAreas_2.Id
ORDER BY tbl2.AreaId, tbl2.CodingId
end

END
go

