USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP006_CommiteWbs_Modal_Employee_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP006_CommiteWbs_Modal_Employee_Update]
@CommiteWbsId int ,
@UserId int,
@FirstName nvarchar(50), 
@LastName nvarchar(50), 
@Responsibility nvarchar(50)
AS
BEGIN
     update tblCommiteDetailWbs
	 set  FirstName = @FirstName ,
	       LastName = @LastName ,
	 Responsibility = @Responsibility,
	         UserId = @UserId
		   where id = @CommiteWbsId
END
GO
