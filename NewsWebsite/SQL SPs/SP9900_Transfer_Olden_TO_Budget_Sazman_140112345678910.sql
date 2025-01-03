USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9900_Transfer_Olden_TO_Budget_Sazman_140112345678910]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9900_Transfer_Olden_TO_Budget_Sazman_140112345678910]
@yearId int ,
@areaId int
AS
BEGIN
if(@yearId = 32 and @areaId = 11)--فاوا 11
begin
delete TBl_Vaset_Taraz_Sazman
where AreaId=11 

insert into TBl_Vaset_Taraz_Sazman( AreaId , YearId ,  AreaName ,   IdKol    ,   IdMoien    ,     IdTafsily   ,     Title        ,   Expense   )
						SELECT        11   ,   32   ,   'فاوا ' , tbl1.IdKol, tbl1.IdMoien, tbl1.IdTafsily4, tblTafsily_1.Name, tbl1.Expense
						FROM            (SELECT        olden.tblSanadDetail_MD.IdKol, olden.tblSanadDetail_MD.IdMoien, olden.tblSanadDetail_MD.IdTafsily4, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
												   FROM            olden.tblSanad_MD INNER JOIN
																			olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName AND 
																			olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId INNER JOIN
																			olden.tblTafsily ON olden.tblSanadDetail_MD.IdTafsily4 = olden.tblTafsily.Id AND olden.tblSanadDetail_MD.IdSotooh4 = olden.tblTafsily.IdSotooh INNER JOIN
																			olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id INNER JOIN
																			olden.tblGroup ON olden.tblKol.IdGroup = olden.tblGroup.Id
												   WHERE  (olden.tblKol.IdGroup IN (6, 7)) AND
												          (olden.tblSanad_MD.YearName = 1401) AND
														  (olden.tblSanad_MD.AreaId = 11) AND
														  (olden.tblSanadDetail_MD.YearName = 1401) AND
														  (olden.tblKol.AreaId = 11) AND 
														  (olden.tblKol.YearName = 1401) AND
														  (olden.tblSanadDetail_MD.AreaId = 11) AND
														  (olden.tblGroup.AreaId = 11) AND
														  (olden.tblGroup.YearName = 1401)
												   GROUP BY olden.tblSanadDetail_MD.IdKol, olden.tblSanadDetail_MD.IdMoien, olden.tblSanadDetail_MD.IdTafsily4) AS tbl1 LEFT OUTER JOIN
												 olden.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily4 = tblTafsily_1.Id
						WHERE   (tblTafsily_1.AreaId = 11) AND
						        (tblTafsily_1.YearName = 1401)
update TBl_Vaset_Taraz_Sazman
set Expense = Expense*-1
where AreaId=16 and IdKol>=600 or IdKol<=699

update TBl_Vaset_Taraz_Sazman
set CodeAcc = cast(IdKol as nvarchar(50))+'-'+cast(IdMoien as nvarchar(50))+'-'+cast(IdTafsily as nvarchar(50))
where AreaId=11 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = tblPerformanceSazman.ExpenseSazman*tblPerformanceSazman.PercentBud/100
FROM            (SELECT        tblBudgetDetailProjectArea_1.id, SUM(TBl_Vaset_Taraz_Sazman.Expense) AS ExpenseSazman, TblCodingsMapSazman.PercentBud
FROM            tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 INNER JOIN
                         tblCoding INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId ON tblCoding.Id = TblBudgetDetails.tblCodingId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                         TBl_Vaset_Taraz_Sazman ON TblCodingsMapSazman.CodeAcc = TBl_Vaset_Taraz_Sazman.CodeAcc
WHERE (TblBudgets.TblYearId = 32) AND
      (TblBudgets.TblAreaId = 11) AND
	  (TBl_Vaset_Taraz_Sazman.YearId = 32) AND
	  (TBl_Vaset_Taraz_Sazman.AreaId = 11) AND
	  (TblCodingsMapSazman.YearId = 32) AND 
      (TblCodingsMapSazman.AreaId = 11)
GROUP BY tblBudgetDetailProjectArea_1.id, TblCodingsMapSazman.PercentBud) AS tblPerformanceSazman INNER JOIN
                         tblBudgetDetailProjectArea ON tblPerformanceSazman.id = tblBudgetDetailProjectArea.id
return
end

--==============================================================================================================================================
if(@yearId = 32 and @areaId = 12)--اتش نشانی 12
begin
delete TBl_Vaset_Taraz_Sazman
where AreaId=12 

insert into TBl_Vaset_Taraz_Sazman( AreaId , YearId ,    AreaName   ,   IdKol    ,   IdMoien    ,     IdTafsily   ,     Title        ,   Expense   )
						SELECT        12   ,   32   ,   'آتش  '     , tbl1.IdKol , tbl1.IdMoien , tbl1.IdTafsily4 , tblTafsily_1.Name, tbl1.Expense
											FROM            (SELECT        olden.tblSanadDetail_MD.IdKol, olden.tblSanadDetail_MD.IdMoien, olden.tblSanadDetail_MD.IdTafsily4, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
																	   FROM            olden.tblSanad_MD INNER JOIN
																								olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName AND 
																								olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId INNER JOIN
																								olden.tblTafsily ON olden.tblSanadDetail_MD.IdTafsily4 = olden.tblTafsily.Id AND olden.tblSanadDetail_MD.IdSotooh4 = olden.tblTafsily.IdSotooh INNER JOIN
																								olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id INNER JOIN
																								olden.tblGroup ON olden.tblKol.IdGroup = olden.tblGroup.Id
																	   WHERE  (olden.tblKol.IdGroup IN (6, 7)) AND
																			  (olden.tblSanad_MD.YearName = 1401) AND
																			  (olden.tblSanad_MD.AreaId = 12) AND
																			  (olden.tblSanadDetail_MD.YearName = 1401) AND
																			  (olden.tblKol.AreaId = 12) AND 
																			  (olden.tblKol.YearName = 1401) AND
																			  (olden.tblSanadDetail_MD.AreaId = 12) AND
																			  (olden.tblGroup.AreaId = 12) AND
																			  (olden.tblGroup.YearName = 1401)
																	   GROUP BY olden.tblSanadDetail_MD.IdKol, olden.tblSanadDetail_MD.IdMoien, olden.tblSanadDetail_MD.IdTafsily4) AS tbl1 LEFT OUTER JOIN
																	 olden.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily4 = tblTafsily_1.Id
											WHERE   (tblTafsily_1.AreaId = 12) AND
													(tblTafsily_1.YearName = 1401)
