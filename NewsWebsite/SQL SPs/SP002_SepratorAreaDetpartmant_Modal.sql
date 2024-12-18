USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_SepratorAreaDetpartmant_Modal]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_SepratorAreaDetpartmant_Modal]
@yearId int ,
@areaId int,
@codingId int ,	
@projectId int 
AS
BEGIN
SELECT        tblBudgetDetailProjectAreaDepartment.Id, tblDepartman.DepartmentName, tblBudgetDetailProjectAreaDepartment.MosavabDepartment
FROM            tblBudgetDetailProjectAreaDepartment INNER JOIN
                         tblDepartman ON tblBudgetDetailProjectAreaDepartment.DepartmenId = tblDepartman.id INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProjectAreaDepartment.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea.id INNER JOIN
                         tblBudgetDetailProject ON tblBudgetDetailProjectArea.BudgetDetailProjectId = tblBudgetDetailProject.Id INNER JOIN
                         TblBudgetDetails ON tblBudgetDetailProject.BudgetDetailId = TblBudgetDetails.Id INNER JOIN
                         TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
                         TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id
				WHERE   (TblBudgets.TblYearId = @yearId) AND
						(TblBudgetDetails.tblCodingId = @CodingId) AND
						(tblBudgetDetailProjectArea.AreaId = @areaId) AND
						(TblProgramOperationDetails.TblProjectId = @ProjectId)
END
GO
