USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_BudgetSepratorArea_TaminModal]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_BudgetSepratorArea_TaminModal]
@yearId int ,
@areaId int ,
@budgetProcessId tinyint ,
@codingId int
AS
BEGIN
SELECT      tblRequest.id, tblRequest.Number, tblRequest.Date, tblRequest.Description, tblRequest.EstimateAmount 
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblRequestBudget ON tblBudgetDetailProjectArea.id = tblRequestBudget.BudgetDetailProjectAreaDepartmentId INNER JOIN
                         tblRequest ON tblRequestBudget.RequestId = tblRequest.Id INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
WHERE (TblBudgets.TblYearId = @yearId) AND
      (tblRequest.AreaId = @areaId) AND
	  (tblCoding.TblBudgetProcessId = @budgetProcessId) AND
	  (TblBudgetDetails.tblCodingId = @codingId)


END
GO
