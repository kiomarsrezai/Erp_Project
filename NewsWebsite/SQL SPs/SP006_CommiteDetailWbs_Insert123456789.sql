USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP006_CommiteDetailWbs_Insert123456789]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP006_CommiteDetailWbs_Insert123456789]
@CommiteDetailId int ,
@Description nvarchar(2000), 
@DateStart date=NULL,
@DateEnd date=NULL
AS
BEGIN
    insert into tblCommiteDetailWbs( CommiteDetailId , Description , DateStart , DateEnd)
	                         values(@CommiteDetailId ,@Description ,@DateStart ,@DateEnd)
END
GO
