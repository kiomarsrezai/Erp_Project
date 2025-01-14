USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9000_Taraz_Witout_Revenue_Expense_3Level_Main12345678910]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9000_Taraz_Witout_Revenue_Expense_3Level_Main12345678910]
@areaId int,
@yearId int
AS
BEGIN
declare @YearName int
if(@yearId = 32) begin set @YearName = 1401  end
if(@yearId = 33) begin set @YearName = 1402  end


SELECT        IdKol, IdMoien, IdTafsily, IdTafsily5, Name, Bedehkar, Bestankar
FROM            (SELECT        tbl2.IdKol, '' AS IdMoien, '' AS IdTafsily, '' AS IdTafsily5, tbl2.Bedehkar, tbl2.Bestankar, tblKol_1.Name
                           FROM            (SELECT        IdKol, SUM(Bedehkar) AS Bedehkar, SUM(Bestankar) AS Bestankar
                                                      FROM            (SELECT        olden.tblSanadDetail_MD.IdKol, olden.tblSanadDetail_MD.Bestankar, olden.tblSanadDetail_MD.Bedehkar
                                                                                 FROM            olden.tblSanad_MD INNER JOIN
                                                                                                          olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId AND 
                                                                                                          olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName INNER JOIN
                                                                                                          olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id AND olden.tblSanadDetail_MD.AreaId = olden.tblKol.AreaId AND 
                                                                                                          olden.tblSanadDetail_MD.YearName = olden.tblKol.YearName
                                                                                 WHERE        (olden.tblKol.AreaId = @areaId) AND (olden.tblKol.YearName = @YearName) AND (olden.tblSanad_MD.AreaId = @areaId) AND (olden.tblSanad_MD.YearName = @YearName) AND 
                                                                                                          (olden.tblSanadDetail_MD.AreaId = @areaId) AND (olden.tblSanadDetail_MD.YearName = @YearName) AND (olden.tblKol.IdGroup NOT IN (888, 999))) AS tbl1
                                                      GROUP BY IdKol) AS tbl2 INNER JOIN
                                                    olden.tblKol AS tblKol_1 ON tbl2.IdKol = tblKol_1.id
                           WHERE        (tblKol_1.AreaId = @areaId) AND (tblKol_1.YearName = @YearName)
                           UNION ALL
                           SELECT        tbl2_2.IdKol, tbl2_2.IdMoien, '' AS IdTafsily, '' AS IdTafsily5, tbl2_2.Bedehkar, tbl2_2.Bestankar, olden.tblMoien.Name
                           FROM            (SELECT        IdKol, IdMoien, SUM(Bedehkar) AS Bedehkar, SUM(Bestankar) AS Bestankar
                                                      FROM            (SELECT        tblSanadDetail_MD_2.IdKol, tblSanadDetail_MD_2.IdMoien, tblSanadDetail_MD_2.Bestankar, tblSanadDetail_MD_2.Bedehkar
                                                                                 FROM            olden.tblSanad_MD AS tblSanad_MD_2 INNER JOIN
                                                                                                          olden.tblSanadDetail_MD AS tblSanadDetail_MD_2 ON tblSanad_MD_2.Id = tblSanadDetail_MD_2.IdSanad_MD AND tblSanad_MD_2.AreaId = tblSanadDetail_MD_2.AreaId AND 
                                                                                                          tblSanad_MD_2.YearName = tblSanadDetail_MD_2.YearName INNER JOIN
                                                                                                          olden.tblKol AS tblKol_3 ON tblSanadDetail_MD_2.IdKol = tblKol_3.id AND tblSanadDetail_MD_2.AreaId = tblKol_3.AreaId AND tblSanadDetail_MD_2.YearName = tblKol_3.YearName
                                                                                 WHERE        (tblKol_3.AreaId = @areaId) AND (tblKol_3.YearName = @YearName) AND (tblSanad_MD_2.AreaId = @areaId) AND (tblSanad_MD_2.YearName = @YearName) AND 
                                                                                                          (tblSanadDetail_MD_2.AreaId = @areaId) AND (tblSanadDetail_MD_2.YearName = @YearName) AND (tblKol_3.IdGroup NOT IN (888, 999))) AS tbl1_2
                                                      GROUP BY IdKol, IdMoien) AS tbl2_2 INNER JOIN
                                                    olden.tblMoien ON tbl2_2.IdMoien = olden.tblMoien.Id
                           WHERE        (olden.tblMoien.AreaId = @areaId) AND (olden.tblMoien.YearName = @YearName)
                           UNION ALL
                 SELECT        tbl2_1.IdKol, tbl2_1.IdMoien, tbl2_1.IdTafsily4, '' AS IdTafsily5, tbl2_1.Bedehkar, tbl2_1.Bestankar, olden.tblTafsily.Name
FROM            (SELECT        IdKol, IdMoien, IdTafsily4, SUM(Bedehkar) AS Bedehkar, SUM(Bestankar) AS Bestankar
                           FROM            (SELECT        tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien, tblSanadDetail_MD_1.IdTafsily4, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.Bedehkar
                                                      FROM            olden.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                                                                               olden.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.AreaId = tblSanadDetail_MD_1.AreaId AND 
                                                                               tblSanad_MD_1.YearName = tblSanadDetail_MD_1.YearName INNER JOIN
                                                                               olden.tblKol AS tblKol_2 ON tblSanadDetail_MD_1.IdKol = tblKol_2.id AND tblSanadDetail_MD_1.AreaId = tblKol_2.AreaId AND tblSanadDetail_MD_1.YearName = tblKol_2.YearName
                                                      WHERE        (tblKol_2.AreaId = @areaId) AND (tblKol_2.YearName = @YearName) AND (tblSanad_MD_1.AreaId = @areaId) AND (tblSanad_MD_1.YearName = @YearName) AND 
                                                                               (tblSanadDetail_MD_1.AreaId = @areaId) AND (tblSanadDetail_MD_1.YearName = @YearName) AND (tblKol_2.IdGroup NOT IN (888, 999))) AS tbl1_1
                           GROUP BY IdKol, IdMoien, IdTafsily4) AS tbl2_1 INNER JOIN
                         olden.tblTafsily ON tbl2_1.IdTafsily4 = olden.tblTafsily.Id
WHERE        (olden.tblTafsily.AreaId = @areaId) AND (olden.tblTafsily.YearName = @YearName)) AS tbl1
ORDER BY IdKol, IdMoien, IdTafsily
END
GO
