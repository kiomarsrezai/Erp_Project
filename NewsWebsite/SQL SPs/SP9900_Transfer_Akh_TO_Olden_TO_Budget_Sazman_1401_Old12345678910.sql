USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9900_Transfer_Akh_TO_Olden_TO_Budget_Sazman_1401_Old12345678910]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9900_Transfer_Akh_TO_Olden_TO_Budget_Sazman_1401_Old12345678910]

AS
BEGIN
--کانورت اسناد سازمان فاوا  
delete olden.tblGroup           where AreaId = 11 and YearName = 1401
delete olden.tblKol             where AreaId = 11 and YearName = 1401
delete olden.tblMoien           where AreaId = 11 and YearName = 1401
delete olden.tblSanadKind       where AreaId = 11 and YearName = 1401
delete olden.tblSanadState      where AreaId = 11 and YearName = 1401
delete olden.tblTafsily         where AreaId = 11 and YearName = 1401
delete olden.tblSanad_MD        where AreaId = 11 and YearName = 1401
delete olden.tblSanadDetail_MD  where AreaId = 11 and YearName = 1401

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   11   ,    1401   , Name
				FROM            LFAVA.AccAMJ.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   11   ,   1401  , IdGroup , Name
			FROM           LFAVA.AccAMJ.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   11   ,  1401   ,IdKol , Name
			    	FROM           LFAVA.AccAMJ.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   11   ,    1401   , Name
					     FROM    LFAVA.AccAMJ.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  11   ,   1401   , Name
				  FROM      LFAVA.AccAMJ.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   11   ,   1401   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LFAVA.AccAMJ.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1401   ,   11   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM            LFAVA.AccAMJ.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 12)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   11   ,  1401    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM           LFAVA.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=12 

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--سازمان فاوا
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
where AreaId=11 and   IdKol in (600,610,620,630,640,650)

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



--************************************************************************************************************************
--************************************************************************************************************************
--************************************************************************************************************************
----کانورت اسناد سازمان آتش نشانی  
delete olden.tblGroup           where AreaId = 12 and YearName = 1401
delete olden.tblKol             where AreaId = 12 and YearName = 1401
delete olden.tblMoien           where AreaId = 12 and YearName = 1401
delete olden.tblSanadKind       where AreaId = 12 and YearName = 1401
delete olden.tblSanadState      where AreaId = 12 and YearName = 1401
delete olden.tblTafsily         where AreaId = 12 and YearName = 1401
delete olden.tblSanad_MD        where AreaId = 12 and YearName = 1401
delete olden.tblSanadDetail_MD  where AreaId = 12 and YearName = 1401

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   12   ,    1401   , Name
				FROM          Lfire.AccAMJ295.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   12   ,   1401  , IdGroup , Name
			FROM           Lfire.AccAMJ295.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   12   ,  1401   ,IdKol , Name
			    	FROM       Lfire.AccAMJ295.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   12   ,    1401   , Name
					     FROM   Lfire.AccAMJ295.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  12   ,   1401   , Name
				  FROM     Lfire.AccAMJ295.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   12   ,   1401   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    Lfire.AccAMJ295.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1401   ,   12   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM            Lfire.AccAMJ295.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 12)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   12   ,  1401    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM         Lfire.AccAMJ295.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=12 

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--آتش نشانی
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

--*******************************************************************************************************************
--*******************************************************************************************************************
--*******************************************************************************************************************
--اتوبوسرانی
delete TBl_Vaset_Taraz_Sazman
where AreaId=13

