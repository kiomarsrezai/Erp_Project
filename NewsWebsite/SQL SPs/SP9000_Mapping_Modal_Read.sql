USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9000_Mapping_Modal_Read]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9000_Mapping_Modal_Read]
@areaId int,
@yearId int
AS
BEGIN

declare @YearName int = (select YearName from TblYears  where id = @yearId )


if(@areaId <= 9 )
begin
SELECT        IdKol, IdMoien, IdTafsily4 AS IdTafsily, IdTafsily5,'123456' as IdTafsily6 ,Name, MarkazHazine,'test' as Tafsily6Name ,Expense 
FROM            (SELECT        tbl2_1.IdKol, tbl2_1.IdMoien, tbl2_1.IdTafsily4, tbl2_1.IdTafsily5, olden.tblTafsily.Name, tbl2_1.Expense, tblTafsily_1.Name AS MarkazHazine
                           FROM            (SELECT        IdKol, IdMoien, IdTafsily4, IdTafsily5, SUM(Expense) AS Expense
                                                      FROM            (SELECT        tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien, tblSanadDetail_MD_1.IdTafsily4, tblSanadDetail_MD_1.IdTafsily5, 
                                                                                                          CASE WHEN tblKol_2.IdGroup = 888 THEN tblSanadDetail_MD_1.Bestankar - tblSanadDetail_MD_1.Bedehkar 
																										       WHEN tblKol_2.IdGroup = 999 THEN tblSanadDetail_MD_1.Bedehkar - tblSanadDetail_MD_1.Bestankar
                                                                                                           END AS Expense
                                                                                 FROM            olden.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                                                                                                          olden.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.AreaId = tblSanadDetail_MD_1.AreaId AND 
                                                                                                          tblSanad_MD_1.YearName = tblSanadDetail_MD_1.YearName INNER JOIN
                                                                                                          olden.tblKol AS tblKol_2 ON tblSanadDetail_MD_1.IdKol = tblKol_2.id AND tblSanadDetail_MD_1.AreaId = tblKol_2.AreaId AND tblSanadDetail_MD_1.YearName = tblKol_2.YearName
                                                                                 WHERE   (tblKol_2.AreaId = @areaId) AND
																				         (tblKol_2.YearName = @YearName) AND
																						 (tblSanad_MD_1.AreaId = @areaId) AND
																						 (tblSanad_MD_1.YearName = @YearName) AND 
                                                                                         (tblSanadDetail_MD_1.AreaId = @areaId) AND
																						 (tblSanadDetail_MD_1.YearName = @YearName) AND
																						 (tblKol_2.IdGroup=888  OR 
																						 (tblKol_2.IdGroup=999 --and
																						-- tblSanadDetail_MD_1.IdKol in (8250,8251,8252,8253,8254,8255,8256)
																						)AND
																						
																						 (tblSanadDetail_MD_1.IdSotooh4 = 4)))
                                                                               AS tbl1_1
                                                      GROUP BY IdKol, IdMoien, IdTafsily4, IdTafsily5) AS tbl2_1 INNER JOIN
                                                    olden.tblTafsily ON tbl2_1.IdTafsily4 = olden.tblTafsily.Id LEFT OUTER JOIN
                                                    olden.tblTafsily AS tblTafsily_1 ON tbl2_1.IdTafsily5 = tblTafsily_1.Id
                           WHERE   (olden.tblTafsily.IdSotooh = 4) AND
						           (olden.tblTafsily.AreaId = @areaId) AND
								   (olden.tblTafsily.YearName = @YearName) AND
								   (tblTafsily_1.IdSotooh = 5) AND
								   (tblTafsily_1.AreaId = @areaId) AND 
                                   (tblTafsily_1.YearName = @YearName)) AS tbl1
WHERE   Expense<>0 and      ((IdKol + '-' + IdMoien + '-' + IdTafsily4 + '-' + IdTafsily5) NOT IN
                             (SELECT        CodeVasetShahrdari
                                FROM            TblCodingsMapSazman
                                WHERE  (YearId = @yearId) AND
								       (AreaId = @areaId) AND
									   (CodeVasetShahrdari IS NOT NULL)))
