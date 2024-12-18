USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[akavan]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[akavan]

AS
BEGIN
select stuff(((SELECT  '-'+ cast(olden.tblSanad_MD.Id as nvarchar(10))
FROM            olden.tblSanadDetail_MD INNER JOIN
                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName
WHERE   (olden.tblSanad_MD.AreaId = 7) AND 
        (olden.tblSanad_MD.YearName = 1401) AND
		(olden.tblSanadDetail_MD.IdKol = N'8255') AND
		(olden.tblSanadDetail_MD.IdMoien = N'82550002') AND 
        (olden.tblSanadDetail_MD.IdTafsily4 = N'7000005') AND
		(olden.tblSanadDetail_MD.IdTafsily5 = N'80143') 
		group by  olden.tblSanad_MD.AreaId,olden.tblSanad_MD.Id FOR XML PATH (''))), 1, 1, '')  as AcceptPerson

SELECT        tbl1.IdTafsily4, tblTafsily.Name, tbl1.IdTafsily5, tblTafsily_1.Name AS Name5, tbl1.expense
FROM            (SELECT        tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5, format(SUM(tblSanadDetail_MD.Bestankar - tblSanadDetail_MD.Bedehkar), '##,##') AS expense
                          FROM           AkH.AccAMJ1001.dbo.tblSanadDetail_MD INNER JOIN
                                                    AkH.AccAMJ1001.dbo.tblSanad_MD ON tblSanadDetail_MD.IdSanad_MD = tblSanad_MD.Id AND tblSanadDetail_MD.IdSalSanad_MD = tblSanad_MD.IdSal_MD INNER JOIN
                                                    AkH.AccAMJ1001.dbo.tblTafsily AS tblTafsily_2 ON tblSanadDetail_MD.IdTafsily4 = tblTafsily_2.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily_2.IdSotooh INNER JOIN
                                                    AkH.AccAMJ1001.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id
                          WHERE        (tblSanadDetail_MD.IdSalSanad_MD = 18) AND (tblKol.IdGroup = '7')
                          GROUP BY tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5) AS tbl1 LEFT OUTER JOIN
                         AkH.AccAMJ1001.dbo.tblTafsily ON tbl1.IdTafsily4 = tblTafsily.Id LEFT OUTER JOIN
                         AkH.AccAMJ1001.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
ORDER BY tbl1.IdTafsily4

SELECT      format(sum(tblSanadDetail_MD.Bestankar - tblSanadDetail_MD.Bedehkar),'##,##') AS expense
FROM            AkH.AccAMJ1001.dbo.tblSanadDetail_MD INNER JOIN
                         AkH.AccAMJ1001.dbo.tblSanad_MD ON tblSanadDetail_MD.IdSanad_MD = tblSanad_MD.Id AND tblSanadDetail_MD.IdSalSanad_MD = tblSanad_MD.IdSal_MD INNER JOIN
                         AkH.AccAMJ1001.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
                         AkH.AccAMJ1001.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id
WHERE        (tblSanadDetail_MD.IdSalSanad_MD = 18) AND (tblKol.IdGroup = '7')

--=========================================================================================
SELECT        tbl1.IdTafsily4, tblTafsily.Name, tbl1.IdTafsily5, tblTafsily_1.Name AS Name5, tbl1.expense
FROM            (SELECT        tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5, format(SUM(tblSanadDetail_MD.Bestankar - tblSanadDetail_MD.Bedehkar), '##,##') AS expense
                          FROM           AkH.AccAMJ1002.dbo.tblSanadDetail_MD INNER JOIN
                                                    AkH.AccAMJ1002.dbo.tblSanad_MD ON tblSanadDetail_MD.IdSanad_MD = tblSanad_MD.Id AND tblSanadDetail_MD.IdSalSanad_MD = tblSanad_MD.IdSal_MD INNER JOIN
                                                    AkH.AccAMJ1002.dbo.tblTafsily AS tblTafsily_2 ON tblSanadDetail_MD.IdTafsily4 = tblTafsily_2.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily_2.IdSotooh INNER JOIN
                                                    AkH.AccAMJ1002.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id
                          WHERE        (tblSanadDetail_MD.IdSalSanad_MD = 21) AND (tblKol.IdGroup = '7')
                          GROUP BY tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5) AS tbl1 LEFT OUTER JOIN
                         AkH.AccAMJ1002.dbo.tblTafsily ON tbl1.IdTafsily4 = tblTafsily.Id LEFT OUTER JOIN
                         AkH.AccAMJ1002.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
