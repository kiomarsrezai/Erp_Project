USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9000_Mapping_Modal_2_Read12345678910111213]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9000_Mapping_Modal_2_Read12345678910111213]
@areaId int ,
@yearId int
AS
BEGIN
declare @YearName int
if(@yearId = 32) begin set @YearName = 1401  end
if(@yearId = 33) begin set @YearName = 1402  end

declare @IdGroup1 tinyint ,@IdGroup2 tinyint,@IdGroup3 tinyint,@IdGroup4 tinyint,@IdGroup5 tinyint

if(@areaId >=11)
begin
	SELECT        IdKol, IdMoien, IdTafsily, Name, Expense
	FROM            (SELECT        tbl2.IdKol, '' AS IdMoien, '' AS IdTafsily, tblKol_1.Name, tbl2.Expense
							   FROM            (SELECT        IdKol, SUM(Expense) AS Expense
														  FROM            (SELECT        olden.tblSanadDetail_MD.IdKol, 
																											  CASE WHEN olden.tblKol.IdGroup = 6 THEN olden.tblSanadDetail_MD.Bestankar - olden.tblSanadDetail_MD.Bedehkar WHEN olden.tblKol.IdGroup = 7 THEN olden.tblSanadDetail_MD.Bedehkar
																											   - olden.tblSanadDetail_MD.Bestankar END AS Expense
																					 FROM            olden.tblSanad_MD INNER JOIN
																											  olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId AND 
																											  olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName INNER JOIN
																											  olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id AND olden.tblSanadDetail_MD.AreaId = olden.tblKol.AreaId AND 
																											  olden.tblSanadDetail_MD.YearName = olden.tblKol.YearName
																					 WHERE  (olden.tblKol.AreaId = @areaId) AND
																							(olden.tblKol.YearName = @YearName) AND
																							(olden.tblSanad_MD.AreaId = @areaId) AND
																							(olden.tblSanad_MD.YearName = @YearName) AND 
																							(olden.tblSanadDetail_MD.AreaId = @areaId) AND
																							(olden.tblSanadDetail_MD.YearName = @YearName) AND
																							(olden.tblKol.IdGroup IN (6, 7))) AS tbl1
														  GROUP BY IdKol) AS tbl2 INNER JOIN
														olden.tblKol AS tblKol_1 ON tbl2.IdKol = tblKol_1.id
							   WHERE (tblKol_1.AreaId = @areaId) AND
									 (tblKol_1.YearName = @YearName)
							   UNION ALL
							   SELECT        tbl2_2.IdKol, tbl2_2.IdMoien, '' AS IdTafsily, olden.tblMoien.Name, tbl2_2.Expense
							   FROM            (SELECT        IdKol, IdMoien, SUM(Expense) AS Expense
														  FROM            (SELECT        tblSanadDetail_MD_2.IdKol, tblSanadDetail_MD_2.IdMoien, 
																											  CASE WHEN tblKol_3.IdGroup = 6 THEN tblSanadDetail_MD_2.Bestankar - tblSanadDetail_MD_2.Bedehkar END AS Expense
																					 FROM            olden.tblSanad_MD AS tblSanad_MD_2 INNER JOIN
																											  olden.tblSanadDetail_MD AS tblSanadDetail_MD_2 ON tblSanad_MD_2.Id = tblSanadDetail_MD_2.IdSanad_MD INNER JOIN
																											  olden.tblKol AS tblKol_3 ON tblSanadDetail_MD_2.IdKol = tblKol_3.id AND tblSanadDetail_MD_2.AreaId = tblKol_3.AreaId AND tblSanadDetail_MD_2.YearName = tblKol_3.YearName
																					 WHERE   (tblKol_3.AreaId = @areaId) AND
																							 (tblKol_3.YearName = @YearName) AND
																							 (tblSanad_MD_2.AreaId = @areaId) AND
																							 (tblSanad_MD_2.YearName = @YearName) AND
																							 (tblSanadDetail_MD_2.AreaId = @areaId) AND 
																							 (tblSanadDetail_MD_2.YearName = @YearName) AND
																							 (tblKol_3.IdGroup IN (6, 7))) AS tbl1_2
														  GROUP BY IdKol, IdMoien) AS tbl2_2 INNER JOIN
														olden.tblMoien ON tbl2_2.IdMoien = olden.tblMoien.Id
							   WHERE (olden.tblMoien.AreaId = @areaId) AND
									 (olden.tblMoien.YearName = @YearName)
							   UNION ALL
							   SELECT        tbl2_1.IdKol, tbl2_1.IdMoien, tbl2_1.IdTafsily4, olden.tblTafsily.Name, tbl2_1.Expense
							   FROM            (SELECT        IdKol, IdMoien, IdTafsily4, SUM(Expense) AS Expense
														  FROM            (SELECT        tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien, tblSanadDetail_MD_1.IdTafsily4, 
																											  CASE WHEN tblKol_2.IdGroup = 6 THEN tblSanadDetail_MD_1.Bestankar - tblSanadDetail_MD_1.Bedehkar WHEN tblKol_2.IdGroup = 7 THEN tblSanadDetail_MD_1.Bedehkar - tblSanadDetail_MD_1.Bestankar
																											   END AS Expense
																					 FROM            olden.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
																											  olden.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.AreaId = tblSanadDetail_MD_1.AreaId AND 
																											  tblSanad_MD_1.YearName = tblSanadDetail_MD_1.YearName INNER JOIN
																											  olden.tblKol AS tblKol_2 ON tblSanadDetail_MD_1.IdKol = tblKol_2.id AND tblSanadDetail_MD_1.AreaId = tblKol_2.AreaId AND tblSanadDetail_MD_1.YearName = tblKol_2.YearName
																					 WHERE (tblKol_2.AreaId = @areaId) AND
																						   (tblKol_2.YearName = @YearName) AND
																						   (tblSanad_MD_1.AreaId = @areaId) AND
																						   (tblSanad_MD_1.YearName = @YearName) AND
																						   (tblSanadDetail_MD_1.AreaId = @areaId) AND 
																						   (tblSanadDetail_MD_1.YearName = @YearName) AND
																						   (tblKol_2.IdGroup IN (6, 7)) AND
																						   (tblSanadDetail_MD_1.IdSotooh4 = 4)) AS tbl1_1
														  GROUP BY IdKol, IdMoien, IdTafsily4) AS tbl2_1 INNER JOIN
														olden.tblTafsily ON tbl2_1.IdTafsily4 = olden.tblTafsily.Id
							   WHERE (olden.tblTafsily.IdSotooh = 4) AND
									 (olden.tblTafsily.AreaId = @areaId) AND
									 (olden.tblTafsily.YearName = @YearName)) AS tbl1
	ORDER BY IdKol, IdMoien, IdTafsily