ORDER BY IdKol, IdMoien, IdTafsily
return
end

--if(@areaId >= 11)
--begin
--SELECT        IdKol, IdMoien, IdTafsily4 as IdTafsily, IdTafsily5, IdTafsily6, Name, MarkazHazine, Tafsily6Name, Expense
--FROM            (SELECT        tbl1_8.IdKol, tbl1_8.IdMoien, tbl1_8.IdTafsily4, tbl1_8.IdTafsily5, tbl1_8.IdTafsily6, olden.tblMoien.Name+'--'+olden.tblKol.Name as Name , '' AS MarkazHazine, '' AS Tafsily6Name, tbl1_8.Expense
--FROM            (SELECT        IdKol, IdMoien, IdTafsily4, IdTafsily5, IdTafsily6, SUM(Expense) AS Expense
--                          FROM            (SELECT        tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien, tblSanadDetail_MD_1.IdTafsily4, tblSanadDetail_MD_1.IdTafsily5, tblSanadDetail_MD_1.IdTafsily6, 
--                                                                              CASE WHEN tblKol_2.IdGroup = 888 THEN tblSanadDetail_MD_1.Bestankar - tblSanadDetail_MD_1.Bedehkar WHEN tblKol_2.IdGroup = 999 THEN tblSanadDetail_MD_1.Bedehkar - tblSanadDetail_MD_1.Bestankar
--                                                                               END AS Expense
--                                                    FROM            olden.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
--                                                                              olden.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.AreaId = tblSanadDetail_MD_1.AreaId AND 
--                                                                              tblSanad_MD_1.YearName = tblSanadDetail_MD_1.YearName INNER JOIN
--                                                                              olden.tblKol AS tblKol_2 ON tblSanadDetail_MD_1.IdKol = tblKol_2.id AND tblSanadDetail_MD_1.AreaId = tblKol_2.AreaId AND tblSanadDetail_MD_1.YearName = tblKol_2.YearName
--                                                    WHERE   (tblKol_2.AreaId = @areaId) AND
--													        (tblKol_2.YearName = 1402) AND
--															(tblSanad_MD_1.AreaId = @areaId) AND
--															(tblSanad_MD_1.YearName = 1402) AND
--															(tblSanadDetail_MD_1.AreaId = @areaId) AND 
--                                                            (tblSanadDetail_MD_1.YearName = 1402) AND
--															(tblSanad_MD_1.IdSanadkind <> 2) AND
--															(tblKol_2.IdGroup IN (888, 999)) AND
--															(tblSanadDetail_MD_1.IdTafsily4 IS NULL) AND 
--                                                            (tblSanadDetail_MD_1.IdTafsily5 IS NULL) AND
--															(tblSanadDetail_MD_1.IdTafsily6 IS NULL)
--															) AS tbl1
--                          GROUP BY IdKol, IdMoien, IdTafsily4, IdTafsily5, IdTafsily6) AS tbl1_8 INNER JOIN
--                         olden.tblMoien ON tbl1_8.IdMoien = olden.tblMoien.Id INNER JOIN
--                         olden.tblKol ON olden.tblMoien.IdKol = olden.tblKol.id
--WHERE        (olden.tblMoien.AreaId = @areaId) AND (olden.tblMoien.YearName = 1402) AND ((tbl1_8.IdKol + '-' + tbl1_8.IdMoien + '---') NOT IN
--                             (SELECT        CodeAcc
--                               FROM            TblCodingsMapSazman
--                               WHERE   (YearId = 33) AND
--							           (AreaId = @areaId) AND
--									   (CodeAcc IS NOT NULL))) AND
--									   (olden.tblKol.AreaId = @areaId) AND
--									   (olden.tblKol.YearName = 1402)
--                          UNION ALL
--                        SELECT        tbl1_6.IdKol, tbl1_6.IdMoien, tbl1_6.IdTafsily4, tbl1_6.IdTafsily5, tbl1_6.IdTafsily6, olden.tblTafsily.Name+'--'+olden.tblMoien.Name as Name, '' AS MarkazHazine, '' AS Tafsily6Name, tbl1_6.Expense
--FROM            (SELECT        IdKol, IdMoien, IdTafsily4, IdTafsily5, IdTafsily6, SUM(Expense) AS Expense
--                          FROM            (SELECT        tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien, tblSanadDetail_MD_1.IdTafsily4, tblSanadDetail_MD_1.IdTafsily5, tblSanadDetail_MD_1.IdTafsily6, 
--                                                                              CASE WHEN tblKol_2.IdGroup = 888 THEN tblSanadDetail_MD_1.Bestankar - tblSanadDetail_MD_1.Bedehkar WHEN tblKol_2.IdGroup = 999 THEN tblSanadDetail_MD_1.Bedehkar - tblSanadDetail_MD_1.Bestankar
--                                                                               END AS Expense
--                                                    FROM            olden.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
--                                                                              olden.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.AreaId = tblSanadDetail_MD_1.AreaId AND 
--                                                                              tblSanad_MD_1.YearName = tblSanadDetail_MD_1.YearName INNER JOIN
--                                                                              olden.tblKol AS tblKol_2 ON tblSanadDetail_MD_1.IdKol = tblKol_2.id AND tblSanadDetail_MD_1.AreaId = tblKol_2.AreaId AND tblSanadDetail_MD_1.YearName = tblKol_2.YearName
--                                                    WHERE       (tblKol_2.AreaId = @areaId) AND (tblKol_2.YearName = 1402) AND (tblSanad_MD_1.AreaId = @areaId) AND (tblSanad_MD_1.YearName = 1402) AND (tblSanadDetail_MD_1.AreaId = @areaId) AND 
--                                                                (tblSanadDetail_MD_1.YearName = 1402) AND
--																(tblSanad_MD_1.IdSanadkind <> 2) AND
--																(tblKol_2.IdGroup IN (888, 999)) --AND
--																--(tblSanadDetail_MD_1.IdTafsily5 IS NULL) AND 
--                --                                                (tblSanadDetail_MD_1.IdTafsily6 IS NULL)
--																) AS tbl1
--                          GROUP BY IdKol, IdMoien, IdTafsily4, IdTafsily5, IdTafsily6) AS tbl1_6 INNER JOIN
--                         olden.tblTafsily ON tbl1_6.IdTafsily4 = olden.tblTafsily.Id INNER JOIN
--                         olden.tblMoien ON tbl1_6.IdMoien = olden.tblMoien.Id
--WHERE        ((tbl1_6.IdKol + '-' + tbl1_6.IdMoien + '-' + tbl1_6.IdTafsily4 + '--') NOT IN
--                             (SELECT        CodeAcc
--                               FROM            TblCodingsMapSazman AS TblCodingsMapSazman_3
--                               WHERE        (YearId = 33) AND (AreaId = @areaId) AND (CodeAcc IS NOT NULL))) AND (olden.tblTafsily.AreaId = @areaId) AND (olden.tblTafsily.YearName = 1402) AND (olden.tblMoien.AreaId = @areaId) AND 
--                         (olden.tblMoien.YearName = 1402)
--                          UNION ALL--------------------------------------------
--                          SELECT        tbl1_4.IdKol, tbl1_4.IdMoien, tbl1_4.IdTafsily4, tbl1_4.IdTafsily5, tbl1_4.IdTafsily6, tblTafsily_4.Name, tblTafsily_2.Name AS MarkazHazine, '' AS Tafsily6Name, tbl1_4.Expense
--                          FROM            (SELECT        IdKol, IdMoien, IdTafsily4, IdTafsily5, IdTafsily6, SUM(Expense) AS Expense
--                                                    FROM            (SELECT        tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien, tblSanadDetail_MD_1.IdTafsily4, tblSanadDetail_MD_1.IdTafsily5, tblSanadDetail_MD_1.IdTafsily6, 
--                                                                                                        CASE WHEN tblKol_2.IdGroup = 888 THEN tblSanadDetail_MD_1.Bestankar - tblSanadDetail_MD_1.Bedehkar WHEN tblKol_2.IdGroup = 999 THEN tblSanadDetail_MD_1.Bedehkar - tblSanadDetail_MD_1.Bestankar
--                                                                                                         END AS Expense
--                                                                              FROM            olden.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
--                                                                                                        olden.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.AreaId = tblSanadDetail_MD_1.AreaId AND 
--                                                                                                        tblSanad_MD_1.YearName = tblSanadDetail_MD_1.YearName INNER JOIN
--                                                                                                        olden.tblKol AS tblKol_2 ON tblSanadDetail_MD_1.IdKol = tblKol_2.id AND tblSanadDetail_MD_1.AreaId = tblKol_2.AreaId AND tblSanadDetail_MD_1.YearName = tblKol_2.YearName
--                                                                              WHERE   (tblKol_2.AreaId = @areaId) AND
--																			          (tblKol_2.YearName = 1402) AND
--																					  (tblSanad_MD_1.AreaId = @areaId) AND
--																					  (tblSanad_MD_1.YearName = 1402) AND
--																					  (tblSanadDetail_MD_1.AreaId = @areaId) AND 
--                                                                                      (tblSanadDetail_MD_1.YearName = 1402) AND
--																					  (tblSanad_MD_1.IdSanadkind <> 2) AND
--																					  (tblKol_2.IdGroup IN (888, 999))) AS tbl1
--                                                    GROUP BY IdKol, IdMoien, IdTafsily4, IdTafsily5, IdTafsily6) AS tbl1_4 INNER JOIN
--                                                   olden.tblTafsily AS tblTafsily_2 ON tbl1_4.IdTafsily5 = tblTafsily_2.Id INNER JOIN
--                                                   olden.tblTafsily AS tblTafsily_4 ON tbl1_4.IdTafsily4 = tblTafsily_4.Id
--                          WHERE        ((tbl1_4.IdKol + '-' + tbl1_4.IdMoien + '-' + tbl1_4.IdTafsily4 + '-' + tbl1_4.IdTafsily5 + '-') NOT IN
--                                                       (SELECT        CodeAcc
--                                                         FROM            TblCodingsMapSazman AS TblCodingsMapSazman_2
--                                                         WHERE  (YearId = 33) AND
--														        (AreaId = @areaId) AND
--																(CodeAcc IS NOT NULL))) AND
--																(tblTafsily_2.AreaId = @areaId) AND
--																(tblTafsily_2.YearName = 1402) --AND
--																--(tbl1_4.IdTafsily6 IS NULL) 
--																AND
--																(tblTafsily_4.AreaId = @areaId) AND 
--                                                                (tblTafsily_4.YearName = 1402)
--                          UNION ALL
--                          SELECT        tbl1_2.IdKol, tbl1_2.IdMoien, tbl1_2.IdTafsily4, tbl1_2.IdTafsily5, tbl1_2.IdTafsily6, tblTafsily_3.Name, tblTafsily_1.Name AS MarkazHazine, tblTafsily_2.Name AS Tafsily6Name, tbl1_2.Expense
--                          FROM            (SELECT        IdKol, IdMoien, IdTafsily4, IdTafsily5, IdTafsily6, SUM(Expense) AS Expense
--                                                    FROM            (SELECT        tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien, tblSanadDetail_MD_1.IdTafsily4, tblSanadDetail_MD_1.IdTafsily5, tblSanadDetail_MD_1.IdTafsily6, 
--                                                                                                        CASE WHEN tblKol_2.IdGroup = 888 THEN tblSanadDetail_MD_1.Bestankar - tblSanadDetail_MD_1.Bedehkar WHEN tblKol_2.IdGroup = 999 THEN tblSanadDetail_MD_1.Bedehkar - tblSanadDetail_MD_1.Bestankar
--                                                                                                         END AS Expense
--                                                                              FROM            olden.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
--                                                                                                        olden.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.AreaId = tblSanadDetail_MD_1.AreaId AND 
--                                                                                                        tblSanad_MD_1.YearName = tblSanadDetail_MD_1.YearName INNER JOIN
--                                                                                                        olden.tblKol AS tblKol_2 ON tblSanadDetail_MD_1.IdKol = tblKol_2.id AND tblSanadDetail_MD_1.AreaId = tblKol_2.AreaId AND tblSanadDetail_MD_1.YearName = tblKol_2.YearName
--                                                                              WHERE  (tblKol_2.AreaId = @areaId) AND
--																			         (tblKol_2.YearName = 1402) AND
--																					 (tblSanad_MD_1.AreaId = @areaId) AND
--																					 (tblSanad_MD_1.YearName = 1402) AND
--																					 (tblSanadDetail_MD_1.AreaId = @areaId) AND 
--                                                                                     (tblSanadDetail_MD_1.YearName = 1402) AND
--																					 (tblSanad_MD_1.IdSanadkind <> 2) AND
--																					 (tblKol_2.IdGroup IN (888, 999))) AS tbl1
--                                                    GROUP BY IdKol, IdMoien, IdTafsily4, IdTafsily5, IdTafsily6) AS tbl1_2 INNER JOIN
--                                                   olden.tblTafsily AS tblTafsily_3 ON tbl1_2.IdTafsily4 = tblTafsily_3.Id INNER JOIN
--                                                   olden.tblTafsily AS tblTafsily_1 ON tbl1_2.IdTafsily5 = tblTafsily_1.Id INNER JOIN
--                                                   olden.tblTafsily AS tblTafsily_2 ON tbl1_2.IdTafsily6 = tblTafsily_2.Id
--                          WHERE        ((tbl1_2.IdKol + '-' + tbl1_2.IdMoien + '-' + tbl1_2.IdTafsily4 + '-' + tbl1_2.IdTafsily5 + '-' + tbl1_2.IdTafsily6) NOT IN
--                                                       (SELECT        CodeAcc
--                                                         FROM            TblCodingsMapSazman AS TblCodingsMapSazman_1
--                                                         WHERE   (YearId = 33) AND
--														         (AreaId = @areaId) AND
--																 (CodeAcc IS NOT NULL))) AND
--																 (tblTafsily_1.AreaId = @areaId) AND
--																 (tblTafsily_1.YearName = 1402) AND
--																 (tblTafsily_3.AreaId = @areaId) AND
--																 (tblTafsily_3.YearName = 1402) AND
--																 (tblTafsily_1.AreaId = @areaId) AND
--																 (tblTafsily_1.YearName = 1402) AND
--																 (tblTafsily_2.AreaId = @areaId) AND
--																 (tblTafsily_2.YearName = 1402)) AS tbl1
--ORDER BY IdKol, IdMoien, IdTafsily4, IdTafsily5, IdTafsily6
--end

