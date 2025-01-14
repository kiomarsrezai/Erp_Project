USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9900_Akh_TO_Olden_Shardari_1401_140212345678910]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9900_Akh_TO_Olden_Shardari_1401_140212345678910]

AS
BEGIN
delete olden.tblGroup           where AreaId = 1 and YearName in ( 1401 ,1402)
delete olden.tblKol             where AreaId = 1 and YearName in ( 1401 ,1402)
delete olden.tblMoien           where AreaId = 1 and YearName in ( 1401 ,1402)
delete olden.tblSanadKind       where AreaId = 1 and YearName in ( 1401 ,1402)
delete olden.tblSanadState      where AreaId = 1 and YearName in ( 1401 ,1402)
delete olden.tblTafsily         where AreaId = 1 and YearName in ( 1401 ,1402)
delete olden.tblSanad_MD        where AreaId = 1 and YearName in ( 1401 ,1402)
delete olden.tblSanadDetail_MD  where AreaId = 1 and YearName in ( 1401 ,1402)

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

--**************************************************************************************************************
--**************************************************************************************************************
--کانورت منطقه 02 - از 97 تا 1402
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

--**************************************************************************************************************
--**************************************************************************************************************
--کانورت منطقه 03 - از 97 تا 1402
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

--**************************************************************************************************************
--**************************************************************************************************************
--کانورت منطقه 04 - از 97 تا 1402
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

--**************************************************************************************************************
--**************************************************************************************************************
--کانورت منطقه 05 - از 97 تا 1402
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

--**************************************************************************************************************
--**************************************************************************************************************
--کانورت منطقه 06 - از 97 تا 1402
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

--**************************************************************************************************************
--**************************************************************************************************************
--کانورت منطقه 07 - از 97 تا 1402
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

--**************************************************************************************************************
--**************************************************************************************************************
--کانورت منطقه 08 - از 97 تا 1402
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

	 
--**************************************************************************************************************
--**************************************************************************************************************
--کانورت  مرکزی - از 97 تا 1402
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

END
GO
