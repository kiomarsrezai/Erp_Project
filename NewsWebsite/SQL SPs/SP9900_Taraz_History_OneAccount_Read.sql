USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9900_Taraz_History_OneAccount_Read]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9900_Taraz_History_OneAccount_Read]
@IdMoein bigint,
@IdTafsil bigint,
@AreaId int
AS
BEGIN
declare @Title nvarchar(1000)=(select TOP(1) Name from olden.tblTafsily where Id= @IdTafsil and AreaId = @AreaId)
if(@AreaId=1)
begin
SELECT        tblSanadDetail_MD_1.IdSanad_MD as IdSanad, tblSanad_MD_1.SanadDateS as SanadDate, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
				tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ1001.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1001.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE         (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)
union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD, tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien, 
              tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
			  tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ9601.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9601.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD, tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, 
				tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ9501.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9501.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD, tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
              tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
			  tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ9401.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9401.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD, tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, 
				tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ9301.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9301.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD, tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
              tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
			  tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ9201.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9201.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD, tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
               tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
			   tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ9101.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9101.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD,tblSanad_MD_1.SanadDateS , tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
               tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
			   tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ9001.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9001.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD,tblSanad_MD_1.SanadDateS , tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
               tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
			   tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ8901.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8901.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD,tblSanad_MD_1.SanadDateS , tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
               tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
			   tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ8801.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8801.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD,tblSanad_MD_1.SanadDateS , tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
               tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
			   tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ8701.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8701.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD,tblSanad_MD_1.SanadDateS , tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
               tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
			   tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ1386.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1386.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)



order by tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdSanad_MD
return
end

if(@AreaId=2)
begin
SELECT        tblSanadDetail_MD_1.IdSanad_MD as IdSanad, tblSanad_MD_1.SanadDateS as SanadDate, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
				tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ1002.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ1002.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE         (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)
union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD, tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien, 
              tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
			  tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ9602.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9602.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD, tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, 
				tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ9502.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9502.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD, tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
              tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
			  tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ9402.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9402.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD, tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
                tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar, 
				tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ9302.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9302.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD, tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
              tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
			  tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ9202.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9202.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD, tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
               tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
			   tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ9102.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9102.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD,tblSanad_MD_1.SanadDateS , tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
               tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
			   tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ9002.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ9002.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD,tblSanad_MD_1.SanadDateS , tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
               tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
			   tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ8902.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8902.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD,tblSanad_MD_1.SanadDateS , tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
               tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
			   tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ8802.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8802.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)

union all
SELECT        tblSanadDetail_MD_1.IdSanad_MD,tblSanad_MD_1.SanadDateS , tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,
               tblSanadDetail_MD_1.Description, tblSanadDetail_MD_1.Bedehkar, tblSanadDetail_MD_1.Bestankar,
			   tblSanadDetail_MD_1.AtfCh, tblSanadDetail_MD_1.AtfDt
FROM            AKH.AccAMJ8702.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 INNER JOIN
                         AKH.AccAMJ8702.dbo.tblSanad_MD AS tblSanad_MD_1 ON tblSanadDetail_MD_1.IdSanad_MD = tblSanad_MD_1.Id AND tblSanadDetail_MD_1.IdSalSanad_MD = tblSanad_MD_1.IdSal_MD
WHERE          (tblSanadDetail_MD_1.IdMoien = @IdMoein) AND (tblSanadDetail_MD_1.IdTafsily4 = @IdTafsil)


order by tblSanadDetail_MD_1.IdKol, tblSanadDetail_MD_1.IdMoien,tblSanad_MD_1.SanadDateS, tblSanadDetail_MD_1.IdSanad_MD
return
end

END
GO
