USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP0_Permission_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP0_Permission_Update]
@UserId int ,
@License nvarchar(3000)
AS
BEGIN
delete tblPermission
where UserId = @UserId

insert into tblPermission( UserId ,  License)
				   values(@UserId , @License)
END
GO
