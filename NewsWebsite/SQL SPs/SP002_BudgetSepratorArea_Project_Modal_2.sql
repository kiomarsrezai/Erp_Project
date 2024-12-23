USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_BudgetSepratorArea_Project_Modal_2]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_BudgetSepratorArea_Project_Modal_2]
@yearId int,
@areaId int
AS
BEGIN

SELECT        TblProgramOperationDetails.Id, TblProjects.ProjectCode, TblProjects.ProjectName, TblAreas.AreaNameShort
FROM            TblProgramOperations INNER JOIN
                         TblProgramOperationDetails ON TblProgramOperations.Id = TblProgramOperationDetails.TblProgramOperationId INNER JOIN
                         TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id INNER JOIN
                         TblAreas ON TblProgramOperations.TblAreaId = TblAreas.Id
WHERE        (TblProgramOperations.TblAreaId = @areaId) AND (TblProgramOperations.TblProgramId = 10)

END
GO
