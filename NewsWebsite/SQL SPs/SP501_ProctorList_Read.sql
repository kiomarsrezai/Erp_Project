USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP501_ProctorList_Read]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP501_ProctorList_Read]

AS
BEGIN
SELECT        Id, ProctorName
FROM            tblProctor
END
GO
