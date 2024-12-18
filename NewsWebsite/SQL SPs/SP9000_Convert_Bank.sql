USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9000_Convert_Bank]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9000_Convert_Bank]

AS
BEGIN
delete Tbl_VasetsBank
--DBCC CHECKIDENT('Tbl_Vasets',RESEED,0)

--=====================================================================================================
--منطقه 01

INSERT INTO Tbl_VasetsBank( YearId, AreaId,    IdTafsily4     ,  NameTafsily   ,      Expense   )
SELECT        32 AS Expr1, 1 AS Expr2, tbl1.IdTafsily4, tblTafsily_2.Name, tbl1.Expense
FROM            (SELECT        tblSanadDetail_MD_1.IdTafsily4, SUM(tblSanadDetail_MD_1.Bedehkar) - SUM(tblSanadDetail_MD_1.Bestankar) AS Expense
                           FROM            AKH.AccAMJ1001.dbo.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                                                    AKH.AccAMJ1001.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.IdSal_MD = tblSanadDetail_MD_1.IdSalSanad_MD INNER JOIN
                                                    AKH.AccAMJ1001.dbo.tblKol AS tblKol_1 ON tblSanadDetail_MD_1.IdKol = tblKol_1.Id
                           WHERE        (tblSanad_MD_1.IdSal_MD = 18) AND (tblKol_1.Id = 1000)
                           GROUP BY tblSanadDetail_MD_1.IdTafsily4) AS tbl1 INNER JOIN
                         AKH.AccAMJ1001.dbo.tblTafsily AS tblTafsily_2 ON tbl1.IdTafsily4 = tblTafsily_2.Id
WHERE        (tbl1.Expense <> 0)


--=====================================================================================================
--منطقه 02
INSERT INTO Tbl_VasetsBank( YearId, AreaId,    IdTafsily4     ,  NameTafsily   ,      Expense   )
			SELECT        32 AS Expr1, 2 AS Expr2, tbl1.IdTafsily4, tblTafsily_2.Name, tbl1.Expense
FROM            (SELECT        tblSanadDetail_MD_1.IdTafsily4, SUM(tblSanadDetail_MD_1.Bedehkar) - SUM(tblSanadDetail_MD_1.Bestankar) AS Expense
                           FROM            AKH.AccAMJ1002.dbo.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                                                    AKH.AccAMJ1002.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.IdSal_MD = tblSanadDetail_MD_1.IdSalSanad_MD INNER JOIN
                                                    AKH.AccAMJ1002.dbo.tblKol AS tblKol_1 ON tblSanadDetail_MD_1.IdKol = tblKol_1.Id
                           WHERE        (tblSanad_MD_1.IdSal_MD = 21) AND (tblKol_1.Id = 1000)
                           GROUP BY tblSanadDetail_MD_1.IdTafsily4) AS tbl1 INNER JOIN
                         AKH.AccAMJ1002.dbo.tblTafsily AS tblTafsily_2 ON tbl1.IdTafsily4 = tblTafsily_2.Id
WHERE        (tbl1.Expense <> 0)
--=====================================================================================================
--منطقه 03
INSERT INTO Tbl_VasetsBank( YearId, AreaId,    IdTafsily4     ,  NameTafsily   ,      Expense   )
SELECT        32 AS Expr1, 3 AS Expr2, tbl1.IdTafsily4, tblTafsily_2.Name, tbl1.Expense
FROM            (SELECT        tblSanadDetail_MD_1.IdTafsily4, SUM(tblSanadDetail_MD_1.Bedehkar) - SUM(tblSanadDetail_MD_1.Bestankar) AS Expense
                           FROM            AKH.AccAMJ1003.dbo.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                                                    AKH.AccAMJ1003.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.IdSal_MD = tblSanadDetail_MD_1.IdSalSanad_MD INNER JOIN
                                                    AKH.AccAMJ1003.dbo.tblKol AS tblKol_1 ON tblSanadDetail_MD_1.IdKol = tblKol_1.Id
                           WHERE        (tblSanad_MD_1.IdSal_MD = 18) AND (tblKol_1.Id = 1000)
                           GROUP BY tblSanadDetail_MD_1.IdTafsily4) AS tbl1 INNER JOIN
                         AKH.AccAMJ1003.dbo.tblTafsily AS tblTafsily_2 ON tbl1.IdTafsily4 = tblTafsily_2.Id
