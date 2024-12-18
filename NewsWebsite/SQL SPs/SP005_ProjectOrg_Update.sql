USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP005_ProjectOrg_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP005_ProjectOrg_Update]
@id int, 
@ProjectCode nvarchar(10), 
@ProjectName nvarchar(200),
@MotherId int
AS
BEGIN
      update TblProjects
	  set ProjectCode = @ProjectCode,
	      ProjectName = @ProjectName ,
		     MotherId = @MotherId
		     where id = @id
END
GO