delete olden.tblGroup           where AreaId = 13 and YearName = 1401
delete olden.tblKol             where AreaId = 13 and YearName = 1401
delete olden.tblMoien           where AreaId = 13 and YearName = 1401
delete olden.tblSanadKind       where AreaId = 13 and YearName = 1401
delete olden.tblSanadState      where AreaId = 13 and YearName = 1401
delete olden.tblTafsily         where AreaId = 13 and YearName = 1401
delete olden.tblSanad_MD        where AreaId = 13 and YearName = 1401
delete olden.tblSanadDetail_MD  where AreaId = 13 and YearName = 1401

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   13   ,    1401   , Name
				FROM            LBUS.AccAMJ295.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   13   ,   1401  , IdGroup , Name
			FROM            LBUS.AccAMJ295.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   13   ,  1401   ,IdKol , Name
			    	FROM            LBUS.AccAMJ295.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   13   ,    1401   , Name
					     FROM     LBUS.AccAMJ295.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  13   ,   1401   , Name
				  FROM       LBUS.AccAMJ295.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   13   ,   1401   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LBUS.AccAMJ295.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1401   ,   13   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM            LBUS.AccAMJ295.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 12)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   13   ,  1401    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            Lbus.AccAMJ295.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=12 

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--اتوبوسرانی
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

--**************************************************************************************************************
--**************************************************************************************************************
--**************************************************************************************************************
----کانورت اسناد حسابداری نوسازی بهسازی
delete olden.tblGroup           where AreaId = 14 and YearName = 1401
delete olden.tblKol             where AreaId = 14 and YearName = 1401
delete olden.tblMoien           where AreaId = 14 and YearName = 1401
delete olden.tblSanadKind       where AreaId = 14 and YearName = 1401
delete olden.tblSanadState      where AreaId = 14 and YearName = 1401
delete olden.tblTafsily         where AreaId = 14 and YearName = 1401
delete olden.tblSanad_MD        where AreaId = 14 and YearName = 1401
delete olden.tblSanadDetail_MD  where AreaId = 14 and YearName = 1401

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   14   ,    1401   , Name
				FROM        Lbehsazi.AccAMJ.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   14   ,   1401  , IdGroup , Name
			FROM            Lbehsazi.AccAMJ.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   14   ,  1401   ,IdKol , Name
			    	FROM     Lbehsazi.AccAMJ.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   14   ,    1401   , Name
					     FROM   Lbehsazi.AccAMJ.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  14   ,   1401   , Name
				  FROM     Lbehsazi.AccAMJ.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   14   ,   1401   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    Lbehsazi.AccAMJ.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1401   ,   14   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM           Lbehsazi.AccAMJ.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 10)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   14   ,  1401    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM           Lbehsazi.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=10 

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--نوسازی بهسازی
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

--**************************************************************************************************************
--**************************************************************************************************************
--**************************************************************************************************************
----کانورت اسناد حسابداری پارکها

delete olden.tblGroup           where AreaId = 15 and YearName = 1401
delete olden.tblKol             where AreaId = 15 and YearName = 1401
delete olden.tblMoien           where AreaId = 15 and YearName = 1401
delete olden.tblSanadKind       where AreaId = 15 and YearName = 1401
delete olden.tblSanadState      where AreaId = 15 and YearName = 1401
delete olden.tblTafsily         where AreaId = 15 and YearName = 1401
delete olden.tblSanad_MD        where AreaId = 15 and YearName = 1401
delete olden.tblSanadDetail_MD  where AreaId = 15 and YearName = 1401

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   15   ,    1401   , Name
				FROM        LPARK.AccAmj196.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   15   ,   1401  , IdGroup , Name
			FROM            LPARK.AccAmj196.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   15   ,  1401   ,IdKol , Name
			    	FROM     LPARK.AccAmj196.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   15   ,    1401   , Name
					     FROM   LPARK.AccAmj196.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  15   ,   1401   , Name
				  FROM     LPARK.AccAmj196.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   15   ,   1401   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LPARK.AccAmj196.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1401   ,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM           LPARK.AccAmj196.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 11)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   15   ,  1401    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM           LPARK.AccAmj196.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=11 


--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--سازمان پارکها

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

