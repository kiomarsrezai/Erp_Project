USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP000_Employee_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP000_Employee_Insert]
@UserName    nvarchar(50), 
@PhoneNumber nvarchar(50), 
@FirstName   nvarchar(50), 
@LastName    nvarchar(150), 
@Gender      int, 
@Bio         nvarchar(500)
AS
BEGIN
insert into AppUsers( UserName ,  PhoneNumber ,  FirstName ,  LastName ,  Gender ,  Bio)
              values(@UserName , @PhoneNumber , @FirstName , @LastName , @Gender , @Bio)

END
GO
