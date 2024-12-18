USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP011_SuppliersAmlak_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP011_SuppliersAmlak_Update]
@Id int,
@FirstName nvarchar(200),
@LastName nvarchar(200),
@Mobile nvarchar(50),
@CodePost nvarchar(50),
@NationalCode nvarchar(50),
@Address nvarchar(500)
AS
BEGIN
UPDATE       tblSuppliers
SET                FirstName = @FirstName, LastName = @LastName, Mobile = @Mobile,NationalCode=@NationalCode,CodePost=@CodePost,Address=@Address
WHERE        (id = @Id)

END
GO