--**************************************************************************************************
--**************************************************************************************************
--**************************************************************************************************
----کانورت اسناد حسابداری ترمینال ها
delete olden.tblGroup           where AreaId = 16 and YearName = 1401
delete olden.tblKol             where AreaId = 16 and YearName = 1401
delete olden.tblMoien           where AreaId = 16 and YearName = 1401
delete olden.tblSanadKind       where AreaId = 16 and YearName = 1401
delete olden.tblSanadState      where AreaId = 16 and YearName = 1401
delete olden.tblTafsily         where AreaId = 16 and YearName = 1401
delete olden.tblSanad_MD        where AreaId = 16 and YearName = 1401
delete olden.tblSanadDetail_MD  where AreaId = 16 and YearName = 1401

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   16   ,    1401   , Name
				FROM        LTERMINAL.AccAmj.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   16   ,   1401  , IdGroup , Name
			FROM            LTERMINAL.AccAmj.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   16   ,  1401   ,IdKol , Name
			    	FROM     LTERMINAL.AccAmj.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   16   ,    1401   , Name
					     FROM   LTERMINAL.AccAmj.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  16   ,   1401   , Name
				  FROM     LTERMINAL.AccAmj.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   16   ,   1401   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LTERMINAL.AccAmj.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1401   ,   16   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM           LTERMINAL.AccAmj.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 11)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   16   ,  1401    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM          LTERMINAL.AccAmj.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=11 
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--ترمینال ها
delete TBl_Vaset_Taraz_Sazman
where AreaId=16 

insert into TBl_Vaset_Taraz_Sazman( AreaId , YearId ,    AreaName   ,   IdKol    ,   IdMoien    ,     IdTafsily   ,     Title        ,   Expense   )
						SELECT        16   ,   32   , 'پایانه ها'  , tbl1.IdKol , tbl1.IdMoien , tbl1.IdTafsily4 , tblTafsily_1.Name, tbl1.Expense
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

--**************************************************************************************************************
--***************************************************************************************************************
--***************************************************************************************************************
----کانورت اسناد حسابداری تاکسیرانی

delete olden.tblGroup           where AreaId = 17 and YearName = 1401
delete olden.tblKol             where AreaId = 17 and YearName = 1401
delete olden.tblMoien           where AreaId = 17 and YearName = 1401
delete olden.tblSanadKind       where AreaId = 17 and YearName = 1401
delete olden.tblSanadState      where AreaId = 17 and YearName = 1401
delete olden.tblTafsily         where AreaId = 17 and YearName = 1401
delete olden.tblSanad_MD        where AreaId = 17 and YearName = 1401
delete olden.tblSanadDetail_MD  where AreaId = 17 and YearName = 1401

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   17   ,    1401   , Name
				FROM        LTAXI.AccAMJ1095.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   17   ,   1401  , IdGroup , Name
			FROM            LTAXI.AccAMJ1095.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   17   ,  1401   ,IdKol , Name
			    	FROM     LTAXI.AccAMJ1095.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   17   ,    1401   , Name
					     FROM   LTAXI.AccAMJ1095.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  17   ,   1401   , Name
				  FROM     LTAXI.AccAMJ1095.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   17   ,   1401   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LTAXI.AccAMJ1095.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1401   ,   17   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM           LTAXI.AccAMJ1095.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 11)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   17   ,  1401    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM          LTAXI.AccAMJ1095.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=11 
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--تاکسیرانی
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

--*********************************************************************************************************
--*********************************************************************************************************
--*********************************************************************************************************
----کانورت اسناد حسابداری موتوری
delete olden.tblGroup           where AreaId = 18 and YearName = 1401
delete olden.tblKol             where AreaId = 18 and YearName = 1401
delete olden.tblMoien           where AreaId = 18 and YearName = 1401
delete olden.tblSanadKind       where AreaId = 18 and YearName = 1401
delete olden.tblSanadState      where AreaId = 18 and YearName = 1401
delete olden.tblTafsily         where AreaId = 18 and YearName = 1401
delete olden.tblSanad_MD        where AreaId = 18 and YearName = 1401
delete olden.tblSanadDetail_MD  where AreaId = 18 and YearName = 1401

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   18   ,    1401   , Name
				FROM        LMOTORI.AccAMJ.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   18   ,   1401  , IdGroup , Name
			FROM            LMOTORI.AccAMJ.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   18   ,  1401   ,IdKol , Name
			    	FROM    LMOTORI.AccAMJ.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   18   ,    1401   , Name
					     FROM   LMOTORI.AccAMJ.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  18   ,   1401   , Name
				  FROM     LMOTORI.AccAMJ.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   18   ,   1401   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LMOTORI.AccAMJ.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1401   ,   18   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM          LMOTORI.AccAMJ.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 14)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   18   ,  1401    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM         LMOTORI.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=14 

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--موتوری
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

