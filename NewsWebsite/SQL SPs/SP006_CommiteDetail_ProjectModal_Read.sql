USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP006_CommiteDetail_ProjectModal_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP006_CommiteDetail_ProjectModal_Read]

AS
BEGIN
select id , ProjectCode , ProjectName from TblProjects
END
GO
