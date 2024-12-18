USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP010_RequestBudget_Modal123456]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP010_RequestBudget_Modal123456]
@yearid int ,
@areaId int,
@departmentId int
AS
BEGIN
SELECT        TblBudgets.TblYearId, tblBudgetDetailProjectArea.AreaId, TblYears.YearName, tblCoding.Code, tblCoding.Description, TblProjects.ProjectCode, TblProjects.ProjectName, 
                         tblBudgetDetailProjectAreaDepartman.DepartmanId
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblBudgetDetailProjectAreaDepartman ON tblBudgetDetailProjectArea.id = tblBudgetDetailProjectAreaDepartman.BudgetDetailProjectAreaId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         TblYears ON TblBudgets.TblYearId = TblYears.Id INNER JOIN
                         TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id INNER JOIN
                         TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id
WHERE        (TblBudgets.TblYearId = 33) AND (tblBudgetDetailProjectArea.AreaId = 1) AND (tblBudgetDetailProjectAreaDepartman.DepartmanId = 1)
END
GO