--***********************************************************************************************************************
--***********************************************************************************************************************
--************************************************************************************************************************
--کانورت اسناد حسابداری ارامستانها
delete olden.tblGroup           where AreaId = 19 and YearName = 1401
delete olden.tblKol             where AreaId = 19 and YearName = 1401
delete olden.tblMoien           where AreaId = 19 and YearName = 1401
delete olden.tblSanadKind       where AreaId = 19 and YearName = 1401
delete olden.tblSanadState      where AreaId = 19 and YearName = 1401
delete olden.tblTafsily         where AreaId = 19 and YearName = 1401
delete olden.tblSanad_MD        where AreaId = 19 and YearName = 1401
delete olden.tblSanadDetail_MD  where AreaId = 19 and YearName = 1401

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   19   ,    1401   , Name
				FROM        LMOTORI.AccAMJ.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   19   ,   1401  , IdGroup , Name
			FROM            LMOTORI.AccAMJ.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   19   ,  1401   ,IdKol , Name
			    	FROM    LMOTORI.AccAMJ.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   19   ,    1401   , Name
					     FROM   LMOTORI.AccAMJ.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  19   ,   1401   , Name
				  FROM     LMOTORI.AccAMJ.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   19   ,   1401   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LMOTORI.AccAMJ.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1401   ,   19   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM          LMOTORI.AccAMJ.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 14)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   19   ,  1401    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM         LMOTORI.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=14 

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
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

--**********************************************************************************************************************
--**********************************************************************************************************************
--***********************************************************************************************************************
----کانورت اسناد حسابداری حمل و نقل بار
delete olden.tblGroup           where AreaId = 20 and YearName = 1401
delete olden.tblKol             where AreaId = 20 and YearName = 1401
delete olden.tblMoien           where AreaId = 20 and YearName = 1401
delete olden.tblSanadKind       where AreaId = 20 and YearName = 1401
delete olden.tblSanadState      where AreaId = 20 and YearName = 1401
delete olden.tblTafsily         where AreaId = 20 and YearName = 1401
delete olden.tblSanad_MD        where AreaId = 20 and YearName = 1401
delete olden.tblSanadDetail_MD  where AreaId = 20 and YearName = 1401

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   20   ,    1401   , Name
				FROM        LBAR.AccAMJ.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   20   ,   1401  , IdGroup , Name
			FROM            LBAR.AccAMJ.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   20   ,  1401   ,IdKol , Name
			    	FROM    LBAR.AccAMJ.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   20   ,    1401   , Name
					     FROM   LBAR.AccAMJ.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  20   ,   1401   , Name
				  FROM     LBAR.AccAMJ.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   20   ,   1401   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LBAR.AccAMJ.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1401   ,   20   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM          LBAR.AccAMJ.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 15)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   20   ,  1401    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM         LBAR.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=15 

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
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

