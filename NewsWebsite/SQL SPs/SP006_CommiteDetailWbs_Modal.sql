USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP006_CommiteDetailWbs_Modal]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP006_CommiteDetailWbs_Modal]
@CommiteDetailId int
AS
BEGIN
	SELECT        Id, Description, FirstName, LastName, Responsibility,DateStart,DateEnd
	FROM            tblCommiteDetailWbs
	WHERE        (CommiteDetailId = @CommiteDetailId)
END
GO
