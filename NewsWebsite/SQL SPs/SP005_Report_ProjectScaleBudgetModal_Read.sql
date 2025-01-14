USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP005_Report_ProjectScaleBudgetModal_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP005_Report_ProjectScaleBudgetModal_Read]
@YearId int,
@AreaId int ,
@ScaleId int
AS
BEGIN
SELECT     tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea as Edit, tblBudgetDetailProjectArea.Supply, 
                         tblBudgetDetailProjectArea.Expense
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id INNER JOIN
                         TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id INNER JOIN
                         TblProjectScale ON TblProjects.ProjectScaleId = TblProjectScale.Id LEFT OUTER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
			WHERE        (TblProjects.ProjectScaleId = @ScaleId) AND
			             (TblBudgets.TblYearId = @YearId) AND
			             (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
			             (tblCoding.TblBudgetProcessId = 3)
ORDER BY tblCoding.Code
END
GO