--*******************************************************************************************************************
--*******************************************************************************************************************
--*******************************************************************************************************************
----کانورت اسناد حسابداری زیبا سازی
delete olden.tblGroup           where AreaId = 21 and YearName = 1401
delete olden.tblKol             where AreaId = 21 and YearName = 1401
delete olden.tblMoien           where AreaId = 21 and YearName = 1401
delete olden.tblSanadKind       where AreaId = 21 and YearName = 1401
delete olden.tblSanadState      where AreaId = 21 and YearName = 1401
delete olden.tblTafsily         where AreaId = 21 and YearName = 1401
delete olden.tblSanad_MD        where AreaId = 21 and YearName = 1401
delete olden.tblSanadDetail_MD  where AreaId = 21 and YearName = 1401

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   21   ,    1401   , Name
				FROM        LZIBA.accamj297.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   21   ,   1401  , IdGroup , Name
			FROM            LZIBA.accamj297.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   21   ,  1401   ,IdKol , Name
			    	FROM    LZIBA.accamj297.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   21   ,    1401   , Name
					     FROM   LZIBA.accamj297.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  21   ,   1401   , Name
				  FROM     LZIBA.accamj297.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   21   ,   1401   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LZIBA.accamj297.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1401   ,   21   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM          LZIBA.accamj297.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 11)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   21   ,  1401    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM         LZIBA.accamj297.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=11 
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--زیبا سازی
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

--***************************************************************************************************************
--***************************************************************************************************************
--***************************************************************************************************************
----کانورت اسناد حسابداری  عمران شهری
delete olden.tblGroup           where AreaId = 22 and YearName = 1401
delete olden.tblKol             where AreaId = 22 and YearName = 1401
delete olden.tblMoien           where AreaId = 22 and YearName = 1401
delete olden.tblSanadKind       where AreaId = 22 and YearName = 1401
delete olden.tblSanadState      where AreaId = 22 and YearName = 1401
delete olden.tblTafsily         where AreaId = 22 and YearName = 1401
delete olden.tblSanad_MD        where AreaId = 22 and YearName = 1401
delete olden.tblSanadDetail_MD  where AreaId = 22 and YearName = 1401

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   22   ,    1401   , Name
				FROM        LOMRAN.AccAMJ.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   22   ,   1401  , IdGroup , Name
			FROM            LOMRAN.AccAMJ.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   22   ,  1401   ,IdKol , Name
			    	FROM    LOMRAN.AccAMJ.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   22   ,    1401   , Name
					     FROM   LOMRAN.AccAMJ.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  22   ,   1401   , Name
				  FROM     LOMRAN.AccAMJ.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   22   ,   1401   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LOMRAN.AccAMJ.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1401   ,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM          LOMRAN.AccAMJ.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 11)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,  1401    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM         LOMRAN.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=11 
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--عمران شهری
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



--*****************************************************************************************************************
--*****************************************************************************************************************
--*****************************************************************************************************************
----کانورت اسناد حسابداری   پسماند
delete olden.tblGroup           where AreaId = 23 and YearName = 1401
delete olden.tblKol             where AreaId = 23 and YearName = 1401
delete olden.tblMoien           where AreaId = 23 and YearName = 1401
delete olden.tblSanadKind       where AreaId = 23 and YearName = 1401
delete olden.tblSanadState      where AreaId = 23 and YearName = 1401
delete olden.tblTafsily         where AreaId = 23 and YearName = 1401
delete olden.tblSanad_MD        where AreaId = 23 and YearName = 1401
delete olden.tblSanadDetail_MD  where AreaId = 23 and YearName = 1401

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   23   ,    1401   , Name
				FROM        LPASMAND.AccAMJ198.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   23   ,   1401  , IdGroup , Name
			FROM            LPASMAND.AccAMJ198.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   23   ,  1401   ,IdKol , Name
			    	FROM    LPASMAND.AccAMJ198.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   23   ,    1401   , Name
					     FROM   LPASMAND.AccAMJ198.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  23   ,   1401   , Name
				  FROM     LPASMAND.AccAMJ198.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   23   ,   1401   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LPASMAND.AccAMJ198.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1401   ,   23   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM          LPASMAND.AccAMJ198.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 11)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   23   ,  1401    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM        LPASMAND.AccAMJ198.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=11 

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--پسماند
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


