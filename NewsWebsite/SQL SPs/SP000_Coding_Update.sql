USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP000_Coding_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP000_Coding_Update]
@id int,
@code nvarchar(50),
@description nvarchar(1000),
@show bit,
@crud bit,
@levelNumber tinyint
AS
BEGIN
     update tblCoding
	  set code = @code ,
   description = @description,
          show = @show,
          crud = @crud,
   levelNumber = @levelNumber
 where      id = @id
END
GO
