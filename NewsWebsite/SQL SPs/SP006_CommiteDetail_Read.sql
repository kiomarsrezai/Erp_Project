USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP006_CommiteDetail_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP006_CommiteDetail_Read]
@id int
AS
BEGIN
SELECT        tblCommiteDetail.Id, tblCommiteDetail.Row, tblCommiteDetail.Description, tblCommiteDetail.ProjectId, ISNULL(TblProjects.ProjectCode, '') + '-' + TblProjects.ProjectName AS ProjectName
FROM            tblCommiteDetail LEFT OUTER JOIN
                         TblProjects ON tblCommiteDetail.ProjectId = TblProjects.Id
WHERE        (tblCommiteDetail.CommiteId = @id)
order by tblCommiteDetail.Row 
END
GO
