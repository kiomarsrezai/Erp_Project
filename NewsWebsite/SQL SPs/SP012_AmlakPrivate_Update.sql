USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_AmlakPrivate_Update]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_AmlakPrivate_Update]
@Id int,
@Masahat float, 
@NumberGhorfe nvarchar(10)
AS
BEGIN
    update tblAmlakPrivate
	  set Masahat = @Masahat ,
     NumberGhorfe = @NumberGhorfe
         where Id = @Id
END
GO
