USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9000_Mapping_Shahdari_Read]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9000_Mapping_Shahdari_Read]
@yearId int ,
@areaId int
AS
BEGIN
if(@yearId = 32 and @areaId=1)
begin
SELECT      1  as Area,   tblTafsily.id as Idtafsily4, tblTafsily.Name as DesTafsily4,tblTafsily_1.Id as Idtafsily5, tblTafsily_1.Name AS DesTafsily5, tblSanadDetail_MD.Bedehkar, tblSanadDetail_MD.Bestankar, tblSanadDetail_MD.Description 
                       
FROM            AKH.AccAMJ1001.dbo.tblSanad_MD INNER JOIN
                         AKH.AccAMJ1001.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
                         AKH.AccAMJ1001.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
                         AKH.AccAMJ1001.dbo.tblTafsily AS tblTafsily_1 ON tblSanadDetail_MD.IdTafsily5 = tblTafsily_1.Id AND tblSanadDetail_MD.IdSotooh5 = tblTafsily_1.IdSotooh INNER JOIN
                         AKH.AccAMJ1001.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
                         AKH.AccAMJ1001.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
WHERE    (tblSanad_MD.IdSal_MD = 18) AND
         (tblKol.IdGroup = 8)AND
		 (tblTafsily.IdTafsilyGroup = 18)
order by tblTafsily.Id
return
end

if(@yearId = 32 and @areaId = 2)
begin

SELECT      2 as Area,   tblTafsily.Id, tblTafsily.Name,  tblTafsily_1.Name AS Expr2, tblSanadDetail_MD.Bedehkar, tblSanadDetail_MD.Bestankar, tblSanadDetail_MD.Description 
                       
FROM            AKH.AccAMJ1002.dbo.tblSanad_MD INNER JOIN
                         AKH.AccAMJ1002.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
                         AKH.AccAMJ1002.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
                         AKH.AccAMJ1002.dbo.tblTafsily AS tblTafsily_1 ON tblSanadDetail_MD.IdTafsily5 = tblTafsily_1.Id AND tblSanadDetail_MD.IdSotooh5 = tblTafsily_1.IdSotooh INNER JOIN
                         AKH.AccAMJ1002.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
                         AKH.AccAMJ1002.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
WHERE   (tblSanad_MD.IdSal_MD = 21) and
        (tblKol.IdGroup = 8 )and  
		(tblTafsily.IdTafsilyGroup = 18)
return
end
if(@yearId = 32 and @areaId = 3)
begin

SELECT      3 as Area,   tblTafsily.Id, tblTafsily.Name,  tblTafsily_1.Name AS Expr2, tblSanadDetail_MD.Bedehkar, tblSanadDetail_MD.Bestankar, tblSanadDetail_MD.Description 
                       
FROM            AKH.AccAMJ1003.dbo.tblSanad_MD INNER JOIN
                         AKH.AccAMJ1003.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
                         AKH.AccAMJ1003.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
                         AKH.AccAMJ1003.dbo.tblTafsily AS tblTafsily_1 ON tblSanadDetail_MD.IdTafsily5 = tblTafsily_1.Id AND tblSanadDetail_MD.IdSotooh5 = tblTafsily_1.IdSotooh INNER JOIN
                         AKH.AccAMJ1003.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
                         AKH.AccAMJ1003.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
WHERE    (tblSanad_MD.IdSal_MD = 18) and
          tblKol.IdGroup=8 and
		  tblTafsily.IdTafsilyGroup=18
return
end

if(@yearId = 32 and @areaId = 4)
begin
SELECT        4 AS Area, tblTafsily.Id, tblTafsily.Name, tblTafsily_1.Name AS Expr2, tblSanadDetail_MD.Bedehkar, tblSanadDetail_MD.Bestankar, tblSanadDetail_MD.Description
FROM            AKH.AccAMJ1004.dbo.tblSanad_MD INNER JOIN
                         AKH.AccAMJ1004.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
                         AKH.AccAMJ1004.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
                         AKH.AccAMJ1004.dbo.tblTafsily AS tblTafsily_1 ON tblSanadDetail_MD.IdTafsily5 = tblTafsily_1.Id AND tblSanadDetail_MD.IdSotooh5 = tblTafsily_1.IdSotooh INNER JOIN
                         AKH.AccAMJ1004.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
                         AKH.AccAMJ1004.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
WHERE     (tblSanad_MD.IdSal_MD = 16) AND
          (tblKol.IdGroup = 8) AND
		  (tblTafsily.IdTafsilyGroup = 18)
return
end

if(@yearId = 32 and @areaId= 5)
begin

SELECT      5 as Area,   tblTafsily.Id, tblTafsily.Name,  tblTafsily_1.Name AS Expr2, tblSanadDetail_MD.Bedehkar, tblSanadDetail_MD.Bestankar, tblSanadDetail_MD.Description 
                       
