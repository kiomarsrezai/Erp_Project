USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP0_Permission_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP0_Permission_Read]
@UserId int
AS
BEGIN
     SELECT        License
FROM            tblPermission
WHERE        (UserId = @UserId)
END
GO
