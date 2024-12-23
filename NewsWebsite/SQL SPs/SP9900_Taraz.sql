USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9900_Taraz]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9900_Taraz]
@yearId int , 
@AreaId int ,
@MoienId bigint = NULL,
@TafsilyId bigint = NULL,
@MarkazHazine int =NULL,
@KindId int = NULL

AS
BEGIN

declare @YearName int =(select YearName from TblYears where id = @yearId)
declare @Revenue int

declare @temp table (id int)
if (@KindId = 1) begin insert into @temp(id) values(888) end 
if (@KindId = 2) begin insert into @temp(id) values(999) end 
if (@KindId = 3) 
 begin 
   insert into @temp(id)
   select id from olden.tblGroup where id not in (888,999)
 end 
--تراز کل و معین
if (@MoienId is null and @TafsilyId is null)
begin
SELECT    1 as Levels,    tbl1.IdKol AS Code, tblKol_1.Name AS Description, tbl1.Bedehkar, tbl1.Bestankar, CASE WHEN tbl1.Bedehkar - tbl1.Bestankar > 0 THEN tbl1.Bedehkar - tbl1.Bestankar ELSE 0 END AS BalanceBedehkar, 
                         CASE WHEN tbl1.Bedehkar - tbl1.Bestankar < 0 THEN tbl1.Bestankar - tbl1.Bedehkar ELSE 0 END AS BalanceBestankar
FROM            (SELECT        olden.tblSanadDetail_MD.IdKol, SUM(olden.tblSanadDetail_MD.Bedehkar) AS Bedehkar, SUM(olden.tblSanadDetail_MD.Bestankar) AS Bestankar
                          FROM            olden.tblSanadDetail_MD INNER JOIN
                                                    olden.tblSanad_MD ON olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName AND 
                                                    olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id INNER JOIN
                                                    olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id INNER JOIN
                                                    olden.tblGroup ON olden.tblKol.IdGroup = olden.tblGroup.Id
                          WHERE  (olden.tblSanad_MD.AreaId = @AreaId) AND
						         (olden.tblSanad_MD.YearName = @YearName) AND
								 (olden.tblSanadDetail_MD.AreaId = @AreaId) AND
								 (olden.tblSanad_MD.YearName = @YearName) AND 
								-- (olden.tblSanad_MD.SanadDateS between '1402/01/01' and '1402/07/30')AND
                                 (olden.tblSanadDetail_MD.YearName = @YearName) AND
								 (olden.tblKol.AreaId = @AreaId) AND
								 (olden.tblGroup.AreaId = @AreaId) AND
								 (olden.tblKol.YearName = @YearName) AND 
                                 (olden.tblGroup.YearName = @YearName)AND
								 (olden.tblKol.IdGroup in (select Id from @temp))
                          GROUP BY olden.tblSanadDetail_MD.IdKol) AS tbl1 INNER JOIN
                         olden.tblKol AS tblKol_1 ON tbl1.IdKol = tblKol_1.id
WHERE   (tblKol_1.AreaId = @AreaId) AND
        (tblKol_1.YearName = @YearName)
UNION ALL
SELECT    2 as Levels,    tbl1.IdMoien, tblMoien_1.Name, tbl1.Bedehkar, tbl1.Bestankar, 
 CASE WHEN tbl1.Bedehkar - tbl1.Bestankar > 0 THEN tbl1.Bedehkar - tbl1.Bestankar ELSE 0 END AS BalanceBedehkar, 
                         CASE WHEN tbl1.Bedehkar - tbl1.Bestankar < 0 THEN tbl1.Bestankar - tbl1.Bedehkar ELSE 0 END AS BalanceBestankar