FROM            AKH.AccAMJ1005.dbo.tblSanad_MD INNER JOIN
                         AKH.AccAMJ1005.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
                         AKH.AccAMJ1005.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
                         AKH.AccAMJ1005.dbo.tblTafsily AS tblTafsily_1 ON tblSanadDetail_MD.IdTafsily5 = tblTafsily_1.Id AND tblSanadDetail_MD.IdSotooh5 = tblTafsily_1.IdSotooh INNER JOIN
                         AKH.AccAMJ1005.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
                         AKH.AccAMJ1005.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
WHERE    (tblSanad_MD.IdSal_MD = 15) and
          tblKol.IdGroup=8 and
		  tblTafsily.IdTafsilyGroup=18
return
end

if(@yearId = 32 and @areaId = 6)
begin

SELECT      6 as Area,   tblTafsily.Id, tblTafsily.Name,  tblTafsily_1.Name AS Expr2, tblSanadDetail_MD.Bedehkar, tblSanadDetail_MD.Bestankar, tblSanadDetail_MD.Description 
                       
FROM            AKH.AccAMJ1006.dbo.tblSanad_MD INNER JOIN
                         AKH.AccAMJ1006.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
                         AKH.AccAMJ1006.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
                         AKH.AccAMJ1006.dbo.tblTafsily AS tblTafsily_1 ON tblSanadDetail_MD.IdTafsily5 = tblTafsily_1.Id AND tblSanadDetail_MD.IdSotooh5 = tblTafsily_1.IdSotooh INNER JOIN
                         AKH.AccAMJ1006.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
                         AKH.AccAMJ1006.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
WHERE   (tblSanad_MD.IdSal_MD = 15) and
         tblKol.IdGroup=8 and
		 tblTafsily.IdTafsilyGroup=18
return
end

if(@yearId = 32 and @areaId= 7)
begin

SELECT      7 as Area,   tblTafsily.Id, tblTafsily.Name,  tblTafsily_1.Name AS Expr2, tblSanadDetail_MD.Bedehkar, tblSanadDetail_MD.Bestankar, tblSanadDetail_MD.Description 
                       
FROM            AKH.AccAMJ1007.dbo.tblSanad_MD INNER JOIN
                         AKH.AccAMJ1007.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
                         AKH.AccAMJ1007.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
                         AKH.AccAMJ1007.dbo.tblTafsily AS tblTafsily_1 ON tblSanadDetail_MD.IdTafsily5 = tblTafsily_1.Id AND tblSanadDetail_MD.IdSotooh5 = tblTafsily_1.IdSotooh INNER JOIN
                         AKH.AccAMJ1007.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
                         AKH.AccAMJ1007.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
WHERE    (tblSanad_MD.IdSal_MD = 13) and
          tblKol.IdGroup=8 and
		  tblTafsily.IdTafsilyGroup=18
return
end

if(@yearId = 32 and @areaId = 8)
begin

SELECT      8 as Area,   tblTafsily.Id, tblTafsily.Name,  tblTafsily_1.Name AS Expr2, tblSanadDetail_MD.Bedehkar, tblSanadDetail_MD.Bestankar, tblSanadDetail_MD.Description 
                       
FROM            AKH.AccAMJ1008.dbo.tblSanad_MD INNER JOIN
                         AKH.AccAMJ1008.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
                         AKH.AccAMJ1008.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
                         AKH.AccAMJ1008.dbo.tblTafsily AS tblTafsily_1 ON tblSanadDetail_MD.IdTafsily5 = tblTafsily_1.Id AND tblSanadDetail_MD.IdSotooh5 = tblTafsily_1.IdSotooh INNER JOIN
                         AKH.AccAMJ1008.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
                         AKH.AccAMJ1008.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
WHERE    (tblSanad_MD.IdSal_MD = 13) and
          tblKol.IdGroup=8 and
		  tblTafsily.IdTafsilyGroup=18
return
end

if(@yearId = 32 and @areaId = 9)
begin

SELECT      9 as Area,   tblTafsily.Id, tblTafsily.Name,  tblTafsily_1.Name AS Expr2, tblSanadDetail_MD.Bedehkar, tblSanadDetail_MD.Bestankar, tblSanadDetail_MD.Description 
                       
FROM            AKH.AccAMJ1000.dbo.tblSanad_MD INNER JOIN
                         AKH.AccAMJ1000.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
                         AKH.AccAMJ1000.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
                         AKH.AccAMJ1000.dbo.tblTafsily AS tblTafsily_1 ON tblSanadDetail_MD.IdTafsily5 = tblTafsily_1.Id AND tblSanadDetail_MD.IdSotooh5 = tblTafsily_1.IdSotooh INNER JOIN
                         AKH.AccAMJ1000.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
                         AKH.AccAMJ1000.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
WHERE        (tblSanad_MD.IdSal_MD = 11) and
             tblKol.IdGroup=8 and
			 tblTafsily.IdTafsilyGroup=18
ORDER BY  tblTafsily.Id
return
end
END
GO
