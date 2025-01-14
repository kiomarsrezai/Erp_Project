USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9000_Mapping_Shahrdari_Modal_Read]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9000_Mapping_Shahrdari_Modal_Read]
@yearId int ,
@areaId int
AS
BEGIN
declare @Year int 
set @Year = (select case when @yearId = 32 then 1401
                         when @yearId = 33 then 1402 end)
SELECT        IdKol, IdMoien, IdTafsily4, IdTafsily5, 
       CASE WHEN tbl2.IdKol IS NOT NULL AND tbl2.IdMoien IS NULL AND tbl2.IdTafsily4 IS NULL AND tbl2.IdTafsily5 IS NULL THEN tbl2.IdKol 
	        WHEN tbl2.IdKol IS NOT NULL AND tbl2.IdMoien IS NOT NULL AND tbl2.IdTafsily4 IS NULL AND tbl2.IdTafsily5 IS NULL THEN tbl2.IdMoien 
			WHEN tbl2.IdKol IS NOT NULL AND tbl2.IdMoien IS NOT NULL AND tbl2.IdTafsily4 IS NOT NULL AND tbl2.IdTafsily5 IS NULL THEN tbl2.IdTafsily4 
			WHEN tbl2.IdKol IS NOT NULL AND tbl2.IdMoien IS NOT NULL AND tbl2.IdTafsily4 IS NOT NULL AND tbl2.IdTafsily5 IS NOT NULL THEN tbl2.IdTafsily5 
			END AS CodeAcc, Name, Expense 
FROM            (SELECT        IdKol, IdMoien, IdTafsily4, IdTafsily5, Name, SUM(Bestankar) - SUM(Bedehkar) AS Expense
                           FROM            (SELECT        olden.tblSanadDetail_MD.IdKol, NULL AS IdMoien, NULL AS IdTafsily4, NULL AS IdTafsily5, olden.tblSanadDetail_MD.Bestankar, olden.tblSanadDetail_MD.Bedehkar, olden.tblKol.Name
                                                      FROM            olden.tblKol INNER JOIN
                                                                               olden.tblSanadDetail_MD INNER JOIN
                                                                               olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                                               olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName ON olden.tblKol.id = olden.tblSanadDetail_MD.IdKol
                                                      WHERE  (olden.tblSanad_MD.AreaId = @areaId) AND
													         (olden.tblSanad_MD.YearName = @Year) AND
															 (olden.tblSanadDetail_MD.AreaId = @areaId) AND
															 (olden.tblSanadDetail_MD.YearName = @Year) AND
															 (olden.tblKol.AreaId = @areaId) AND
															 (olden.tblKol.YearName = @Year) AND
															 (olden.tblKol.IdGroup IN (4, 7))
                                                      UNION ALL
                                                      SELECT        tblSanadDetail_MD_2.IdKol, tblSanadDetail_MD_2.IdMoien, NULL AS IdTafsily4, NULL AS IdTafsily5, tblSanadDetail_MD_2.Bestankar, tblSanadDetail_MD_2.Bedehkar, 
                                                                               olden.tblMoien.Name AS MoienName
                                                      FROM            olden.tblKol AS tblKol_2 INNER JOIN
                                                                               olden.tblSanadDetail_MD AS tblSanadDetail_MD_2 INNER JOIN
                                                                               olden.tblSanad_MD AS tblSanad_MD_2 ON tblSanadDetail_MD_2.IdSanad_MD = tblSanad_MD_2.Id AND tblSanadDetail_MD_2.AreaId = tblSanad_MD_2.AreaId AND 
                                                                               tblSanadDetail_MD_2.YearName = tblSanad_MD_2.YearName ON tblKol_2.id = tblSanadDetail_MD_2.IdKol INNER JOIN
                                                                               olden.tblMoien ON tblSanadDetail_MD_2.IdMoien = olden.tblMoien.Id
                                                      WHERE  (tblSanad_MD_2.AreaId = @areaId) AND
													         (tblSanad_MD_2.YearName = @Year) AND
															 (tblSanadDetail_MD_2.AreaId = @areaId) AND
															 (tblSanadDetail_MD_2.YearName = @Year) AND
															 (tblKol_2.AreaId = @areaId) AND 
                                                             (tblKol_2.YearName = @Year) AND
															 (tblKol_2.IdGroup IN (4, 7)) AND
															 (olden.tblMoien.AreaId = @areaId) AND
															 (olden.tblMoien.YearName = @Year)
                                                      UNION ALL
                                                      SELECT        tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien, tblSanadDetail_MD_1.IdTafsily4, NULL AS IdTafsily5, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.Bedehkar, 
                                                                               olden.tblTafsily.Name AS TafsilyName
                                                      FROM            olden.tblKol AS tblKol_1 INNER JOIN
                                                                               olden.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                                                                               olden.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.AreaId = tblSanad_MD_1.AreaId AND 
                                                                               tblSanadDetail_MD_1.YearName = tblSanad_MD_1.YearName ON tblKol_1.id = tblSanadDetail_MD_1.IdKol INNER JOIN
                                                                               olden.tblTafsily ON tblSanadDetail_MD_1.IdTafsily4 = olden.tblTafsily.Id
                                                      WHERE   (tblSanad_MD_1.AreaId = @areaId) AND
													          (tblSanad_MD_1.YearName = @Year) AND
															  (tblSanadDetail_MD_1.AreaId = @areaId) AND
															  (tblSanadDetail_MD_1.YearName = @Year) AND
															  (tblKol_1.AreaId = @areaId) AND 
                                                              (tblKol_1.YearName = @Year) AND
															  (tblKol_1.IdGroup IN (4, 7)) AND
															  (olden.tblTafsily.AreaId = @areaId) AND
															  (olden.tblTafsily.YearName = @Year) AND
															  (olden.tblTafsily.IdSotooh = 4)
                                                      UNION ALL
                                                      SELECT        tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien, tblSanadDetail_MD_1.IdTafsily4, tblSanadDetail_MD_1.IdTafsily5, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.Bedehkar, 
                                                                               tblTafsily_1.Name
                                                      FROM            olden.tblKol AS tblKol_1 INNER JOIN
                                                                               olden.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                                                                               olden.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.AreaId = tblSanad_MD_1.AreaId AND 
                                                                               tblSanadDetail_MD_1.YearName = tblSanad_MD_1.YearName ON tblKol_1.id = tblSanadDetail_MD_1.IdKol INNER JOIN
                                                                               olden.tblTafsily AS tblTafsily_1 ON tblSanadDetail_MD_1.IdTafsily5 = tblTafsily_1.Id
                                                      WHERE  (tblSanad_MD_1.AreaId = @areaId) AND
													         (tblSanad_MD_1.YearName = @Year) AND
														     (tblSanadDetail_MD_1.AreaId = @areaId) AND
														     (tblSanadDetail_MD_1.YearName = @Year) AND
															 (tblKol_1.AreaId = @areaId) AND 
                                                             (tblKol_1.YearName = @Year) AND
															 (tblKol_1.IdGroup IN (4, 7)) AND
															 (tblTafsily_1.IdSotooh = 5) AND
															 (tblTafsily_1.AreaId = @areaId) AND
															 (tblTafsily_1.YearName = @Year)) AS tbl1
                           GROUP BY IdKol, IdMoien, IdTafsily4, IdTafsily5, Name) AS tbl2
ORDER BY IdKol, IdMoien, IdTafsily4, IdTafsily5
                          
END
GO
