USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal3Area_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetModal3Area_Read]
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
GO
