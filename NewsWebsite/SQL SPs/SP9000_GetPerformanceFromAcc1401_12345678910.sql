USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9000_GetPerformanceFromAcc1401_12345678910]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9000_GetPerformanceFromAcc1401_12345678910]

AS
BEGIN
delete Tbl_Vasets
DBCC CHECKIDENT('Tbl_Vasets',RESEED,0)

--=====================================================================================================
--منطقه 01

INSERT INTO Tbl_Vasets( YearId, AreaId,    IdTafsily4   ,    IdTafsily5   ,  NameTafsily   ,    Markhazhazine  ,    Expense   ,                CodeVaset         )

SELECT        32 AS Expr1, 1 AS Expr2, tbl1.IdTafsily4, tbl1.IdTafsily5, tblTafsily.Name, tblTafsily_1.Name AS Expr3, tbl1.Expense, tbl1.IdTafsily4 + tbl1.IdTafsily5 AS Expr4
FROM            (SELECT        tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
                           FROM            AKH.AccAMJ1001.dbo.tblSanad_MD INNER JOIN
                                                    AKH.AccAMJ1001.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
                                                    AKH.AccAMJ1001.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
                                                    AKH.AccAMJ1001.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh
                           WHERE        (tblSanad_MD.IdSal_MD = 18) AND (tblKol.IdGroup IN (7, 8)) AND (tblTafsily.IdTafsilyGroup <> '18')
                           GROUP BY tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5) AS tbl1 INNER JOIN
                         AKH.AccAMJ1001.dbo.tblTafsily ON tbl1.IdTafsily4 = tblTafsily.Id INNER JOIN
                         AKH.AccAMJ1001.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
WHERE        (tbl1.Expense <> 0)
				
--=====================================================================================================
--منطقه 02
INSERT INTO Tbl_Vasets( YearId, AreaId, IdTafsily4 , IdTafsily5 , NameTafsily , Markhazhazine ,Expense ,CodeVaset)
			SELECT        32 AS Expr1, 2 AS Expr2, tbl1.IdTafsily4, tbl1.IdTafsily5, tblTafsily.Name, tblTafsily_1.Name AS Expr3, tbl1.Expense, tbl1.IdTafsily4 + tbl1.IdTafsily5 AS Expr4
			FROM            (SELECT        tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
									   FROM            AKH.AccAMJ1002.dbo.tblSanad_MD INNER JOIN
																AKH.AccAMJ1002.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																AKH.AccAMJ1002.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																AKH.AccAMJ1002.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh
									   WHERE        (tblSanad_MD.IdSal_MD = 21) AND (tblKol.IdGroup IN (7, 8)) AND (tblTafsily.IdTafsilyGroup <> '18')
									   GROUP BY tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5) AS tbl1 INNER JOIN
									 AKH.AccAMJ1002.dbo.tblTafsily ON tbl1.IdTafsily4 = tblTafsily.Id INNER JOIN
									 AKH.AccAMJ1002.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
			WHERE        (tbl1.Expense <> 0)

--=====================================================================================================
--منطقه 03
INSERT INTO Tbl_Vasets( YearId, AreaId, IdTafsily4 , IdTafsily5 , NameTafsily , Markhazhazine ,Expense ,CodeVaset)
			SELECT        32 AS Expr1, 3 AS Expr2, tbl1.IdTafsily4, tbl1.IdTafsily5, tblTafsily.Name, tblTafsily_1.Name AS Expr3, tbl1.Expense, tbl1.IdTafsily4 + tbl1.IdTafsily5 AS Expr4
			FROM            (SELECT        tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
									   FROM            AKH.AccAMJ1003.dbo.tblSanad_MD INNER JOIN
																AKH.AccAMJ1003.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																AKH.AccAMJ1003.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																AKH.AccAMJ1003.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh
									   WHERE        (tblSanad_MD.IdSal_MD = 18) AND (tblKol.IdGroup IN (7, 8)) AND (tblTafsily.IdTafsilyGroup <> '18')
									   GROUP BY tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5) AS tbl1 INNER JOIN
									 AKH.AccAMJ1003.dbo.tblTafsily ON tbl1.IdTafsily4 = tblTafsily.Id INNER JOIN
									 AKH.AccAMJ1003.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
			WHERE        (tbl1.Expense <> 0)