if(@areaId >= 11)
begin
SELECT        tbl9.IdKol, tbl9.IdMoien, tbl9.IdTafsily4 AS IdTafsily, tbl9.IdTafsily5, tbl9.IdTafsily6, tbl9.CodeVaset, '' AS MarkazHazine, '' AS Tafsily6Name, tbl9.Expense, ISNULL(olden.tblKol.Name, N'') + '-' + ISNULL(olden.tblMoien.Name, N'') 
                         + '-' + ISNULL(olden.tblTafsily.Name, N'') + '-' + ISNULL(tblTafsily_1.Name, N'') + '-' + ISNULL(tblTafsily_2.Name, N'') AS Name
FROM            (SELECT        @areaId AS areaid, 1402 AS yearname, IdKol, IdMoien, IdTafsily4, IdTafsily5, IdTafsily6, Expense, ISNULL(IdKol, '') + '-' + ISNULL(IdMoien, '') + '-' + ISNULL(IdTafsily4, '') + '-' + ISNULL(IdTafsily5, '') 
                                                    + '-' + ISNULL(IdTafsily6, '') AS CodeVaset
                          FROM            (SELECT        IdKol, IdMoien, IdTafsily4, IdTafsily5, IdTafsily6, SUM(Expense) AS Expense
                                                    FROM            (SELECT        tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien, tblSanadDetail_MD_1.IdTafsily4, tblSanadDetail_MD_1.IdTafsily5, tblSanadDetail_MD_1.IdTafsily6, 
                                                                                                        CASE WHEN tblKol_2.IdGroup = 888 THEN tblSanadDetail_MD_1.Bestankar - tblSanadDetail_MD_1.Bedehkar WHEN tblKol_2.IdGroup = 999 THEN tblSanadDetail_MD_1.Bedehkar - tblSanadDetail_MD_1.Bestankar
                                                                                                         END AS Expense
                                                                              FROM            olden.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                                                                                                        olden.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.AreaId = tblSanadDetail_MD_1.AreaId AND 
                                                                                                        tblSanad_MD_1.YearName = tblSanadDetail_MD_1.YearName INNER JOIN
                                                                                                        olden.tblKol AS tblKol_2 ON tblSanadDetail_MD_1.IdKol = tblKol_2.id AND tblSanadDetail_MD_1.AreaId = tblKol_2.AreaId AND tblSanadDetail_MD_1.YearName = tblKol_2.YearName
                                                                              WHERE   (tblKol_2.AreaId = @areaId) AND
																			          (tblKol_2.YearName = 1402) AND
																					  (tblSanad_MD_1.AreaId = @areaId) AND
																					  (tblSanad_MD_1.YearName = 1402) AND
					  																  (tblSanadDetail_MD_1.Description NOT LIKE '%بستن حساب%') AND
																					  (tblSanadDetail_MD_1.AreaId = @areaId) AND 
                                                                                      (tblSanadDetail_MD_1.YearName = 1402) AND
																					  (tblSanad_MD_1.IdSanadkind <> 2) AND
																					  (tblKol_2.IdGroup IN (888, 999))) AS tbl1
                                                    GROUP BY IdKol, IdMoien, IdTafsily4, IdTafsily5, IdTafsily6) AS tbl1_8) AS tbl9 LEFT OUTER JOIN
                         olden.tblTafsily AS tblTafsily_2 ON tbl9.IdTafsily6 = tblTafsily_2.Id AND tbl9.areaid = tblTafsily_2.AreaId AND tbl9.yearname = tblTafsily_2.YearName LEFT OUTER JOIN
                         olden.tblTafsily AS tblTafsily_1 ON tbl9.IdTafsily5 = tblTafsily_1.Id AND tbl9.areaid = tblTafsily_1.AreaId AND tbl9.yearname = tblTafsily_1.YearName LEFT OUTER JOIN
                         olden.tblMoien ON tbl9.yearname = olden.tblMoien.YearName AND tbl9.areaid = olden.tblMoien.AreaId AND tbl9.IdMoien = olden.tblMoien.Id LEFT OUTER JOIN
                         olden.tblTafsily ON tbl9.yearname = olden.tblTafsily.YearName AND tbl9.areaid = olden.tblTafsily.AreaId AND tbl9.IdTafsily4 = olden.tblTafsily.Id LEFT OUTER JOIN
                         olden.tblKol ON tbl9.yearname = olden.tblKol.YearName AND tbl9.areaid = olden.tblKol.AreaId AND tbl9.IdKol = olden.tblKol.id
WHERE        (tbl9.CodeVaset NOT IN (select CodeAcc from TblCodingsMapSazman where AreaId = @areaId and YearId = 33 and CodeAcc is not null))

ORDER BY IdKol, IdMoien, IdTafsily4, IdTafsily5, IdTafsily6
end


END

GO
