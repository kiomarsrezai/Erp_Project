USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9900_Transfer_Akh_TO_Olden_TO_Budget_Shardari_1401_Old12345678910]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9900_Transfer_Akh_TO_Olden_TO_Budget_Shardari_1401_Old12345678910]
AS
BEGIN
delete Tbl_Vasets
DBCC CHECKIDENT('Tbl_Vasets',RESEED,0)

--=====================================================================================================
--منطقه 01
delete olden.tblGroup           where AreaId = 1 and YearName = 1401
delete olden.tblKol             where AreaId = 1 and YearName = 1401
delete olden.tblMoien           where AreaId = 1 and YearName = 1401
delete olden.tblSanadKind       where AreaId = 1 and YearName = 1401
delete olden.tblSanadState      where AreaId = 1 and YearName = 1401
delete olden.tblTafsily         where AreaId = 1 and YearName = 1401
delete olden.tblSanad_MD        where AreaId = 1 and YearName = 1401
delete olden.tblSanadDetail_MD  where AreaId = 1 and YearName = 1401

insert into olden.tblGroup(        id    , AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id ,    1   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            AKH.AccAMJ1001.dbo.tblGroup CROSS JOIN
										 AKH.AccAMJ1001.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (18))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    1   , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            AKH.AccAMJ1001.dbo.tblKol CROSS JOIN
									 AKH.AccAMJ1001.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (18))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,   1   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            AKH.AccAMJ1001.dbo.tblSal_MD CROSS JOIN
										 AKH.AccAMJ1001.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (18))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,   1   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            AKH.AccAMJ1001.dbo.tblSal_MD CROSS JOIN
									 AKH.AccAMJ1001.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (18))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,    1   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
						FROM            AKH.AccAMJ1001.dbo.tblSal_MD CROSS JOIN
												 AKH.AccAMJ1001.dbo.tblSanadState
						WHERE        (tblSal_MD.Id IN (18))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   1  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
							FROM            AKH.AccAMJ1001.dbo.tblSal_MD CROSS JOIN
													 AKH.AccAMJ1001.dbo.tblTafsily
							WHERE        (tblSal_MD.Id IN (18))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 18 then 1401 end ,   1   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ1001.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName              , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    1  , 
						   											case when IdSalSanad_MD = 18 then 1401 end   ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            AKH.AccAMJ1001.dbo.tblSanadDetail_MD

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
INSERT INTO Tbl_Vasets( YearId, AreaId,    IdTafsily4   ,    IdTafsily5   ,  NameTafsily   ,    Markhazhazine  ,    Expense   ,                CodeVaset         )

SELECT        32 AS Expr1, 1 AS Expr2, tbl1.IdTafsily4, tbl1.IdTafsily5, tblTafsily_2.Name, tblTafsily_1.Name AS Expr3, tbl1.Expense, cast(tbl1.IdTafsily4 as nvarchar(50)) + cast(tbl1.IdTafsily5 as nvarchar(50))
FROM            (SELECT        olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
FROM            olden.tblSanad_MD INNER JOIN
                         olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName AND 
                         olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId INNER JOIN
                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id INNER JOIN
                         olden.tblTafsily ON olden.tblSanadDetail_MD.IdTafsily4 = olden.tblTafsily.Id AND olden.tblSanadDetail_MD.IdSotooh4 = olden.tblTafsily.IdSotooh AND olden.tblSanadDetail_MD.AreaId = olden.tblTafsily.AreaId AND 
                         olden.tblSanadDetail_MD.YearName = olden.tblTafsily.YearName
WHERE  (olden.tblSanad_MD.YearName = 1401) AND
       (olden.tblKol.IdGroup IN (7, 8)) AND
	   (olden.tblTafsily.IdTafsilyGroup <> '18') AND
	   (olden.tblSanad_MD.AreaId = 1) AND
	   (olden.tblSanadDetail_MD.AreaId = 1) AND 
       (olden.tblTafsily.AreaId = 1) AND
	   (olden.tblSanad_MD.YearName = 1401) AND
	   (olden.tblSanadDetail_MD.YearName = 1401) AND
	   (olden.tblTafsily.YearName = 1401) AND
	   (olden.tblKol.AreaId = 1) AND 
       (olden.tblKol.YearName = 1401)
GROUP BY olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5) AS tbl1 INNER JOIN
                         olden.tblTafsily AS tblTafsily_2 ON tbl1.IdTafsily4 = tblTafsily_2.Id INNER JOIN
                         olden.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
WHERE  (tbl1.Expense <> 0) AND
       (tblTafsily_2.AreaId = 1) AND
	   (tblTafsily_2.YearName = 1401) AND
	   (tblTafsily_1.AreaId = 1) AND
	   (tblTafsily_1.YearName = 1401)
				
