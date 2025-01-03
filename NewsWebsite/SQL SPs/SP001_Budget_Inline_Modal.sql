USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_Budget_Inline_Modal]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_Budget_Inline_Modal]
@yearId int,
@areaId int
AS
BEGIN
declare @Area2 int 
if(@areaId in (30,31,32,33,34,35,36,42,43,44,53)) 
begin 
set  @areaId=9   
end
SELECT        TblProgramOperationDetails.Id, TblProjects.ProjectCode, TblProjects.ProjectName
FROM            TblProgramOperations INNER JOIN
                         TblProgramOperationDetails ON TblProgramOperations.Id = TblProgramOperationDetails.TblProgramOperationId INNER JOIN
                         TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id INNER JOIN
                         TblAreas ON TblProgramOperations.TblAreaId = TblAreas.Id
WHERE     (TblProgramOperations.TblAreaId = @areaId) AND
          (TblProgramOperations.TblProgramId = 10)
END
GO
