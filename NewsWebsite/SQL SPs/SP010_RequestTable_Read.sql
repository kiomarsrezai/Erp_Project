USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP010_RequestTable_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP010_RequestTable_Read]
@id int
AS
BEGIN
SELECT        Id, Description, Quantity, Scale, Price, Amount, OthersDescription
FROM            tblRequestTable
WHERE        (RequestId = @id)
END
GO