--*********************************************************************************************************
--*********************************************************************************************************
--*********************************************************************************************************
delete olden.tblGroup           where AreaId = 2 and YearName in (1401,1402)
delete olden.tblKol             where AreaId = 2 and YearName in (1401,1402)
delete olden.tblMoien           where AreaId = 2 and YearName in (1401,1402)
delete olden.tblSanadKind       where AreaId = 2 and YearName in (1401,1402)
delete olden.tblSanadState      where AreaId = 2 and YearName in (1401,1402)
delete olden.tblTafsily         where AreaId = 2 and YearName in (1401,1402)
delete olden.tblSanad_MD        where AreaId = 2 and YearName in (1401,1402)
delete olden.tblSanadDetail_MD  where AreaId = 2 and YearName in (1401,1402)

insert into olden.tblGroup(        id    , AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id ,   2   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            AKH.AccAMJ1002.dbo.tblGroup CROSS JOIN
										 AKH.AccAMJ1002.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (21))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    2  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            AKH.AccAMJ1002.dbo.tblKol CROSS JOIN
									 AKH.AccAMJ1002.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (21))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  2   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            AKH.AccAMJ1002.dbo.tblSal_MD CROSS JOIN
										 AKH.AccAMJ1002.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (21))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  2   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            AKH.AccAMJ1002.dbo.tblSal_MD CROSS JOIN
									 AKH.AccAMJ1002.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (21))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   2   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
						FROM            AKH.AccAMJ1002.dbo.tblSal_MD CROSS JOIN
												 AKH.AccAMJ1002.dbo.tblSanadState
						WHERE        (tblSal_MD.Id IN (21))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   2  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
							FROM            AKH.AccAMJ1002.dbo.tblSal_MD CROSS JOIN
													 AKH.AccAMJ1002.dbo.tblTafsily
							WHERE        (tblSal_MD.Id IN (21))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 21 then 1401 end ,   2   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ1002.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName              , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    2  , 
						   											case  when IdSalSanad_MD = 21 then 1401 end   ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            AKH.AccAMJ1002.dbo.tblSanadDetail_MD
--++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++
--منطقه 02
INSERT INTO Tbl_Vasets( YearId, AreaId,    IdTafsily4   ,   IdTafsily5   ,   NameTafsily    ,   Markhazhazine   ,    Expense   ,              CodeVaset                    )
			SELECT        32  ,   2   , tbl1.IdTafsily4 , tbl1.IdTafsily5, tblTafsily_2.Name, tblTafsily_1.Name , tbl1.Expense , cast(tbl1.IdTafsily4 as nvarchar(50)) + cast(tbl1.IdTafsily5 as nvarchar(50))
			FROM            (SELECT        olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
									   FROM            olden.tblSanad_MD INNER JOIN
																olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName AND 
																olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId INNER JOIN
																olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id INNER JOIN
																olden.tblTafsily ON olden.tblSanadDetail_MD.IdTafsily4 = olden.tblTafsily.Id AND olden.tblSanadDetail_MD.IdSotooh4 = olden.tblTafsily.IdSotooh
									   WHERE (olden.tblSanad_MD.YearName = 1401) AND
									         (olden.tblKol.IdGroup IN (7, 8)) AND
											 (olden.tblTafsily.IdTafsilyGroup <> '18') AND
											 (olden.tblSanad_MD.AreaId = 2) AND
											 (olden.tblSanadDetail_MD.AreaId = 2) AND 
											 (olden.tblTafsily.AreaId = 2) AND
											 (olden.tblSanad_MD.YearName = 1401) AND
											 (olden.tblSanadDetail_MD.YearName = 1401) AND
											 (olden.tblTafsily.YearName = 1401) AND
											 (olden.tblKol.AreaId = 2) AND 
											 (olden.tblKol.YearName = 1401)
									   GROUP BY olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5) AS tbl1 INNER JOIN
									 olden.tblTafsily AS tblTafsily_2 ON tbl1.IdTafsily4 = tblTafsily_2.Id INNER JOIN
									 olden.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
			WHERE        (tbl1.Expense <> 0) AND
				   (tblTafsily_2.AreaId = 1) AND
				   (tblTafsily_2.YearName = 1401) AND
				   (tblTafsily_1.AreaId = 1) AND
				   (tblTafsily_1.YearName = 1401)

--*************************************************************************************************************
--*************************************************************************************************************
--*************************************************************************************************************
delete olden.tblGroup           where AreaId = 3 and YearName in (1401,1402)
delete olden.tblKol             where AreaId = 3  and YearName in (1401,1402)
delete olden.tblMoien           where AreaId = 3  and YearName in (1401,1402)
delete olden.tblSanadKind       where AreaId = 3  and YearName in (1401,1402)
delete olden.tblSanadState      where AreaId = 3  and YearName in (1401,1402)
delete olden.tblTafsily         where AreaId = 3  and YearName in (1401,1402)
delete olden.tblSanad_MD        where AreaId = 3  and YearName in (1401,1402)
delete olden.tblSanadDetail_MD  where AreaId = 3  and YearName in (1401,1402)

