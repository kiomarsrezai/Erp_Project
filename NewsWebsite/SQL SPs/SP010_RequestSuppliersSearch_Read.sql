USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP010_RequestSuppliersSearch_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP010_RequestSuppliersSearch_Read]

AS
BEGIN
SELECT        id, SuppliersName
FROM            tblSuppliers
where SuppliersName is not null
END
GO
