USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP006_CommiteDetailAccept_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP006_CommiteDetailAccept_Update]
@Id int
AS
BEGIN
     update tblCommiteDetailAccept
	 set DateAccept = GetDate()
	 where id = @Id
END
GO
