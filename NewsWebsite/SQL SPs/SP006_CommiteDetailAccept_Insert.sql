USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP006_CommiteDetailAccept_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP006_CommiteDetailAccept_Insert]
@CommiteDetailId int,
@UserId int
AS
BEGIN
  declare @FirstName nvarchar(200) = (select FirstName from AppUsers where id = @UserId)
  declare @LastName  nvarchar(200) = (select LastName  from AppUsers where id = @UserId)
  declare @Bio       nvarchar(200) = (select Bio       from AppUsers where id = @UserId)

     insert into tblCommiteDetailAccept( CommiteDetailId ,  UserId ,  FirstName ,  LastName ,Resposibility)
	                             values(@CommiteDetailId , @UserId , @FirstName , @LastName ,     @Bio    )
END
GO