update TBl_Vaset_Taraz_Sazman
set Expense = Expense*-1
where AreaId=12 and IdKol=400

update TBl_Vaset_Taraz_Sazman
set CodeAcc = cast(IdKol as nvarchar(50))+'-'+cast(IdMoien as nvarchar(50))+'-'+cast(IdTafsily as nvarchar(50))
where AreaId=12 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = tblPerformanceSazman.ExpenseSazman*tblPerformanceSazman.PercentBud/100
FROM            (SELECT        tblBudgetDetailProjectArea_1.id, SUM(TBl_Vaset_Taraz_Sazman.Expense) AS ExpenseSazman, TblCodingsMapSazman.PercentBud
FROM            tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 INNER JOIN
                         tblCoding INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId ON tblCoding.Id = TblBudgetDetails.tblCodingId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                         TBl_Vaset_Taraz_Sazman ON TblCodingsMapSazman.CodeAcc = TBl_Vaset_Taraz_Sazman.CodeAcc
WHERE (TblBudgets.TblYearId = 32) AND
      (TblBudgets.TblAreaId = 12) AND
	  (TBl_Vaset_Taraz_Sazman.YearId = 32) AND
	  (TBl_Vaset_Taraz_Sazman.AreaId = 12) AND
	  (TblCodingsMapSazman.YearId = 32) AND 
      (TblCodingsMapSazman.AreaId = 12)
GROUP BY tblBudgetDetailProjectArea_1.id, TblCodingsMapSazman.PercentBud) AS tblPerformanceSazman INNER JOIN
                         tblBudgetDetailProjectArea ON tblPerformanceSazman.id = tblBudgetDetailProjectArea.id
return
end

--==============================================================================================================================================
if(@yearId = 32 and @areaId = 13)--اتوبوسرانی 13
begin
delete TBl_Vaset_Taraz_Sazman
where AreaId=13

insert into TBl_Vaset_Taraz_Sazman( AreaId , YearId ,  AreaName     ,   IdKol    ,   IdMoien    ,     IdTafsily   ,     Title        ,   Expense   )
						SELECT        13   ,   32   , 'اتوبوسرانی' , tbl1.IdKol, tbl1.IdMoien, tbl1.IdTafsily4, tblTafsily_1.Name, tbl1.Expense
											FROM            (SELECT        olden.tblSanadDetail_MD.IdKol, olden.tblSanadDetail_MD.IdMoien, olden.tblSanadDetail_MD.IdTafsily4, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
																	   FROM            olden.tblSanad_MD INNER JOIN
																								olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName AND 
																								olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId INNER JOIN
																								olden.tblTafsily ON olden.tblSanadDetail_MD.IdTafsily4 = olden.tblTafsily.Id AND olden.tblSanadDetail_MD.IdSotooh4 = olden.tblTafsily.IdSotooh INNER JOIN
																								olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id INNER JOIN
																								olden.tblGroup ON olden.tblKol.IdGroup = olden.tblGroup.Id
																	   WHERE  (olden.tblKol.IdGroup IN (6, 7)) AND
																			  (olden.tblSanad_MD.YearName = 1401) AND
																			  (olden.tblSanad_MD.AreaId = 13) AND
																			  (olden.tblSanadDetail_MD.YearName = 1401) AND
																			  (olden.tblKol.AreaId = 13) AND 
																			  (olden.tblKol.YearName = 1401) AND
																			  (olden.tblSanadDetail_MD.AreaId = 13) AND
																			  (olden.tblGroup.AreaId = 13) AND
																			  (olden.tblGroup.YearName = 1401)
																	   GROUP BY olden.tblSanadDetail_MD.IdKol, olden.tblSanadDetail_MD.IdMoien, olden.tblSanadDetail_MD.IdTafsily4) AS tbl1 LEFT OUTER JOIN
																	 olden.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily4 = tblTafsily_1.Id
											WHERE   (tblTafsily_1.AreaId = 13) AND
													(tblTafsily_1.YearName = 1401)
update TBl_Vaset_Taraz_Sazman
set Expense = Expense*-1
where AreaId=13 and IdKol=6021

update TBl_Vaset_Taraz_Sazman
set CodeAcc = cast(IdKol as nvarchar(50))+'-'+cast(IdMoien as nvarchar(50))+'-'+cast(IdTafsily as nvarchar(50))
where AreaId=13 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = tblPerformanceSazman.ExpenseSazman*tblPerformanceSazman.PercentBud/100
FROM            (SELECT        tblBudgetDetailProjectArea_1.id, SUM(TBl_Vaset_Taraz_Sazman.Expense) AS ExpenseSazman, TblCodingsMapSazman.PercentBud
FROM            tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 INNER JOIN
                         tblCoding INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId ON tblCoding.Id = TblBudgetDetails.tblCodingId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                         TBl_Vaset_Taraz_Sazman ON TblCodingsMapSazman.CodeAcc = TBl_Vaset_Taraz_Sazman.CodeAcc
WHERE (TblBudgets.TblYearId = 32) AND
      (TblBudgets.TblAreaId = 13) AND
	  (TBl_Vaset_Taraz_Sazman.YearId = 32) AND
	  (TBl_Vaset_Taraz_Sazman.AreaId = 13) AND
	  (TblCodingsMapSazman.YearId = 32) AND 
      (TblCodingsMapSazman.AreaId = 13)
GROUP BY tblBudgetDetailProjectArea_1.id, TblCodingsMapSazman.PercentBud) AS tblPerformanceSazman INNER JOIN
                         tblBudgetDetailProjectArea ON tblPerformanceSazman.id = tblBudgetDetailProjectArea.id
return
end

--===============================================================================================================================================
if(@yearId = 32 and @areaId = 14)--نوسازی بهسازی 14
begin
delete TBl_Vaset_Taraz_Sazman
where AreaId=14 

