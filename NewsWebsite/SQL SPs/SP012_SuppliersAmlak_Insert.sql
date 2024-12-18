USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_SuppliersAmlak_Insert]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_SuppliersAmlak_Insert]
@FirstName nvarchar(200),
@LastName nvarchar(200),
@Mobile nvarchar(50),
@CodePost nvarchar(50),
@NationalCode nvarchar(50),
@Address nvarchar(500)
AS
BEGIN
INSERT INTO tblSuppliers (FirstName, LastName, Mobile,CodePost,NationalCode,Address,SuppliersKindId)
		   VALUES        (@FirstName,@LastName,@Mobile,@CodePost,@NationalCode,@Address,4)

declare @ref int=(select id from tblSuppliers where id=@@IDENTITY)
--if(@ref is null or @MaxCode='')
--if(@ref is null)
--	 begin
--	    select 'خطا' as Message_DB
--	 return
--	 end
SELECT        id,FirstName, LastName, Mobile, CodePost, NationalCode, Address,SuppliersKindId
FROM            tblSuppliers
WHERE        (id = @ref)
END
GO
