USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_AmlakPrivate_Insert]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_AmlakPrivate_Insert]
@AmlakInfoId int,
@Masahat float, 
@NumberGhorfe nvarchar(10)

AS
BEGIN
    insert into tblAmlakPrivate( AmlakInfoId , Masahat , NumberGhorfe)
	                     values(@AmlakInfoId ,@Masahat ,@NumberGhorfe)
END
GO
