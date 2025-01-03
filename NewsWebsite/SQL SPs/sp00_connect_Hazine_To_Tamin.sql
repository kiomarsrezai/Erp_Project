USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[sp00_connect_Hazine_To_Tamin]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp00_connect_Hazine_To_Tamin]
@areaId int ,
@YearId int
AS
BEGIN
declare @yearName int
if(@YearId = 32) begin set @yearName=1401   end
if(@YearId = 33) begin set @yearName=1402   end
if(@areaId <=9)
begin
SELECT        IdKol, IdMoien, IdTafsily4, Name, Description, Bedehkar, Bestankar, TafsilyCode5, TafsilyName5
FROM            (SELECT        olden.tblSanadDetail_MD.IdKol, olden.tblSanadDetail_MD.IdMoien, olden.tblSanadDetail_MD.IdTafsily4, olden.tblTafsily.Name, olden.tblSanadDetail_MD.Description, olden.tblSanadDetail_MD.Bedehkar, 
                         olden.tblSanadDetail_MD.Bestankar, tblTafsily_1.Id AS TafsilyCode5, tblTafsily_1.Name AS TafsilyName5
FROM            olden.tblKol INNER JOIN
                         olden.tblSanad_MD INNER JOIN
                         olden.tblSanadDetail_MD ON olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId AND olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName AND 
                         olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD ON olden.tblKol.id = olden.tblSanadDetail_MD.IdKol INNER JOIN
                         olden.tblTafsily ON olden.tblSanadDetail_MD.IdTafsily4 = olden.tblTafsily.Id LEFT OUTER JOIN
                         olden.tblTafsily AS tblTafsily_1 ON olden.tblSanadDetail_MD.IdTafsily5 = tblTafsily_1.Id
WHERE   (olden.tblSanad_MD.AreaId = @areaId) AND
        (olden.tblSanad_MD.YearName = @yearName) AND
		(olden.tblSanadDetail_MD.AreaId = @areaId) AND
		(olden.tblSanadDetail_MD.YearName = @yearName) AND 
        (olden.tblKol.AreaId = @areaId) AND
		(olden.tblKol.YearName = @yearName) AND
		(olden.tblTafsily.AreaId = @areaId) AND
		(olden.tblTafsily.YearName = @yearName) AND
		(olden.tblTafsily.IdSotooh = 4) AND 
        (olden.tblKol.IdGroup = 999) AND
		(tblTafsily_1.IdSotooh = 5) AND
		(tblTafsily_1.AreaId = @areaId) AND
		(tblTafsily_1.YearName = @yearName) AND
		(olden.tblKol.Id >=8258  or olden.tblKol.Id <=8288)
		) AS tbl1
ORDER BY IdKol, IdMoien, IdTafsily4, TafsilyCode5
return
end

if(@areaId >=11)
begin
SELECT        Id, SanadDateS, IdKol, IdMoien, IdTafsily4, Name, Description, Bedehkar, Bestankar
FROM            (SELECT        olden.tblSanad_MD.Id, olden.tblSanad_MD.SanadDateS, olden.tblSanadDetail_MD.IdKol, olden.tblSanadDetail_MD.IdMoien, olden.tblSanadDetail_MD.IdTafsily4, olden.tblTafsily.Name, 
                                                    olden.tblSanadDetail_MD.Description, olden.tblSanadDetail_MD.Bedehkar, olden.tblSanadDetail_MD.Bestankar
                           FROM            olden.tblKol INNER JOIN
                                                    olden.tblSanad_MD INNER JOIN
                                                    olden.tblSanadDetail_MD ON olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId AND olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName AND 
                                                    olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD ON olden.tblKol.id = olden.tblSanadDetail_MD.IdKol INNER JOIN
                                                    olden.tblTafsily ON olden.tblSanadDetail_MD.IdTafsily4 = olden.tblTafsily.Id
                           WHERE        (olden.tblSanad_MD.AreaId = @areaId) AND (olden.tblSanad_MD.YearName = @yearName) AND (olden.tblSanadDetail_MD.AreaId = @areaId) AND (olden.tblSanadDetail_MD.YearName = @yearName) AND 
                                                    (olden.tblKol.AreaId = @areaId) AND (olden.tblKol.YearName = @yearName) AND (olden.tblTafsily.AreaId = @areaId) AND (olden.tblTafsily.YearName = @yearName) AND (olden.tblTafsily.IdSotooh = 4) AND 
                                                    (olden.tblKol.IdGroup = 999)) AS tbl1
ORDER BY IdKol, IdMoien, IdTafsily4
return
end

END
GO
