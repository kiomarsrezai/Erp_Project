USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP005_ProjectOrg_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP005_ProjectOrg_Insert]
@id int
AS
BEGIN
      insert into TblProjects( MotherId ,ProjectCode , ProjectName)
	                   values(   @id    ,     NULL   ,    NULL    )

END
GO