insert into olden.tblGroup(        id    , AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id ,   3   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            AKH.AccAMJ1003.dbo.tblGroup CROSS JOIN
										 AKH.AccAMJ1003.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (18))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    3  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            AKH.AccAMJ1003.dbo.tblKol CROSS JOIN
									 AKH.AccAMJ1003.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (18))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  3    ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            AKH.AccAMJ1003.dbo.tblSal_MD CROSS JOIN
										 AKH.AccAMJ1003.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (18))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  3   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            AKH.AccAMJ1003.dbo.tblSal_MD CROSS JOIN
									 AKH.AccAMJ1003.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (18))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   3   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
						FROM            AKH.AccAMJ1003.dbo.tblSal_MD CROSS JOIN
												 AKH.AccAMJ1003.dbo.tblSanadState
						WHERE        (tblSal_MD.Id IN (18))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   3   ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
							FROM            AKH.AccAMJ1003.dbo.tblSal_MD CROSS JOIN
													 AKH.AccAMJ1003.dbo.tblTafsily
							WHERE        (tblSal_MD.Id IN (18))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 18 then 1401 end ,   3   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ1003.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName              , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    3   , 
						   											case  when IdSalSanad_MD = 18 then 1401 end   ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            AKH.AccAMJ1003.dbo.tblSanadDetail_MD
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--منطقه 03
INSERT INTO Tbl_Vasets( YearId, AreaId, IdTafsily4 , IdTafsily5 , NameTafsily , Markhazhazine ,Expense ,CodeVaset)
			SELECT        32  ,   3   , tbl1.IdTafsily4 , tbl1.IdTafsily5, tblTafsily_2.Name, tblTafsily_1.Name , tbl1.Expense , cast(tbl1.IdTafsily4 as nvarchar(50)) + cast(tbl1.IdTafsily5 as nvarchar(50))
					FROM            (SELECT        olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
											   FROM            olden.tblSanad_MD INNER JOIN
																		olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName AND 
																		olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId INNER JOIN
																		olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id INNER JOIN
																		olden.tblTafsily ON olden.tblSanadDetail_MD.IdTafsily4 = olden.tblTafsily.Id AND olden.tblSanadDetail_MD.IdSotooh4 = olden.tblTafsily.IdSotooh
											   WHERE (olden.tblSanad_MD.YearName = 1401) AND
													 (olden.tblKol.IdGroup IN (7, 8)) AND
													 (olden.tblTafsily.IdTafsilyGroup <> '18') AND
													 (olden.tblSanad_MD.AreaId = 3) AND
													 (olden.tblSanadDetail_MD.AreaId = 3) AND 
													 (olden.tblTafsily.AreaId = 3) AND
													 (olden.tblSanad_MD.YearName = 1401) AND
													 (olden.tblSanadDetail_MD.YearName = 1401) AND
													 (olden.tblTafsily.YearName = 1401)AND
												     (olden.tblKol.AreaId = 3) AND 
												     (olden.tblKol.YearName = 1401)
											   GROUP BY olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5) AS tbl1 INNER JOIN
											 olden.tblTafsily AS tblTafsily_2 ON tbl1.IdTafsily4 = tblTafsily_2.Id INNER JOIN
											 olden.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
					WHERE        (tbl1.Expense <> 0) AND
						   (tblTafsily_2.AreaId = 3) AND
						   (tblTafsily_2.YearName = 1401) AND
						   (tblTafsily_1.AreaId = 3) AND
						   (tblTafsily_1.YearName = 1401)

--************************************************************************************************************
--************************************************************************************************************
--************************************************************************************************************
--منطقه 04
delete olden.tblGroup           where AreaId = 4 and YearName in (1401,1402)
delete olden.tblKol             where AreaId = 4 and YearName in (1401,1402)
delete olden.tblMoien           where AreaId = 4 and YearName in (1401,1402)
delete olden.tblSanadKind       where AreaId = 4 and YearName in (1401,1402)
delete olden.tblSanadState      where AreaId = 4 and YearName in (1401,1402)
delete olden.tblTafsily         where AreaId = 4 and YearName in (1401,1402)
delete olden.tblSanad_MD        where AreaId = 4 and YearName in (1401,1402)
delete olden.tblSanadDetail_MD  where AreaId = 4 and YearName in (1401,1402)

