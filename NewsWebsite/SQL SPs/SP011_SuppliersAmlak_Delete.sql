USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP011_SuppliersAmlak_Delete]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP011_SuppliersAmlak_Delete]
@Id int
AS
BEGIN
DELETE FROM tblSuppliers
WHERE        (id = @Id)

END
GO
