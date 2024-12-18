USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP006_CommiteDetail_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP006_CommiteDetail_Update]
@Id int,
@Row tinyint,
@Description nvarchar(3000),
@ProjectId int=NULL
AS
BEGIN
    update tblCommiteDetail
	  set Row = @Row ,
  Description = @Description,
    ProjectId = @ProjectId
     where Id = @Id
END
GO
