USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_Coding_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_Coding_Update]
@CodingId int ,
@Code nvarchar(50),
@Description nvarchar(1500)
AS
BEGIN
  update tblCoding
     set code = @Code ,
  Description = @Description
     where id = @CodingId
 
END
GO