insert into TBl_Vaset_Taraz_Sazman( AreaId , YearId ,    AreaName   ,   IdKol    ,   IdMoien    ,     IdTafsily   ,     Title        ,   Expense   )
						SELECT        14   ,   32   ,   'نوسازی '  , tbl1.IdKol, tbl1.IdMoien, tbl1.IdTafsily4, tblTafsily_1.Name, tbl1.Expense
						FROM            (SELECT        olden.tblSanadDetail_MD.IdKol, olden.tblSanadDetail_MD.IdMoien, olden.tblSanadDetail_MD.IdTafsily4, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
												   FROM            olden.tblSanad_MD INNER JOIN
																			olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName AND 
																			olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId INNER JOIN
																			olden.tblTafsily ON olden.tblSanadDetail_MD.IdTafsily4 = olden.tblTafsily.Id AND olden.tblSanadDetail_MD.IdSotooh4 = olden.tblTafsily.IdSotooh INNER JOIN
																			olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id INNER JOIN
																			olden.tblGroup ON olden.tblKol.IdGroup = olden.tblGroup.Id
												   WHERE  (olden.tblKol.IdGroup IN (6, 7)) AND
												          (olden.tblSanad_MD.YearName = 1401) AND
														  (olden.tblSanad_MD.AreaId = 14) AND
														  (olden.tblSanadDetail_MD.YearName = 1401) AND
														  (olden.tblKol.AreaId = 14) AND 
														  (olden.tblKol.YearName = 1401) AND
														  (olden.tblSanadDetail_MD.AreaId = 14) AND
														  (olden.tblGroup.AreaId = 14) AND
														  (olden.tblGroup.YearName = 1401)
												   GROUP BY olden.tblSanadDetail_MD.IdKol, olden.tblSanadDetail_MD.IdMoien, olden.tblSanadDetail_MD.IdTafsily4) AS tbl1 LEFT OUTER JOIN
												 olden.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily4 = tblTafsily_1.Id
						WHERE   (tblTafsily_1.AreaId = 14) AND
						        (tblTafsily_1.YearName = 1401)
--update TBl_Vaset_Taraz_Sazman
--set Expense = Expense*-1
--where AreaId=14 and IdKol=600

update TBl_Vaset_Taraz_Sazman
set CodeAcc = cast(IdKol as nvarchar(50))+'-'+cast(IdMoien as nvarchar(50))+'-'+cast(IdTafsily as nvarchar(50))
where AreaId=14 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = tblPerformanceSazman.ExpenseSazman*tblPerformanceSazman.PercentBud/100
FROM            (SELECT        tblBudgetDetailProjectArea_1.id, SUM(TBl_Vaset_Taraz_Sazman.Expense) AS ExpenseSazman, TblCodingsMapSazman.PercentBud
FROM            tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 INNER JOIN
                         tblCoding INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId ON tblCoding.Id = TblBudgetDetails.tblCodingId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                         TBl_Vaset_Taraz_Sazman ON TblCodingsMapSazman.CodeAcc = TBl_Vaset_Taraz_Sazman.CodeAcc
WHERE (TblBudgets.TblYearId = 32) AND
      (TblBudgets.TblAreaId = 14) AND
	  (TBl_Vaset_Taraz_Sazman.YearId = 32) AND
	  (TBl_Vaset_Taraz_Sazman.AreaId = 14) AND
	  (TblCodingsMapSazman.YearId = 32) AND 
      (TblCodingsMapSazman.AreaId = 14)
GROUP BY tblBudgetDetailProjectArea_1.id, TblCodingsMapSazman.PercentBud) AS tblPerformanceSazman INNER JOIN
                         tblBudgetDetailProjectArea ON tblPerformanceSazman.id = tblBudgetDetailProjectArea.id
return
end

--===============================================================================================================================================
if(@yearId = 32 and @areaId = 15)--پارکها 15
begin
delete TBl_Vaset_Taraz_Sazman
where AreaId=15 

insert into TBl_Vaset_Taraz_Sazman( AreaId , YearId ,    AreaName   ,   IdKol    ,   IdMoien    ,     IdTafsily   ,     Title        ,   Expense   )
						SELECT        15   ,   32   , 'پارکها' , tbl1.IdKol , tbl1.IdMoien , tbl1.IdTafsily4 , tblTafsily_1.Name, tbl1.Expense
						FROM            (SELECT        tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
													FROM            LPARK.AccAmj196.dbo.tblSanad_MD INNER JOIN
																			LPARK.AccAmj196.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																			LPARK.AccAmj196.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
																			LPARK.AccAmj196.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																			LPARK.AccAmj196.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
													WHERE        (tblKol.IdGroup IN (7, 6)) AND (tblSanad_MD.IdSal_MD = 11)
													GROUP BY tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4) AS tbl1 LEFT OUTER JOIN
													LPARK.AccAmj196.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily4 = tblTafsily_1.Id
update TBl_Vaset_Taraz_Sazman
set Expense = Expense*-1
where AreaId=15 and IdKol=600

update TBl_Vaset_Taraz_Sazman
set CodeAcc = cast(IdKol as nvarchar(50))+'-'+cast(IdMoien as nvarchar(50))+'-'+cast(IdTafsily as nvarchar(50))
where AreaId=15 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = tblPerformanceSazman.ExpenseSazman*tblPerformanceSazman.PercentBud/100
FROM            (SELECT        tblBudgetDetailProjectArea_1.id, SUM(TBl_Vaset_Taraz_Sazman.Expense) AS ExpenseSazman, TblCodingsMapSazman.PercentBud
FROM            tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 INNER JOIN
                         tblCoding INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId ON tblCoding.Id = TblBudgetDetails.tblCodingId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                         TBl_Vaset_Taraz_Sazman ON TblCodingsMapSazman.CodeAcc = TBl_Vaset_Taraz_Sazman.CodeAcc
WHERE (TblBudgets.TblYearId = 32) AND
      (TblBudgets.TblAreaId = 15) AND
	  (TBl_Vaset_Taraz_Sazman.YearId = 32) AND
	  (TBl_Vaset_Taraz_Sazman.AreaId = 15) AND
	  (TblCodingsMapSazman.YearId = 32) AND 
      (TblCodingsMapSazman.AreaId = 15)
GROUP BY tblBudgetDetailProjectArea_1.id, TblCodingsMapSazman.PercentBud) AS tblPerformanceSazman INNER JOIN
                         tblBudgetDetailProjectArea ON tblPerformanceSazman.id = tblBudgetDetailProjectArea.id
return
end

--===============================================================================================================================================
if(@yearId = 32 and @areaId = 16)--ترمینال ها 16
begin
delete TBl_Vaset_Taraz_Sazman
where AreaId=16 

