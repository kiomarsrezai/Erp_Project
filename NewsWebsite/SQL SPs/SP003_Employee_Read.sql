USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP003_Employee_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP003_Employee_Read]

AS
BEGIN
SELECT        Id, FirstName, LastName, Bio
FROM            AppUsers
order by LastName
END
GO
