USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP000_GetUserInfoByTocken]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP000_GetUserInfoByTocken]
@tocken nvarchar(max)
AS
BEGIN

SELECT        FirstName, LastName, Lisence, Bio, SectionId, Token, Id, UserName,AmlakLisence
FROM            AppUsers
WHERE        (Token=@tocken)

END
GO
