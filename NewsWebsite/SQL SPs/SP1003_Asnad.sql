USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP1003_Asnad]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP1003_Asnad]

AS
BEGIN
SELECT        1 ,  Expense
FROM            (SELECT        tblSanadDetail_MD_1.IdKol, SUM(tblSanadDetail_MD_1.Bedehkar) - SUM(tblSanadDetail_MD_1.Bestankar) AS Expense
FROM            AKH.AccAMJ1001.dbo.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                         AKH.AccAMJ1001.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.IdSal_MD = tblSanadDetail_MD_1.IdSalSanad_MD INNER JOIN
                         AKH.AccAMJ1001.dbo.tblKol AS tblKol_1 ON tblSanadDetail_MD_1.IdKol = tblKol_1.Id
WHERE        (tblKol_1.Id = 1003)
GROUP BY tblSanadDetail_MD_1.IdKol) AS tbl1
WHERE        (Expense <> 0)

union all
--=====================================================================================================
--منطقه 02

SELECT        2 ,  Expense
FROM            (SELECT        tblSanadDetail_MD_1.IdKol, SUM(tblSanadDetail_MD_1.Bedehkar) - SUM(tblSanadDetail_MD_1.Bestankar) AS Expense
FROM            AKH.AccAMJ1002.dbo.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                         AKH.AccAMJ1002.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.IdSal_MD = tblSanadDetail_MD_1.IdSalSanad_MD INNER JOIN
                         AKH.AccAMJ1002.dbo.tblKol AS tblKol_1 ON tblSanadDetail_MD_1.IdKol = tblKol_1.Id
WHERE        (tblKol_1.Id = 1003)
GROUP BY tblSanadDetail_MD_1.IdKol) AS tbl1
WHERE        (Expense <> 0)
--=====================================================================================================
--منطقه 03
union all
SELECT        3 ,  Expense
FROM            (SELECT        tblSanadDetail_MD_1.IdKol, SUM(tblSanadDetail_MD_1.Bedehkar) - SUM(tblSanadDetail_MD_1.Bestankar) AS Expense
FROM            AKH.AccAMJ1003.dbo.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                         AKH.AccAMJ1003.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.IdSal_MD = tblSanadDetail_MD_1.IdSalSanad_MD INNER JOIN
                         AKH.AccAMJ1003.dbo.tblKol AS tblKol_1 ON tblSanadDetail_MD_1.IdKol = tblKol_1.Id
WHERE        (tblKol_1.Id = 1003)
GROUP BY tblSanadDetail_MD_1.IdKol) AS tbl1
WHERE        (Expense <> 0)
--=====================================================================================================
--منطقه 04
union all
SELECT        4 ,  Expense
FROM            (SELECT        tblSanadDetail_MD_1.IdKol, SUM(tblSanadDetail_MD_1.Bedehkar) - SUM(tblSanadDetail_MD_1.Bestankar) AS Expense
FROM            AKH.AccAMJ1004.dbo.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                         AKH.AccAMJ1004.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.IdSal_MD = tblSanadDetail_MD_1.IdSalSanad_MD INNER JOIN
                         AKH.AccAMJ1004.dbo.tblKol AS tblKol_1 ON tblSanadDetail_MD_1.IdKol = tblKol_1.Id
WHERE        (tblKol_1.Id = 1003)
GROUP BY tblSanadDetail_MD_1.IdKol) AS tbl1
WHERE        (Expense <> 0)
--=====================================================================================================
--منطقه 05
union all
SELECT        5 ,  Expense
FROM            (SELECT        tblSanadDetail_MD_1.IdKol, SUM(tblSanadDetail_MD_1.Bedehkar) - SUM(tblSanadDetail_MD_1.Bestankar) AS Expense
FROM            AKH.AccAMJ1005.dbo.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                         AKH.AccAMJ1005.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.IdSal_MD = tblSanadDetail_MD_1.IdSalSanad_MD INNER JOIN
                         AKH.AccAMJ1005.dbo.tblKol AS tblKol_1 ON tblSanadDetail_MD_1.IdKol = tblKol_1.Id
WHERE        (tblKol_1.Id = 1003)
GROUP BY tblSanadDetail_MD_1.IdKol) AS tbl1
WHERE        (Expense <> 0)
--=====================================================================================================
--منطقه 06
union all
SELECT        6 ,  Expense
FROM            (SELECT        tblSanadDetail_MD_1.IdKol, SUM(tblSanadDetail_MD_1.Bedehkar) - SUM(tblSanadDetail_MD_1.Bestankar) AS Expense
FROM            AKH.AccAMJ1006.dbo.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                         AKH.AccAMJ1006.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.IdSal_MD = tblSanadDetail_MD_1.IdSalSanad_MD INNER JOIN
                         AKH.AccAMJ1006.dbo.tblKol AS tblKol_1 ON tblSanadDetail_MD_1.IdKol = tblKol_1.Id
WHERE        (tblKol_1.Id = 1003)
GROUP BY tblSanadDetail_MD_1.IdKol) AS tbl1
WHERE        (Expense <> 0)
--=====================================================================================================
--منطقه 07
union all
SELECT        7 ,  Expense
FROM            (SELECT        tblSanadDetail_MD_1.IdKol, SUM(tblSanadDetail_MD_1.Bedehkar) - SUM(tblSanadDetail_MD_1.Bestankar) AS Expense
FROM            AKH.AccAMJ1007.dbo.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                         AKH.AccAMJ1007.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.IdSal_MD = tblSanadDetail_MD_1.IdSalSanad_MD INNER JOIN
                         AKH.AccAMJ1007.dbo.tblKol AS tblKol_1 ON tblSanadDetail_MD_1.IdKol = tblKol_1.Id
WHERE        (tblKol_1.Id = 1003)
GROUP BY tblSanadDetail_MD_1.IdKol) AS tbl1
WHERE        (Expense <> 0)
--=====================================================================================================
--منطقه 08
union all
SELECT        8 ,  Expense
FROM            (SELECT        tblSanadDetail_MD_1.IdKol, SUM(tblSanadDetail_MD_1.Bedehkar) - SUM(tblSanadDetail_MD_1.Bestankar) AS Expense
FROM            AKH.AccAMJ1008.dbo.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                         AKH.AccAMJ1008.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.IdSal_MD = tblSanadDetail_MD_1.IdSalSanad_MD INNER JOIN
                         AKH.AccAMJ1008.dbo.tblKol AS tblKol_1 ON tblSanadDetail_MD_1.IdKol = tblKol_1.Id
WHERE        (tblKol_1.Id = 1003)
GROUP BY tblSanadDetail_MD_1.IdKol) AS tbl1
WHERE        (Expense <> 0)
--=====================================================================================================
--مرکزی
union all
SELECT        9 ,  Expense
FROM            (SELECT        tblSanadDetail_MD_1.IdKol, SUM(tblSanadDetail_MD_1.Bedehkar) - SUM(tblSanadDetail_MD_1.Bestankar) AS Expense
FROM            AKH.AccAMJ1000.dbo.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                         AKH.AccAMJ1000.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.IdSal_MD = tblSanadDetail_MD_1.IdSalSanad_MD INNER JOIN
                         AKH.AccAMJ1000.dbo.tblKol AS tblKol_1 ON tblSanadDetail_MD_1.IdKol = tblKol_1.Id
WHERE        (tblKol_1.Id = 1003)
GROUP BY tblSanadDetail_MD_1.IdKol) AS tbl1
WHERE        (Expense <> 0)
--=====================================================================================================
END
GO
