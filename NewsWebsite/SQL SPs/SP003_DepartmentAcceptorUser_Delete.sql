USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP003_DepartmentAcceptorUser_Delete]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP003_DepartmentAcceptorUser_Delete]
@Id int
AS
BEGIN

DELETE FROM tblDepartmentAcceptorUser
      WHERE Id = @Id
END
GO