insert into olden.tblGroup(        id    , AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id ,   4   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            AKH.AccAMJ1004.dbo.tblGroup CROSS JOIN
										 AKH.AccAMJ1004.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (16))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    4   , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            AKH.AccAMJ1004.dbo.tblKol CROSS JOIN
									 AKH.AccAMJ1004.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (16))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  4   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            AKH.AccAMJ1004.dbo.tblSal_MD CROSS JOIN
										 AKH.AccAMJ1004.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (16))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,   4   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            AKH.AccAMJ1004.dbo.tblSal_MD CROSS JOIN
									 AKH.AccAMJ1004.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (16))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,    4   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
						FROM            AKH.AccAMJ1004.dbo.tblSal_MD CROSS JOIN
												 AKH.AccAMJ1004.dbo.tblSanadState
						WHERE        (tblSal_MD.Id IN (16))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   4   ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
							FROM            AKH.AccAMJ1004.dbo.tblSal_MD CROSS JOIN
													 AKH.AccAMJ1004.dbo.tblTafsily
							WHERE        (tblSal_MD.Id IN (16))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 16 then 1401 end ,   4   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ1004.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName              , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    4  , 
						   											case when IdSalSanad_MD = 16 then 1401 end   ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            AKH.AccAMJ1004.dbo.tblSanadDetail_MD
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--منطقه 4
INSERT INTO Tbl_Vasets( YearId, AreaId, IdTafsily4 , IdTafsily5 , NameTafsily , Markhazhazine ,Expense ,CodeVaset)
			SELECT        32  ,   4   , tbl1.IdTafsily4 , tbl1.IdTafsily5, tblTafsily_2.Name, tblTafsily_1.Name , tbl1.Expense , cast(tbl1.IdTafsily4 as nvarchar(50)) + cast(tbl1.IdTafsily5 as nvarchar(50))
					FROM            (SELECT        olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
											   FROM            olden.tblSanad_MD INNER JOIN
																		olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName AND 
																		olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId INNER JOIN
																		olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id INNER JOIN
																		olden.tblTafsily ON olden.tblSanadDetail_MD.IdTafsily4 = olden.tblTafsily.Id AND olden.tblSanadDetail_MD.IdSotooh4 = olden.tblTafsily.IdSotooh
											   WHERE (olden.tblSanad_MD.YearName = 1401) AND
													 (olden.tblKol.IdGroup IN (7, 8)) AND
													 (olden.tblTafsily.IdTafsilyGroup <> '18') AND
													 (olden.tblSanad_MD.AreaId = 4) AND
													 (olden.tblSanadDetail_MD.AreaId = 4) AND 
													 (olden.tblTafsily.AreaId = 4) AND
													 (olden.tblSanad_MD.YearName = 1401) AND
													 (olden.tblSanadDetail_MD.YearName = 1401) AND
													 (olden.tblTafsily.YearName = 1401)AND
												     (olden.tblKol.AreaId = 4) AND 
												     (olden.tblKol.YearName = 1401)
											   GROUP BY olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5) AS tbl1 INNER JOIN
											 olden.tblTafsily AS tblTafsily_2 ON tbl1.IdTafsily4 = tblTafsily_2.Id INNER JOIN
											 olden.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
					WHERE        (tbl1.Expense <> 0) AND
						   (tblTafsily_2.AreaId = 4) AND
						   (tblTafsily_2.YearName = 1401) AND
						   (tblTafsily_1.AreaId = 4) AND
						   (tblTafsily_1.YearName = 1401)

--****************************************************************************************************
--****************************************************************************************************
--****************************************************************************************************
--منطقه 05
delete olden.tblGroup           where AreaId = 5 and YearName in (1401,1402)
delete olden.tblKol             where AreaId = 5 and YearName in (1401,1402)
delete olden.tblMoien           where AreaId = 5 and YearName in (1401,1402)
delete olden.tblSanadKind       where AreaId = 5 and YearName in (1401,1402)
delete olden.tblSanadState      where AreaId = 5 and YearName in (1401,1402)
delete olden.tblTafsily         where AreaId = 5 and YearName in (1401,1402)
delete olden.tblSanad_MD        where AreaId = 5 and YearName in (1401,1402)
delete olden.tblSanadDetail_MD  where AreaId = 5 and YearName in (1401,1402)

insert into olden.tblGroup(        id    , AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id ,    5   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            AKH.AccAMJ1005.dbo.tblGroup CROSS JOIN
										 AKH.AccAMJ1005.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (15))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    5   , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            AKH.AccAMJ1005.dbo.tblKol CROSS JOIN
									 AKH.AccAMJ1005.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (15))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  5    ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            AKH.AccAMJ1005.dbo.tblSal_MD CROSS JOIN
										 AKH.AccAMJ1005.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (15))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  5    , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            AKH.AccAMJ1005.dbo.tblSal_MD CROSS JOIN
									 AKH.AccAMJ1005.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (15))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   5    , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
						FROM            AKH.AccAMJ1005.dbo.tblSal_MD CROSS JOIN
												 AKH.AccAMJ1005.dbo.tblSanadState
						WHERE        (tblSal_MD.Id IN (15))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   5  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
							FROM            AKH.AccAMJ1005.dbo.tblSal_MD CROSS JOIN
													 AKH.AccAMJ1005.dbo.tblTafsily
							WHERE        (tblSal_MD.Id IN (15))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 15 then 1401 end ,   5   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ1005.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName              , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    5  , 
						   											case when IdSalSanad_MD = 15 then 1401 end   ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            AKH.AccAMJ1005.dbo.tblSanadDetail_MD