WHERE        (tbl1.Expense <> 0)
--=====================================================================================================
--منطقه 04
INSERT INTO Tbl_VasetsBank( YearId, AreaId,    IdTafsily4     ,  NameTafsily   ,      Expense   )
	SELECT        32 AS Expr1, 4 AS Expr2, tbl1.IdTafsily4, tblTafsily_2.Name, tbl1.Expense
FROM            (SELECT        tblSanadDetail_MD_1.IdTafsily4, SUM(tblSanadDetail_MD_1.Bedehkar) - SUM(tblSanadDetail_MD_1.Bestankar) AS Expense
                           FROM            AKH.AccAMJ1004.dbo.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                                                    AKH.AccAMJ1004.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.IdSal_MD = tblSanadDetail_MD_1.IdSalSanad_MD INNER JOIN
                                                    AKH.AccAMJ1004.dbo.tblKol AS tblKol_1 ON tblSanadDetail_MD_1.IdKol = tblKol_1.Id
                           WHERE        (tblSanad_MD_1.IdSal_MD = 16) AND (tblKol_1.Id = 1000)
                           GROUP BY tblSanadDetail_MD_1.IdTafsily4, tblSanadDetail_MD_1.IdTafsily5) AS tbl1 INNER JOIN
                         AKH.AccAMJ1004.dbo.tblTafsily AS tblTafsily_2 ON tbl1.IdTafsily4 = tblTafsily_2.Id
WHERE        (tbl1.Expense <> 0)
--=====================================================================================================
--منطقه 05
INSERT INTO Tbl_VasetsBank( YearId, AreaId,    IdTafsily4     ,  NameTafsily   ,      Expense   )
SELECT        32 AS Expr1, 5 AS Expr2, tbl1.IdTafsily4, tblTafsily_2.Name, tbl1.Expense
FROM            (SELECT        tblSanadDetail_MD_1.IdTafsily4, SUM(tblSanadDetail_MD_1.Bedehkar) - SUM(tblSanadDetail_MD_1.Bestankar) AS Expense
                           FROM            AKH.AccAMJ1005.dbo.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                                                    AKH.AccAMJ1005.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.IdSal_MD = tblSanadDetail_MD_1.IdSalSanad_MD INNER JOIN
                                                    AKH.AccAMJ1005.dbo.tblKol AS tblKol_1 ON tblSanadDetail_MD_1.IdKol = tblKol_1.Id
                           WHERE        (tblSanad_MD_1.IdSal_MD = 15) AND (tblKol_1.Id = 1000)
                           GROUP BY tblSanadDetail_MD_1.IdTafsily4) AS tbl1 INNER JOIN
                         AKH.AccAMJ1005.dbo.tblTafsily AS tblTafsily_2 ON tbl1.IdTafsily4 = tblTafsily_2.Id
WHERE        (tbl1.Expense <> 0)
--=====================================================================================================
--منطقه 06
INSERT INTO Tbl_VasetsBank( YearId, AreaId,    IdTafsily4     ,  NameTafsily   ,      Expense   )
SELECT        32 AS Expr1, 6 AS Expr2, tbl1.IdTafsily4, tblTafsily_2.Name, tbl1.Expense
FROM            (SELECT        tblSanadDetail_MD_1.IdTafsily4,  SUM(tblSanadDetail_MD_1.Bedehkar) - SUM(tblSanadDetail_MD_1.Bestankar) AS Expense
                           FROM            AKH.AccAMJ1006.dbo.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                                                    AKH.AccAMJ1006.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.IdSal_MD = tblSanadDetail_MD_1.IdSalSanad_MD INNER JOIN
                                                    AKH.AccAMJ1006.dbo.tblKol AS tblKol_1 ON tblSanadDetail_MD_1.IdKol = tblKol_1.Id
                           WHERE        (tblSanad_MD_1.IdSal_MD = 15) AND (tblKol_1.Id = 1000)
                           GROUP BY tblSanadDetail_MD_1.IdTafsily4) AS tbl1 INNER JOIN
                         AKH.AccAMJ1006.dbo.tblTafsily AS tblTafsily_2 ON tbl1.IdTafsily4 = tblTafsily_2.Id
