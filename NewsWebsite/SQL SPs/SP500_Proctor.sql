USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP500_Proctor]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP500_Proctor]
@yearId    int=0,
@proctorId int=0,
@areaId    int=0 ,
@budgetProcessId tinyint=0

AS
BEGIN

if(@YearId>0  and @ProctorId=0 and @AreaId=0 and @budgetProcessId=0)	
begin
SELECT   tblProctor.Id, 
tblProctor.ProctorName, 
ISNULL(der_Current.MosavabCurrent, 0) AS MosavabCurrent,
ISNULL(der_Current.ExpenseCurrent, 0) AS ExpenseCurrent,
ISNULL(der_Civil.MosavabCivil, 0) AS MosavabCivil, 
ISNULL(der_Civil.ExpenseCivil, 0) AS ExpenseCivil,
ISNULL(der_Civil.CreditAmountCivil, 0) AS CreditAmountCivil,
ISNULL(der_Current.CreditAmountCurrent, 0) AS CreditAmountCurrent,
ISNULL(der_Civil.EditCivil,0) as EditCivil, 
ISNULL(der_Current.EditCurrent,0) as EditCurrent
FROM            tblProctor LEFT OUTER JOIN
                             (SELECT        tblCoding_1.ProctorId, SUM(tblBudgetDetailProjectArea_1.Mosavab) AS MosavabCivil, SUM(tblBudgetDetailProjectArea_1.EditArea) AS EditCivil, SUM(tblBudgetDetailProjectArea_1.Supply) AS CreditAmountCivil, 
                                                         SUM(tblBudgetDetailProjectArea_1.Expense) AS ExpenseCivil
                               FROM            TblBudgetDetails AS TblBudgetDetails_1 INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         TblBudgets AS TblBudgets_1 ON TblBudgetDetails_1.BudgetId = TblBudgets_1.Id INNER JOIN
                                                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                         TblAreas ON tblBudgetDetailProjectArea_1.AreaId = TblAreas.Id
                               WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_1.TblBudgetProcessId = 3) AND (TblAreas.StructureId = 1)
                               GROUP BY tblCoding_1.ProctorId) AS der_Civil ON tblProctor.Id = der_Civil.ProctorId LEFT OUTER JOIN
                             (SELECT        tblCoding.ProctorId, SUM(tblBudgetDetailProjectArea.Mosavab) AS MosavabCurrent, SUM(tblBudgetDetailProjectArea.EditArea) AS EditCurrent, SUM(tblBudgetDetailProjectArea.Supply) AS CreditAmountCurrent, 
                                                         SUM(tblBudgetDetailProjectArea.Expense) AS ExpenseCurrent
                               FROM            TblBudgetDetails INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                         TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblAreas AS TblAreas_1 ON tblBudgetDetailProjectArea.AreaId = TblAreas_1.Id
                               WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = 2) AND (TblAreas_1.StructureId = 1)
                               GROUP BY tblCoding.ProctorId) AS der_Current ON tblProctor.Id = der_Current.ProctorId
return
end

if(@YearId>0  and @ProctorId>0 and @AreaId=0)	
begin
SELECT TblAreas_2.Id AS AreaId, TblAreas_2.AreaName, 
       ISNULL(der_Current.MosavabCurrent, 0) AS MosavabCurrent,
	   ISNULL(der_Current.EditCurrent,0) as EditCurrent, 
	   ISNULL(der_Current.CreditAmountCurrent,0) as CreditAmountCurrent, 
	   ISNULL(der_Current.ExpenseCurrent, 0) AS ExpenseCurrent, 
	   ISNULL(der_Civil.MosavabCivil, 0) AS MosavabCivil, 
	   ISNULL(der_Civil.EditCivil,0) as EditCivil, 
	   ISNULL(der_Civil.CreditAmountCivil,0) as CreditAmountCivil, 
	   ISNULL(der_Civil.ExpenseCivil, 0) AS ExpenseCivil
FROM            TblAreas AS TblAreas_2 LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.AreaId, SUM(tblBudgetDetailProjectArea_1.Mosavab) AS MosavabCivil, SUM(tblBudgetDetailProjectArea_1.EditArea) AS EditCivil, SUM(tblBudgetDetailProjectArea_1.Supply) 
                                                         AS CreditAmountCivil, SUM(tblBudgetDetailProjectArea_1.Expense) AS ExpenseCivil
                               FROM            TblBudgetDetails AS TblBudgetDetails_1 INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         TblBudgets AS TblBudgets_1 ON TblBudgetDetails_1.BudgetId = TblBudgets_1.Id INNER JOIN
                                                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                         TblAreas ON tblBudgetDetailProjectArea_1.AreaId = TblAreas.Id
                               WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_1.TblBudgetProcessId = 3) AND (tblCoding_1.ProctorId = @ProctorId) AND (TblAreas.StructureId = 1)
                               GROUP BY tblBudgetDetailProjectArea_1.AreaId) AS der_Civil ON TblAreas_2.Id = der_Civil.AreaId LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea.AreaId, SUM(tblBudgetDetailProjectArea.Mosavab) AS MosavabCurrent, SUM(tblBudgetDetailProjectArea.EditArea) AS EditCurrent, SUM(tblBudgetDetailProjectArea.Supply) 
                                                         AS CreditAmountCurrent, SUM(tblBudgetDetailProjectArea.Expense) AS ExpenseCurrent
                               FROM            TblBudgetDetails INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                         TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblAreas AS TblAreas_1 ON tblBudgetDetailProjectArea.AreaId = TblAreas_1.Id
                               WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = 2) AND (tblCoding.ProctorId = @ProctorId) AND (TblAreas_1.StructureId = 1)
                               GROUP BY tblBudgetDetailProjectArea.AreaId) AS der_Current ON TblAreas_2.Id = der_Current.AreaId
WHERE        (TblAreas_2.StructureId = 1) AND (TblAreas_2.Id <> 10)
return
end

if(@YearId>0  and @ProctorId>0 and @AreaId>0)	
begin
--Supply
SELECT  tblCoding.Code, tblCoding.Description, 
        ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, 
		ISNULL(tblBudgetDetailProjectArea.EditArea,0) As Edit, 
		ISNULL(tblBudgetDetailProjectArea.Supply,0) as Supply, 
		ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense
FROM            TblBudgetDetails INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (tblCoding.ProctorId = @ProctorId) AND (tblBudgetDetailProjectArea.AreaId = @AreaId)
ORDER BY tblCoding.Code

return
end




END



GO
