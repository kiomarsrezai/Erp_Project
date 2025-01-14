USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP005_ProgramOperation]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP005_ProgramOperation]
@programId int ,
@areaId int
AS
BEGIN
SELECT        TblProgramOperationDetails.Id, TblProgramOperationDetails.TblProjectId as ProjectId, TblProjects.ProjectCode, TblProjects.ProjectName, TblProjects.ProjectScaleId, TblProjectScale.ProjectScaleName, TblProgramOperationDetails.Id AS Expr1
FROM            TblProgramOperations INNER JOIN
                         TblProgramOperationDetails ON TblProgramOperations.Id = TblProgramOperationDetails.TblProgramOperationId INNER JOIN
                         TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id LEFT OUTER JOIN
                         TblProjectScale ON TblProjects.ProjectScaleId = TblProjectScale.Id
WHERE        (TblProgramOperations.TblAreaId = @areaId) AND (TblProgramOperations.TblProgramId = @programId)
END
GO