ORDER BY tbl1.IdTafsily4



SELECT      format(sum(tblSanadDetail_MD.Bestankar - tblSanadDetail_MD.Bedehkar),'##,##') AS expense
FROM            AkH.AccAMJ1002.dbo.tblSanadDetail_MD INNER JOIN
                         AkH.AccAMJ1002.dbo.tblSanad_MD ON tblSanadDetail_MD.IdSanad_MD = tblSanad_MD.Id AND tblSanadDetail_MD.IdSalSanad_MD = tblSanad_MD.IdSal_MD INNER JOIN
                         AkH.AccAMJ1002.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
                         AkH.AccAMJ1002.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id
WHERE        (tblSanadDetail_MD.IdSalSanad_MD = 21) AND (tblKol.IdGroup = '7')
--==========================================================================================

SELECT        tbl1.IdTafsily4, tblTafsily.Name, tbl1.IdTafsily5, tblTafsily_1.Name AS Name5, tbl1.expense
FROM            (SELECT        tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5, format(SUM(tblSanadDetail_MD.Bestankar - tblSanadDetail_MD.Bedehkar), '##,##') AS expense
                          FROM           AkH.AccAMJ1003.dbo.tblSanadDetail_MD INNER JOIN
                                                    AkH.AccAMJ1003.dbo.tblSanad_MD ON tblSanadDetail_MD.IdSanad_MD = tblSanad_MD.Id AND tblSanadDetail_MD.IdSalSanad_MD = tblSanad_MD.IdSal_MD INNER JOIN
                                                    AkH.AccAMJ1003.dbo.tblTafsily AS tblTafsily_2 ON tblSanadDetail_MD.IdTafsily4 = tblTafsily_2.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily_2.IdSotooh INNER JOIN
                                                    AkH.AccAMJ1003.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id
                          WHERE        (tblSanadDetail_MD.IdSalSanad_MD = 18) AND (tblKol.IdGroup = '7')
                          GROUP BY tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5) AS tbl1 LEFT OUTER JOIN
                         AkH.AccAMJ1003.dbo.tblTafsily ON tbl1.IdTafsily4 = tblTafsily.Id LEFT OUTER JOIN
                         AkH.AccAMJ1003.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
ORDER BY tbl1.IdTafsily4



SELECT      format(sum(tblSanadDetail_MD.Bestankar - tblSanadDetail_MD.Bedehkar),'##,##') AS expense
FROM            AkH.AccAMJ1003.dbo.tblSanadDetail_MD INNER JOIN
                         AkH.AccAMJ1003.dbo.tblSanad_MD ON tblSanadDetail_MD.IdSanad_MD = tblSanad_MD.Id AND tblSanadDetail_MD.IdSalSanad_MD = tblSanad_MD.IdSal_MD INNER JOIN
                         AkH.AccAMJ1003.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
                         AkH.AccAMJ1003.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id
WHERE        (tblSanadDetail_MD.IdSalSanad_MD = 18) AND (tblKol.IdGroup = '7')
--=================================================================================================

SELECT        tbl1.IdTafsily4, tblTafsily.Name, tbl1.IdTafsily5, tblTafsily_1.Name AS Name5, tbl1.expense
FROM            (SELECT        tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5, format(SUM(tblSanadDetail_MD.Bestankar - tblSanadDetail_MD.Bedehkar), '##,##') AS expense
                          FROM           AkH.AccAMJ1004.dbo.tblSanadDetail_MD INNER JOIN
                                                    AkH.AccAMJ1004.dbo.tblSanad_MD ON tblSanadDetail_MD.IdSanad_MD = tblSanad_MD.Id AND tblSanadDetail_MD.IdSalSanad_MD = tblSanad_MD.IdSal_MD INNER JOIN
                                                    AkH.AccAMJ1004.dbo.tblTafsily AS tblTafsily_2 ON tblSanadDetail_MD.IdTafsily4 = tblTafsily_2.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily_2.IdSotooh INNER JOIN
                                                    AkH.AccAMJ1004.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id
                          WHERE        (tblSanadDetail_MD.IdSalSanad_MD = 16) AND (tblKol.IdGroup = '7')
                          GROUP BY tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5) AS tbl1 LEFT OUTER JOIN
                         AkH.AccAMJ1004.dbo.tblTafsily ON tbl1.IdTafsily4 = tblTafsily.Id LEFT OUTER JOIN
                         AkH.AccAMJ1004.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