insert into TBl_Vaset_Taraz_Sazman( AreaId , YearId ,    AreaName   ,   IdKol    ,   IdMoien    ,     IdTafsily   ,     Title        ,   Expense   )
						SELECT        16   ,   32   , 'پایانه ها' , tbl1.IdKol , tbl1.IdMoien , tbl1.IdTafsily4 , tblTafsily_1.Name, tbl1.Expense
						FROM            (SELECT        tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
													FROM            LTERMINAL.AccAMJ.dbo.tblSanad_MD INNER JOIN
																			LTERMINAL.AccAmj.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																			LTERMINAL.AccAmj.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
																			LTERMINAL.AccAmj.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																			LTERMINAL.AccAmj.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
													WHERE        (tblKol.IdGroup IN (7, 6)) AND (tblSanad_MD.IdSal_MD = 11)
													GROUP BY tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4) AS tbl1 LEFT OUTER JOIN
													LTERMINAL.AccAmj.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily4 = tblTafsily_1.Id

update TBl_Vaset_Taraz_Sazman
set Expense = Expense*-1
where AreaId=16 and IdKol=600

update TBl_Vaset_Taraz_Sazman
set CodeAcc = cast(IdKol as nvarchar(50))+'-'+cast(IdMoien as nvarchar(50))+'-'+cast(IdTafsily as nvarchar(50))
where AreaId=16 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = tblPerformanceSazman.ExpenseSazman*tblPerformanceSazman.PercentBud/100
FROM            (SELECT        tblBudgetDetailProjectArea_1.id, SUM(TBl_Vaset_Taraz_Sazman.Expense) AS ExpenseSazman, TblCodingsMapSazman.PercentBud
FROM            tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 INNER JOIN
                         tblCoding INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId ON tblCoding.Id = TblBudgetDetails.tblCodingId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                         TBl_Vaset_Taraz_Sazman ON TblCodingsMapSazman.CodeAcc = TBl_Vaset_Taraz_Sazman.CodeAcc
WHERE (TblBudgets.TblYearId = 32) AND
      (TblBudgets.TblAreaId = 16) AND
	  (TBl_Vaset_Taraz_Sazman.YearId = 32) AND
	  (TBl_Vaset_Taraz_Sazman.AreaId = 16) AND
	  (TblCodingsMapSazman.YearId = 32) AND 
      (TblCodingsMapSazman.AreaId = 16)
GROUP BY tblBudgetDetailProjectArea_1.id, TblCodingsMapSazman.PercentBud) AS tblPerformanceSazman INNER JOIN
                         tblBudgetDetailProjectArea ON tblPerformanceSazman.id = tblBudgetDetailProjectArea.id

return
end

--===============================================================================================================================================
if(@yearId = 32 and @areaId = 17)--تاکسیرانی 17 
begin
delete TBl_Vaset_Taraz_Sazman
where AreaId=17 

insert into TBl_Vaset_Taraz_Sazman( AreaId , YearId ,    AreaName   ,   IdKol    ,   IdMoien    ,     IdTafsily   ,     Title        ,   Expense   )
						SELECT        17   ,   32   , 'تاکسیرانی' , tbl1.IdKol , tbl1.IdMoien , tbl1.IdTafsily4 , tblTafsily_1.Name, tbl1.Expense
						FROM            (SELECT        tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
													FROM            LTAXI.AccAMJ1095.dbo.tblSanad_MD INNER JOIN
																			LTAXI.AccAMJ1095.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																			LTAXI.AccAMJ1095.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
																			LTAXI.AccAMJ1095.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																			LTAXI.AccAMJ1095.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
													WHERE        (tblKol.IdGroup IN (7, 6)) AND (tblSanad_MD.IdSal_MD = 11)
													GROUP BY tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4) AS tbl1 LEFT OUTER JOIN
													LTAXI.AccAMJ1095.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily4 = tblTafsily_1.Id
update TBl_Vaset_Taraz_Sazman
set Expense = Expense*-1
where AreaId=17 and IdKol=600

update TBl_Vaset_Taraz_Sazman
set CodeAcc = cast(IdKol as nvarchar(50))+'-'+cast(IdMoien as nvarchar(50))+'-'+cast(IdTafsily as nvarchar(50))
where AreaId=17 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = tblPerformanceSazman.ExpenseSazman*tblPerformanceSazman.PercentBud/100
FROM            (SELECT        tblBudgetDetailProjectArea_1.id, SUM(TBl_Vaset_Taraz_Sazman.Expense) AS ExpenseSazman, TblCodingsMapSazman.PercentBud
FROM            tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 INNER JOIN
                         tblCoding INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId ON tblCoding.Id = TblBudgetDetails.tblCodingId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                         TBl_Vaset_Taraz_Sazman ON TblCodingsMapSazman.CodeAcc = TBl_Vaset_Taraz_Sazman.CodeAcc
WHERE (TblBudgets.TblYearId = 32) AND
      (TblBudgets.TblAreaId = 17) AND
	  (TBl_Vaset_Taraz_Sazman.YearId = 32) AND
	  (TBl_Vaset_Taraz_Sazman.AreaId = 17) AND
	  (TblCodingsMapSazman.YearId = 32) AND 
      (TblCodingsMapSazman.AreaId = 17)
GROUP BY tblBudgetDetailProjectArea_1.id, TblCodingsMapSazman.PercentBud) AS tblPerformanceSazman INNER JOIN
                         tblBudgetDetailProjectArea ON tblPerformanceSazman.id = tblBudgetDetailProjectArea.id
return
end

--===============================================================================================================================================
if(@yearId = 32 and @areaId = 18)--سازمان موتوری  18
begin
delete TBl_Vaset_Taraz_Sazman
where AreaId=18 

insert into TBl_Vaset_Taraz_Sazman(     AreaId   ,   YearId    ,       AreaName       ,   IdKol     ,    IdMoien    ,     IdTafsily   ,     Title     ,   Expense   )
							SELECT     18 as AreaId ,32 as YearId, 'موتوری' as AreaNAme  ,     tbl1.IdKol, tbl1.IdMoien, tbl1.IdTafsily4, tblTafsily_1.Name, tbl1.Expense
							FROM            (SELECT        tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
														FROM            LMoTORI.AccAMJ.dbo.tblSanad_MD INNER JOIN
																				LMoTORI.AccAMJ.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																				LMoTORI.AccAMJ.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
																				LMoTORI.AccAMJ.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																				LMoTORI.AccAMJ.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
														WHERE        (tblKol.IdGroup IN (6, 7, 8)) AND (tblSanad_MD.IdSal_MD = 14)
														GROUP BY tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4) AS tbl1 LEFT OUTER JOIN
														LMoTORI.AccAMJ.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily4 = tblTafsily_1.Id
