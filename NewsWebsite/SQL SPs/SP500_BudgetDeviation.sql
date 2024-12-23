USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP500_BudgetDeviation]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP500_BudgetDeviation]
@areaId int,
@yearId int
AS
BEGIN
if(@areaId<>10)
begin
SELECT        TblAreas.AreaNameShort as    AreaName, tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab , 
tblBudgetDetailProjectArea.EditArea AS Edit,
tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.Supply as CreditAmount
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id 
WHERE (TblBudgets.TblYearId = @yearId) AND
      (tblBudgetDetailProjectArea.AreaId = @areaId)AND
      ((tblBudgetDetailProjectArea.Expense > tblBudgetDetailProjectArea.EditArea) or
	   (tblBudgetDetailProjectArea.Supply >tblBudgetDetailProjectArea.EditArea )
	  
	  ) AND
	  (tblCoding.TblBudgetProcessId IN (2, 3, 4))
ORDER BY TblAreas.AreaName, tblCoding.Code
return
end

if(@areaId=10)
begin
SELECT        TblAreas.AreaNameShort as AreaName, tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea AS Edit, tblBudgetDetailProjectArea.Supply AS CreditAmount, 
                         tblBudgetDetailProjectArea.Expense
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
WHERE   (TblBudgets.TblYearId = @yearId) AND
        (tblBudgetDetailProjectArea.Expense > tblBudgetDetailProjectArea.EditArea or
		tblBudgetDetailProjectArea.Supply > tblBudgetDetailProjectArea.EditArea
		) AND
		(tblCoding.TblBudgetProcessId IN (2, 3, 4)) 
ORDER BY TblAreas.AreaName, tblCoding.Code
return
end
END


GO