return
end

if (@areaId <=9)
begin
	SELECT        IdKol, IdMoien, IdTafsily,IdTafsily5, Name, Expense
	FROM            (SELECT        tbl2.IdKol, '' AS IdMoien, '' AS IdTafsily,'' as IdTafsily5, tblKol_1.Name, tbl2.Expense
							   FROM            (SELECT        IdKol, SUM(Expense) AS Expense
														  FROM            (SELECT        olden.tblSanadDetail_MD.IdKol, 
																											  CASE WHEN olden.tblKol.IdGroup = 7 THEN olden.tblSanadDetail_MD.Bestankar - olden.tblSanadDetail_MD.Bedehkar WHEN olden.tblKol.IdGroup = 8 THEN olden.tblSanadDetail_MD.Bedehkar
																											   - olden.tblSanadDetail_MD.Bestankar END AS Expense
																					 FROM            olden.tblSanad_MD INNER JOIN
																											  olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId AND 
																											  olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName INNER JOIN
																											  olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id AND olden.tblSanadDetail_MD.AreaId = olden.tblKol.AreaId AND 
																											  olden.tblSanadDetail_MD.YearName = olden.tblKol.YearName
																					 WHERE  (olden.tblKol.AreaId = @areaId) AND
																							(olden.tblKol.YearName = @YearName) AND
																							(olden.tblSanad_MD.AreaId = @areaId) AND
																							(olden.tblSanad_MD.YearName = @YearName) AND 
																							(olden.tblSanadDetail_MD.AreaId = @areaId) AND
																							(olden.tblSanadDetail_MD.YearName = @YearName) AND
																							(olden.tblKol.IdGroup IN (8, 7))) AS tbl1
														  GROUP BY IdKol) AS tbl2 INNER JOIN
														olden.tblKol AS tblKol_1 ON tbl2.IdKol = tblKol_1.id
							   WHERE (tblKol_1.AreaId = @areaId) AND
									 (tblKol_1.YearName = @YearName)
							   UNION ALL
							   SELECT        tbl2_2.IdKol, tbl2_2.IdMoien, '' AS IdTafsily,'' AS IdTafsily5, olden.tblMoien.Name, tbl2_2.Expense
							   FROM            (SELECT        IdKol, IdMoien, SUM(Expense) AS Expense
														  FROM            (SELECT        tblSanadDetail_MD_2.IdKol, tblSanadDetail_MD_2.IdMoien, 
																												  CASE WHEN tblKol_3.IdGroup = 7 THEN tblSanadDetail_MD_2.Bestankar - tblSanadDetail_MD_2.Bedehkar WHEN tblKol_3.IdGroup = 8 THEN tblSanadDetail_MD_2.Bedehkar
																											   - tblSanadDetail_MD_2.Bestankar END AS Expense
																					 FROM            olden.tblSanad_MD AS tblSanad_MD_2 INNER JOIN
																											  olden.tblSanadDetail_MD AS tblSanadDetail_MD_2 ON tblSanad_MD_2.Id = tblSanadDetail_MD_2.IdSanad_MD INNER JOIN
																											  olden.tblKol AS tblKol_3 ON tblSanadDetail_MD_2.IdKol = tblKol_3.id AND tblSanadDetail_MD_2.AreaId = tblKol_3.AreaId AND tblSanadDetail_MD_2.YearName = tblKol_3.YearName
																					 WHERE   (tblKol_3.AreaId = @areaId) AND
																							 (tblKol_3.YearName = @YearName) AND
																							 (tblSanad_MD_2.AreaId = @areaId) AND
																							 (tblSanad_MD_2.YearName = @YearName) AND
																							 (tblSanadDetail_MD_2.AreaId = @areaId) AND 
																							 (tblSanadDetail_MD_2.YearName = @YearName) AND
																							 (tblKol_3.IdGroup IN (8, 7))) AS tbl1_2
														  GROUP BY IdKol, IdMoien) AS tbl2_2 INNER JOIN
														olden.tblMoien ON tbl2_2.IdMoien = olden.tblMoien.Id
							   WHERE (olden.tblMoien.AreaId = @areaId) AND
									 (olden.tblMoien.YearName = @YearName)
							   UNION ALL
							SELECT        tbl2_1.IdKol, tbl2_1.IdMoien, tbl2_1.IdTafsily4, tbl2_1.IdTafsily5, olden.tblTafsily.Name, tbl2_1.Expense
FROM            (SELECT        IdKol, IdMoien, IdTafsily4, IdTafsily5, SUM(Expense) AS Expense
                           FROM            (SELECT        tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien, tblSanadDetail_MD_1.IdTafsily4, tblSanadDetail_MD_1.IdTafsily5, 
                                                                               CASE WHEN tblKol_2.IdGroup = 7 THEN tblSanadDetail_MD_1.Bestankar - tblSanadDetail_MD_1.Bedehkar WHEN tblKol_2.IdGroup = 8 THEN tblSanadDetail_MD_1.Bedehkar - tblSanadDetail_MD_1.Bestankar
                                                                                END AS Expense
                                                      FROM            olden.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                                                                               olden.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.AreaId = tblSanadDetail_MD_1.AreaId AND 
                                                                               tblSanad_MD_1.YearName = tblSanadDetail_MD_1.YearName INNER JOIN
                                                                               olden.tblKol AS tblKol_2 ON tblSanadDetail_MD_1.IdKol = tblKol_2.id AND tblSanadDetail_MD_1.AreaId = tblKol_2.AreaId AND tblSanadDetail_MD_1.YearName = tblKol_2.YearName
                                                      WHERE        (tblKol_2.AreaId = @areaId) AND (tblKol_2.YearName = @YearName) AND (tblSanad_MD_1.AreaId = @areaId) AND (tblSanad_MD_1.YearName = @YearName) AND 
                                                                               (tblSanadDetail_MD_1.AreaId = @areaId) AND (tblSanadDetail_MD_1.YearName = @YearName) AND (tblKol_2.IdGroup IN (8, 7)) AND (tblSanadDetail_MD_1.IdSotooh4 = 4)) AS tbl1_1
                           GROUP BY IdKol, IdMoien, IdTafsily4, IdTafsily5) AS tbl2_1 INNER JOIN
                         olden.tblTafsily ON tbl2_1.IdTafsily4 = olden.tblTafsily.Id
WHERE        (olden.tblTafsily.IdSotooh = 4) AND (olden.tblTafsily.AreaId = @areaId) AND (olden.tblTafsily.YearName = @YearName)) AS tbl1
	ORDER BY IdKol, IdMoien, IdTafsily
return
end
END
GO