ORDER BY tbl1.IdTafsily4



SELECT      format(sum(tblSanadDetail_MD.Bestankar - tblSanadDetail_MD.Bedehkar),'##,##') AS expense
FROM            AkH.AccAMJ1004.dbo.tblSanadDetail_MD INNER JOIN
                         AkH.AccAMJ1004.dbo.tblSanad_MD ON tblSanadDetail_MD.IdSanad_MD = tblSanad_MD.Id AND tblSanadDetail_MD.IdSalSanad_MD = tblSanad_MD.IdSal_MD INNER JOIN
                         AkH.AccAMJ1004.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
                         AkH.AccAMJ1004.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id
WHERE        (tblSanadDetail_MD.IdSalSanad_MD = 16) AND (tblKol.IdGroup = '7')
--======================================================================================================

SELECT        tbl1.IdTafsily4, tblTafsily.Name, tbl1.IdTafsily5, tblTafsily_1.Name AS Name5, tbl1.expense
FROM            (SELECT        tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5, format(SUM(tblSanadDetail_MD.Bestankar - tblSanadDetail_MD.Bedehkar), '##,##') AS expense
                          FROM           AkH.AccAMJ1005.dbo.tblSanadDetail_MD INNER JOIN
                                                    AkH.AccAMJ1005.dbo.tblSanad_MD ON tblSanadDetail_MD.IdSanad_MD = tblSanad_MD.Id AND tblSanadDetail_MD.IdSalSanad_MD = tblSanad_MD.IdSal_MD INNER JOIN
                                                    AkH.AccAMJ1005.dbo.tblTafsily AS tblTafsily_2 ON tblSanadDetail_MD.IdTafsily4 = tblTafsily_2.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily_2.IdSotooh INNER JOIN
                                                    AkH.AccAMJ1005.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id
                          WHERE        (tblSanadDetail_MD.IdSalSanad_MD = 15) AND (tblKol.IdGroup = '7')
                          GROUP BY tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5) AS tbl1 LEFT OUTER JOIN
                         AkH.AccAMJ1005.dbo.tblTafsily ON tbl1.IdTafsily4 = tblTafsily.Id LEFT OUTER JOIN
                         AkH.AccAMJ1005.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
ORDER BY tbl1.IdTafsily4



SELECT      format(sum(tblSanadDetail_MD.Bestankar - tblSanadDetail_MD.Bedehkar),'##,##') AS expense
FROM            AkH.AccAMJ1005.dbo.tblSanadDetail_MD INNER JOIN
                         AkH.AccAMJ1005.dbo.tblSanad_MD ON tblSanadDetail_MD.IdSanad_MD = tblSanad_MD.Id AND tblSanadDetail_MD.IdSalSanad_MD = tblSanad_MD.IdSal_MD INNER JOIN
                         AkH.AccAMJ1005.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
                         AkH.AccAMJ1005.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id
WHERE        (tblSanadDetail_MD.IdSalSanad_MD = 15) AND (tblKol.IdGroup = '7')
--=====================================================================================================

