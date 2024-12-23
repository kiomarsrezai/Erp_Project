USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP006_CommiteDetail_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP006_CommiteDetail_Insert]
@Row tinyint,
@CommiteId int,
@Description nvarchar(3000),
@ProjectId int=NULL
AS
BEGIN
INSERT INTO tblCommiteDetail( Row ,  CommiteId , Description , ProjectId)
                     VALUES (@Row , @CommiteId ,@Description ,@ProjectId)
END
GO
