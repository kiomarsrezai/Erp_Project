USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9900_Sanad12345678910]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9900_Sanad12345678910]
@yearId int , 
@AreaId int , 
@NumberSanad int
AS
BEGIN
SELECT        olden.tblSanadDetail_MD.IdKol, olden.tblSanadDetail_MD.IdMoien, olden.tblTafsily.Id, olden.tblTafsily.Name AS Expr2, olden.tblSanadDetail_MD.Description, olden.tblSanadDetail_MD.Bedehkar, 
                         olden.tblSanadDetail_MD.Bestankar
FROM            olden.tblTafsily INNER JOIN
                         olden.tblSanadDetail_MD ON olden.tblTafsily.Id = olden.tblSanadDetail_MD.IdTafsily4 AND olden.tblTafsily.IdSotooh = olden.tblSanadDetail_MD.IdSotooh4 INNER JOIN
                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName AND 
                         olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id
WHERE        (olden.tblSanad_MD.Id = @NumberSanad) AND (olden.tblSanad_MD.AreaId = @AreaId) AND (olden.tblSanad_MD.AreaId = @AreaId) AND (olden.tblSanadDetail_MD.AreaId = @AreaId) AND (olden.tblTafsily.AreaId = @AreaId) AND
                          (olden.tblSanad_MD.YearName = @yearId) AND (olden.tblSanadDetail_MD.YearName = @yearId) AND (olden.tblTafsily.YearName = @yearId)
END
GO