FROM            (SELECT        olden.tblSanadDetail_MD.IdKol, SUM(olden.tblSanadDetail_MD.Bedehkar) AS Bedehkar, SUM(olden.tblSanadDetail_MD.Bestankar) AS Bestankar, olden.tblSanadDetail_MD.IdMoien
                          FROM            olden.tblMoien INNER JOIN
                                                    olden.tblSanadDetail_MD INNER JOIN
                                                    olden.tblSanad_MD ON olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName AND 
                                                    olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id ON olden.tblMoien.Id = olden.tblSanadDetail_MD.IdMoien INNER JOIN
                                                    olden.tblGroup INNER JOIN
                                                    olden.tblKol ON olden.tblGroup.Id = olden.tblKol.IdGroup ON olden.tblMoien.IdKol = olden.tblKol.id
                          WHERE  (olden.tblSanad_MD.AreaId = @AreaId) AND
						         (olden.tblSanad_MD.AreaId = @AreaId) AND
								 (olden.tblSanadDetail_MD.AreaId = @AreaId) AND
								 (olden.tblSanad_MD.YearName = @YearName) AND 
                                 (olden.tblSanadDetail_MD.YearName = @YearName) AND
								 (olden.tblKol.AreaId = @AreaId) AND
								 (olden.tblGroup.AreaId = @AreaId) AND
								 (olden.tblKol.YearName = @YearName) AND 
								-- (olden.tblSanad_MD.SanadDateS between '1402/01/01' and '1402/07/30')AND
                                 (olden.tblGroup.YearName = @YearName) AND
								 (olden.tblMoien.AreaId = @AreaId) AND
								 (olden.tblMoien.YearName = @YearName)AND
								 (olden.tblKol.IdGroup in (select id from @temp))
                          GROUP BY olden.tblSanadDetail_MD.IdKol, olden.tblSanadDetail_MD.IdMoien) AS tbl1 INNER JOIN
                         olden.tblMoien AS tblMoien_1 ON tbl1.IdMoien = tblMoien_1.Id
WHERE    (tblMoien_1.AreaId = @AreaId) AND
         (tblMoien_1.YearName = @YearName)
ORDER BY tbl1.IdKol
return 
end
--تراز تفضیل
if (@MoienId is not null and @TafsilyId is null)
begin
if(@AreaId<=9)
begin
SELECT        tbl1.IdTafsily4 AS Code, olden.tblTafsily.Name AS Description, tbl1.IdTafsily5 as MarkazHazine, tblTafsily_1.Name as MarkazHazineName, tbl1.Bedehkar, tbl1.Bestankar, 
                         CASE WHEN tbl1.Bedehkar - tbl1.Bestankar > 0 THEN tbl1.Bedehkar - tbl1.Bestankar ELSE 0 END AS BalanceBedehkar, 
                         CASE WHEN tbl1.Bedehkar - tbl1.Bestankar < 0 THEN tbl1.Bestankar - tbl1.Bedehkar ELSE 0 END AS BalanceBestankar, 100 AS Levels
FROM            (SELECT        olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5, SUM(olden.tblSanadDetail_MD.Bedehkar) AS Bedehkar, SUM(olden.tblSanadDetail_MD.Bestankar) AS Bestankar
                          FROM            olden.tblSanadDetail_MD INNER JOIN
                                                    olden.tblSanad_MD ON olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName AND 
                                                    olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id
                          WHERE  (olden.tblSanad_MD.AreaId = @AreaId) AND
						         (olden.tblSanad_MD.YearName = @YearName) AND
								 (olden.tblSanadDetail_MD.AreaId = @AreaId) AND
								 (olden.tblSanadDetail_MD.YearName = @YearName) AND 
								-- (olden.tblSanad_MD.SanadDateS between '1402/01/01' and '1402/07/30')AND
                                 (olden.tblSanadDetail_MD.IdMoien = @MoienId)
                          GROUP BY olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5) AS tbl1 LEFT OUTER JOIN
                         olden.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id LEFT OUTER JOIN
                         olden.tblTafsily ON tbl1.IdTafsily4 = olden.tblTafsily.Id
WHERE  (olden.tblTafsily.AreaId = @AreaId) AND
       (olden.tblTafsily.YearName = @YearName) AND
	   (olden.tblTafsily.IdSotooh = 4)AND
	   (tblTafsily_1.AreaId = @AreaId) AND
	   (tblTafsily_1.YearName = @YearName)AND
	    (tblTafsily_1.IdSotooh = 5)
ORDER BY Code
	return 
end

if(@AreaId>=11)
begin
SELECT        tbl1.IdTafsily4 AS Code, olden.tblTafsily.Name AS Description, '' AS MarkazHazine, '' AS MarkazHazineName,
              tbl1.Bedehkar, tbl1.Bestankar, 
                         CASE WHEN tbl1.Bedehkar - tbl1.Bestankar > 0 THEN tbl1.Bedehkar - tbl1.Bestankar ELSE 0 END AS BalanceBedehkar, 
                         CASE WHEN tbl1.Bedehkar - tbl1.Bestankar < 0 THEN tbl1.Bestankar - tbl1.Bedehkar ELSE 0 END AS BalanceBestankar, 100 AS Levels
