USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_Coding_SendId_BeforUpdate132456789]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_Coding_SendId_BeforUpdate132456789]
@codingId int
AS
BEGIN
SELECT        Id, Code, Description, CodeVaset
FROM            TblCodings
WHERE        (Id = @CodingId)
END
GO
