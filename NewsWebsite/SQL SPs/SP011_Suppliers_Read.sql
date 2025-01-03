USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP011_Suppliers_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP011_Suppliers_Read]
@Id tinyint
AS
BEGIN
SELECT        id, SuppliersName, Bank, Branch, NumberBank, NationalCode,Address,CodePost,SuppliersCoKindId
FROM            tblSuppliers
WHERE        (id = @Id)
ORDER BY SuppliersName
END
GO
