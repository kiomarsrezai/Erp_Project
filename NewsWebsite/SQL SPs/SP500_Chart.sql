USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP500_Chart]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[SP500_Chart]
@yearId int,
@centerId tinyint,
@budgetProcessId tinyint,
@structureId tinyint,
--@revenue bit,
--@sale bit ,
--@loan bit ,
--@niabati bit,
@areaId int=NULL ,
@CodingId int=NULL

AS
BEGIN
declare @MonthPercent float = .75
if(@StructureId=3) begin set @StructureId=1  end
if(@StructureId=4) begin set @StructureId=2  end

declare @Area tinyint
if(@CenterId in (0,1)) begin set @Area=0   end
if(@CenterId = 2)      begin set @Area=9   end

declare @Day int
declare @DateEnd date = (select DateEnd from TblYears where id = @yearId)

if(@areaId is null AND @CodingId is null)
begin
--	set @Day =(select DATEDIFF(day,DateFrom,Getdate())  from TblYears where id=@yearId)
--SELECT        AreaId, AreaName, Mosavab, MosavabDaily, Expense, NotGet
--FROM            (SELECT        tbl1.AreaId, TblAreas.AreaNameShort AS AreaName, tbl1.Mosavab, CASE WHEN GetDate() < @DateEnd THEN ROUND(tbl1.Mosavab * (@Day / CAST(365 AS float)), 0) ELSE tbl1.Mosavab END AS MosavabDaily, 
--                                                    tbl1.Expense, CASE WHEN GetDate() < @DateEnd THEN ROUND(tbl1.Mosavab * (@Day / CAST(365 AS float)), 0) - tbl1.Expense ELSE tbl1.Mosavab - tbl1.Expense END AS NotGet, 
--                                                    CASE WHEN tbl1.Mosavab > 0 THEN tbl1.Expense / CAST(tbl1.Mosavab AS float) ELSE 0 END AS PercentPerformance
--                          FROM            (SELECT        tblBudgetDetailProjectArea.AreaId, SUM(tblBudgetDetailProjectArea.Mosavab) AS Mosavab, SUM(tblBudgetDetailProjectArea.Expense) AS Expense
--FROM            TblBudgets INNER JOIN
--                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
--                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
--                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
--WHERE       (TblBudgets.TblYearId = @yearId) AND
--			(tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
--			(tblBudgetDetailProjectArea.AreaId NOT IN (@Area, 10)) AND
--			(TblAreas.StructureId = @StructureId)
--GROUP BY tblBudgetDetailProjectArea.AreaId) AS tbl1 INNER JOIN
--                                                    TblAreas ON tbl1.AreaId = TblAreas.Id) AS tbl3
--WHERE        (Mosavab <> 0) OR (Expense <> 0)
--ORDER BY AreaId

SELECT        AreaId, AreaName, Mosavab, Supply, MosavabDaily, Expense, NotGet
FROM            (SELECT        tbl1.AreaId, TblAreas_1.AreaNameShort AS AreaName, tbl1.Mosavab, tbl1.Supply, CAST(ROUND(@MonthPercent * tbl1.Mosavab, 0) AS bigint) AS MosavabDaily, tbl1.Expense, 
                                                    CAST(ROUND(tbl1.Mosavab * @MonthPercent, 0) - tbl1.Expense AS bigint) AS NotGet, CASE WHEN tbl1.Mosavab > 0 THEN tbl1.Expense / CAST(tbl1.Mosavab AS float) ELSE 0 END AS PercentPerformance
                          FROM            (SELECT        tblBudgetDetailProjectArea.AreaId, SUM(tblBudgetDetailProjectArea.Mosavab) AS Mosavab, SUM(tblBudgetDetailProjectArea.Supply) AS Supply, SUM(tblBudgetDetailProjectArea.Expense) 
                                                                              AS Expense
                                                    FROM            TblBudgets INNER JOIN
                                                                              TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                                              tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                                              tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                                              tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                              TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                                    WHERE        (TblBudgets.TblYearId = @yearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (tblBudgetDetailProjectArea.AreaId NOT IN (@Area, 10)) AND (TblAreas.StructureId = @StructureId)
                                                    GROUP BY tblBudgetDetailProjectArea.AreaId) AS tbl1 INNER JOIN
                                                    TblAreas AS TblAreas_1 ON tbl1.AreaId = TblAreas_1.Id) AS tbl3
WHERE        (Mosavab <> 0) OR
                         (Expense <> 0)
ORDER BY AreaId
return
end

if(@areaId is not null and @CodingId is null)
begin
SELECT        tblCoding_1.Id as CodingId, tblCoding_1.Code, tblCoding_1.Description, tbl1.Mosavab, tbl1.Expense
FROM            (SELECT        TblBudgetDetails.tblCodingId, SUM(tblBudgetDetailProjectArea.Mosavab) AS Mosavab, SUM(tblBudgetDetailProjectArea.Expense) AS Expense
                          FROM            TblBudgets INNER JOIN
                                                    TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                    
                tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                    tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                    tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                    TblAreas ON TblBudgets.TblAreaId = TblAreas.Id
                          WHERE (TblBudgets.TblYearId = @yearId) AND
						        (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
								(tblBudgetDetailProjectArea.AreaId = @areaId) --AND
								--(tblCoding.CodingKindId IN (@RevenueValue, @SaleValue,@LoadValue))
                          GROUP BY TblBudgetDetails.tblCodingId) AS tbl1 INNER JOIN
                         tblCoding AS tblCoding_1 ON tbl1.tblCodingId = tblCoding_1.Id
						 where tbl1.Mosavab<>0 or tbl1.Expense<>0
order by tblCoding_1.Code
 return
 end                                                  

if(@CodingId is not null)
begin

SELECT   TblAreas.AreaNameShort as AreaName,  tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.Expense ,0 as MosavabDaily ,0 as NotGet
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
WHERE  (TblBudgets.TblYearId = @yearId) AND
       (TblBudgetDetails.tblCodingId = @CodingId) AND
	   (TblAreas.StructureId = @structureId)
 return                        
end
END
GO