INSERT INTO Tbl_Vasets( YearId, AreaId, IdTafsily4 , IdTafsily5 , NameTafsily , Markhazhazine ,Expense ,CodeVaset)
			SELECT        32  ,   5   , tbl1.IdTafsily4 , tbl1.IdTafsily5, tblTafsily_2.Name, tblTafsily_1.Name , tbl1.Expense , cast(tbl1.IdTafsily4 as nvarchar(50)) + cast(tbl1.IdTafsily5 as nvarchar(50))
					FROM            (SELECT        olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
											   FROM            olden.tblSanad_MD INNER JOIN
																		olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName AND 
																		olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId INNER JOIN
																		olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id INNER JOIN
																		olden.tblTafsily ON olden.tblSanadDetail_MD.IdTafsily4 = olden.tblTafsily.Id AND olden.tblSanadDetail_MD.IdSotooh4 = olden.tblTafsily.IdSotooh
											   WHERE (olden.tblSanad_MD.YearName = 1401) AND
													 (olden.tblKol.IdGroup IN (7, 8)) AND
													 (olden.tblTafsily.IdTafsilyGroup <> '18') AND
													 (olden.tblSanad_MD.AreaId = 5) AND
													 (olden.tblSanadDetail_MD.AreaId = 5) AND 
													 (olden.tblTafsily.AreaId = 5) AND
													 (olden.tblSanad_MD.YearName = 1401) AND
													 (olden.tblSanadDetail_MD.YearName = 1401) AND
													 (olden.tblTafsily.YearName = 1401) AND
												     (olden.tblKol.AreaId = 5) AND 
												     (olden.tblKol.YearName = 1401)
											   GROUP BY olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5) AS tbl1 INNER JOIN
											 olden.tblTafsily AS tblTafsily_2 ON tbl1.IdTafsily4 = tblTafsily_2.Id INNER JOIN
											 olden.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
					WHERE        (tbl1.Expense <> 0) AND
						   (tblTafsily_2.AreaId = 5) AND
						   (tblTafsily_2.YearName = 1401) AND
						   (tblTafsily_1.AreaId = 5) AND
						   (tblTafsily_1.YearName = 1401)

--*******************************************************************************************
--*******************************************************************************************
--*******************************************************************************************
--منطقه 06
delete olden.tblGroup           where AreaId = 6 and YearName in (1401,1402)
delete olden.tblKol             where AreaId = 6 and YearName in (1401,1402)
delete olden.tblMoien           where AreaId = 6 and YearName in (1401,1402)
delete olden.tblSanadKind       where AreaId = 6 and YearName in (1401,1402)
delete olden.tblSanadState      where AreaId = 6 and YearName in (1401,1402)
delete olden.tblTafsily         where AreaId = 6 and YearName in (1401,1402)
delete olden.tblSanad_MD        where AreaId = 6 and YearName in (1401,1402)
delete olden.tblSanadDetail_MD  where AreaId = 6 and YearName in (1401,1402)

insert into olden.tblGroup(        id    , AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id ,   6   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            AKH.AccAMJ1006.dbo.tblGroup CROSS JOIN
										 AKH.AccAMJ1006.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (15))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    6  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            AKH.AccAMJ1006.dbo.tblKol CROSS JOIN
									 AKH.AccAMJ1006.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (15))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  6   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            AKH.AccAMJ1006.dbo.tblSal_MD CROSS JOIN
										 AKH.AccAMJ1006.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (15))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  6   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            AKH.AccAMJ1006.dbo.tblSal_MD CROSS JOIN
									 AKH.AccAMJ1006.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (15))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   6   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
						FROM            AKH.AccAMJ1006.dbo.tblSal_MD CROSS JOIN
												 AKH.AccAMJ1006.dbo.tblSanadState
						WHERE        (tblSal_MD.Id IN (15))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   6  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
							FROM            AKH.AccAMJ1006.dbo.tblSal_MD CROSS JOIN
													 AKH.AccAMJ1006.dbo.tblTafsily
							WHERE        (tblSal_MD.Id IN (15))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 15 then 1401 end ,   6   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ1006.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName              , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    6  , 
						   											case when IdSalSanad_MD = 15 then 1401 end   ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            AKH.AccAMJ1006.dbo.tblSanadDetail_MD
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--منطقه 6
INSERT INTO Tbl_Vasets( YearId, AreaId, IdTafsily4 , IdTafsily5 , NameTafsily , Markhazhazine ,Expense ,CodeVaset)
			SELECT        32  ,   6   , tbl1.IdTafsily4 , tbl1.IdTafsily5, tblTafsily_2.Name, tblTafsily_1.Name , tbl1.Expense , cast(tbl1.IdTafsily4 as nvarchar(50)) + cast(tbl1.IdTafsily5 as nvarchar(50))
					FROM            (SELECT        olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
											   FROM            olden.tblSanad_MD INNER JOIN
																		olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName AND 
																		olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId INNER JOIN
																		olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id INNER JOIN
																		olden.tblTafsily ON olden.tblSanadDetail_MD.IdTafsily4 = olden.tblTafsily.Id AND olden.tblSanadDetail_MD.IdSotooh4 = olden.tblTafsily.IdSotooh
											   WHERE (olden.tblSanad_MD.YearName = 1401) AND
													 (olden.tblKol.IdGroup IN (7, 8)) AND
													 (olden.tblTafsily.IdTafsilyGroup <> '18') AND
													 (olden.tblSanad_MD.AreaId = 6) AND
													 (olden.tblSanadDetail_MD.AreaId = 6) AND 
													 (olden.tblTafsily.AreaId = 6) AND
													 (olden.tblSanad_MD.YearName = 1401) AND
													 (olden.tblSanadDetail_MD.YearName = 1401) AND
													 (olden.tblTafsily.YearName = 1401)AND
												     (olden.tblKol.AreaId = 6) AND 
												     (olden.tblKol.YearName = 1401)
											   GROUP BY olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5) AS tbl1 INNER JOIN
											 olden.tblTafsily AS tblTafsily_2 ON tbl1.IdTafsily4 = tblTafsily_2.Id INNER JOIN
											 olden.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
					WHERE        (tbl1.Expense <> 0) AND
						   (tblTafsily_2.AreaId = 6) AND
						   (tblTafsily_2.YearName = 1401) AND
						   (tblTafsily_1.AreaId = 6) AND
						   (tblTafsily_1.YearName = 1401)

