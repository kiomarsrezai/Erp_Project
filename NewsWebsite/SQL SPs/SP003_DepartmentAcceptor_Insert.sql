USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP003_DepartmentAcceptor_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP003_DepartmentAcceptor_Insert]
@DepartmanId int ,
@AreaId int
AS
BEGIN
 INSERT INTO tblDepartmentAcceptor( DepartmanId ,  AreaId)
                           VALUES (@DepartmanId , @AreaId)

END
GO