FROM            (SELECT        olden.tblSanadDetail_MD.IdTafsily4, SUM(olden.tblSanadDetail_MD.Bedehkar) AS Bedehkar, SUM(olden.tblSanadDetail_MD.Bestankar) AS Bestankar
                          FROM            olden.tblSanadDetail_MD INNER JOIN
                                                    olden.tblSanad_MD ON olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName AND 
                                                    olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id
                          WHERE (olden.tblSanad_MD.AreaId = @AreaId) AND
						        (olden.tblSanad_MD.YearName = @YearName) AND
								(olden.tblSanadDetail_MD.AreaId = @AreaId) AND
								(olden.tblSanadDetail_MD.YearName = @YearName) AND 
								--(olden.tblSanad_MD.SanadDateS between '1402/01/01' and '1402/07/30')AND
                                (olden.tblSanadDetail_MD.IdMoien = @MoienId)
                          GROUP BY olden.tblSanadDetail_MD.IdTafsily4) AS tbl1 LEFT OUTER JOIN
                         olden.tblTafsily ON tbl1.IdTafsily4 = olden.tblTafsily.Id
WHERE  (olden.tblTafsily.AreaId = @AreaId) AND
       (olden.tblTafsily.YearName = @YearName)
ORDER BY Code
	return 
end

end
--دفتر
if (@TafsilyId is not null)
begin
if(@AreaId <=9 )
begin
SELECT  olden.tblSanadDetail_MD.IdSanad_MD as SanadNumber, olden.tblSanad_MD.SanadDateS SanadDate, 
        olden.tblSanadDetail_MD.Description, olden.tblSanadDetail_MD.Bedehkar, 
		olden.tblSanadDetail_MD.Bestankar, 200 as Levels
FROM            olden.tblSanadDetail_MD INNER JOIN
                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName AND 
                         olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id INNER JOIN
                         olden.tblTafsily ON olden.tblSanadDetail_MD.AreaId = olden.tblTafsily.AreaId AND olden.tblSanadDetail_MD.YearName = olden.tblTafsily.YearName AND olden.tblSanadDetail_MD.IdTafsily4 = olden.tblTafsily.Id AND 
                         olden.tblSanadDetail_MD.IdSotooh4 = olden.tblTafsily.IdSotooh
WHERE (olden.tblSanad_MD.AreaId = @AreaId) AND
      (olden.tblSanad_MD.AreaId = @AreaId) AND
	  (olden.tblSanadDetail_MD.AreaId = @AreaId) AND
	  (olden.tblSanad_MD.YearName = @YearName) AND 
	  (olden.tblSanadDetail_MD.YearName = @YearName) AND
	  (olden.tblSanadDetail_MD.IdTafsily4 = @TafsilyId) AND 
	  --	 (olden.tblSanad_MD.SanadDateS between '1402/01/01' and '1402/07/30')AND
	  (olden.tblSanadDetail_MD.IdTafsily5 = @MarkazHazine) AND 
      (olden.tblTafsily.AreaId = @AreaId) AND
	  (olden.tblTafsily.YearName = @YearName) AND
	  (olden.tblSanadDetail_MD.IdMoien = @MoienId)
order by olden.tblSanadDetail_MD.IdSanad_MD
return
end

if(@AreaId >=11)
begin
SELECT  olden.tblSanadDetail_MD.IdSanad_MD as SanadNumber, olden.tblSanad_MD.SanadDateS SanadDate, 
        olden.tblSanadDetail_MD.Description, olden.tblSanadDetail_MD.Bedehkar, 
		olden.tblSanadDetail_MD.Bestankar, 200 as Levels
FROM            olden.tblSanadDetail_MD INNER JOIN
                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName AND 
                         olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id INNER JOIN
                         olden.tblTafsily ON olden.tblSanadDetail_MD.AreaId = olden.tblTafsily.AreaId AND olden.tblSanadDetail_MD.YearName = olden.tblTafsily.YearName AND olden.tblSanadDetail_MD.IdTafsily4 = olden.tblTafsily.Id AND 
                         olden.tblSanadDetail_MD.IdSotooh4 = olden.tblTafsily.IdSotooh
WHERE (olden.tblSanad_MD.AreaId = @AreaId) AND
      (olden.tblSanad_MD.AreaId = @AreaId) AND
	  (olden.tblSanadDetail_MD.AreaId = @AreaId) AND
	  (olden.tblSanad_MD.YearName = @YearName) AND 
	  (olden.tblSanadDetail_MD.YearName = @YearName) AND
	  (olden.tblSanadDetail_MD.IdTafsily4 = @TafsilyId) AND 
	  	-- (olden.tblSanad_MD.SanadDateS between '1402/01/01' and '1402/07/30')AND
      (olden.tblTafsily.AreaId = @AreaId) AND
	  (olden.tblTafsily.YearName = @YearName)AND
	  (olden.tblSanadDetail_MD.IdMoien = @MoienId)
order by olden.tblSanadDetail_MD.IdSanad_MD
return
end

end

END


GO