--***********************************************************************************
--***********************************************************************************
--************************************************************************************
--منطقه 07
delete olden.tblGroup           where AreaId = 7 and YearName in (1401,1402)
delete olden.tblKol             where AreaId = 7 and YearName in (1401,1402)
delete olden.tblMoien           where AreaId = 7 and YearName in (1401,1402)
delete olden.tblSanadKind       where AreaId = 7 and YearName in (1401,1402)
delete olden.tblSanadState      where AreaId = 7 and YearName in (1401,1402)
delete olden.tblTafsily         where AreaId = 7 and YearName in (1401,1402)
delete olden.tblSanad_MD        where AreaId = 7 and YearName in (1401,1402)
delete olden.tblSanadDetail_MD  where AreaId = 7 and YearName in (1401,1402)

insert into olden.tblGroup(        id    , AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id ,   7   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            AKH.AccAMJ1007.dbo.tblGroup CROSS JOIN
										 AKH.AccAMJ1007.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (13))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    7  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            AKH.AccAMJ1007.dbo.tblKol CROSS JOIN
									 AKH.AccAMJ1007.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (13))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  7   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            AKH.AccAMJ1007.dbo.tblSal_MD CROSS JOIN
										 AKH.AccAMJ1007.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (13))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  7   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            AKH.AccAMJ1007.dbo.tblSal_MD CROSS JOIN
									 AKH.AccAMJ1007.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (13))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   7   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
						FROM            AKH.AccAMJ1007.dbo.tblSal_MD CROSS JOIN
												 AKH.AccAMJ1007.dbo.tblSanadState
						WHERE        (tblSal_MD.Id IN (13))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   7  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
							FROM            AKH.AccAMJ1007.dbo.tblSal_MD CROSS JOIN
													 AKH.AccAMJ1007.dbo.tblTafsily
							WHERE        (tblSal_MD.Id IN (13))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 13 then 1401 end ,   7   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ1007.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName              , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    7  , 
						   											case when IdSalSanad_MD = 13 then 1401 end   ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            AKH.AccAMJ1007.dbo.tblSanadDetail_MD
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--منطقه 7
INSERT INTO Tbl_Vasets( YearId, AreaId,     IdTafsily4  ,    IdTafsily5   ,    NameTafsily    ,   Markhazhazine   ,    Expense   ,            CodeVaset)
				 SELECT   32  ,   7   , tbl1.IdTafsily4 , tbl1.IdTafsily5 , tblTafsily_2.Name , tblTafsily_1.Name , tbl1.Expense , cast(tbl1.IdTafsily4 as nvarchar(50)) + cast(tbl1.IdTafsily5 as nvarchar(50))
					FROM            (SELECT        olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
											   FROM            olden.tblSanad_MD INNER JOIN
																		olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName AND 
																		olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId INNER JOIN
																		olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id INNER JOIN
																		olden.tblTafsily ON olden.tblSanadDetail_MD.IdTafsily4 = olden.tblTafsily.Id AND olden.tblSanadDetail_MD.IdSotooh4 = olden.tblTafsily.IdSotooh
											   WHERE (olden.tblSanad_MD.YearName = 1401) AND
													 (olden.tblKol.IdGroup IN (7, 8)) AND
													 (olden.tblTafsily.IdTafsilyGroup <> '18') AND
													 (olden.tblSanad_MD.AreaId = 7) AND
													 (olden.tblSanadDetail_MD.AreaId =7) AND 
													 (olden.tblTafsily.AreaId = 7) AND
													 (olden.tblSanad_MD.YearName = 1401) AND
													 (olden.tblSanadDetail_MD.YearName = 1401) AND
													 (olden.tblTafsily.YearName = 1401)AND
												     (olden.tblKol.AreaId = 7) AND 
												     (olden.tblKol.YearName = 1401)
											   GROUP BY olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5) AS tbl1 INNER JOIN
											 olden.tblTafsily AS tblTafsily_2 ON tbl1.IdTafsily4 = tblTafsily_2.Id INNER JOIN
											 olden.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
					WHERE        (tbl1.Expense <> 0) AND
						   (tblTafsily_2.AreaId = 7) AND
						   (tblTafsily_2.YearName = 1401) AND
						   (tblTafsily_1.AreaId = 7) AND
						   (tblTafsily_1.YearName = 1401)

