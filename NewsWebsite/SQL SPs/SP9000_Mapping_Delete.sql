USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9000_Mapping_Delete]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9000_Mapping_Delete]
@id int
AS
BEGIN
   update TblCodingsMapSazman
		set   CodeAcc = NULL ,
		     TitleAcc = NULL ,
   CodeVasetShahrdari = NULL
		     where id = @id
  --   delete TblCodingsMapSazman
	 --where id = @id
END
GO
