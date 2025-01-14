USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal2ProjectSearch]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetModal2ProjectSearch]
@areaId int,
@yearId int
AS
BEGIN
SELECT        TblProgramOperationDetails.Id, TblProjects.ProjectCode, TblProjects.ProjectName
FROM            TblProgramOperations INNER JOIN
                         TblProgramOperationDetails ON TblProgramOperations.Id = TblProgramOperationDetails.TblProgramOperationId INNER JOIN
                         TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id
WHERE (TblProgramOperations.TblAreaId = @areaId) AND
      (TblProgramOperations.TblProgramId = 10)
END
GO