update TBl_Vaset_Taraz_Sazman
set Expense = Expense*-1
where AreaId=18 and IdKol=6201

update TBl_Vaset_Taraz_Sazman
set CodeAcc = cast(IdKol as nvarchar(50))+'-'+cast(IdMoien as nvarchar(50))+'-'+cast(IdTafsily as nvarchar(50))
where AreaId=18 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = tblPerformanceSazman.ExpenseSazman*tblPerformanceSazman.PercentBud/100
FROM            (SELECT        tblBudgetDetailProjectArea_1.id, SUM(TBl_Vaset_Taraz_Sazman.Expense) AS ExpenseSazman, TblCodingsMapSazman.PercentBud
FROM            tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 INNER JOIN
                         tblCoding INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId ON tblCoding.Id = TblBudgetDetails.tblCodingId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                         TBl_Vaset_Taraz_Sazman ON TblCodingsMapSazman.CodeAcc = TBl_Vaset_Taraz_Sazman.CodeAcc
WHERE (TblBudgets.TblYearId = 32) AND
      (TblBudgets.TblAreaId = 18) AND
	  (TBl_Vaset_Taraz_Sazman.YearId = 32) AND
	  (TBl_Vaset_Taraz_Sazman.AreaId = 18) AND
	  (TblCodingsMapSazman.YearId = 32) AND 
      (TblCodingsMapSazman.AreaId = 18)
GROUP BY tblBudgetDetailProjectArea_1.id, TblCodingsMapSazman.PercentBud) AS tblPerformanceSazman INNER JOIN
                         tblBudgetDetailProjectArea ON tblPerformanceSazman.id = tblBudgetDetailProjectArea.id
return
end

--===============================================================================================================================================
if(@yearId = 32 and @areaId = 19)-- ارامستانها 19
begin
delete TBl_Vaset_Taraz_Sazman
where AreaId=19 

insert into TBl_Vaset_Taraz_Sazman( AreaId , YearId ,    AreaName    ,   IdKol    ,   IdMoien    ,     IdTafsily   ,     Title        ,   Expense   )
						SELECT        19   ,   32   , ' آرامستانها' , tbl1.IdKol , tbl1.IdMoien , tbl1.IdTafsily4 , tblTafsily_1.Name, tbl1.Expense
						FROM            (SELECT        tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
													FROM            LBEHESHT.accamj.dbo.tblSanad_MD INNER JOIN
																			LBEHESHT.accamj.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																			LBEHESHT.accamj.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
																			LBEHESHT.accamj.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																			LBEHESHT.accamj.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
													WHERE        (tblKol.IdGroup IN (7, 6)) AND (tblSanad_MD.IdSal_MD = 10)
													GROUP BY tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4) AS tbl1 LEFT OUTER JOIN
													LBEHESHT.accamj.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily4 = tblTafsily_1.Id
--update TBl_Vaset_Taraz_Sazman
--set Expense = Expense*-1
--where AreaId=16 and IdKol=600

update TBl_Vaset_Taraz_Sazman
set CodeAcc = cast(IdKol as nvarchar(50))+'-'+cast(IdMoien as nvarchar(50))+'-'+cast(IdTafsily as nvarchar(50))
where AreaId=19 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = tblPerformanceSazman.ExpenseSazman*tblPerformanceSazman.PercentBud/100
FROM            (SELECT        tblBudgetDetailProjectArea_1.id, SUM(TBl_Vaset_Taraz_Sazman.Expense) AS ExpenseSazman, TblCodingsMapSazman.PercentBud
FROM            tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 INNER JOIN
                         tblCoding INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId ON tblCoding.Id = TblBudgetDetails.tblCodingId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                         TBl_Vaset_Taraz_Sazman ON TblCodingsMapSazman.CodeAcc = TBl_Vaset_Taraz_Sazman.CodeAcc
WHERE (TblBudgets.TblYearId = 32) AND
      (TblBudgets.TblAreaId = 19) AND
	  (TBl_Vaset_Taraz_Sazman.YearId = 32) AND
	  (TBl_Vaset_Taraz_Sazman.AreaId = 19) AND
	  (TblCodingsMapSazman.YearId = 32) AND 
      (TblCodingsMapSazman.AreaId = 19)
GROUP BY tblBudgetDetailProjectArea_1.id, TblCodingsMapSazman.PercentBud) AS tblPerformanceSazman INNER JOIN
                         tblBudgetDetailProjectArea ON tblPerformanceSazman.id = tblBudgetDetailProjectArea.id
return
end

--===============================================================================================================================================
if(@yearId = 32 and @areaId = 20)-- 20 سازمان حمل و نقل بار
begin
delete TBl_Vaset_Taraz_Sazman
where AreaId=20 

insert into TBl_Vaset_Taraz_Sazman(     AreaId   ,   YearId    ,       AreaName       ,   IdKol     ,    IdMoien    ,     IdTafsily   ,     Title     ,   Expense   )
							
							SELECT     20 as AreaId ,32 as YearId, 'بار' as AreaNAme  ,     tbl1.IdKol, tbl1.IdMoien, tbl1.IdTafsily4, tblTafsily_1.Name, tbl1.Expense
							FROM            (SELECT        tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
														FROM            LBAR.AccAMJ.dbo.tblSanad_MD INNER JOIN
																				LBAR.AccAMJ.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																				LBAR.AccAMJ.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
																				LBAR.AccAMJ.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																				LBAR.AccAMJ.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
														WHERE        (tblKol.IdGroup IN (4,5)) AND (tblSanad_MD.IdSal_MD = 15)
														GROUP BY tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4) AS tbl1 LEFT OUTER JOIN
														LBAR.AccAMJ.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily4 = tblTafsily_1.Id
update TBl_Vaset_Taraz_Sazman
set Expense = Expense*-1
where AreaId=20 and IdKol=4102

