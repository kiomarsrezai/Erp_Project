USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP0_FileDetail_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[SP0_FileDetail_Read]
@Id int 
AS
BEGIN

    SELECT        FileName, ProjectId As Id
FROM            FileDetail
WHERE        (ProjectId = @Id)


END
GO
