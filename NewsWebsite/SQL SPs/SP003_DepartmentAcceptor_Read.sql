USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP003_DepartmentAcceptor_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP003_DepartmentAcceptor_Read]

AS
BEGIN
SELECT        tblDepartmentAcceptor.Id, tblDepartmentAcceptor.DepartmanId, tblDepartmentAcceptor.AreaId, tblDepartman.DepartmentCode, tblDepartman.DepartmentName, TblAreas.AreaName
FROM            tblDepartmentAcceptor LEFT OUTER JOIN
                         TblAreas ON tblDepartmentAcceptor.AreaId = TblAreas.Id LEFT OUTER JOIN
                         tblDepartman ON tblDepartmentAcceptor.DepartmanId = tblDepartman.id
						 order by tblDepartmentAcceptor.AreaId,tblDepartman.DepartmentName
END
GO
