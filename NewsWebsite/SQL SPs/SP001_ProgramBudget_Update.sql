USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_ProgramBudget_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_ProgramBudget_Update]
@Ids NVARCHAR(MAX),
@programDetailsId int
AS
BEGIN
    Update tblBudgetDetailProjectArea set ProgramDetailsId=@programDetailsId
    WHERE Id IN (SELECT Id FROM dbo.fn_SplitString(@Ids, ','))
END
GO
