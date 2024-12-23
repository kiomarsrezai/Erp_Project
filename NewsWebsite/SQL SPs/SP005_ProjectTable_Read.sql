USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP005_ProjectTable_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP005_ProjectTable_Read]
@areaId int
AS
BEGIN
if(@areaId<>10)
begin
	SELECT TblProjects.Id, TblProjects.ProjectCode, TblProjects.ProjectName, TblProjects.DateFrom, TblProjects.DateEnd,
	       TblProjects.AreaArray, TblProjects.ProjectScaleId, TblProjectScale.ProjectScaleName
	FROM            TblProjects LEFT OUTER JOIN
							 TblProjectScale ON TblProjects.ProjectScaleId = TblProjectScale.Id
	WHERE  (TblProjects.MotherId IS NULL) and
	       (TblProjects.AreaArray like '%-'+cast(@areaId as nvarchar(10))+'-%')
return
end

if(@areaId = 10)
begin
	SELECT TblProjects.Id, TblProjects.ProjectCode, TblProjects.ProjectName, TblProjects.DateFrom, TblProjects.DateEnd,
	       TblProjects.AreaArray, TblProjects.ProjectScaleId, TblProjectScale.ProjectScaleName
	FROM            TblProjects LEFT OUTER JOIN
							 TblProjectScale ON TblProjects.ProjectScaleId = TblProjectScale.Id
	WHERE  (TblProjects.MotherId IS NULL) and
	       len(TblProjects.AreaArray)>4
return
end

END
GO