update TBl_Vaset_Taraz_Sazman
set CodeAcc = cast(IdKol as nvarchar(50))+'-'+cast(IdMoien as nvarchar(50))+'-'+cast(IdTafsily as nvarchar(50))
where AreaId=20 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = tblPerformanceSazman.ExpenseSazman*tblPerformanceSazman.PercentBud/100
FROM            (SELECT        tblBudgetDetailProjectArea_1.id, SUM(TBl_Vaset_Taraz_Sazman.Expense) AS ExpenseSazman, TblCodingsMapSazman.PercentBud
FROM            tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 INNER JOIN
                         tblCoding INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId ON tblCoding.Id = TblBudgetDetails.tblCodingId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                         TBl_Vaset_Taraz_Sazman ON TblCodingsMapSazman.CodeAcc = TBl_Vaset_Taraz_Sazman.CodeAcc
WHERE (TblBudgets.TblYearId = 32) AND
      (TblBudgets.TblAreaId = 20) AND
	  (TBl_Vaset_Taraz_Sazman.YearId = 32) AND
	  (TBl_Vaset_Taraz_Sazman.AreaId = 20) AND
	  (TblCodingsMapSazman.YearId = 32) AND 
      (TblCodingsMapSazman.AreaId = 20)
GROUP BY tblBudgetDetailProjectArea_1.id, TblCodingsMapSazman.PercentBud) AS tblPerformanceSazman INNER JOIN
                         tblBudgetDetailProjectArea ON tblPerformanceSazman.id = tblBudgetDetailProjectArea.id
return
end

--===============================================================================================================================================
if(@yearId = 32 and @areaId = 21)-- زیبا سازی 21
begin
delete TBl_Vaset_Taraz_Sazman
where AreaId=21 

insert into TBl_Vaset_Taraz_Sazman( AreaId , YearId ,    AreaName   ,   IdKol    ,   IdMoien    ,     IdTafsily   ,     Title        ,   Expense   )
						SELECT        21   ,   32   , 'زیبا سازی' , tbl1.IdKol , tbl1.IdMoien , tbl1.IdTafsily4 , tblTafsily_1.Name, tbl1.Expense
						FROM            (SELECT        tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
													FROM            LZIBA.accamj297.dbo.tblSanad_MD INNER JOIN
																			LZIBA.accamj297.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																			LZIBA.accamj297.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
																			LZIBA.accamj297.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																			LZIBA.accamj297.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
													WHERE        (tblKol.IdGroup IN (7, 6)) AND (tblSanad_MD.IdSal_MD = 11)
													GROUP BY tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4) AS tbl1 LEFT OUTER JOIN
													LZIBA.accamj297.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily4 = tblTafsily_1.Id
update TBl_Vaset_Taraz_Sazman
set Expense = Expense*-1
where AreaId=21 and IdKol=0701

update TBl_Vaset_Taraz_Sazman
set CodeAcc = cast(IdKol as nvarchar(50))+'-'+cast(IdMoien as nvarchar(50))+'-'+cast(IdTafsily as nvarchar(50))
where AreaId=21

UPDATE       tblBudgetDetailProjectArea
SET                Expense = tblPerformanceSazman.ExpenseSazman*tblPerformanceSazman.PercentBud/100
FROM            (SELECT        tblBudgetDetailProjectArea_1.id, SUM(TBl_Vaset_Taraz_Sazman.Expense) AS ExpenseSazman, TblCodingsMapSazman.PercentBud
FROM            tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 INNER JOIN
                         tblCoding INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId ON tblCoding.Id = TblBudgetDetails.tblCodingId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                         TBl_Vaset_Taraz_Sazman ON TblCodingsMapSazman.CodeAcc = TBl_Vaset_Taraz_Sazman.CodeAcc
WHERE (TblBudgets.TblYearId = 32) AND
      (TblBudgets.TblAreaId = 21) AND
	  (TBl_Vaset_Taraz_Sazman.YearId = 32) AND
	  (TBl_Vaset_Taraz_Sazman.AreaId = 21) AND
	  (TblCodingsMapSazman.YearId = 32) AND 
      (TblCodingsMapSazman.AreaId = 21)
GROUP BY tblBudgetDetailProjectArea_1.id, TblCodingsMapSazman.PercentBud) AS tblPerformanceSazman INNER JOIN
                         tblBudgetDetailProjectArea ON tblPerformanceSazman.id = tblBudgetDetailProjectArea.id
return
end

--===============================================================================================================================================
if(@yearId = 32 and @areaId = 22)--عمران 22
begin
delete TBl_Vaset_Taraz_Sazman
where AreaId=22

insert into TBl_Vaset_Taraz_Sazman( AreaId , YearId ,    AreaName   ,   IdKol    ,   IdMoien    ,     IdTafsily   ,     Title        ,   Expense   )
						SELECT        22   ,   32   , 'عمران' , tbl1.IdKol , tbl1.IdMoien , tbl1.IdTafsily4 , tblTafsily_1.Name, tbl1.Expense
						FROM            (SELECT        tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
													FROM            LOMRAN.accamj.dbo.tblSanad_MD INNER JOIN
																			LOMRAN.accamj.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																			LOMRAN.accamj.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
																			LOMRAN.accamj.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																			LOMRAN.accamj.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
													WHERE        (tblKol.IdGroup IN (1)) AND (tblSanad_MD.IdSal_MD = 11)
													GROUP BY tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4) AS tbl1 LEFT OUTER JOIN
													LOMRAN.accamj.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily4 = tblTafsily_1.Id
--update TBl_Vaset_Taraz_Sazman
--set Expense = Expense*-1
--where AreaId=16 and IdKol=600

update TBl_Vaset_Taraz_Sazman
set CodeAcc = cast(IdKol as nvarchar(50))+'-'+cast(IdMoien as nvarchar(50))+'-'+cast(IdTafsily as nvarchar(50))
where AreaId=22 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = tblPerformanceSazman.ExpenseSazman*tblPerformanceSazman.PercentBud/100
FROM            (SELECT        tblBudgetDetailProjectArea_1.id, SUM(TBl_Vaset_Taraz_Sazman.Expense) AS ExpenseSazman, TblCodingsMapSazman.PercentBud
FROM            tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 INNER JOIN
                         tblCoding INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId ON tblCoding.Id = TblBudgetDetails.tblCodingId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                         TBl_Vaset_Taraz_Sazman ON TblCodingsMapSazman.CodeAcc = TBl_Vaset_Taraz_Sazman.CodeAcc
WHERE (TblBudgets.TblYearId = 32) AND
      (TblBudgets.TblAreaId = 22) AND
	  (TBl_Vaset_Taraz_Sazman.YearId = 32) AND
	  (TBl_Vaset_Taraz_Sazman.AreaId = 22) AND
	  (TblCodingsMapSazman.YearId = 32) AND 
      (TblCodingsMapSazman.AreaId = 22)
GROUP BY tblBudgetDetailProjectArea_1.id, TblCodingsMapSazman.PercentBud) AS tblPerformanceSazman INNER JOIN
                         tblBudgetDetailProjectArea ON tblPerformanceSazman.id = tblBudgetDetailProjectArea.id