--**********************************************************************************************************************
--**********************************************************************************************************************
--**********************************************************************************************************************
----کانورت اسناد حسابداری   میادین
delete olden.tblGroup           where AreaId = 24 and YearName = 1401
delete olden.tblKol             where AreaId = 24 and YearName = 1401
delete olden.tblMoien           where AreaId = 24 and YearName = 1401
delete olden.tblSanadKind       where AreaId = 24 and YearName = 1401
delete olden.tblSanadState      where AreaId = 24 and YearName = 1401
delete olden.tblTafsily         where AreaId = 24 and YearName = 1401
delete olden.tblSanad_MD        where AreaId = 24 and YearName = 1401
delete olden.tblSanadDetail_MD  where AreaId = 24 and YearName = 1401

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   24   ,    1401   , Name
				FROM        LMAYADIN.AccAMJ.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   24   ,   1401  , IdGroup , Name
			FROM            LMAYADIN.AccAMJ.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   24   ,  1401   ,IdKol , Name
			    	FROM    LMAYADIN.AccAMJ.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   24   ,    1401   , Name
					     FROM   LMAYADIN.AccAMJ.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  24   ,   1401   , Name
				  FROM     LMAYADIN.AccAMJ.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   24   ,   1401   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LMAYADIN.AccAMJ.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1401   ,   24   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM          LMAYADIN.AccAMJ.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 11)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   24   ,  1401    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM        LMAYADIN.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=11 

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--میادین
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

--****************************************************************************************************************
--****************************************************************************************************************
--****************************************************************************************************************
----کانورت اسناد حسابداری   فرهنگی
delete olden.tblGroup           where AreaId = 25 and YearName = 1401
delete olden.tblKol             where AreaId = 25 and YearName = 1401
delete olden.tblMoien           where AreaId = 25 and YearName = 1401
delete olden.tblSanadKind       where AreaId = 25 and YearName = 1401
delete olden.tblSanadState      where AreaId = 25 and YearName = 1401
delete olden.tblTafsily         where AreaId = 25 and YearName = 1401
delete olden.tblSanad_MD        where AreaId = 25 and YearName = 1401
delete olden.tblSanadDetail_MD  where AreaId = 25 and YearName = 1401

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   25   ,    1401   , Name
				FROM        LSPORT.AccAMJ.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   25   ,   1401  , IdGroup , Name
			FROM            LSPORT.AccAMJ.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   25   ,  1401   ,IdKol , Name
			    	FROM    LSPORT.AccAMJ.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   25   ,    1401   , Name
					     FROM   LSPORT.AccAMJ.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  25   ,   1401   , Name
				  FROM     LSPORT.AccAMJ.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   25   ,   1401   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LSPORT.AccAMJ.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1401   ,   25   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM          LSPORT.AccAMJ.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 11)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   25   ,  1401    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM        LSPORT.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=11 

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--فرهنگی
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


--**************************************************************************************************************
--**************************************************************************************************************
--**************************************************************************************************************
----کانورت اسناد حسابداری   ریلی
delete olden.tblGroup           where AreaId = 26 and YearName = 1401
delete olden.tblKol             where AreaId = 26 and YearName = 1401
delete olden.tblMoien           where AreaId = 26 and YearName = 1401
delete olden.tblSanadKind       where AreaId = 26 and YearName = 1401
delete olden.tblSanadState      where AreaId = 26 and YearName = 1401
delete olden.tblTafsily         where AreaId = 26 and YearName = 1401
delete olden.tblSanad_MD        where AreaId = 26 and YearName = 1401
delete olden.tblSanadDetail_MD  where AreaId = 26 and YearName = 1401

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   26   ,    1401   , Name
				FROM      LMETRO.AccAMJ195.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   26   ,   1401  , IdGroup , Name
			FROM      LMETRO.AccAMJ195.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   26   ,  1401   ,IdKol , Name
			    	FROM     LMETRO.AccAMJ195.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   26   ,    1401   , Name
					     FROM    LMETRO.AccAMJ195.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  26   ,   1401   , Name
				  FROM      LMETRO.AccAMJ195.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   26   ,   1401   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM     LMETRO.AccAMJ195.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1401   ,   26   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM           LMETRO.AccAMJ195.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 14)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   26   ,  1401    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM         LMETRO.AccAMJ195.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=14 

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--ریلی
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
END
GO
