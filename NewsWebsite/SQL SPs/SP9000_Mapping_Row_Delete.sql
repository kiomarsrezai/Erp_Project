USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9000_Mapping_Row_Delete]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9000_Mapping_Row_Delete]
@Id int
AS
BEGIN
   delete TblCodingsMapSazman
   where Id = @Id
END
GO