return
end

--===============================================================================================================================================
if(@yearId = 32 and @areaId = 23)--پسماند 23
begin
delete TBl_Vaset_Taraz_Sazman
where AreaId=23 

insert into TBl_Vaset_Taraz_Sazman( AreaId , YearId ,    AreaName   ,   IdKol    ,   IdMoien    ,     IdTafsily   ,     Title        ,   Expense   )
						SELECT        23   ,   32   , 'پسماند' , tbl1.IdKol , tbl1.IdMoien , tbl1.IdTafsily4 , tblTafsily_1.Name, tbl1.Expense
						FROM            (SELECT        tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
													FROM            LPASMAND.AccAMJ198.dbo.tblSanad_MD INNER JOIN
																			LPASMAND.AccAMJ198.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																			LPASMAND.AccAMJ198.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
																			LPASMAND.AccAMJ198.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																			LPASMAND.AccAMJ198.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
													WHERE        (tblKol.IdGroup IN (6,7)) AND (tblSanad_MD.IdSal_MD = 12)
													GROUP BY tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4) AS tbl1 LEFT OUTER JOIN
													LPASMAND.AccAMJ198.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily4 = tblTafsily_1.Id
update TBl_Vaset_Taraz_Sazman
set Expense = Expense*-1
where AreaId=23 and IdKol=600

update TBl_Vaset_Taraz_Sazman
set CodeAcc = cast(IdKol as nvarchar(50))+'-'+cast(IdMoien as nvarchar(50))+'-'+cast(IdTafsily as nvarchar(50))
where AreaId=23 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = tblPerformanceSazman.ExpenseSazman*tblPerformanceSazman.PercentBud/100
FROM            (SELECT        tblBudgetDetailProjectArea_1.id, SUM(TBl_Vaset_Taraz_Sazman.Expense) AS ExpenseSazman, TblCodingsMapSazman.PercentBud
FROM            tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 INNER JOIN
                         tblCoding INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId ON tblCoding.Id = TblBudgetDetails.tblCodingId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                         TBl_Vaset_Taraz_Sazman ON TblCodingsMapSazman.CodeAcc = TBl_Vaset_Taraz_Sazman.CodeAcc
WHERE (TblBudgets.TblYearId = 32) AND
      (TblBudgets.TblAreaId = 23) AND
	  (TBl_Vaset_Taraz_Sazman.YearId = 32) AND
	  (TBl_Vaset_Taraz_Sazman.AreaId = 23) AND
	  (TblCodingsMapSazman.YearId = 32) AND 
      (TblCodingsMapSazman.AreaId = 23)
GROUP BY tblBudgetDetailProjectArea_1.id, TblCodingsMapSazman.PercentBud) AS tblPerformanceSazman INNER JOIN
                         tblBudgetDetailProjectArea ON tblPerformanceSazman.id = tblBudgetDetailProjectArea.id
return
end

--===============================================================================================================================================
if(@yearId = 32 and @areaId = 24)--میادین 24
begin
delete TBl_Vaset_Taraz_Sazman
where AreaId=24 

insert into TBl_Vaset_Taraz_Sazman( AreaId , YearId ,    AreaName   ,   IdKol    ,   IdMoien    ,     IdTafsily   ,     Title        ,   Expense   )
						SELECT        24   ,   32   , 'میادین'     , tbl1.IdKol , tbl1.IdMoien , tbl1.IdTafsily4 , tblTafsily_1.Name, tbl1.Expense
						FROM            (SELECT        tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
													FROM            LMAYADIN.AccAMJ.dbo.tblSanad_MD INNER JOIN
																			LMAYADIN.AccAMJ.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																			LMAYADIN.AccAMJ.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
																			LMAYADIN.AccAMJ.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																			LMAYADIN.AccAMJ.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
													WHERE        (tblKol.IdGroup IN (6,7)) AND (tblSanad_MD.IdSal_MD = 11)
													GROUP BY tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4) AS tbl1 LEFT OUTER JOIN
													LMAYADIN.AccAMJ.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily4 = tblTafsily_1.Id
--update TBl_Vaset_Taraz_Sazman
--set Expense = Expense*-1
--where AreaId=16 and IdKol=600

update TBl_Vaset_Taraz_Sazman
set CodeAcc = cast(IdKol as nvarchar(50))+'-'+cast(IdMoien as nvarchar(50))+'-'+cast(IdTafsily as nvarchar(50))
where AreaId=24 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = tblPerformanceSazman.ExpenseSazman*tblPerformanceSazman.PercentBud/100
FROM            (SELECT        tblBudgetDetailProjectArea_1.id, SUM(TBl_Vaset_Taraz_Sazman.Expense) AS ExpenseSazman, TblCodingsMapSazman.PercentBud
FROM            tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 INNER JOIN
                         tblCoding INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId ON tblCoding.Id = TblBudgetDetails.tblCodingId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                         TBl_Vaset_Taraz_Sazman ON TblCodingsMapSazman.CodeAcc = TBl_Vaset_Taraz_Sazman.CodeAcc
WHERE (TblBudgets.TblYearId = 32) AND
      (TblBudgets.TblAreaId = 24) AND
	  (TBl_Vaset_Taraz_Sazman.YearId = 32) AND
	  (TBl_Vaset_Taraz_Sazman.AreaId = 24) AND
	  (TblCodingsMapSazman.YearId = 32) AND 
      (TblCodingsMapSazman.AreaId = 24)
GROUP BY tblBudgetDetailProjectArea_1.id, TblCodingsMapSazman.PercentBud) AS tblPerformanceSazman INNER JOIN
                         tblBudgetDetailProjectArea ON tblPerformanceSazman.id = tblBudgetDetailProjectArea.id
return
end

--===============================================================================================================================================
if(@yearId = 32 and @areaId = 25)--فرهنگی ورزشی 25	
begin
delete TBl_Vaset_Taraz_Sazman
where AreaId=25 