--**************************************************************************************************
--**************************************************************************************************
--**************************************************************************************************
--منطقه 08
INSERT INTO Tbl_Vasets( YearId, AreaId, IdTafsily4 , IdTafsily5 , NameTafsily , Markhazhazine ,Expense ,CodeVaset)
				 SELECT   32  ,   8   , tbl1.IdTafsily4 , tbl1.IdTafsily5 , tblTafsily_2.Name , tblTafsily_1.Name , tbl1.Expense , cast(tbl1.IdTafsily4 as nvarchar(50)) + cast(tbl1.IdTafsily5 as nvarchar(50))
					FROM            (SELECT        olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
											   FROM            olden.tblSanad_MD INNER JOIN
																		olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName AND 
																		olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId INNER JOIN
																		olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id INNER JOIN
																		olden.tblTafsily ON olden.tblSanadDetail_MD.IdTafsily4 = olden.tblTafsily.Id AND olden.tblSanadDetail_MD.IdSotooh4 = olden.tblTafsily.IdSotooh
											   WHERE (olden.tblSanad_MD.YearName = 1401) AND
													 (olden.tblKol.IdGroup IN (7, 8)) AND
													 (olden.tblTafsily.IdTafsilyGroup <> '18') AND
													 (olden.tblSanad_MD.AreaId = 8) AND
													 (olden.tblSanadDetail_MD.AreaId =8) AND 
													 (olden.tblTafsily.AreaId = 8) AND
													 (olden.tblSanad_MD.YearName = 1401) AND
													 (olden.tblSanadDetail_MD.YearName = 1401) AND
													 (olden.tblTafsily.YearName = 1401)AND
												     (olden.tblKol.AreaId = 8) AND 
												     (olden.tblKol.YearName = 1401)
											   GROUP BY olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5) AS tbl1 INNER JOIN
											 olden.tblTafsily AS tblTafsily_2 ON tbl1.IdTafsily4 = tblTafsily_2.Id INNER JOIN
											 olden.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
					WHERE        (tbl1.Expense <> 0) AND
						   (tblTafsily_2.AreaId = 8) AND
						   (tblTafsily_2.YearName = 1401) AND
						   (tblTafsily_1.AreaId = 8) AND
						   (tblTafsily_1.YearName = 1401)
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--منطقه 8
delete olden.tblGroup           where AreaId = 8 and YearName in (1401,1402)
delete olden.tblKol             where AreaId = 8 and YearName in (1401,1402)
delete olden.tblMoien           where AreaId = 8 and YearName in (1401,1402)
delete olden.tblSanadKind       where AreaId = 8 and YearName in (1401,1402)
delete olden.tblSanadState      where AreaId = 8 and YearName in (1401,1402)
delete olden.tblTafsily         where AreaId = 8 and YearName in (1401,1402)
delete olden.tblSanad_MD        where AreaId = 8 and YearName in (1401,1402)
delete olden.tblSanadDetail_MD  where AreaId = 8 and YearName in (1401,1402)

insert into olden.tblGroup(        id    , AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id ,   8   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            AKH.AccAMJ1008.dbo.tblGroup CROSS JOIN
										 AKH.AccAMJ1008.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (13))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    8  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            AKH.AccAMJ1008.dbo.tblKol CROSS JOIN
									 AKH.AccAMJ1008.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (13))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  8   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            AKH.AccAMJ1008.dbo.tblSal_MD CROSS JOIN
										 AKH.AccAMJ1008.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (13))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  8   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            AKH.AccAMJ1008.dbo.tblSal_MD CROSS JOIN
									 AKH.AccAMJ1008.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (13))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   8   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
						FROM            AKH.AccAMJ1008.dbo.tblSal_MD CROSS JOIN
												 AKH.AccAMJ1008.dbo.tblSanadState
						WHERE        (tblSal_MD.Id IN (13))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   8  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
							FROM            AKH.AccAMJ1008.dbo.tblSal_MD CROSS JOIN
													 AKH.AccAMJ1008.dbo.tblTafsily
							WHERE        (tblSal_MD.Id IN (13))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 13 then 1401 end ,   8   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ1008.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName              , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    8  , 
						   											case when IdSalSanad_MD = 13 then 1401 end   ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            AKH.AccAMJ1008.dbo.tblSanadDetail_MD