SELECT        tbl1.IdTafsily4, tblTafsily.Name, tbl1.IdTafsily5, tblTafsily_1.Name AS Name5, tbl1.expense
FROM            (SELECT        tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5, format(SUM(tblSanadDetail_MD.Bestankar - tblSanadDetail_MD.Bedehkar), '##,##') AS expense
                          FROM           AkH.AccAMJ1006.dbo.tblSanadDetail_MD INNER JOIN
                                                    AkH.AccAMJ1006.dbo.tblSanad_MD ON tblSanadDetail_MD.IdSanad_MD = tblSanad_MD.Id AND tblSanadDetail_MD.IdSalSanad_MD = tblSanad_MD.IdSal_MD INNER JOIN
                                                    AkH.AccAMJ1006.dbo.tblTafsily AS tblTafsily_2 ON tblSanadDetail_MD.IdTafsily4 = tblTafsily_2.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily_2.IdSotooh INNER JOIN
                                                    AkH.AccAMJ1006.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id
                          WHERE        (tblSanadDetail_MD.IdSalSanad_MD = 15) AND (tblKol.IdGroup = '7')
                          GROUP BY tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5) AS tbl1 LEFT OUTER JOIN
                         AkH.AccAMJ1006.dbo.tblTafsily ON tbl1.IdTafsily4 = tblTafsily.Id LEFT OUTER JOIN
                         AkH.AccAMJ1006.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
ORDER BY tbl1.IdTafsily4



SELECT      format(sum(tblSanadDetail_MD.Bestankar - tblSanadDetail_MD.Bedehkar),'##,##') AS expense
FROM            AkH.AccAMJ1006.dbo.tblSanadDetail_MD INNER JOIN
                         AkH.AccAMJ1006.dbo.tblSanad_MD ON tblSanadDetail_MD.IdSanad_MD = tblSanad_MD.Id AND tblSanadDetail_MD.IdSalSanad_MD = tblSanad_MD.IdSal_MD INNER JOIN
                         AkH.AccAMJ1006.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
                         AkH.AccAMJ1006.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id
WHERE        (tblSanadDetail_MD.IdSalSanad_MD = 15) AND (tblKol.IdGroup = '7')
--==========================================================================================================
SELECT        tbl1.IdTafsily4, tblTafsily.Name, tbl1.IdTafsily5, tblTafsily_1.Name AS Name5, tbl1.expense
FROM            (SELECT        tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5, format(SUM(tblSanadDetail_MD.Bestankar - tblSanadDetail_MD.Bedehkar), '##,##') AS expense
                          FROM           AkH.AccAMJ1007.dbo.tblSanadDetail_MD INNER JOIN
                                                    AkH.AccAMJ1007.dbo.tblSanad_MD ON tblSanadDetail_MD.IdSanad_MD = tblSanad_MD.Id AND tblSanadDetail_MD.IdSalSanad_MD = tblSanad_MD.IdSal_MD INNER JOIN
                                                    AkH.AccAMJ1007.dbo.tblTafsily AS tblTafsily_2 ON tblSanadDetail_MD.IdTafsily4 = tblTafsily_2.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily_2.IdSotooh INNER JOIN
                                                    AkH.AccAMJ1007.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id
                          WHERE        (tblSanadDetail_MD.IdSalSanad_MD = 13) AND (tblKol.IdGroup = '7')
                          GROUP BY tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5) AS tbl1 LEFT OUTER JOIN
                         AkH.AccAMJ1007.dbo.tblTafsily ON tbl1.IdTafsily4 = tblTafsily.Id LEFT OUTER JOIN
                         AkH.AccAMJ1007.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
ORDER BY tbl1.IdTafsily4



SELECT      format(sum(tblSanadDetail_MD.Bestankar - tblSanadDetail_MD.Bedehkar),'##,##') AS expense
FROM            AkH.AccAMJ1007.dbo.tblSanadDetail_MD INNER JOIN
                         AkH.AccAMJ1007.dbo.tblSanad_MD ON tblSanadDetail_MD.IdSanad_MD = tblSanad_MD.Id AND tblSanadDetail_MD.IdSalSanad_MD = tblSanad_MD.IdSal_MD INNER JOIN
                         AkH.AccAMJ1007.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
                         AkH.AccAMJ1007.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id
WHERE        (tblSanadDetail_MD.IdSalSanad_MD = 13) AND (tblKol.IdGroup = '7')
--=========================================================================================