insert into TBl_Vaset_Taraz_Sazman( AreaId , YearId ,    AreaName   ,   IdKol    ,   IdMoien    ,     IdTafsily   ,     Title        ,   Expense   )
						SELECT        25   ,   32   , 'فرهنگی ورزشی' , tbl1.IdKol , tbl1.IdMoien , tbl1.IdTafsily4 , tblTafsily_1.Name, tbl1.Expense
						FROM            (SELECT        tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
													FROM            LSPORT.AccAMJ.dbo.tblSanad_MD INNER JOIN
																			LSPORT.AccAMJ.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																			LSPORT.AccAMJ.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
																			LSPORT.AccAMJ.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																			LSPORT.AccAMJ.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
													WHERE        (tblKol.IdGroup IN (6,7)) AND (tblSanad_MD.IdSal_MD = 13)
													GROUP BY tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4) AS tbl1 LEFT OUTER JOIN
													LSPORT.AccAMJ.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily4 = tblTafsily_1.Id
update TBl_Vaset_Taraz_Sazman
set Expense = Expense*-1
where AreaId=25 and IdKol=600

update TBl_Vaset_Taraz_Sazman
set CodeAcc = cast(IdKol as nvarchar(50))+'-'+cast(IdMoien as nvarchar(50))+'-'+cast(IdTafsily as nvarchar(50))
where AreaId=25 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = tblPerformanceSazman.ExpenseSazman*tblPerformanceSazman.PercentBud/100
FROM            (SELECT        tblBudgetDetailProjectArea_1.id, SUM(TBl_Vaset_Taraz_Sazman.Expense) AS ExpenseSazman, TblCodingsMapSazman.PercentBud
FROM            tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 INNER JOIN
                         tblCoding INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId ON tblCoding.Id = TblBudgetDetails.tblCodingId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                         TBl_Vaset_Taraz_Sazman ON TblCodingsMapSazman.CodeAcc = TBl_Vaset_Taraz_Sazman.CodeAcc
WHERE (TblBudgets.TblYearId = 32) AND
      (TblBudgets.TblAreaId = 25) AND
	  (TBl_Vaset_Taraz_Sazman.YearId = 32) AND
	  (TBl_Vaset_Taraz_Sazman.AreaId = 25) AND
	  (TblCodingsMapSazman.YearId = 32) AND 
      (TblCodingsMapSazman.AreaId = 25)
GROUP BY tblBudgetDetailProjectArea_1.id, TblCodingsMapSazman.PercentBud) AS tblPerformanceSazman INNER JOIN
                         tblBudgetDetailProjectArea ON tblPerformanceSazman.id = tblBudgetDetailProjectArea.id
return
end

--===============================================================================================================================================
if(@yearId = 32 and @areaId = 26)--قطار شهری 26
begin
delete TBl_Vaset_Taraz_Sazman
where AreaId=26 

insert into TBl_Vaset_Taraz_Sazman( AreaId , YearId ,    AreaName   ,   IdKol    ,   IdMoien    ,     IdTafsily   ,     Title        ,   Expense   )
						SELECT        26   ,   32   , 'قطار شهری'  , tbl1.IdKol , tbl1.IdMoien , tbl1.IdTafsily4 , tblTafsily_1.Name, tbl1.Expense
						FROM            (SELECT        tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4, SUM(tblSanadDetail_MD.Bedehkar) - SUM(tblSanadDetail_MD.Bestankar) AS Expense
													FROM            LMETRO.AccAMJ195.dbo.tblSanad_MD INNER JOIN
																			LMETRO.AccAMJ195.dbo.tblSanadDetail_MD ON tblSanad_MD.Id = tblSanadDetail_MD.IdSanad_MD AND tblSanad_MD.IdSal_MD = tblSanadDetail_MD.IdSalSanad_MD INNER JOIN
																			LMETRO.AccAMJ195.dbo.tblTafsily ON tblSanadDetail_MD.IdTafsily4 = tblTafsily.Id AND tblSanadDetail_MD.IdSotooh4 = tblTafsily.IdSotooh INNER JOIN
																			LMETRO.AccAMJ195.dbo.tblKol ON tblSanadDetail_MD.IdKol = tblKol.Id INNER JOIN
																			LMETRO.AccAMJ195.dbo.tblGroup ON tblKol.IdGroup = tblGroup.Id
													WHERE        (tblKol.IdGroup IN (6,7)) AND (tblSanad_MD.IdSal_MD = 14)
													GROUP BY tblSanadDetail_MD.IdKol, tblSanadDetail_MD.IdMoien, tblSanadDetail_MD.IdTafsily4) AS tbl1 LEFT OUTER JOIN
													LMETRO.AccAMJ195.dbo.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily4 = tblTafsily_1.Id
--update TBl_Vaset_Taraz_Sazman
--set Expense = Expense*-1
--where AreaId=16 and IdKol=600

update TBl_Vaset_Taraz_Sazman
set CodeAcc = cast(IdKol as nvarchar(50))+'-'+cast(IdMoien as nvarchar(50))+'-'+cast(IdTafsily as nvarchar(50))
where AreaId=26 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = tblPerformanceSazman.ExpenseSazman*tblPerformanceSazman.PercentBud/100
FROM            (SELECT        tblBudgetDetailProjectArea_1.id, SUM(TBl_Vaset_Taraz_Sazman.Expense) AS ExpenseSazman, TblCodingsMapSazman.PercentBud
FROM            tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 INNER JOIN
                         tblCoding INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId ON tblCoding.Id = TblBudgetDetails.tblCodingId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                         TBl_Vaset_Taraz_Sazman ON TblCodingsMapSazman.CodeAcc = TBl_Vaset_Taraz_Sazman.CodeAcc
WHERE (TblBudgets.TblYearId = 32) AND
      (TblBudgets.TblAreaId = 26) AND
	  (TBl_Vaset_Taraz_Sazman.YearId = 32) AND
	  (TBl_Vaset_Taraz_Sazman.AreaId = 26) AND
	  (TblCodingsMapSazman.YearId = 32) AND 
      (TblCodingsMapSazman.AreaId = 26)
GROUP BY tblBudgetDetailProjectArea_1.id, TblCodingsMapSazman.PercentBud) AS tblPerformanceSazman INNER JOIN
                         tblBudgetDetailProjectArea ON tblPerformanceSazman.id = tblBudgetDetailProjectArea.id
return
end
END
GO
