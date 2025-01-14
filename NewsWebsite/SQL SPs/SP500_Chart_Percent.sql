USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP500_Chart_Percent]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP500_Chart_Percent]
@yearId int ,
@budgetProcessId tinyint,
@structureId tinyint

AS
BEGIN

declare @DateEnd  date = (select DateEnd  from TblYears where id = @yearId)
declare @DateFrom date = (select DateFrom from TblYears where id = @yearId)

declare @NumberOfPastDay int = (select case when @DateEnd>GetDate() then DATEDIFF(day,@DateFrom,Getdate()) 
	                                            when @DateEnd<GetDate() then DATEDIFF(day,@DateFrom,@DateEnd) else 0 end)
declare @PercentDaily float = round(@NumberOfPastDay/cast(365 as float)*100,0)

SELECT        AreaId, @PercentDaily , CASE WHEN Mosavab > 0 THEN round(Expense / CAST(Mosavab AS float), 0) ELSE 0 END AS PercentDaily
FROM            (SELECT        tblBudgetDetailProjectArea.AreaId, SUM(tblBudgetDetailProjectArea.Mosavab) AS Mosavab, SUM(tblBudgetDetailProjectArea.Expense) AS Expense
                          FROM            TblBudgets INNER JOIN
                                                    TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                    tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                    tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                    tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                    TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                          WHERE        (TblBudgets.TblYearId = @yearId) AND
						  (tblCoding.TblBudgetProcessId = @budgetProcessId) AND
						  (tblBudgetDetailProjectArea.AreaId <> 10) AND
						  (TblAreas.StructureId = @structureId)
                          GROUP BY tblBudgetDetailProjectArea.AreaId) AS tbl1
END
GO