SELECT        tbl1.IdTafsily4, tblTafsily.Name, tbl1.IdTafsily5, tblTafsily_1.Name AS Name5, tbl1.expense
FROM            (SELECT        tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5, format(SUM(tblSanadDetail_MD.Bestankar - tblSanadDetail_MD.Bedehkar), '##,##') AS expense
                          FROM           AkH.AccAMJ1008.dbo.tblSanadDetail_MD INNER JOIN
                                                    AkH.AccAMJ1008.dbo.tblSanad_MD ON tblSanadDetail_MD.IdSanad_MD = tblSanad_MD.Id AND tblSanadDetail_MD.IdSalSanad_MD = tblSanad_MD.IdSal_MD INNER JOIN
                                                    AkH.AccAMJ1008.dbo.tblTafsily AS tblTafsily_2 ON tblSanadDetail_MD.IdTafsily4 = tblTafsily_2.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily_2.IdSotooh INNER JOIN
                                                    AkH.AccAMJ1008.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id
                          WHERE        (tblSanadDetail_MD.IdSalSanad_MD = 13) AND (tblKol.IdGroup = '7')
                          GROUP BY tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5) AS tbl1 LEFT OUTER JOIN
                         AkH.AccAMJ1008.dbo.tblTafsily ON tbl1.IdTafsily4 = tblTafsily.Id LEFT OUTER JOIN
                         AkH.AccAMJ1008.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
ORDER BY tbl1.IdTafsily4



SELECT      format(sum(tblSanadDetail_MD.Bestankar - tblSanadDetail_MD.Bedehkar),'##,##') AS expense
FROM            AkH.AccAMJ1008.dbo.tblSanadDetail_MD INNER JOIN
                         AkH.AccAMJ1008.dbo.tblSanad_MD ON tblSanadDetail_MD.IdSanad_MD = tblSanad_MD.Id AND tblSanadDetail_MD.IdSalSanad_MD = tblSanad_MD.IdSal_MD INNER JOIN
                         AkH.AccAMJ1008.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
                         AkH.AccAMJ1008.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id
WHERE        (tblSanadDetail_MD.IdSalSanad_MD = 13) AND (tblKol.IdGroup = '7')
--==========================================================================
SELECT        tbl1.IdTafsily4, tblTafsily.Name, tbl1.IdTafsily5, tblTafsily_1.Name AS Name5, tbl1.expense
FROM            (SELECT        tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5, format(SUM(tblSanadDetail_MD.Bestankar - tblSanadDetail_MD.Bedehkar), '##,##') AS expense
                          FROM           AkH.AccAMJ1000.dbo.tblSanadDetail_MD INNER JOIN
                                                    AkH.AccAMJ1000.dbo.tblSanad_MD ON tblSanadDetail_MD.IdSanad_MD = tblSanad_MD.Id AND tblSanadDetail_MD.IdSalSanad_MD = tblSanad_MD.IdSal_MD INNER JOIN
                                                    AkH.AccAMJ1000.dbo.tblTafsily AS tblTafsily_2 ON tblSanadDetail_MD.IdTafsily4 = tblTafsily_2.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily_2.IdSotooh INNER JOIN
                                                    AkH.AccAMJ1000.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id
                          WHERE        (tblSanadDetail_MD.IdSalSanad_MD = 11) AND (tblKol.IdGroup = '7')
                          GROUP BY tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5) AS tbl1 LEFT OUTER JOIN
                         AkH.AccAMJ1000.dbo.tblTafsily ON tbl1.IdTafsily4 = tblTafsily.Id LEFT OUTER JOIN
                         AkH.AccAMJ1000.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
ORDER BY tbl1.IdTafsily4



SELECT      format(sum(tblSanadDetail_MD.Bestankar - tblSanadDetail_MD.Bedehkar),'##,##') AS expense
FROM            AkH.AccAMJ1000.dbo.tblSanadDetail_MD INNER JOIN
                         AkH.AccAMJ1000.dbo.tblSanad_MD ON tblSanadDetail_MD.IdSanad_MD = tblSanad_MD.Id AND tblSanadDetail_MD.IdSalSanad_MD = tblSanad_MD.IdSal_MD INNER JOIN
                         AkH.AccAMJ1000.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
                         AkH.AccAMJ1000.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id
WHERE        (tblSanadDetail_MD.IdSalSanad_MD = 11) AND (tblKol.IdGroup = '7')
END


--SELECT     *
--FROM            AkH.AccAMJ1000.dbo.tblSal_MD 
GO
