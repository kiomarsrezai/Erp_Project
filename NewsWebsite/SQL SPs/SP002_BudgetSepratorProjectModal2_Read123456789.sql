USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_BudgetSepratorProjectModal2_Read123456789]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_BudgetSepratorProjectModal2_Read123456789]
@yearId int ,
@areaId int ,
@BudgetProcessId tinyint,
@codingId int,
@projectId int
AS
BEGIN
SELECT        tblBudgetDetailProjectAreaDepartment.Id, TblProgramOperationDetails.TblProjectId AS ProjectId, tblDepartman.DepartmentName, tblBudgetDetailProjectAreaDepartment.MosavabDepartment
FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblProgramOperationDetails ON tblBudgetDetailProject_1.ProgramOperationDetailsId = TblProgramOperationDetails.Id INNER JOIN
                         tblBudgetDetailProjectAreaDepartment ON tblBudgetDetailProjectArea.id = tblBudgetDetailProjectAreaDepartment.BudgetDetailProjectAreaId INNER JOIN
                         tblDepartman ON tblBudgetDetailProjectAreaDepartment.DepartmenId = tblDepartman.id
WHERE  (TblBudgets_1.TblYearId = @yearId) AND
       (tblBudgetDetailProjectArea.AreaId = @areaId) AND
	   (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND
	   (TblBudgetDetails_1.tblCodingId = @codingId) AND 
       (TblProgramOperationDetails.TblProjectId = @projectId)
END
GO