--=====================================================================================================
--منطقه 04
INSERT INTO Tbl_Vasets( YearId, AreaId, IdTafsily4 , IdTafsily5 , NameTafsily , Markhazhazine ,Expense ,CodeVaset)
			SELECT        32 AS Expr1, 4 AS Expr2, tbl1.IdTafsily4, tbl1.IdTafsily5, tblTafsily.Name, tblTafsily_1.Name AS Expr3, tbl1.Expense, tbl1.IdTafsily4 + tbl1.IdTafsily5 AS Expr4
			FROM            (SELECT        tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
									   FROM            AKH.AccAMJ1004.dbo.tblSanad_MD INNER JOIN
																AKH.AccAMJ1004.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																AKH.AccAMJ1004.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																AKH.AccAMJ1004.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh
									   WHERE        (tblSanad_MD.IdSal_MD = 16) AND (tblKol.IdGroup IN (7, 8)) AND (tblTafsily.IdTafsilyGroup <> '18')
									   GROUP BY tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5) AS tbl1 INNER JOIN
									 AKH.AccAMJ1004.dbo.tblTafsily ON tbl1.IdTafsily4 = tblTafsily.Id INNER JOIN
									 AKH.AccAMJ1004.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
			WHERE        (tbl1.Expense <> 0)

--=====================================================================================================
--منطقه 05
INSERT INTO Tbl_Vasets( YearId, AreaId, IdTafsily4 , IdTafsily5 , NameTafsily , Markhazhazine ,Expense ,CodeVaset)
			SELECT        32  ,   5   , tbl1.IdTafsily4, tbl1.IdTafsily5, tblTafsily.Name, tblTafsily_1.Name AS Expr3, tbl1.Expense, tbl1.IdTafsily4 + tbl1.IdTafsily5 AS Expr4
			FROM            (SELECT        tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
									   FROM            AKH.AccAMJ1005.dbo.tblSanad_MD INNER JOIN
																AKH.AccAMJ1005.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																AKH.AccAMJ1005.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																AKH.AccAMJ1005.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh
									   WHERE        (tblSanad_MD.IdSal_MD = 15) AND (tblKol.IdGroup IN (7, 8)) AND (tblTafsily.IdTafsilyGroup <> '18')
									   GROUP BY tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5) AS tbl1 INNER JOIN
									 AKH.AccAMJ1005.dbo.tblTafsily ON tbl1.IdTafsily4 = tblTafsily.Id INNER JOIN
									 AKH.AccAMJ1005.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
			WHERE        (tbl1.Expense <> 0)

--=====================================================================================================
--منطقه 06
INSERT INTO Tbl_Vasets( YearId, AreaId, IdTafsily4 , IdTafsily5 , NameTafsily , Markhazhazine ,Expense ,CodeVaset)
			SELECT        32  ,   6   , tbl1.IdTafsily4, tbl1.IdTafsily5, tblTafsily.Name, tblTafsily_1.Name AS Expr3, tbl1.Expense, tbl1.IdTafsily4 + tbl1.IdTafsily5 AS Expr4
				FROM            (SELECT        tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
										   FROM            AKH.AccAMJ1006.dbo.tblSanad_MD INNER JOIN
																	AKH.AccAMJ1006.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																	AKH.AccAMJ1006.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																	AKH.AccAMJ1006.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh
										   WHERE        (tblSanad_MD.IdSal_MD = 15) AND (tblKol.IdGroup IN (7, 8)) AND (tblTafsily.IdTafsilyGroup <> '18')
										   GROUP BY tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5) AS tbl1 INNER JOIN
										 AKH.AccAMJ1006.dbo.tblTafsily ON tbl1.IdTafsily4 = tblTafsily.Id INNER JOIN
										 AKH.AccAMJ1006.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
				WHERE        (tbl1.Expense <> 0)

--=====================================================================================================
--منطقه 07
INSERT INTO Tbl_Vasets( YearId, AreaId, IdTafsily4 , IdTafsily5 , NameTafsily , Markhazhazine ,Expense ,CodeVaset)
			SELECT        32  ,   7   , tbl1.IdTafsily4, tbl1.IdTafsily5, tblTafsily.Name, tblTafsily_1.Name AS Expr3, tbl1.Expense, tbl1.IdTafsily4 + tbl1.IdTafsily5 AS Expr4
				FROM            (SELECT        tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
										   FROM            AKH.AccAMJ1007.dbo.tblSanad_MD INNER JOIN
																	AKH.AccAMJ1007.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																	AKH.AccAMJ1007.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																	AKH.AccAMJ1007.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh
										   WHERE        (tblSanad_MD.IdSal_MD = 13) AND (tblKol.IdGroup IN (7, 8)) AND (tblTafsily.IdTafsilyGroup <> '18')
										   GROUP BY tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5) AS tbl1 INNER JOIN
										 AKH.AccAMJ1007.dbo.tblTafsily ON tbl1.IdTafsily4 = tblTafsily.Id INNER JOIN
										 AKH.AccAMJ1007.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
				WHERE        (tbl1.Expense <> 0)

