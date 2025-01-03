USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP000_Employee_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP000_Employee_Update]
@Id int,
@UserName    nvarchar(50), 
@PhoneNumber nvarchar(50), 
@FirstName   nvarchar(50), 
@LastName    nvarchar(150), 
@Gender      int, 
@Bio         nvarchar(500),
@NormalizedUserName  nvarchar(150), 
@Email               nvarchar(150), 
@NormalizedEmail     nvarchar(150), 
@BirthDate           nvarchar(150), 
@IsActive bit


AS
BEGIN
   update AppUsers
      set UserName = @UserName , 
       PhoneNumber = @PhoneNumber, 
         FirstName = @FirstName  , 
          LastName = @LastName , 
            Gender = @Gender , 
               Bio = @Bio       ,
NormalizedUserName = @NormalizedUserName, 
             Email = @Email, 
   NormalizedEmail = @NormalizedEmail , 
         BirthDate = @BirthDate , 
          IsActive = @IsActive
		  where id = @Id
END
GO
