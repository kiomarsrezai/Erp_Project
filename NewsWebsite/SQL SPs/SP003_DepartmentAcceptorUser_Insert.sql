USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP003_DepartmentAcceptorUser_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP003_DepartmentAcceptorUser_Insert]
@EmployeeId int,
@DepartmentAcceptorId int
AS
BEGIN
      declare @FirstName nvarchar(100)=(select FirstName from AppUsers where id = @EmployeeId)
	  declare @LastName nvarchar(100)=(select LastName from AppUsers where id = @EmployeeId)
	  declare @Bio      nvarchar(100)=(select Bio from AppUsers where id = @EmployeeId)

	  insert into tblDepartmentAcceptorUser(  DepartmanAcceptorId , FirstName , LastName ,Resposibility ,  UserId     )
                                     values(@DepartmentAcceptorId ,@FirstName ,@LastName ,     @Bio     ,@EmployeeId  )
END
GO
