USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9900_Taraz_HistoryAccount_Read]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9900_Taraz_HistoryAccount_Read]
@IdTafsil int,--2100098
@AreaId int    --1
AS
BEGIN

if(@AreaId = 1)
begin
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ1001.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1001.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)
union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9601.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9601.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9501.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9501.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)
union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9401.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9401.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9301.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9301.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9201.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9201.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9101.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9101.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9001.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9001.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8901.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8901.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblKol      WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblMoien    WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily  WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8801.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8801.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8701.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8701.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

order by tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdSanad_MD
return
end

if(@AreaId = 2)
begin
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ1002.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1002.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)
union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9602.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9602.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9502.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9502.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)
union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9402.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9402.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9302.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9302.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9202.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9202.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9102.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9102.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9002.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9002.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8902.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8902.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblKol      WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblMoien    WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily  WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8802.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8802.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8702.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8702.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

order by tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdSanad_MD
return
end

if(@AreaId = 3)
begin
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ1003.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1003.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)
union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9603.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9603.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9503.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9503.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)
union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9403.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9403.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9303.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9303.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9203.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9203.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9103.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9103.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9003.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9003.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8903.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8903.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblKol      WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblMoien    WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily  WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8803.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8803.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8703.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8703.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

order by tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdSanad_MD
return
end

if(@AreaId = 4)
begin
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ1004.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1004.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)
union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9604.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9604.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9504.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9504.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)
union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9404.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9404.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9304.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9304.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9204.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9204.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9104.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9104.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9004.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9004.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8904.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8904.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblKol      WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblMoien    WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily  WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8804.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8804.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8704.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8704.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

order by tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdSanad_MD
return
end

if(@AreaId = 5)
begin
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ1005.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1005.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)
union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9605.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9605.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9505.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9505.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)


order by tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdSanad_MD
return
end

if(@AreaId = 6)
begin
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ1006.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1006.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)
union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9606.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9606.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9506.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9506.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)
union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9406.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9406.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9306.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9306.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9206.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9206.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9106.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9106.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9006.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9006.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8906.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8906.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblKol      WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblMoien    WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily  WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8806.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8806.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8706.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8706.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

order by tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdSanad_MD
return
end

if(@AreaId = 7)
begin
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ1007.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1007.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)
union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9607.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9607.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9507.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9507.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)
union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9407.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9407.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9307.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9307.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9207.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9207.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9107.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9107.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9007.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9007.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8907.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8907.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblKol      WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblMoien    WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily  WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8807.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8807.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8707.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8707.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

order by tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdSanad_MD
return
end

if(@AreaId = 8)
begin
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ1008.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1008.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)
union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9608.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9608.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9508.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9508.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)
union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9408.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9408.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9308.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9308.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9208.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9208.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9108.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9108.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ9008.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9008.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8908.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8908.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblKol      WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblMoien    WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT  Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily  WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8808.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8808.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD AS IdSanad, tblSanad_MD_1.SanadDateS AS SanadDate, tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, tblSanadDetail_MD_1.AtfCh, 
                         tblSanadDetail_MD_1.AtfDt, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblKol     WHERE (Id = tblSanadDetail_MD_1.IdKol)) AS KolName,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblMoien   WHERE (Id = tblSanadDetail_MD_1.IdMoien)) AS MoienName,
                             (SELECT   Name  FROM  AKH.AccAMJ1001.dbo.tblTafsily WHERE (Id = @IdTafsil)) AS TafsilyName
FROM            AKH.AccAMJ8708.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8708.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

order by tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdSanad_MD
return
end
END
GO