--**********************************************************************************************
--**********************************************************************************************
--**********************************************************************************************
--مرکزی

delete olden.tblGroup           where AreaId = 9 and YearName in (1401,1402)
delete olden.tblKol             where AreaId = 9 and YearName in (1401,1402)
delete olden.tblMoien           where AreaId = 9 and YearName in (1401,1402)
delete olden.tblSanadKind       where AreaId = 9 and YearName in (1401,1402)
delete olden.tblSanadState      where AreaId = 9 and YearName in (1401,1402)
delete olden.tblTafsily         where AreaId = 9 and YearName in (1401,1402)
delete olden.tblSanad_MD        where AreaId = 9 and YearName in (1401,1402)
delete olden.tblSanadDetail_MD  where AreaId = 9 and YearName in (1401,1402)

insert into olden.tblGroup(        id    , AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id ,   9   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            AKH.AccAMJ1000.dbo.tblGroup CROSS JOIN
										 AKH.AccAMJ1000.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (11))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    9  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            AKH.AccAMJ1000.dbo.tblKol CROSS JOIN
									 AKH.AccAMJ1000.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (11))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  9   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            AKH.AccAMJ1000.dbo.tblSal_MD CROSS JOIN
										 AKH.AccAMJ1000.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (11))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  9   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            AKH.AccAMJ1000.dbo.tblSal_MD CROSS JOIN
									 AKH.AccAMJ1000.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (11))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   9   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
						FROM            AKH.AccAMJ1000.dbo.tblSal_MD CROSS JOIN
												 AKH.AccAMJ1000.dbo.tblSanadState
						WHERE        (tblSal_MD.Id IN (11))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   9  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
							FROM            AKH.AccAMJ1000.dbo.tblSal_MD CROSS JOIN
													 AKH.AccAMJ1000.dbo.tblTafsily
							WHERE        (tblSal_MD.Id IN (11))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 11 then 1401 end ,   9   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ1000.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName              , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    9  , 
						   											case when IdSalSanad_MD = 11 then 1401 end   ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            AKH.AccAMJ1000.dbo.tblSanadDetail_MD
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--مرکزی
INSERT INTO Tbl_Vasets( YearId, AreaId, IdTafsily4 , IdTafsily5 , NameTafsily , Markhazhazine ,Expense ,CodeVaset)
				 SELECT   32  ,   9   , tbl1.IdTafsily4 , tbl1.IdTafsily5 , tblTafsily_2.Name , tblTafsily_1.Name , tbl1.Expense , cast(tbl1.IdTafsily4 as nvarchar(50)) + cast(tbl1.IdTafsily5 as nvarchar(50))
					FROM            (SELECT        olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
											   FROM            olden.tblSanad_MD INNER JOIN
																		olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName AND 
																		olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId INNER JOIN
																		olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id INNER JOIN
																		olden.tblTafsily ON olden.tblSanadDetail_MD.IdTafsily4 = olden.tblTafsily.Id AND olden.tblSanadDetail_MD.IdSotooh4 = olden.tblTafsily.IdSotooh
											   WHERE (olden.tblSanad_MD.YearName = 1401) AND
													 (olden.tblKol.IdGroup IN (7, 8)) AND
													 (olden.tblTafsily.IdTafsilyGroup <> '18') AND
													 (olden.tblSanad_MD.AreaId = 9) AND
													 (olden.tblSanadDetail_MD.AreaId =9) AND 
													 (olden.tblTafsily.AreaId = 9) AND
													 (olden.tblSanad_MD.YearName = 1401) AND
													 (olden.tblSanadDetail_MD.YearName = 1401) AND
													 (olden.tblTafsily.YearName = 1401)AND
												     (olden.tblKol.AreaId = 9) AND 
												     (olden.tblKol.YearName = 1401)
											   GROUP BY olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.IdTafsily5) AS tbl1 INNER JOIN
											 olden.tblTafsily AS tblTafsily_2 ON tbl1.IdTafsily4 = tblTafsily_2.Id INNER JOIN
											 olden.tblTafsily AS tblTafsily_1 ON tbl1.IdTafsily5 = tblTafsily_1.Id
					WHERE        (tbl1.Expense <> 0) AND
						   (tblTafsily_2.AreaId = 9) AND
						   (tblTafsily_2.YearName = 1401) AND
						   (tblTafsily_1.AreaId = 9) AND
						   (tblTafsily_1.YearName = 1401)

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
