USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP010_RequestBudget_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP010_RequestBudget_Read]
@RequestId int
AS
BEGIN
SELECT        tblRequestBudget.Id, TblYears.YearName, tblCoding.Code, tblCoding.Description, TblProjects.ProjectCode + '  ' + TblProjects.ProjectName AS Project, tblRequestBudget.RequestBudgetAmount
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         TblYears ON TblBudgets.TblYearId = TblYears.Id INNER JOIN
                         TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id INNER JOIN
                         TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id INNER JOIN
                         tblRequestBudget ON tblBudgetDetailProjectArea.id = tblRequestBudget.BudgetDetailProjectAreaId
WHERE        (tblRequestBudget.RequestId = @RequestId)
ORDER BY TblYears.YearName, tblCoding.Code
END
GO
