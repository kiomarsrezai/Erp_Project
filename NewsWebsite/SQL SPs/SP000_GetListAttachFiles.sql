USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP000_GetListAttachFiles]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP000_GetListAttachFiles] 
	-- Add the parameters for the stored procedure here
@ProjectId int
AS
BEGIN

SELECT        TblProjects.ProjectCode, FileDetail.FileName, FileDetail.ID AS FileDetailId, TblProjects.Id AS ProjectId
FROM            TblProjects INNER JOIN
                         FileDetail ON TblProjects.Id = FileDetail.ProjectId
WHERE        (TblProjects.Id = @ProjectId)

END
GO