WHERE        (tbl1.Expense <> 0)
--=====================================================================================================
--منطقه 07
INSERT INTO Tbl_VasetsBank( YearId, AreaId,    IdTafsily4     ,  NameTafsily   ,      Expense   )
		SELECT        32 AS Expr1, 7 AS Expr2, tbl1.IdTafsily4, tblTafsily_2.Name, tbl1.Expense
FROM            (SELECT        tblSanadDetail_MD_1.IdTafsily4,  SUM(tblSanadDetail_MD_1.Bedehkar) - SUM(tblSanadDetail_MD_1.Bestankar) AS Expense
                           FROM            AKH.AccAMJ1007.dbo.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                                                    AKH.AccAMJ1007.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.IdSal_MD = tblSanadDetail_MD_1.IdSalSanad_MD INNER JOIN
                                                    AKH.AccAMJ1007.dbo.tblKol AS tblKol_1 ON tblSanadDetail_MD_1.IdKol = tblKol_1.Id
                           WHERE        (tblSanad_MD_1.IdSal_MD = 13) AND (tblKol_1.Id = 1000)
                           GROUP BY tblSanadDetail_MD_1.IdTafsily4) AS tbl1 INNER JOIN
                         AKH.AccAMJ1007.dbo.tblTafsily AS tblTafsily_2 ON tbl1.IdTafsily4 = tblTafsily_2.Id
WHERE        (tbl1.Expense <> 0)
--=====================================================================================================
--منطقه 08
INSERT INTO Tbl_VasetsBank( YearId, AreaId,    IdTafsily4     ,  NameTafsily   ,      Expense   )
SELECT        32 AS Expr1, 8 AS Expr2, tbl1.IdTafsily4, tblTafsily_2.Name, tbl1.Expense
FROM            (SELECT        tblSanadDetail_MD_1.IdTafsily4,  SUM(tblSanadDetail_MD_1.Bedehkar) - SUM(tblSanadDetail_MD_1.Bestankar) AS Expense
                           FROM            AKH.AccAMJ1008.dbo.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                                                    AKH.AccAMJ1008.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.IdSal_MD = tblSanadDetail_MD_1.IdSalSanad_MD INNER JOIN
                                                    AKH.AccAMJ1008.dbo.tblKol AS tblKol_1 ON tblSanadDetail_MD_1.IdKol = tblKol_1.Id
                           WHERE        (tblSanad_MD_1.IdSal_MD = 13) AND (tblKol_1.Id = 1000)
                           GROUP BY tblSanadDetail_MD_1.IdTafsily4) AS tbl1 INNER JOIN
                         AKH.AccAMJ1008.dbo.tblTafsily AS tblTafsily_2 ON tbl1.IdTafsily4 = tblTafsily_2.Id
WHERE        (tbl1.Expense <> 0)
--=====================================================================================================
--مرکزی
INSERT INTO Tbl_VasetsBank( YearId, AreaId,    IdTafsily4     ,  NameTafsily   ,      Expense   )
SELECT        32 AS Expr1, 9 AS Expr2, tbl1.IdTafsily4, tblTafsily_2.Name, tbl1.Expense
FROM            (SELECT        tblSanadDetail_MD_1.IdTafsily4,  SUM(tblSanadDetail_MD_1.Bedehkar) - SUM(tblSanadDetail_MD_1.Bestankar) AS Expense
                           FROM            AKH.AccAMJ1000.dbo.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                                                    AKH.AccAMJ1000.dbo.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.IdSal_MD = tblSanadDetail_MD_1.IdSalSanad_MD INNER JOIN
                                                    AKH.AccAMJ1000.dbo.tblKol AS tblKol_1 ON tblSanadDetail_MD_1.IdKol = tblKol_1.Id
                           WHERE        (tblSanad_MD_1.IdSal_MD = 11) AND (tblKol_1.Id = 1000)
                           GROUP BY tblSanadDetail_MD_1.IdTafsily4) AS tbl1 INNER JOIN
                         AKH.AccAMJ1000.dbo.tblTafsily AS tblTafsily_2 ON tbl1.IdTafsily4 = tblTafsily_2.Id
WHERE        (tbl1.Expense <> 0)
--=====================================================================================================

SELECT        YearId, AreaId, IdTafsily4, NameTafsily, Expense
FROM            Tbl_VasetsBank
order by Expense desc
END
GO
