USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9900_Taraz_1reyal_Read]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9900_Taraz_1reyal_Read]

AS
BEGIN
declare @date nvarchar(10)='1402/07/30'
SELECT     1 as area,   tblSanadDetail_MD_1.IdSanad_MD as IdSanad, tblSanad_MD_1.SanadDateS as SanadDate, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
				tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ1001.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1001.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.bedehkar = 1 ) and tblSanad_MD_1.SanadDateS=@date

union all

SELECT     2 as area,   tblSanadDetail_MD_1.IdSanad_MD as IdSanad, tblSanad_MD_1.SanadDateS as SanadDate, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
				tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ1002.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1002.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.bedehkar = 1 ) and  tblSanad_MD_1.SanadDateS=@date

union all

SELECT     3 as area,   tblSanadDetail_MD_1.IdSanad_MD as IdSanad, tblSanad_MD_1.SanadDateS as SanadDate, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
				tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ1003.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1003.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.bedehkar = 1 ) and  tblSanad_MD_1.SanadDateS=@date

union all

SELECT     4 as area,   tblSanadDetail_MD_1.IdSanad_MD as IdSanad, tblSanad_MD_1.SanadDateS as SanadDate, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
				tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ1004.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1004.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.bedehkar = 1 ) and  tblSanad_MD_1.SanadDateS=@date

union all

SELECT     5 as area,   tblSanadDetail_MD_1.IdSanad_MD as IdSanad, tblSanad_MD_1.SanadDateS as SanadDate, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
				tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ1005.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1005.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.bedehkar = 1 ) and  tblSanad_MD_1.SanadDateS=@date

union all

SELECT     6 as area,   tblSanadDetail_MD_1.IdSanad_MD as IdSanad, tblSanad_MD_1.SanadDateS as SanadDate, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
				tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ1006.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1006.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.bedehkar = 1 ) and  tblSanad_MD_1.SanadDateS=@date

union all

SELECT     7 as area,   tblSanadDetail_MD_1.IdSanad_MD as IdSanad, tblSanad_MD_1.SanadDateS as SanadDate, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
				tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ1007.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1007.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.bedehkar = 1 ) and  tblSanad_MD_1.SanadDateS=@date

union all

SELECT     8 as area,   tblSanadDetail_MD_1.IdSanad_MD as IdSanad, tblSanad_MD_1.SanadDateS as SanadDate, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
				tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ1008.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1008.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.bedehkar = 1 ) and  tblSanad_MD_1.SanadDateS=@date

union all

SELECT     9 as area,   tblSanadDetail_MD_1.IdSanad_MD as IdSanad, tblSanad_MD_1.SanadDateS as SanadDate, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
				tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ1000.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1000.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE        (tblSanadDetail_MD_1.bedehkar = 1 ) and  tblSanad_MD_1.SanadDateS=@date
END
GO