--=====================================================================================================
--منطقه 08
INSERT INTO Tbl_Vasets( YearId, AreaId, IdTafsily4 , IdTafsily5 , NameTafsily , Markhazhazine ,Expense ,CodeVaset)
			SELECT        32  ,   8   , tbl1.IdTafsily4, tbl1.IdTafsily5, tblTafsily.Name, tblTafsily_1.Name AS Expr3, tbl1.Expense, tbl1.IdTafsily4 + tbl1.IdTafsily5 AS Expr4
				FROM            (SELECT        tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
										   FROM            AKH.AccAMJ1008.dbo.tblSanad_MD INNER JOIN
																	AKH.AccAMJ1008.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																	AKH.AccAMJ1008.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																	AKH.AccAMJ1008.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh
										   WHERE        (tblSanad_MD.IdSal_MD = 13) AND (tblKol.IdGroup IN (7, 8)) AND (tblTafsily.IdTafsilyGroup <> '18')
										   GROUP BY tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5) AS tbl1 INNER JOIN
										 AKH.AccAMJ1008.dbo.tblTafsily ON tbl1.IdTafsily4 = tblTafsily.Id INNER JOIN
										 AKH.AccAMJ1008.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
				WHERE        (tbl1.Expense <> 0)

--=====================================================================================================
--مرکزی
INSERT INTO Tbl_Vasets( YearId, AreaId, IdTafsily4 , IdTafsily5 , NameTafsily , Markhazhazine ,Expense ,CodeVaset)
			SELECT        32  ,   9   , tbl1.IdTafsily4, tbl1.IdTafsily5, tblTafsily.Name, tblTafsily_1.Name AS Expr3, tbl1.Expense, tbl1.IdTafsily4 + tbl1.IdTafsily5 AS Expr4
				FROM            (SELECT        tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
										   FROM            AKH.AccAMJ1000.dbo.tblSanad_MD INNER JOIN
																	AKH.AccAMJ1000.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																	AKH.AccAMJ1000.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																	AKH.AccAMJ1000.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh
										   WHERE        (tblSanad_MD.IdSal_MD = 11) AND (tblKol.IdGroup IN (7, 8)) AND (tblTafsily.IdTafsilyGroup <> '18')
										   GROUP BY tblSanadDetail_MD.IdTafsily4, tblSanadDetail_MD.IdTafsily5) AS tbl1 INNER JOIN
										 AKH.AccAMJ1000.dbo.tblTafsily ON tbl1.IdTafsily4 = tblTafsily.Id INNER JOIN
										 AKH.AccAMJ1000.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
				WHERE        (tbl1.Expense <> 0)

--=====================================================================================================


--حذف رکورد ها با ارقام صفر
delete Tbl_Vasets
where Expense=0

--مثبت نمودن ارقام درآمد چون ردیف های درآمد و هزینه با هم در یک فرمول هستند
update Tbl_Vasets
set Expense = Expense*-1
where Expense<0

--صفر نمودن فیلد عملکرد در تمام رکورد های درآمد و هزینه 
UPDATE       tblBudgetDetailProjectArea
SET                Expense = 0
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblAreas ON TblBudgets.TblAreaId = TblAreas.Id
WHERE        (TblBudgets.TblYearId = 32) and (TblAreas.StructureId=1)


--بروزاوری جدید
UPDATE       tblBudgetDetailProjectArea
SET                Expense = Tbl_Vasets.Expense
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         Tbl_Vasets ON tblBudgetDetailProjectArea.AreaId = Tbl_Vasets.AreaId AND tblCoding.CodeVaset = Tbl_Vasets.CodeVaset
WHERE        (TblBudgets.TblYearId = 32)


----حذف نمودن رکورد هادر جدول واسط  که ارقام عملکرد آنها به دیتا بیس  منتقل شده است
DELETE FROM Tbl_Vasets
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         Tbl_Vasets ON tblBudgetDetailProjectArea.AreaId = Tbl_Vasets.AreaId AND tblCoding.CodeVaset = Tbl_Vasets.CodeVaset
WHERE        (TblBudgets.TblYearId = 32)


--=====================================================================================================

SELECT        AreaId, IdTafsily4, IdTafsily5, NameTafsily, Markhazhazine,  Expense, CodeVaset--format(Expense,'##,##') as
FROM            Tbl_Vasets
--where SUBSTRING(IdTafsily4,1,2) < '45' --and  AreaId in (3,4)
ORDER BY AreaId,IdTafsily4, IdTafsily5

END
GO
