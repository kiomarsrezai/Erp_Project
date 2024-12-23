USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_Contract_Request_Search]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_Contract_Request_Search]
@yearId int ,
@areaId int
AS
BEGIN
SELECT tblRequest.Id, tblDepartman.DepartmentName, tblRequest.Number, tblRequest.Date, tblRequest.Description
FROM            tblRequest LEFT OUTER JOIN
                         tblDepartman ON tblRequest.DepartmentId = tblDepartman.id
WHERE (tblRequest.YearId = @yearId) AND
      (tblRequest.AreaId = @areaId)
END
GO
