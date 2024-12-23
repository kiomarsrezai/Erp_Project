USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP011_SuppliersAmlak_List]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP011_SuppliersAmlak_List]
@txtSerach nvarchar(150)='ا'
AS
BEGIN
if (@txtSerach=null)
begin
SELECT        id, NationalCode, Address, CodePost, Mobile, FirstName, LastName
FROM            tblSuppliers
WHERE        (SuppliersCoKindId = 4)
ORDER BY SuppliersName
end
else
begin
--declare @tst nvarchar(50)=(SELECT );

SELECT        id, NationalCode, Address, CodePost, Mobile, FirstName, LastName
FROM            tblSuppliers
WHERE        (CAST(id AS VARCHAR(10))=@txtSerach) Or (FirstName like '%'+ @txtSerach + '%') or (LastName like '%'+ @txtSerach + '%') or (NationalCode  like '%'+ @txtSerach + '%') 
ORDER BY SuppliersName
end

END
GO
