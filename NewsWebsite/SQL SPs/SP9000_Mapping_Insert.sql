USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9000_Mapping_Insert]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9000_Mapping_Insert]
@id int 

AS
BEGIN

insert into TblCodingsMapSazman(YearId , AreaId , CodingId)
					SELECT      YearId , AreaId , CodingId
					FROM            TblCodingsMapSazman
					WHERE        (Id = @id)

END
GO
