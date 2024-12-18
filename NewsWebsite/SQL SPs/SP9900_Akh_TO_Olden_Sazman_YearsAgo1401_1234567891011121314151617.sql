USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9900_Akh_TO_Olden_Sazman_YearsAgo1401_1234567891011121314151617]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9900_Akh_TO_Olden_Sazman_YearsAgo1401_1234567891011121314151617]

AS
BEGIN




----کانورت اسناد حسابداری اتوبوسرانی
---- سال های 1395  تا 1402


----=====================================================================================================================
----کانورت اسناد حسابداری نوسازی بهسازی
---- سال های 1395  تا 1401
delete olden.tblGroup           where AreaId = 14
delete olden.tblKol             where AreaId = 14
delete olden.tblMoien           where AreaId = 14
delete olden.tblSal_MD          where AreaId = 14
delete olden.tblSanadKind       where AreaId = 14
delete olden.tblSanadState      where AreaId = 14
delete olden.tblTafsily         where AreaId = 14
delete olden.tblSanad_MD        where AreaId = 14
delete olden.tblSanadDetail_MD  where AreaId = 14

insert into olden.tblGroup(        id    ,IdRecognition , IdKind , AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id ,IdRecognition , IdKind ,   14   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            Lbehsazi.AccAMJ.dbo.tblGroup CROSS JOIN
										 Lbehsazi.AccAMJ.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (5, 6, 7, 8, 9, 10,11))

	


insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    14  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            Lbehsazi.AccAMJ.dbo.tblKol CROSS JOIN
									 Lbehsazi.AccAMJ.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (5, 6, 7, 8, 9,10, 11))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  14   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            Lbehsazi.AccAMJ.dbo.tblSal_MD CROSS JOIN
										 Lbehsazi.AccAMJ.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (5, 6, 7, 8, 9,10, 11))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  14   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            Lbehsazi.AccAMJ.dbo.tblSal_MD CROSS JOIN
									 Lbehsazi.AccAMJ.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (5, 6, 7, 8, 9,10, 11))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   14   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            Lbehsazi.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         Lbehsazi.AccAMJ.dbo.tblSanadState
WHERE        (tblSal_MD.Id IN (5, 6, 7, 8, 9,10, 11))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   14  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM            Lbehsazi.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         Lbehsazi.AccAMJ.dbo.tblTafsily
WHERE        (tblSal_MD.Id IN (5, 6, 7, 8, 9,10,  11))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 5   then 1395
										when IdSal_MD = 6   then 1396
										when IdSal_MD = 7   then 1397
										when IdSal_MD = 8   then 1398
										when IdSal_MD = 9   then 1400
										when IdSal_MD = 10  then 1401
										when IdSal_MD = 11  then 1399 end ,   14   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lbehsazi.AccAMJ.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                        , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    14  , 
						   											     case when IdSalSanad_MD = 5   then 1395
										                                      when IdSalSanad_MD = 6   then 1396
										                                      when IdSalSanad_MD = 7   then 1397
										                                      when IdSalSanad_MD = 8   then 1398
										                                      when IdSalSanad_MD = 9   then 1400
																			  when IdSalSanad_MD = 10  then 1401
										                                      when IdSalSanad_MD = 11  then 1399 end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            Lbehsazi.AccAMJ.dbo.tblSanadDetail_MD


--کانورت 1394 نوسازی بهسازی
insert into olden.tblGroup( id , IdRecognition , IdKind , AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,    14  ,   1394   , Name
FROM            Lbehsazi.AccAMJ194.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   14   ,  1394   ,IdGroup , Name
	FROM            Lbehsazi.AccAMJ194.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   14  ,   1394   ,IdKol ,Name
             FROM            Lbehsazi.AccAMJ194.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   14   ,   1394  , Name
FROM            Lbehsazi.AccAMJ194.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   14   ,   1394   , Name
					FROM            Lbehsazi.AccAMJ194.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   14  ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            Lbehsazi.AccAMJ194.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1394	,   14   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lbehsazi.AccAMJ194.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id ,  IdSanad_MD ,  14   ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            Lbehsazi.AccAMJ194.dbo.tblSanadDetail_MD

-- کانورت 1393  نوسازی بهسازی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   14  ,   1393   , Name
FROM            Lbehsazi.AccAMJ193.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   14   ,  1393   ,IdGroup , Name
	FROM            Lbehsazi.AccAMJ193.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   14  ,   1393   ,IdKol ,Name
             FROM            Lbehsazi.AccAMJ193.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   14   ,   1393  , Name
FROM            Lbehsazi.AccAMJ193.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   14   ,   1393   , Name
					FROM            Lbehsazi.AccAMJ193.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   14  ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            Lbehsazi.AccAMJ193.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1393	,   14   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lbehsazi.AccAMJ193.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   14   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            Lbehsazi.AccAMJ193.dbo.tblSanadDetail_MD

-------------------------------------کانورت 1392  نوسازی بهسازی

insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   14  ,   1392   , Name
FROM            Lbehsazi.AccAMJ192.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   14   ,  1392   ,IdGroup , Name
	FROM            Lbehsazi.AccAMJ192.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   14  ,   1392   ,IdKol ,Name
             FROM            Lbehsazi.AccAMJ192.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   14   ,   1392  , Name
FROM            Lbehsazi.AccAMJ192.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   14   ,   1392   , Name
					FROM            Lbehsazi.AccAMJ192.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   14  ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            Lbehsazi.AccAMJ192.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1392	,   14   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lbehsazi.AccAMJ192.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   14   ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            Lbehsazi.AccAMJ192.dbo.tblSanadDetail_MD

----------------------------------کانورت 1391  نوسازی بهسازی------------------------------------------------------

insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   14  ,   1391   , Name
FROM            Lbehsazi.AccAMJ191.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   14   ,  1391   ,IdGroup , Name
	FROM            Lbehsazi.AccAMJ191.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   14  ,   1391   ,IdKol ,Name
             FROM            Lbehsazi.AccAMJ191.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   14   ,   1391  , Name
FROM            Lbehsazi.AccAMJ191.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   14   ,   1391   , Name
					FROM            Lbehsazi.AccAMJ191.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   14  ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            Lbehsazi.AccAMJ191.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1391	,   14   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lbehsazi.AccAMJ191.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,  14   ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            Lbehsazi.AccAMJ191.dbo.tblSanadDetail_MD

-- کانورت 1390 نوسازی بهسازی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  14   ,   1390   , Name
FROM            Lbehsazi.AccAMJ190.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   14   ,  1390   ,IdGroup , Name
	FROM            Lbehsazi.AccAMJ190.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   14  ,   1390   ,IdKol ,Name
             FROM            Lbehsazi.AccAMJ190.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   14   ,   1390  , Name
FROM            Lbehsazi.AccAMJ190.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   14   ,   1390   , Name
					FROM            Lbehsazi.AccAMJ190.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   14  ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            Lbehsazi.AccAMJ190.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1390	,   14   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lbehsazi.AccAMJ190.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,  14   ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            Lbehsazi.AccAMJ190.dbo.tblSanadDetail_MD

------------------------کانورت 1389 نوسازی بهسازی----------------------------------------------
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   14  ,   1389   , Name
FROM            Lbehsazi.AccAMJ189.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   14   ,  1389   ,IdGroup , Name
	FROM            Lbehsazi.AccAMJ189.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   14  ,   1389   ,IdKol ,Name
             FROM            Lbehsazi.AccAMJ189.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   14   ,   1389  , Name
FROM            Lbehsazi.AccAMJ189.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   14   ,   1389   , Name
					FROM            Lbehsazi.AccAMJ189.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   14  ,   1389    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            Lbehsazi.AccAMJ189.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1389	,   14   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lbehsazi.AccAMJ189.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id ,  IdSanad_MD ,  14   ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            Lbehsazi.AccAMJ189.dbo.tblSanadDetail_MD

----=====================================================================================================================
----کانورت اسناد حسابداری پارکها
---- سال های 1396  تا 1401
delete olden.tblGroup           where AreaId = 15
delete olden.tblKol             where AreaId = 15
delete olden.tblMoien           where AreaId = 15
delete olden.tblSal_MD          where AreaId = 15
delete olden.tblSanadKind       where AreaId = 15
delete olden.tblSanadState      where AreaId = 15
delete olden.tblTafsily         where AreaId = 15
delete olden.tblSanad_MD        where AreaId = 15
delete olden.tblSanadDetail_MD  where AreaId = 15
insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  15   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LPARK.AccAmj196.dbo.tblGroup CROSS JOIN
										 LPARK.AccAmj196.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (6, 7, 8, 9, 10,11))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    15  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LPARK.AccAmj196.dbo.tblKol CROSS JOIN
									 LPARK.AccAmj196.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (6, 7, 8, 9, 10,11))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  15   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LPARK.AccAmj196.dbo.tblSal_MD CROSS JOIN
										 LPARK.AccAmj196.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (6, 7, 8, 9, 10,11))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  15   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LPARK.AccAmj196.dbo.tblSal_MD CROSS JOIN
									 LPARK.AccAmj196.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (6, 7, 8, 9, 10,11))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   15   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LPARK.AccAmj196.dbo.tblSal_MD CROSS JOIN
                         LPARK.AccAmj196.dbo.tblSanadState
WHERE        (tblSal_MD.Id IN (6, 7, 8, 9, 10,11))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   15  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM            LPARK.AccAmj196.dbo.tblSal_MD CROSS JOIN
                         LPARK.AccAmj196.dbo.tblTafsily
WHERE        (tblSal_MD.Id IN (6, 7, 8, 9, 10,11))

				
insert into olden.tblSanad_MD(Id ,      YearName                         , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 6  then 1396
										when IdSal_MD = 7  then 1397
										when IdSal_MD = 8  then 1398
										when IdSal_MD = 9  then 1399
										when IdSal_MD = 10 then 1400 
										when IdSal_MD = 11 then 1401 
										end ,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAmj196.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                        , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    15  , 
						   											     case when IdSalSanad_MD = 6  then 1396
										                                      when IdSalSanad_MD = 7  then 1397
										                                      when IdSalSanad_MD = 8  then 1398
										                                      when IdSalSanad_MD = 9  then 1399
										                                      when IdSalSanad_MD = 10 then 1400 
																			  when IdSalSanad_MD = 11 then 1401
																			  end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAmj196.dbo.tblSanadDetail_MD


--کانورت 1395  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1395   , Name
              FROM            LPARK.AccAMJ195.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1395   ,IdGroup , Name
	        FROM            LPARK.AccAMJ195.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1395   ,IdKol ,Name
                  FROM            LPARK.AccAMJ195.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1395  , Name
                       FROM            LPARK.AccAMJ195.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1395   , Name
					FROM            LPARK.AccAMJ195.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1395    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ195.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1395	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ195.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id ,  IdSanad_MD ,  15   ,   1395   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ195.dbo.tblSanadDetail_MD

--کانورت 1394  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1394   , Name
              FROM            LPARK.AccAMJ194.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1394   ,IdGroup , Name
	        FROM            LPARK.AccAMJ194.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1394   ,IdKol ,Name
                  FROM            LPARK.AccAMJ194.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1394  , Name
                       FROM            LPARK.AccAMJ194.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1394   , Name
					FROM            LPARK.AccAMJ194.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ194.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1394	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ194.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id ,  IdSanad_MD ,  15   ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ194.dbo.tblSanadDetail_MD

							 --کانورت 1393  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1393   , Name
              FROM            LPARK.AccAMJ193.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1393   ,IdGroup , Name
	        FROM            LPARK.AccAMJ193.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1393   ,IdKol ,Name
                  FROM            LPARK.AccAMJ193.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1393  , Name
                       FROM            LPARK.AccAMJ193.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1393   , Name
					FROM            LPARK.AccAMJ193.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ193.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1393	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ193.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id ,  IdSanad_MD ,  15   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ193.dbo.tblSanadDetail_MD

--کانورت 1392  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1392   , Name
              FROM            LPARK.AccAMJ192.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1392   ,IdGroup , Name
	        FROM            LPARK.AccAMJ192.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1392   ,IdKol ,Name
                  FROM            LPARK.AccAMJ192.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1392  , Name
                       FROM            LPARK.AccAMJ192.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1392   , Name
					FROM            LPARK.AccAMJ192.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ192.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1392	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ192.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id ,  IdSanad_MD ,  15   ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ192.dbo.tblSanadDetail_MD

--کانورت 1391  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1391   , Name
              FROM            LPARK.AccAMJ191.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1391   ,IdGroup , Name
	        FROM            LPARK.AccAMJ191.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1391   ,IdKol ,Name
                  FROM            LPARK.AccAMJ191.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1391  , Name
                       FROM            LPARK.AccAMJ191.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1391   , Name
					FROM            LPARK.AccAMJ191.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ191.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1391	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ191.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id ,  IdSanad_MD ,  15   ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ191.dbo.tblSanadDetail_MD

--کانورت 1390  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1390   , Name
              FROM            LPARK.AccAMJ190.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1390   ,IdGroup , Name
	        FROM            LPARK.AccAMJ190.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1390   ,IdKol ,Name
                  FROM            LPARK.AccAMJ190.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1390  , Name
                       FROM            LPARK.AccAMJ190.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1390   , Name
					FROM            LPARK.AccAMJ190.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ190.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1390	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ190.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,  15   ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ190.dbo.tblSanadDetail_MD

--کانورت 1389  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1389   , Name
              FROM            LPARK.AccAMJ189.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1389   ,IdGroup , Name
	        FROM            LPARK.AccAMJ189.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1389   ,IdKol ,Name
                  FROM            LPARK.AccAMJ189.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1389  , Name
                       FROM            LPARK.AccAMJ189.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1389   , Name
					FROM            LPARK.AccAMJ189.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1389    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ189.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1389	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ189.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id ,  IdSanad_MD ,  15   ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ189.dbo.tblSanadDetail_MD

--کانورت 1388  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1388   , Name
              FROM            LPARK.AccAMJ188.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1388   ,IdGroup , Name
	        FROM            LPARK.AccAMJ188.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1388   ,IdKol ,Name
                  FROM            LPARK.AccAMJ188.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1388  , Name
                       FROM            LPARK.AccAMJ188.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1388   , Name
					FROM            LPARK.AccAMJ188.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1388    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ188.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1388	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ188.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id ,  IdSanad_MD ,  15   ,   1388   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ188.dbo.tblSanadDetail_MD

--کانورت 1387  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1387   , Name
              FROM            LPARK.AccAMJ187.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1387   ,IdGroup , Name
	        FROM            LPARK.AccAMJ187.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1387   ,IdKol ,Name
                  FROM            LPARK.AccAMJ187.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1387  , Name
                       FROM            LPARK.AccAMJ187.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1387   , Name
					FROM            LPARK.AccAMJ187.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1387    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ187.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1387	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ187.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   15   ,   1387   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ187.dbo.tblSanadDetail_MD

--کانورت 1386  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1386   , Name
              FROM            LPARK.AccAMJ186.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1386   ,IdGroup , Name
	        FROM            LPARK.AccAMJ186.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1386   ,IdKol ,Name
                  FROM            LPARK.AccAMJ186.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1386  , Name
                       FROM            LPARK.AccAMJ186.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1386   , Name
					FROM            LPARK.AccAMJ186.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1386    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ186.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1386	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ186.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   15   ,   1386   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ186.dbo.tblSanadDetail_MD

--کانورت 1385  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1385   , Name
              FROM            LPARK.AccAMJ185.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1385   ,IdGroup , Name
	        FROM            LPARK.AccAMJ185.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1385   ,IdKol ,Name
                  FROM            LPARK.AccAMJ185.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1385  , Name
                       FROM            LPARK.AccAMJ185.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1385   , Name
					FROM            LPARK.AccAMJ185.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1385    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ185.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1385	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ185.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   15   ,   1385   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ185.dbo.tblSanadDetail_MD

--کانورت 1384  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1384   , Name
              FROM            LPARK.AccAMJ184.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1384   ,IdGroup , Name
	        FROM            LPARK.AccAMJ184.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1384   ,IdKol ,Name
                  FROM            LPARK.AccAMJ184.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1384  , Name
                       FROM            LPARK.AccAMJ184.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1384   , Name
					FROM            LPARK.AccAMJ184.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1384   , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ184.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1384	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ184.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   15   ,   1384   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ184.dbo.tblSanadDetail_MD

--کانورت 1383  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  15  ,   1383   , Name
              FROM            LPARK.AccAMJ183.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1383   ,IdGroup , Name
	        FROM            LPARK.AccAMJ183.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1383   ,IdKol ,Name
                  FROM            LPARK.AccAMJ183.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1383  , Name
                       FROM            LPARK.AccAMJ183.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1383   , Name
					FROM            LPARK.AccAMJ183.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1383    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ183.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1383	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ183.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   15   ,   1383   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ183.dbo.tblSanadDetail_MD

--کانورت 1382  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1382   , Name
              FROM            LPARK.AccAMJ182.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1382   ,IdGroup , Name
	        FROM            LPARK.AccAMJ182.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1382   ,IdKol ,Name
                  FROM            LPARK.AccAMJ182.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1382  , Name
                       FROM            LPARK.AccAMJ182.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1382   , Name
					FROM            LPARK.AccAMJ182.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1382    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ182.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1382	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ182.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   15   ,   1382   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ182.dbo.tblSanadDetail_MD

--کانورت 1381  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1381   , Name
              FROM            LPARK.AccAMJ181.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1381   ,IdGroup , Name
	        FROM            LPARK.AccAMJ181.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1381   ,IdKol ,Name
                  FROM            LPARK.AccAMJ181.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1381  , Name
                       FROM            LPARK.AccAMJ181.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1381   , Name
					FROM            LPARK.AccAMJ181.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1381    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ181.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1381	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ181.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   15   ,   1381   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ181.dbo.tblSanadDetail_MD

--کانورت 1380  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1380   , Name
              FROM            LPARK.AccAMJ180.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1380   ,IdGroup , Name
	        FROM            LPARK.AccAMJ180.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1380   ,IdKol ,Name
                  FROM            LPARK.AccAMJ180.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1380  , Name
                       FROM            LPARK.AccAMJ180.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1380   , Name
					FROM            LPARK.AccAMJ180.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1380    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ180.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1380	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ180.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   15   ,   1380   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ180.dbo.tblSanadDetail_MD

--کانورت 1379  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1379   , Name
              FROM            LPARK.AccAMJ179.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1379   ,IdGroup , Name
	        FROM            LPARK.AccAMJ179.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1379   ,IdKol ,Name
                  FROM            LPARK.AccAMJ179.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1379  , Name
                       FROM            LPARK.AccAMJ179.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1379   , Name
					FROM            LPARK.AccAMJ179.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1379    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ179.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1379	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ179.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,  15   ,   1379   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ179.dbo.tblSanadDetail_MD

--کانورت 1378  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1378   , Name
              FROM            LPARK.AccAMJ178.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1378   ,IdGroup , Name
	        FROM            LPARK.AccAMJ178.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1378   ,IdKol ,Name
                  FROM            LPARK.AccAMJ178.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1378  , Name
                       FROM            LPARK.AccAMJ178.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1378   , Name
					FROM            LPARK.AccAMJ178.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1378    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ178.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1378	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ178.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id ,  IdSanad_MD ,   15  ,   1378   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ178.dbo.tblSanadDetail_MD

--کانورت 1377  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1377   , Name
              FROM            LPARK.AccAMJ177.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1377   ,IdGroup , Name
	        FROM            LPARK.AccAMJ177.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1377   ,IdKol ,Name
                  FROM            LPARK.AccAMJ177.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1377  , Name
                       FROM            LPARK.AccAMJ177.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1377   , Name
					FROM            LPARK.AccAMJ177.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1377    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ177.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1377	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ177.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   15   ,   1377   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ177.dbo.tblSanadDetail_MD

--کانورت 1376  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1376   , Name
              FROM            LPARK.AccAMJ176.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   15   ,  1376   ,IdGroup , Name
	        FROM            LPARK.AccAMJ176.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   15  ,   1376   ,IdKol ,Name
                  FROM            LPARK.AccAMJ176.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   15   ,   1376  , Name
                       FROM            LPARK.AccAMJ176.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   15   ,   1376   , Name
					FROM            LPARK.AccAMJ176.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   15  ,   1376    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LPARK.AccAMJ176.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1376	,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPARK.AccAMJ176.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   15   ,   1376   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPARK.AccAMJ176.dbo.tblSanadDetail_MD


--***********************************************************************************************************************
----=====================================================================================================================
----کانورت اسناد حسابداری ترمینال ها
---- سال های 1398  تا 1402
delete olden.tblGroup           where AreaId = 16
delete olden.tblKol             where AreaId = 16
delete olden.tblMoien           where AreaId = 16
delete olden.tblSal_MD          where AreaId = 16
delete olden.tblSanadKind       where AreaId = 16
delete olden.tblSanadState      where AreaId = 16
delete olden.tblTafsily         where AreaId = 16
delete olden.tblSanad_MD        where AreaId = 16
delete olden.tblSanadDetail_MD  where AreaId = 16

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  16   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LTERMINAL.AccAmj.dbo.tblGroup CROSS JOIN
										 LTERMINAL.AccAmj.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN ( 8, 9, 10,11))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    16  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LTERMINAL.AccAmj.dbo.tblKol CROSS JOIN
									 LTERMINAL.AccAmj.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (8, 9, 10,11 ))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  16   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LTERMINAL.AccAmj.dbo.tblSal_MD CROSS JOIN
										 LTERMINAL.AccAmj.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (8, 9, 10,11 ))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  16   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LTERMINAL.AccAmj.dbo.tblSal_MD CROSS JOIN
									 LTERMINAL.AccAmj.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (8, 9, 10 ,11))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   16   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LTERMINAL.AccAmj.dbo.tblSal_MD CROSS JOIN
                         LTERMINAL.AccAmj.dbo.tblSanadState
WHERE        (tblSal_MD.Id IN (8, 9, 10,11))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   16  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM            LTERMINAL.AccAmj.dbo.tblSal_MD CROSS JOIN
                         LTERMINAL.AccAmj.dbo.tblTafsily
WHERE        (tblSal_MD.Id IN (8, 9, 10,11))

				
insert into olden.tblSanad_MD(Id ,      YearName                         , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 8   then 1398
										when IdSal_MD = 9   then 1399
										when IdSal_MD = 10  then 1400
										when IdSal_MD = 11  then 1401
										end ,   16   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTERMINAL.AccAmj.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                          , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    16  , 
						   											     case when IdSalSanad_MD = 8   then 1398
										                                      when IdSalSanad_MD = 9   then 1399
										                                      when IdSalSanad_MD = 10  then 1400
																			  when IdSalSanad_MD = 11  then 1401
																			  end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTERMINAL.AccAmj.dbo.tblSanadDetail_MD


--کانورت 1397  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   16  ,   1397   , Name
              FROM            LTERMINAL.AccAMJ197.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   16   ,  1397   ,IdGroup , Name
	        FROM            LTERMINAL.AccAMJ197.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   16  ,   1397   ,IdKol ,Name
                  FROM            LTERMINAL.AccAMJ197.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   16   ,   1397  , Name
                       FROM            LTERMINAL.AccAMJ197.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   16   ,   1397   , Name
					FROM            LTERMINAL.AccAMJ197.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   16  ,   1397    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LTERMINAL.AccAMJ197.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1397	,   16   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTERMINAL.AccAMJ197.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   16   ,   1397   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTERMINAL.AccAMJ197.dbo.tblSanadDetail_MD

--کانورت 1396  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   16  ,   1396   , Name
              FROM            LTERMINAL.AccAMJ196.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   16   ,  1396   ,IdGroup , Name
	        FROM            LTERMINAL.AccAMJ196.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   16  ,   1396   ,IdKol ,Name
                  FROM            LTERMINAL.AccAMJ196.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   16   ,   1396  , Name
                       FROM            LTERMINAL.AccAMJ196.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   16   ,   1396   , Name
					FROM            LTERMINAL.AccAMJ196.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   16  ,   1396    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LTERMINAL.AccAMJ196.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1396	,   16   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTERMINAL.AccAMJ196.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   16   ,   1396   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTERMINAL.AccAMJ196.dbo.tblSanadDetail_MD

--کانورت 1395  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  16   ,   1395   , Name
              FROM            LTERMINAL.AccAMJ195.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   16   ,  1395   ,IdGroup , Name
	        FROM            LTERMINAL.AccAMJ195.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   16  ,   1395   ,IdKol ,Name
                  FROM            LTERMINAL.AccAMJ195.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   16   ,   1395  , Name
                       FROM            LTERMINAL.AccAMJ195.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   16   ,   1395   , Name
					FROM            LTERMINAL.AccAMJ195.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   16  ,   1395    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LTERMINAL.AccAMJ195.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1395	,   16   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTERMINAL.AccAMJ195.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   16   ,   1395   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTERMINAL.AccAMJ195.dbo.tblSanadDetail_MD


--کانورت 1394  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   16  ,   1394   , Name
              FROM            LTERMINAL.AccAMJ194.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   16   ,  1394   ,IdGroup , Name
	        FROM            LTERMINAL.AccAMJ194.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   16  ,   1394   ,IdKol ,Name
                  FROM            LTERMINAL.AccAMJ194.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   16   ,   1394  , Name
                       FROM            LTERMINAL.AccAMJ194.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   16   ,   1394   , Name
					FROM            LTERMINAL.AccAMJ194.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   16  ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LTERMINAL.AccAMJ194.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1394	,   16   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTERMINAL.AccAMJ194.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   16   ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTERMINAL.AccAMJ194.dbo.tblSanadDetail_MD

--کانورت 1393  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   16  ,   1393   , Name
              FROM            LTERMINAL.AccAMJ193.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   16   ,  1393   ,IdGroup , Name
	        FROM            LTERMINAL.AccAMJ193.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   16  ,   1393   ,IdKol ,Name
                  FROM            LTERMINAL.AccAMJ193.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   16   ,   1393  , Name
                       FROM            LTERMINAL.AccAMJ193.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   16   ,   1393   , Name
					FROM            LTERMINAL.AccAMJ193.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   16  ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LTERMINAL.AccAMJ193.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1393	,   16   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTERMINAL.AccAMJ193.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   16   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTERMINAL.AccAMJ193.dbo.tblSanadDetail_MD

--کانورت 1392  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   16  ,   1392   , Name
              FROM            LTERMINAL.AccAMJ192.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   16   ,  1392   ,IdGroup , Name
	        FROM            LTERMINAL.AccAMJ192.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   16  ,   1392   ,IdKol ,Name
                  FROM            LTERMINAL.AccAMJ192.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   16   ,   1392  , Name
                       FROM            LTERMINAL.AccAMJ192.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   16   ,   1392   , Name
					FROM            LTERMINAL.AccAMJ192.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   16  ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LTERMINAL.AccAMJ192.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1392	,   16   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTERMINAL.AccAMJ192.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   16   ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTERMINAL.AccAMJ192.dbo.tblSanadDetail_MD

--کانورت 1391  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   16  ,   1391   , Name
              FROM            LTERMINAL.AccAMJ191.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   16   ,  1391   ,IdGroup , Name
	        FROM            LTERMINAL.AccAMJ191.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   16  ,   1391   ,IdKol ,Name
                  FROM            LTERMINAL.AccAMJ191.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   16   ,   1391  , Name
                       FROM            LTERMINAL.AccAMJ191.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   16   ,   1391   , Name
					FROM            LTERMINAL.AccAMJ191.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   16  ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LTERMINAL.AccAMJ191.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1391	,   16   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTERMINAL.AccAMJ191.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   16   ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTERMINAL.AccAMJ191.dbo.tblSanadDetail_MD

--کانورت 1390  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   16  ,   1390   , Name
              FROM            LTERMINAL.AccAMJ190.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   16   ,  1390   ,IdGroup , Name
	        FROM            LTERMINAL.AccAMJ190.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   16  ,   1390   ,IdKol ,Name
                  FROM            LTERMINAL.AccAMJ190.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   16   ,   1390  , Name
                       FROM            LTERMINAL.AccAMJ190.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   16   ,   1390   , Name
					FROM            LTERMINAL.AccAMJ190.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   16  ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LTERMINAL.AccAMJ190.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1390	,   16   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTERMINAL.AccAMJ190.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   16   ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTERMINAL.AccAMJ190.dbo.tblSanadDetail_MD

--کانورت 1389  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   16  ,   1389   , Name
              FROM            LTERMINAL.AccAMJ189.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   16   ,  1389   ,IdGroup , Name
	        FROM            LTERMINAL.AccAMJ189.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   16  ,   1389   ,IdKol ,Name
                  FROM            LTERMINAL.AccAMJ189.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   16   ,   1389  , Name
                       FROM            LTERMINAL.AccAMJ189.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   16   ,   1389   , Name
					FROM            LTERMINAL.AccAMJ189.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   16  ,   1389    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LTERMINAL.AccAMJ189.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1389	,   16   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTERMINAL.AccAMJ189.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   16   ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTERMINAL.AccAMJ189.dbo.tblSanadDetail_MD

--کانورت 1388  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   16  ,   1388   , Name
              FROM            LTERMINAL.AccAMJ188.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   16   ,  1388   ,IdGroup , Name
	        FROM            LTERMINAL.AccAMJ188.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   16  ,   1388   ,IdKol ,Name
                  FROM            LTERMINAL.AccAMJ188.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   16   ,   1388  , Name
                       FROM            LTERMINAL.AccAMJ188.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   16   ,   1388   , Name
					FROM            LTERMINAL.AccAMJ188.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   16  ,   1388    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LTERMINAL.AccAMJ188.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1388	,   16   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTERMINAL.AccAMJ188.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   16   ,   1388   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTERMINAL.AccAMJ188.dbo.tblSanadDetail_MD

----=====================================================================================================================
----کانورت اسناد حسابداری تاکسیرانی
---- سال های 1396  تا 1401
delete olden.tblGroup           where AreaId = 17
delete olden.tblKol             where AreaId = 17
delete olden.tblMoien           where AreaId = 17
delete olden.tblSal_MD          where AreaId = 17
delete olden.tblSanadKind       where AreaId = 17
delete olden.tblSanadState      where AreaId = 17
delete olden.tblTafsily         where AreaId = 17
delete olden.tblSanad_MD        where AreaId = 17
delete olden.tblSanadDetail_MD  where AreaId = 17
insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  17   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LTAXI.AccAMJ1095.dbo.tblGroup CROSS JOIN
										 LTAXI.AccAMJ1095.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN ( 6, 7, 8 , 9 ,10,11))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    17  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LTAXI.AccAMJ1095.dbo.tblKol CROSS JOIN
									 LTAXI.AccAMJ1095.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (6, 7, 8 , 9 ,10,11))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  17   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LTAXI.AccAMJ1095.dbo.tblSal_MD CROSS JOIN
										 LTAXI.AccAMJ1095.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (6, 7, 8 , 9 ,10,11))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  17   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LTAXI.AccAMJ1095.dbo.tblSal_MD CROSS JOIN
									 LTAXI.AccAMJ1095.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (6, 7, 8 , 9 ,10,11))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   17   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LTAXI.AccAMJ1095.dbo.tblSal_MD CROSS JOIN
                         LTAXI.AccAMJ1095.dbo.tblSanadState
WHERE        (tblSal_MD.Id IN (6, 7, 8 , 9 ,10,11))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   17  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LTAXI.AccAMJ1095.dbo.tblSal_MD CROSS JOIN
                         LTAXI.AccAMJ1095.dbo.tblTafsily
WHERE        (tblSal_MD.Id IN (6, 7, 8 , 9 ,10,11))

				
insert into olden.tblSanad_MD(Id ,      YearName                         , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 6   then 1396
								        when IdSal_MD = 7   then 1397
										when IdSal_MD = 8   then 1398
										when IdSal_MD = 9   then 1399
										when IdSal_MD = 10  then 1400 
										when IdSal_MD = 11  then 1401 
										end ,   17   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTAXI.AccAMJ1095.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                         , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    17  , 
						   											     case when IdSalSanad_MD = 6   then 1396
										                                      when IdSalSanad_MD = 7   then 1397
																			  when IdSalSanad_MD = 8   then 1398
										                                      when IdSalSanad_MD = 9   then 1399
										                                      when IdSalSanad_MD = 10  then 1400 
																			  when IdSalSanad_MD = 11  then 1401 
																			  end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTAXI.AccAMJ1095.dbo.tblSanadDetail_MD


--کانورت 1395  تاکسیرانی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   17  ,   1395   , Name
              FROM            LTAXI.AccAMJ1195.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   17   ,  1395   ,IdGroup , Name
	        FROM            LTAXI.AccAMJ1195.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   17  ,   1395   ,IdKol ,Name
                  FROM            LTAXI.AccAMJ1195.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   17   ,   1395  , Name
                       FROM            LTAXI.AccAMJ1195.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   17   ,   1395   , Name
					FROM            LTAXI.AccAMJ1195.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   17  ,   1395    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LTAXI.AccAMJ1195.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1395	,   17   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTAXI.AccAMJ1195.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   17   ,   1395   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTAXI.AccAMJ1195.dbo.tblSanadDetail_MD

 --کانورت 1394  تاکسیرانی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   17  ,   1394   , Name
              FROM            LTAXI.AccAMJ1094.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   17   ,  1394   ,IdGroup , Name
	        FROM            LTAXI.AccAMJ1094.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   17  ,   1394   ,IdKol ,Name
                  FROM            LTAXI.AccAMJ1094.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   17   ,   1394  , Name
                       FROM            LTAXI.AccAMJ1094.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   17   ,   1394   , Name
					FROM            LTAXI.AccAMJ1094.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   17  ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LTAXI.AccAMJ1094.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1394	,   17   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTAXI.AccAMJ1094.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   17   ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTAXI.AccAMJ1094.dbo.tblSanadDetail_MD

--کانورت 1393  تاکسیرانی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   17  ,   1393   , Name
              FROM            LTAXI.AccAMJ1093.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   17   ,  1393   ,IdGroup , Name
	        FROM            LTAXI.AccAMJ1093.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   17  ,   1393   ,IdKol ,Name
                  FROM            LTAXI.AccAMJ1093.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   17   ,   1393  , Name
                       FROM            LTAXI.AccAMJ1093.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   17   ,   1393   , Name
					FROM            LTAXI.AccAMJ1093.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   17  ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LTAXI.AccAMJ1093.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1393	,   17   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTAXI.AccAMJ1093.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   17   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTAXI.AccAMJ1093.dbo.tblSanadDetail_MD

--کانورت 1392  تاکسیرانی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   17  ,   1392   , Name
              FROM            LTAXI.AccAMJ1092.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   17   ,  1392   ,IdGroup , Name
	        FROM            LTAXI.AccAMJ1092.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   17  ,   1392   ,IdKol ,Name
                  FROM            LTAXI.AccAMJ1092.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   17   ,   1392  , Name
                       FROM            LTAXI.AccAMJ1092.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   17   ,   1392   , Name
					FROM            LTAXI.AccAMJ1092.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   17  ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LTAXI.AccAMJ1092.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1392	,   17   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTAXI.AccAMJ1092.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   17   ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTAXI.AccAMJ1092.dbo.tblSanadDetail_MD

--کانورت 1391  تاکسیرانی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   17  ,   1391   , Name
              FROM            LTAXI.AccAMJ1091.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   17   ,  1391   ,IdGroup , Name
	        FROM            LTAXI.AccAMJ1091.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   17  ,   1391   ,IdKol ,Name
                  FROM            LTAXI.AccAMJ1091.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   17   ,   1391  , Name
                       FROM            LTAXI.AccAMJ1091.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   17   ,   1391   , Name
					FROM            LTAXI.AccAMJ1091.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   17  ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LTAXI.AccAMJ1091.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1391	,   17   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTAXI.AccAMJ1091.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   17   ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTAXI.AccAMJ1091.dbo.tblSanadDetail_MD

--کانورت 1390  تاکسیرانی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   17  ,   1390   , Name
              FROM            LTAXI.AccAMJ1090.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   17   ,  1390   ,IdGroup , Name
	        FROM            LTAXI.AccAMJ1090.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   17  ,   1390   ,IdKol ,Name
                  FROM            LTAXI.AccAMJ1090.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   17   ,   1390  , Name
                       FROM            LTAXI.AccAMJ1090.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   17   ,   1390   , Name
					FROM            LTAXI.AccAMJ1090.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   17  ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LTAXI.AccAMJ1090.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1390	,   17   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTAXI.AccAMJ1090.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   17   ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTAXI.AccAMJ1090.dbo.tblSanadDetail_MD

--کانورت 1389  تاکسیرانی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   17  ,   1389   , Name
              FROM            LTAXI.AccAMJ1089.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   17   ,  1389   ,IdGroup , Name
	        FROM            LTAXI.AccAMJ1089.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   17  ,   1389   ,IdKol ,Name
                  FROM            LTAXI.AccAMJ1089.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   17   ,   1389  , Name
                       FROM            LTAXI.AccAMJ1089.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   17   ,   1389   , Name
					FROM            LTAXI.AccAMJ1089.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   17  ,   1389    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LTAXI.AccAMJ1089.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1389	,   17   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTAXI.AccAMJ1089.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   17   ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTAXI.AccAMJ1089.dbo.tblSanadDetail_MD

--کانورت 1388  تاکسیرانی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   17  ,   1388   , Name
              FROM            LTAXI.AccAMJ1088.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   17   ,  1388   ,IdGroup , Name
	        FROM            LTAXI.AccAMJ1088.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   17  ,   1388   ,IdKol ,Name
                  FROM            LTAXI.AccAMJ1088.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   17   ,   1388  , Name
                       FROM            LTAXI.AccAMJ1088.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   17   ,   1388   , Name
					FROM            LTAXI.AccAMJ1088.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   17  ,   1388    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LTAXI.AccAMJ1088.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1388	,   17   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LTAXI.AccAMJ1088.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   17   ,   1388   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LTAXI.AccAMJ1088.dbo.tblSanadDetail_MD

----=====================================================================================================================
----کانورت اسناد حسابداری موتوری
---- سال های 1399  تا 1383
delete olden.tblGroup           where AreaId = 18
delete olden.tblKol             where AreaId = 18
delete olden.tblMoien           where AreaId = 18
delete olden.tblSal_MD          where AreaId = 18
delete olden.tblSanadKind       where AreaId = 18
delete olden.tblSanadState      where AreaId = 18
delete olden.tblTafsily         where AreaId = 18
delete olden.tblSanad_MD        where AreaId = 18
delete olden.tblSanadDetail_MD  where AreaId = 18
insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  18   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LMOTORI.AccAMJ1399.dbo.tblGroup CROSS JOIN
										 LMOTORI.AccAMJ1399.dbo.tblSal_MD
				--WHERE        (tblSal_MD.Id IN ( 6, 7, 8 , 9 ,10 , 11))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    18  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LMOTORI.AccAMJ1399.dbo.tblKol CROSS JOIN
									 LMOTORI.AccAMJ1399.dbo.tblSal_MD
				--WHERE        (tblSal_MD.Id IN (6, 7, 8 , 9 ,10 , 11))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  18   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LMOTORI.AccAMJ1399.dbo.tblSal_MD CROSS JOIN
										 LMOTORI.AccAMJ1399.dbo.tblMoien
				--WHERE        (tblSal_MD.Id IN (6, 7, 8 , 9 ,10 , 11))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  18   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LMOTORI.AccAMJ1399.dbo.tblSal_MD CROSS JOIN
									 LMOTORI.AccAMJ1399.dbo.tblSanadKind
			--WHERE        (tblSal_MD.Id IN (6, 7, 8 , 9 ,10 , 11))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   18   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LMOTORI.AccAMJ1399.dbo.tblSal_MD CROSS JOIN
                         LMOTORI.AccAMJ1399.dbo.tblSanadState
--WHERE        (tblSal_MD.Id IN (6, 7, 8 , 9 ,10 , 11))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   18  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LMOTORI.AccAMJ1399.dbo.tblSal_MD CROSS JOIN
                         LMOTORI.AccAMJ1399.dbo.tblTafsily
--WHERE        (tblSal_MD.Id IN (6, 7, 8 , 9 ,10 , 11))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 11   then 1383
								        when IdSal_MD = 12   then 1384
										when IdSal_MD = 13   then 1385
										when IdSal_MD = 14   then 1386
										when IdSal_MD = 15   then 1387
										when IdSal_MD = 16   then 1388
									    when IdSal_MD = 17   then 1389
										when IdSal_MD = 18   then 1390
										when IdSal_MD = 19   then 1391
										when IdSal_MD = 20   then 1392
										when IdSal_MD = 21   then 1393
										when IdSal_MD = 22   then 1394
										when IdSal_MD = 23   then 1395
										when IdSal_MD = 24   then 1396
										when IdSal_MD = 25   then 1397
										when IdSal_MD = 26   then 1398
										when IdSal_MD = 27   then 1399  end ,   18   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMOTORI.AccAMJ1399.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                        , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,   18   , 
						   											     case when IdSalSanad_MD = 11  then 1383
										                                      when IdSalSanad_MD = 12  then 1384
																		      when IdSalSanad_MD = 13  then 1385
																			  when IdSalSanad_MD = 14  then 1386
																			  when IdSalSanad_MD = 15  then 1387
																			  when IdSalSanad_MD = 16  then 1388
																			  when IdSalSanad_MD = 17  then 1389
																			  when IdSalSanad_MD = 18  then 1390
																			  when IdSalSanad_MD = 19  then 1391
																			  when IdSalSanad_MD = 20  then 1392
																			  when IdSalSanad_MD = 21  then 1393
																			  when IdSalSanad_MD = 22  then 1394
																			  when IdSalSanad_MD = 23  then 1395
																			  when IdSalSanad_MD = 24  then 1396
																			  when IdSalSanad_MD = 25  then 1397
																			  when IdSalSanad_MD = 26  then 1398
										                                      when IdSalSanad_MD = 27  then 1399 end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM  LMOTORI.AccAMJ1399.dbo.tblSanadDetail_MD

-- سال های  1400  تا 1402 موتوری

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  18   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LMOTORI.AccAMJ.dbo.tblGroup CROSS JOIN
										 LMOTORI.AccAMJ.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN ( 10 ,14 ))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    18  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LMOTORI.AccAMJ.dbo.tblKol CROSS JOIN
									 LMOTORI.AccAMJ.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (10,14))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  18   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LMOTORI.AccAMJ.dbo.tblSal_MD CROSS JOIN
										 LMOTORI.AccAMJ.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (10,14))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  18   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LMOTORI.AccAMJ.dbo.tblSal_MD CROSS JOIN
									 LMOTORI.AccAMJ.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (10,14))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   18   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LMOTORI.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         LMOTORI.AccAMJ.dbo.tblSanadState
WHERE        (tblSal_MD.Id IN (10,14))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   18  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LMOTORI.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         LMOTORI.AccAMJ.dbo.tblTafsily
WHERE        (tblSal_MD.Id IN (10,14))

				
insert into olden.tblSanad_MD(Id ,      YearName                           , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 10   then 1400 
								        when IdSal_MD = 14   then 1401 
								   end ,   18   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMOTORI.AccAMJ.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                          , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,   18   ,   
						   											     case when IdSalSanad_MD = 10  then 1400 
																		      when IdSalSanad_MD = 14  then 1401 
																		 end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM  LMOTORI.AccAMJ.dbo.tblSanadDetail_MD

--***********************************************************************************************************************
----=====================================================================================================================
----کانورت اسناد حسابداری ارامستانها
---- سال های 1399  تا 1401
delete olden.tblGroup           where AreaId = 19
delete olden.tblKol             where AreaId = 19
delete olden.tblMoien           where AreaId = 19
delete olden.tblSal_MD          where AreaId = 19
delete olden.tblSanadKind       where AreaId = 19
delete olden.tblSanadState      where AreaId = 19
delete olden.tblTafsily         where AreaId = 19
delete olden.tblSanad_MD        where AreaId = 19
delete olden.tblSanadDetail_MD  where AreaId = 19
insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  19   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LBEHESHT.AccAMJ.dbo.tblGroup CROSS JOIN
										 LBEHESHT.AccAMJ.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (7,9,10))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    19  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LBEHESHT.AccAMJ.dbo.tblKol CROSS JOIN
									 LBEHESHT.AccAMJ.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (7,9,10))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  19   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LBEHESHT.AccAMJ.dbo.tblSal_MD CROSS JOIN
										 LBEHESHT.AccAMJ.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (7,9,10))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  19   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LBEHESHT.AccAMJ.dbo.tblSal_MD CROSS JOIN
									 LBEHESHT.AccAMJ.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (7,9,10))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   19   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LBEHESHT.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         LBEHESHT.AccAMJ.dbo.tblSanadState
WHERE        (tblSal_MD.Id IN (7,9,10))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   19  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LBEHESHT.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         LBEHESHT.AccAMJ.dbo.tblTafsily
WHERE        (tblSal_MD.Id IN (7,9,10))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 7  then 1399
								        when IdSal_MD = 9  then 1400
										when IdSal_MD = 10  then 1401
										                            end ,   19   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LBEHESHT.AccAMJ.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                     , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,   19   , 
						   											     case when IdSalSanad_MD = 7  then 1399
										                                      when IdSalSanad_MD = 9  then 1400
																			  when IdSalSanad_MD = 10  then 1401
																			                                end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM  LBEHESHT.AccAMJ.dbo.tblSanadDetail_MD

--کانورت 1398  آرامستانها
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  19   ,   1398   , Name
              FROM            LBEHESHT.AccAmj198.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   19   ,  1398   ,IdGroup , Name
	        FROM            LBEHESHT.AccAmj198.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   19  ,   1398   ,IdKol ,Name
                  FROM            LBEHESHT.AccAmj198.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   19   ,   1398  , Name
                       FROM            LBEHESHT.AccAmj198.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   19   ,   1398   , Name
					FROM            LBEHESHT.AccAmj198.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   19  ,   1398    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LBEHESHT.AccAmj198.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1398	,   19   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LBEHESHT.AccAmj198.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   19   ,   1398   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LBEHESHT.AccAmj198.dbo.tblSanadDetail_MD

--کانورت 1397  آرامستانها
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind, 19    ,   1397   , Name
              FROM            LBEHESHT.AccAmj197.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   19   ,  1397   ,IdGroup , Name
	        FROM            LBEHESHT.AccAmj197.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   19  ,   1397   ,IdKol ,Name
                  FROM            LBEHESHT.AccAmj197.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   19   ,   1397  , Name
                       FROM            LBEHESHT.AccAmj197.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   19   ,   1397   , Name
					FROM            LBEHESHT.AccAmj197.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   19  ,   1397    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LBEHESHT.AccAmj197.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1397	,   19   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LBEHESHT.AccAmj197.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   19   ,   1397   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LBEHESHT.AccAmj197.dbo.tblSanadDetail_MD

--کانورت 1396  آرامستانها
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  19   ,   1396   , Name
              FROM            LBEHESHT.AccAmj196.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   19   ,  1396   ,IdGroup , Name
	        FROM            LBEHESHT.AccAmj196.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   19  ,   1396   ,IdKol ,Name
                  FROM            LBEHESHT.AccAmj196.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   19   ,   1396  , Name
                       FROM            LBEHESHT.AccAmj196.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   19   ,   1396   , Name
					FROM            LBEHESHT.AccAmj196.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   19  ,   1396    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LBEHESHT.AccAmj196.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1396	,   19   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LBEHESHT.AccAmj196.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   19   ,   1396   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LBEHESHT.AccAmj196.dbo.tblSanadDetail_MD

--کانورت 1395  آرامستانها
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  19   ,   1395   , Name
              FROM            LBEHESHT.AccAmj195.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   19   ,  1395   ,IdGroup , Name
	        FROM            LBEHESHT.AccAmj195.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   19  ,   1395   ,IdKol ,Name
                  FROM            LBEHESHT.AccAmj195.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   19   ,   1395  , Name
                       FROM            LBEHESHT.AccAmj195.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   19   ,   1395   , Name
					FROM            LBEHESHT.AccAmj195.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   19  ,   1395    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LBEHESHT.AccAmj195.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1395	,   19   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LBEHESHT.AccAmj195.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   19   ,   1395   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LBEHESHT.AccAmj195.dbo.tblSanadDetail_MD

--کانورت 1394  آرامستانها
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  19   ,   1394   , Name
              FROM            LBEHESHT.AccAmj194.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   19   ,  1394   ,IdGroup , Name
	        FROM            LBEHESHT.AccAmj194.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   19  ,   1394   ,IdKol ,Name
                  FROM            LBEHESHT.AccAmj194.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   19   ,   1394  , Name
                       FROM            LBEHESHT.AccAmj194.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   19   ,   1394   , Name
					FROM            LBEHESHT.AccAmj194.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   19  ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LBEHESHT.AccAmj194.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1394	,   19   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LBEHESHT.AccAmj194.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   19   ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LBEHESHT.AccAmj194.dbo.tblSanadDetail_MD

--کانورت 1393  آرامستانها
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  19   ,   1393   , Name
              FROM            LBEHESHT.AccAmj193.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   19   ,  1393   ,IdGroup , Name
	        FROM            LBEHESHT.AccAmj193.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   19  ,   1393   ,IdKol ,Name
                  FROM            LBEHESHT.AccAmj193.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   19   ,   1393  , Name
                       FROM            LBEHESHT.AccAmj193.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   19   ,   1393   , Name
					FROM            LBEHESHT.AccAmj193.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   19  ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LBEHESHT.AccAmj193.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1393	,   19   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LBEHESHT.AccAmj193.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   19   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LBEHESHT.AccAmj193.dbo.tblSanadDetail_MD

--کانورت 1392  آرامستانها
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  19   ,   1392   , Name
              FROM            LBEHESHT.AccAmj192.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   19   ,  1392   ,IdGroup , Name
	        FROM            LBEHESHT.AccAmj192.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   19  ,   1392   ,IdKol ,Name
                  FROM            LBEHESHT.AccAmj192.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   19   ,   1392  , Name
                       FROM            LBEHESHT.AccAmj192.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   19   ,   1392   , Name
					FROM            LBEHESHT.AccAmj192.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   19  ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LBEHESHT.AccAmj192.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1392	,   19   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LBEHESHT.AccAmj192.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   19   ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LBEHESHT.AccAmj192.dbo.tblSanadDetail_MD

--کانورت 1391  آرامستانها

insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  19   ,   1391   , Name
              FROM            LBEHESHT.AccAmj191.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   19   ,  1391   ,IdGroup , Name
	        FROM            LBEHESHT.AccAmj191.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   19  ,   1391   ,IdKol ,Name
                  FROM            LBEHESHT.AccAmj191.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   19   ,   1391  , Name
                       FROM            LBEHESHT.AccAmj191.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   19   ,   1391   , Name
					FROM            LBEHESHT.AccAmj191.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   19  ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LBEHESHT.AccAmj191.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1391	,   19   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LBEHESHT.AccAmj191.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   19   ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LBEHESHT.AccAmj191.dbo.tblSanadDetail_MD


--کانورت 1390  آرامستانها
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  19   ,   1390   , Name
              FROM            LBEHESHT.AccAmj190.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   19   ,  1390   ,IdGroup , Name
	        FROM            LBEHESHT.AccAmj190.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   19  ,   1390   ,IdKol ,Name
                  FROM            LBEHESHT.AccAmj190.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   19   ,   1390  , Name
                       FROM            LBEHESHT.AccAmj190.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   19   ,   1390   , Name
					FROM            LBEHESHT.AccAmj190.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   19  ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LBEHESHT.AccAmj190.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1390	,   19   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LBEHESHT.AccAmj190.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   19   ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LBEHESHT.AccAmj190.dbo.tblSanadDetail_MD

--کانورت 1389  آرامستانها
--insert into olden.tblGroup( id , AreaId , YearName , Name )
--	          SELECT        Id ,   19   ,   1389   , Name
--              FROM            LBEHESHT.AccAmj189.dbo.tblGroup
--insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
--			SELECT        Id  ,   19   ,  1389   ,IdGroup , Name
--	        FROM            LBEHESHT.AccAmj189.dbo.tblKol
--insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
--			   SELECT      Id ,   19  ,   1389   ,IdKol ,Name
--                  FROM            LBEHESHT.AccAmj189.dbo.tblMoien AS tblMoien_1
--insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
--		         SELECT        Id ,   19   ,   1389  , Name
--                       FROM            LBEHESHT.AccAmj189.dbo.tblSanadKind AS tblSanadKind_1				 
--insert into olden.tblSanadState(Id , AreaId , YearName , Name)
--					SELECT      Id ,   19   ,   1389   , Name
--					FROM            LBEHESHT.AccAmj189.dbo.tblSanadState AS tblSanadState_1
--insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
--				    SELECT   Id , IdSotooh ,   19  ,   1389    , IdTafsilyGroup , Name , IdTafsilyType
--		FROM            LBEHESHT.AccAmj189.dbo.tblTafsily AS tblTafsily_1
--insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
--	                SELECT    Id ,   1389	,   19   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
--										FROM LBEHESHT.AccAmj189.dbo.tblSanad_MD				
--insert into olden.tblSanadDetail_MD(Id , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
--						   SELECT   Id ,   19   ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
--							 FROM            LBEHESHT.AccAmj189.dbo.tblSanadDetail_MD


--کانورت 1388  آرامستانها
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  19   ,   1388   , Name
              FROM            LBEHESHT.AccAmj188.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   19   ,  1388   ,IdGroup , Name
	        FROM            LBEHESHT.AccAmj188.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   19  ,   1388   ,IdKol ,Name
                  FROM            LBEHESHT.AccAmj188.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   19   ,   1388  , Name
                       FROM            LBEHESHT.AccAmj188.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   19   ,   1388   , Name
					FROM            LBEHESHT.AccAmj188.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   19  ,   1388    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LBEHESHT.AccAmj188.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1388	,   19   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LBEHESHT.AccAmj188.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   19   ,   1388   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LBEHESHT.AccAmj188.dbo.tblSanadDetail_MD

--کانورت 1387  آرامستانها

insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind, 19   ,   1387   , Name
              FROM            LBEHESHT.AccAmj187.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   19   ,  1387   ,IdGroup , Name
	        FROM            LBEHESHT.AccAmj187.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   19  ,   1387   ,IdKol ,Name
                  FROM            LBEHESHT.AccAmj187.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   19   ,   1387  , Name
                       FROM            LBEHESHT.AccAmj187.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   19   ,   1387   , Name
					FROM            LBEHESHT.AccAmj187.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   19  ,   1387    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LBEHESHT.AccAmj187.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1387	,   19   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LBEHESHT.AccAmj187.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   19   ,   1387   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LBEHESHT.AccAmj187.dbo.tblSanadDetail_MD
--کانورت 1386  آرامستانها

--insert into olden.tblGroup( id , AreaId , YearName , Name )
--	          SELECT        Id ,   19   ,   1386   , Name
--              FROM            LBEHESHT.AccAmj186.dbo.tblGroup AS tblGroup_1

--insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
--			SELECT        Id  ,   19   ,  1386   ,IdGroup , Name
--	        FROM            LBEHESHT.AccAmj186.dbo.tblKol AS tblKol_1
	

--insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
--			   SELECT      Id ,   19  ,   1386   ,IdKol ,Name
--                  FROM            LBEHESHT.AccAmj186.dbo.tblMoien AS tblMoien_1

--insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
--		         SELECT        Id ,   19   ,   1386  , Name
--                       FROM            LBEHESHT.AccAmj186.dbo.tblSanadKind AS tblSanadKind_1				 

--insert into olden.tblSanadState(Id , AreaId , YearName , Name)
--					SELECT      Id ,   19   ,   1386   , Name
--					FROM            LBEHESHT.AccAmj186.dbo.tblSanadState AS tblSanadState_1
					  

--insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
--				    SELECT   Id , IdSotooh ,   19  ,   1386    , IdTafsilyGroup , Name , IdTafsilyType
--		FROM            LBEHESHT.AccAmj186.dbo.tblTafsily AS tblTafsily_1

				
--insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
--	                SELECT    Id ,   1386	,   19   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
--										FROM LBEHESHT.AccAmj186.dbo.tblSanad_MD				

--insert into olden.tblSanadDetail_MD(Id , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
--						   SELECT   Id ,   19   ,   1386   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
--							 FROM            LBEHESHT.AccAmj186.dbo.tblSanadDetail_MD

--کانورت 1385  آرامستانها

insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  19   ,   1385   , Name
              FROM            LBEHESHT.AccAmj185.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   19   ,  1385   ,IdGroup , Name
	        FROM            LBEHESHT.AccAmj185.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   19  ,   1385   ,IdKol ,Name
                  FROM            LBEHESHT.AccAmj185.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   19   ,   1385  , Name
                       FROM            LBEHESHT.AccAmj185.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   19   ,   1385   , Name
					FROM            LBEHESHT.AccAmj185.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   19  ,   1385    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LBEHESHT.AccAmj185.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1385	,   19   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LBEHESHT.AccAmj185.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   19   ,   1385   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LBEHESHT.AccAmj185.dbo.tblSanadDetail_MD

--**********************************************************************************************************************
----=====================================================================================================================
----کانورت اسناد حسابداری حمل و نقل بار
---- سال های 1397  تا 1401
delete olden.tblGroup           where AreaId = 20
delete olden.tblKol             where AreaId = 20
delete olden.tblMoien           where AreaId = 20
delete olden.tblSal_MD          where AreaId = 20
delete olden.tblSanadKind       where AreaId = 20
delete olden.tblSanadState      where AreaId = 20
delete olden.tblTafsily         where AreaId = 20
delete olden.tblSanad_MD        where AreaId = 20
delete olden.tblSanadDetail_MD  where AreaId = 20
insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  20   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LBAR.AccAMJ.dbo.tblGroup CROSS JOIN
										 LBAR.AccAMJ.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN ( 8 , 9 ,10 , 13 , 15))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    20  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LBAR.AccAMJ.dbo.tblKol CROSS JOIN
									 LBAR.AccAMJ.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (8 , 9 ,10 , 13 , 15))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  20   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LBAR.AccAMJ.dbo.tblSal_MD CROSS JOIN
										 LBAR.AccAMJ.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (8 , 9 , 10 , 13 , 15))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  20   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LBAR.AccAMJ.dbo.tblSal_MD CROSS JOIN
									 LBAR.AccAMJ.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (8 , 9 , 10 , 13  , 15))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   20   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LBAR.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         LBAR.AccAMJ.dbo.tblSanadState
WHERE        (tblSal_MD.Id IN (8 , 9 , 10 , 13 , 15 ))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   20  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LBAR.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         LBAR.AccAMJ.dbo.tblTafsily
WHERE        (tblSal_MD.Id IN (8 , 9 , 10 , 13  , 15))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 8  then 1397
								        when IdSal_MD = 9  then 1398
										when IdSal_MD = 10 then 1399
										when IdSal_MD = 13 then 1400
										when IdSal_MD = 15 then 1401
										                             end ,   20   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LBAR.AccAMJ.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                        , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,   20   , 
						   											     case when IdSalSanad_MD = 8  then 1397
										                                      when IdSalSanad_MD = 9  then 1398
																		      when IdSalSanad_MD = 10 then 1399
																			  when IdSalSanad_MD = 13 then 1400
																			  when IdSalSanad_MD = 15 then 1401
																			                                   end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM  LBAR.AccAMJ.dbo.tblSanadDetail_MD


----=====================================================================================================================
----کانورت اسناد حسابداری زیبا سازی
---- سال های 1396  تا 1402
delete olden.tblGroup           where AreaId = 21
delete olden.tblKol             where AreaId = 21
delete olden.tblMoien           where AreaId = 21
delete olden.tblSal_MD          where AreaId = 21
delete olden.tblSanadKind       where AreaId = 21
delete olden.tblSanadState      where AreaId = 21
delete olden.tblTafsily         where AreaId = 21
delete olden.tblSanad_MD        where AreaId = 21
delete olden.tblSanadDetail_MD  where AreaId = 21
insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  21   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LZIBA.accamj297.dbo.tblGroup CROSS JOIN
										 LZIBA.accamj297.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN ( 6,7,8,9,10,11))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    21  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LZIBA.accamj297.dbo.tblKol CROSS JOIN
									 LZIBA.accamj297.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN ( 6,7,8,9,10,11))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  21   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LZIBA.accamj297.dbo.tblSal_MD CROSS JOIN
										 LZIBA.accamj297.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN ( 6,7,8,9,10,11))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  21   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LZIBA.accamj297.dbo.tblSal_MD CROSS JOIN
									 LZIBA.accamj297.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN ( 6,7,8,9,10,11))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   21   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LZIBA.accamj297.dbo.tblSal_MD CROSS JOIN
                         LZIBA.accamj297.dbo.tblSanadState
WHERE        (tblSal_MD.Id IN ( 6,7,8,9,10,11))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   21  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LZIBA.accamj297.dbo.tblSal_MD CROSS JOIN
                         LZIBA.accamj297.dbo.tblTafsily
WHERE        (tblSal_MD.Id IN ( 6,7,8,9,10,11))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 6   then 1396
								        when IdSal_MD = 7   then 1397
										when IdSal_MD = 8   then 1398
										when IdSal_MD = 9   then 1399
										when IdSal_MD = 10  then 1400
										when IdSal_MD = 11  then 1401
										                             end ,   21   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LZIBA.accamj297.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                        , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    21  , 
						   											     case when IdSalSanad_MD = 6   then 1396
										                                      when IdSalSanad_MD = 7   then 1397
																			  when IdSalSanad_MD = 8   then 1398
										                                      when IdSalSanad_MD = 9   then 1399
										                                      when IdSalSanad_MD = 10  then 1400
																			  when IdSalSanad_MD = 11  then 1401
																			                                   end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LZIBA.accamj297.dbo.tblSanadDetail_MD


--کانورت 1395  زیبا سازی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   21  ,   1395   , Name
              FROM            LZIBA.AccAMJ295.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   21   ,  1395   ,IdGroup , Name
	        FROM            LZIBA.AccAMJ295.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   21  ,   1395   ,IdKol ,Name
                  FROM            LZIBA.AccAMJ295.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   21   ,   1395  , Name
                       FROM            LZIBA.AccAMJ295.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   21   ,   1395   , Name
					FROM            LZIBA.AccAMJ295.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   21  ,   1395    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LZIBA.AccAMJ295.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1395	,   21   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LZIBA.AccAMJ295.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id ,  IdSanad_MD ,  21   ,   1395   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LZIBA.AccAMJ295.dbo.tblSanadDetail_MD

--کانورت 1394  زیبا سازی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   21  ,   1394   , Name
              FROM            LZIBA.AccAMJ294.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   21   ,  1394   ,IdGroup , Name
	        FROM            LZIBA.AccAMJ294.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   21  ,   1394   ,IdKol ,Name
                  FROM            LZIBA.AccAMJ294.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   21   ,   1394  , Name
                       FROM            LZIBA.AccAMJ294.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   21   ,   1394   , Name
					FROM            LZIBA.AccAMJ294.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   21  ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LZIBA.AccAMJ294.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1394	,   21   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LZIBA.AccAMJ294.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   21   ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LZIBA.AccAMJ294.dbo.tblSanadDetail_MD

--کانورت 1393  زیبا سازی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   21  ,   1393   , Name
              FROM            LZIBA.AccAMJ293.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   21   ,  1393   ,IdGroup , Name
	        FROM            LZIBA.AccAMJ293.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   21  ,   1393   ,IdKol ,Name
                  FROM            LZIBA.AccAMJ293.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   21   ,   1393  , Name
                       FROM            LZIBA.AccAMJ293.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   21   ,   1393   , Name
					FROM            LZIBA.AccAMJ293.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   21  ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LZIBA.AccAMJ293.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1393	,   21   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LZIBA.AccAMJ293.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   21   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LZIBA.AccAMJ293.dbo.tblSanadDetail_MD

--کانورت 1392  زیبا سازی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   21  ,   1392   , Name
              FROM            LZIBA.AccAMJ292.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   21   ,  1392   ,IdGroup , Name
	        FROM            LZIBA.AccAMJ292.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   21  ,   1392   ,IdKol ,Name
                  FROM            LZIBA.AccAMJ292.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   21   ,   1392  , Name
                       FROM            LZIBA.AccAMJ292.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   21   ,   1392   , Name
					FROM            LZIBA.AccAMJ292.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   21  ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LZIBA.AccAMJ292.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1392	,   21   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LZIBA.AccAMJ292.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   21   ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LZIBA.AccAMJ292.dbo.tblSanadDetail_MD

--کانورت 1391  زیبا سازی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   21  ,   1391   , Name
              FROM            LZIBA.AccAMJ291.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   21   ,  1391   ,IdGroup , Name
	        FROM            LZIBA.AccAMJ291.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   21  ,   1391   ,IdKol ,Name
                  FROM            LZIBA.AccAMJ291.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   21   ,   1391  , Name
                       FROM            LZIBA.AccAMJ291.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   21   ,   1391   , Name
					FROM            LZIBA.AccAMJ291.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   21  ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LZIBA.AccAMJ291.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1391	,   21   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LZIBA.AccAMJ291.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   21   ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LZIBA.AccAMJ291.dbo.tblSanadDetail_MD

--کانورت 1390  زیبا سازی
insert into olden.tblGroup( id , IdRecognition , IdKind , AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,    21  ,   1390   , Name
              FROM            LZIBA.AccAMJ290.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   21   ,  1390   ,IdGroup , Name
	        FROM            LZIBA.AccAMJ290.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   21  ,   1390   ,IdKol ,Name
                  FROM            LZIBA.AccAMJ290.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   21   ,   1390  , Name
                       FROM            LZIBA.AccAMJ290.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   21   ,   1390   , Name
					FROM            LZIBA.AccAMJ290.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   21  ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LZIBA.AccAMJ290.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1390	,   21   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LZIBA.AccAMJ290.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   21   ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LZIBA.AccAMJ290.dbo.tblSanadDetail_MD

--کانورت 1389  زیبا سازی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   21  ,   1389   , Name
              FROM            LZIBA.AccAMJ289.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   21   ,  1389   ,IdGroup , Name
	        FROM            LZIBA.AccAMJ289.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   21  ,   1389   ,IdKol ,Name
                  FROM            LZIBA.AccAMJ289.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   21   ,   1389  , Name
                       FROM            LZIBA.AccAMJ289.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   21   ,   1389   , Name
					FROM            LZIBA.AccAMJ289.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   21  ,   1389    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LZIBA.AccAMJ289.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1389	,   21   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LZIBA.AccAMJ289.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   21   ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LZIBA.AccAMJ289.dbo.tblSanadDetail_MD

--کانورت 1388  زیبا سازی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   21  ,   1388   , Name
              FROM            LZIBA.AccAMJ288.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   21   ,  1388   ,IdGroup , Name
	        FROM            LZIBA.AccAMJ288.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   21  ,   1388   ,IdKol ,Name
                  FROM            LZIBA.AccAMJ288.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   21   ,   1388  , Name
                       FROM            LZIBA.AccAMJ288.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   21   ,   1388   , Name
					FROM            LZIBA.AccAMJ288.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   21  ,   1388    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LZIBA.AccAMJ288.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1388	,   21   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LZIBA.AccAMJ288.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   21   ,   1388   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LZIBA.AccAMJ288.dbo.tblSanadDetail_MD

----=====================================================================================================================
----کانورت اسناد حسابداری  عمران شهری
---- سال های 1396  تا 1402
delete olden.tblGroup           where AreaId = 22
delete olden.tblKol             where AreaId = 22
delete olden.tblMoien           where AreaId = 22
delete olden.tblSal_MD          where AreaId = 22
delete olden.tblSanadKind       where AreaId = 22
delete olden.tblSanadState      where AreaId = 22
delete olden.tblTafsily         where AreaId = 22
delete olden.tblSanad_MD        where AreaId = 22
delete olden.tblSanadDetail_MD  where AreaId = 22
insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  22   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LOMRAN.AccAMJ.dbo.tblGroup CROSS JOIN
										 LOMRAN.AccAMJ.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN ( 6,7,8,9,10,11))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    22  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LOMRAN.AccAMJ.dbo.tblKol CROSS JOIN
									 LOMRAN.AccAMJ.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN ( 6,7,8,9,10,11))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  22   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LOMRAN.AccAMJ.dbo.tblSal_MD CROSS JOIN
										 LOMRAN.AccAMJ.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN ( 6,7,8,9,10,11))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  22   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LOMRAN.AccAMJ.dbo.tblSal_MD CROSS JOIN
									 LOMRAN.AccAMJ.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN ( 6,7,8,9,10,11))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   22   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LOMRAN.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         LOMRAN.AccAMJ.dbo.tblSanadState
WHERE        (tblSal_MD.Id IN ( 6,7,8,9,10,11))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   22  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LOMRAN.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         LOMRAN.AccAMJ.dbo.tblTafsily
WHERE        (tblSal_MD.Id IN ( 6,7,8,9,10,11))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 6   then 1396
								        when IdSal_MD = 7   then 1397
										when IdSal_MD = 8   then 1398
										when IdSal_MD = 9   then 1399
										when IdSal_MD = 10  then 1400
										when IdSal_MD = 11  then 1401
										                            end ,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LOMRAN.AccAMJ.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                        , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    22  , 
						   											     case when IdSalSanad_MD = 6   then 1396
										                                      when IdSalSanad_MD = 7   then 1397
																			  when IdSalSanad_MD = 8   then 1398
										                                      when IdSalSanad_MD = 9   then 1399
										                                      when IdSalSanad_MD = 10  then 1400
																			  when IdSalSanad_MD = 11  then 1401
																			                                    end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LOMRAN.AccAMJ.dbo.tblSanadDetail_MD


--کانورت 1395   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   22  ,   1395   , Name
              FROM            LOMRAN.AccAMJ195.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   22   ,  1395   ,IdGroup , Name
	        FROM            LOMRAN.AccAMJ195.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   22  ,   1395   ,IdKol ,Name
                  FROM   LOMRAN.AccAMJ195.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   22   ,   1395  , Name
                       FROM   LOMRAN.AccAMJ195.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   22   ,   1395   , Name
					FROM    LOMRAN.AccAMJ195.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   22  ,   1395    , IdTafsilyGroup , Name , IdTafsilyType
		           FROM    LOMRAN.AccAMJ195.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1395	,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
							FROM LOMRAN.AccAMJ195.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,   1395   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM   LOMRAN.AccAMJ195.dbo.tblSanadDetail_MD

--کانورت 1394   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   22  ,   1394   , Name
              FROM            LOMRAN.AccAMJ194.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   22   ,  1394   ,IdGroup , Name
	        FROM            LOMRAN.AccAMJ194.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   22  ,   1394   ,IdKol ,Name
                  FROM   LOMRAN.AccAMJ194.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   22   ,   1394  , Name
                       FROM   LOMRAN.AccAMJ194.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   22   ,   1394   , Name
					FROM    LOMRAN.AccAMJ194.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   22  ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
		           FROM    LOMRAN.AccAMJ194.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1394	,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
							FROM LOMRAN.AccAMJ194.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM   LOMRAN.AccAMJ194.dbo.tblSanadDetail_MD

--کانورت 1393   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   22  ,   1393   , Name
              FROM            LOMRAN.AccAMJ193.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   22   ,  1393   ,IdGroup , Name
	        FROM            LOMRAN.AccAMJ193.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   22  ,   1393   ,IdKol ,Name
                  FROM   LOMRAN.AccAMJ193.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   22   ,   1393  , Name
                       FROM   LOMRAN.AccAMJ193.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   22   ,   1393   , Name
					FROM    LOMRAN.AccAMJ193.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   22  ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
		           FROM    LOMRAN.AccAMJ193.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1393	,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
							FROM LOMRAN.AccAMJ193.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM   LOMRAN.AccAMJ193.dbo.tblSanadDetail_MD

--کانورت 1392   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   22  ,   1392   , Name
              FROM            LOMRAN.AccAMJ192.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   22   ,  1392   ,IdGroup , Name
	        FROM            LOMRAN.AccAMJ192.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   22  ,   1392   ,IdKol ,Name
                  FROM   LOMRAN.AccAMJ192.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   22   ,   1392  , Name
                       FROM   LOMRAN.AccAMJ192.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   22   ,   1392   , Name
					FROM    LOMRAN.AccAMJ192.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   22  ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
		           FROM    LOMRAN.AccAMJ192.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1392	,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
							FROM LOMRAN.AccAMJ192.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM   LOMRAN.AccAMJ192.dbo.tblSanadDetail_MD

--کانورت 1391   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   22  ,   1391   , Name
              FROM            LOMRAN.AccAMJ191.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   22   ,  1391   ,IdGroup , Name
	        FROM            LOMRAN.AccAMJ191.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   22  ,   1391   ,IdKol ,Name
                  FROM   LOMRAN.AccAMJ191.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   22   ,   1391  , Name
                       FROM   LOMRAN.AccAMJ191.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   22   ,   1391   , Name
					FROM    LOMRAN.AccAMJ191.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   22  ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
		           FROM    LOMRAN.AccAMJ191.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1391	,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
							FROM LOMRAN.AccAMJ191.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM   LOMRAN.AccAMJ191.dbo.tblSanadDetail_MD

--کانورت 1390   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   22  ,   1390   , Name
              FROM            LOMRAN.AccAMJ190.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   22   ,  1390   ,IdGroup , Name
	        FROM            LOMRAN.AccAMJ190.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   22  ,   1390   ,IdKol ,Name
                  FROM   LOMRAN.AccAMJ190.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   22   ,   1390  , Name
                       FROM   LOMRAN.AccAMJ190.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   22   ,   1390   , Name
					FROM    LOMRAN.AccAMJ190.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   22  ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
		           FROM    LOMRAN.AccAMJ190.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1390	,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
							FROM LOMRAN.AccAMJ190.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM   LOMRAN.AccAMJ190.dbo.tblSanadDetail_MD

--کانورت 1389   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   22  ,   1389   , Name
              FROM            LOMRAN.AccAMJ189.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   22   ,  1389   ,IdGroup , Name
	        FROM            LOMRAN.AccAMJ189.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   22  ,   1389   ,IdKol ,Name
                  FROM   LOMRAN.AccAMJ189.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   22   ,   1389  , Name
                       FROM   LOMRAN.AccAMJ189.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   22   ,   1389   , Name
					FROM    LOMRAN.AccAMJ189.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   22  ,   1389    , IdTafsilyGroup , Name , IdTafsilyType
		           FROM    LOMRAN.AccAMJ189.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1389	,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
							FROM LOMRAN.AccAMJ189.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM   LOMRAN.AccAMJ189.dbo.tblSanadDetail_MD

--کانورت 1388   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   22  ,   1388   , Name
              FROM            LOMRAN.AccAMJ188.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   22   ,  1388   ,IdGroup , Name
	        FROM            LOMRAN.AccAMJ188.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   22  ,   1388   ,IdKol ,Name
                  FROM   LOMRAN.AccAMJ188.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   22   ,   1388  , Name
                       FROM   LOMRAN.AccAMJ188.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   22   ,   1388   , Name
					FROM    LOMRAN.AccAMJ188.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   22  ,   1388    , IdTafsilyGroup , Name , IdTafsilyType
		           FROM    LOMRAN.AccAMJ188.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1388	,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
							FROM LOMRAN.AccAMJ188.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,   1388   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM   LOMRAN.AccAMJ188.dbo.tblSanadDetail_MD

--کانورت 1387   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   22  ,   1387   , Name
              FROM            LOMRAN.AccAMJ187.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   22   ,  1387   ,IdGroup , Name
	        FROM            LOMRAN.AccAMJ187.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   22  ,   1387   ,IdKol ,Name
                  FROM   LOMRAN.AccAMJ187.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   22   ,   1387  , Name
                       FROM   LOMRAN.AccAMJ187.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   22   ,   1387   , Name
					FROM    LOMRAN.AccAMJ187.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   22  ,   1387    , IdTafsilyGroup , Name , IdTafsilyType
		           FROM    LOMRAN.AccAMJ187.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1387	,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
							FROM LOMRAN.AccAMJ187.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,   1387   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM   LOMRAN.AccAMJ187.dbo.tblSanadDetail_MD

--کانورت 1386   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   22  ,   1386   , Name
              FROM            LOMRAN.AccAMJ186.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   22   ,  1386   ,IdGroup , Name
	        FROM            LOMRAN.AccAMJ186.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   22  ,   1386   ,IdKol ,Name
                  FROM   LOMRAN.AccAMJ186.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   22   ,   1386  , Name
                       FROM   LOMRAN.AccAMJ186.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   22   ,   1386   , Name
					FROM    LOMRAN.AccAMJ186.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   22  ,   1386    , IdTafsilyGroup , Name , IdTafsilyType
		           FROM    LOMRAN.AccAMJ186.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1386	,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
							FROM LOMRAN.AccAMJ186.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,   1386   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM   LOMRAN.AccAMJ186.dbo.tblSanadDetail_MD

--کانورت 1385   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   22  ,   1385   , Name
              FROM            LOMRAN.AccAMJ185.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   22   ,  1385   ,IdGroup , Name
	        FROM            LOMRAN.AccAMJ185.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   22  ,   1385   ,IdKol ,Name
                  FROM   LOMRAN.AccAMJ185.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   22   ,   1385  , Name
                       FROM   LOMRAN.AccAMJ185.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   22   ,   1385   , Name
					FROM    LOMRAN.AccAMJ185.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   22  ,   1385    , IdTafsilyGroup , Name , IdTafsilyType
		           FROM    LOMRAN.AccAMJ185.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1385	,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
							FROM LOMRAN.AccAMJ185.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,   1385   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM   LOMRAN.AccAMJ185.dbo.tblSanadDetail_MD

--کانورت 1384   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   22  ,   1384   , Name
              FROM            LOMRAN.AccAMJ184.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   22   ,  1384   ,IdGroup , Name
	        FROM            LOMRAN.AccAMJ184.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   22  ,   1384   ,IdKol ,Name
                  FROM   LOMRAN.AccAMJ184.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   22   ,   1384  , Name
                       FROM   LOMRAN.AccAMJ184.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   22   ,   1384   , Name
					FROM    LOMRAN.AccAMJ184.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   22  ,   1384    , IdTafsilyGroup , Name , IdTafsilyType
		           FROM    LOMRAN.AccAMJ184.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1384	,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
							FROM LOMRAN.AccAMJ184.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,   1384   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM   LOMRAN.AccAMJ184.dbo.tblSanadDetail_MD

--کانورت 1383   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   22  ,   1383   , Name
              FROM            LOMRAN.AccAMJ183.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   22   ,  1383   ,IdGroup , Name
	        FROM            LOMRAN.AccAMJ183.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   22  ,   1383   ,IdKol ,Name
                  FROM   LOMRAN.AccAMJ183.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   22   ,   1383  , Name
                       FROM   LOMRAN.AccAMJ183.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   22   ,   1383   , Name
					FROM    LOMRAN.AccAMJ183.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   22  ,   1383    , IdTafsilyGroup , Name , IdTafsilyType
		           FROM    LOMRAN.AccAMJ183.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1383	,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
							FROM LOMRAN.AccAMJ183.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,   1383   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM   LOMRAN.AccAMJ183.dbo.tblSanadDetail_MD

--کانورت 1382   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   22  ,   1382   , Name
              FROM            LOMRAN.AccAMJ182.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   22   ,  1382   ,IdGroup , Name
	        FROM            LOMRAN.AccAMJ182.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   22  ,   1382   ,IdKol ,Name
                  FROM   LOMRAN.AccAMJ182.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   22   ,   1382  , Name
                       FROM   LOMRAN.AccAMJ182.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   22   ,   1382   , Name
					FROM    LOMRAN.AccAMJ182.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   22  ,   1382    , IdTafsilyGroup , Name , IdTafsilyType
		           FROM    LOMRAN.AccAMJ182.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1382	,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
							FROM LOMRAN.AccAMJ182.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,   1382   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM   LOMRAN.AccAMJ182.dbo.tblSanadDetail_MD

--کانورت 1381   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   22  ,   1381   , Name
              FROM            LOMRAN.AccAMJ181.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   22   ,  1381   ,IdGroup , Name
	        FROM            LOMRAN.AccAMJ181.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   22  ,   1381   ,IdKol ,Name
                  FROM   LOMRAN.AccAMJ181.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   22   ,   1381  , Name
                       FROM   LOMRAN.AccAMJ181.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   22   ,   1381   , Name
					FROM    LOMRAN.AccAMJ181.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   22  ,   1381    , IdTafsilyGroup , Name , IdTafsilyType
		           FROM    LOMRAN.AccAMJ181.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1381	,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
							FROM LOMRAN.AccAMJ181.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,   1381   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM   LOMRAN.AccAMJ181.dbo.tblSanadDetail_MD

--کانورت 1380   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   22  ,   1380   , Name
              FROM            LOMRAN.AccAMJ180.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   22   ,  1380   ,IdGroup , Name
	        FROM            LOMRAN.AccAMJ180.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   22  ,   1380   ,IdKol ,Name
                  FROM   LOMRAN.AccAMJ180.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   22   ,   1380  , Name
                       FROM   LOMRAN.AccAMJ180.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   22   ,   1380   , Name
					FROM    LOMRAN.AccAMJ180.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   22  ,   1380    , IdTafsilyGroup , Name , IdTafsilyType
		           FROM    LOMRAN.AccAMJ180.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1380	,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
							FROM LOMRAN.AccAMJ180.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,   1380   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM   LOMRAN.AccAMJ180.dbo.tblSanadDetail_MD

--کانورت 1379   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   22  ,   1379   , Name
              FROM            LOMRAN.AccAMJ179.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   22   ,  1379   ,IdGroup , Name
	        FROM            LOMRAN.AccAMJ179.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   22  ,   1379   ,IdKol ,Name
                  FROM   LOMRAN.AccAMJ179.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   22   ,   1379  , Name
                       FROM   LOMRAN.AccAMJ179.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   22   ,   1379   , Name
					FROM    LOMRAN.AccAMJ179.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   22  ,   1379    , IdTafsilyGroup , Name , IdTafsilyType
		           FROM    LOMRAN.AccAMJ179.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1379	,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
							FROM LOMRAN.AccAMJ179.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,   1379   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM   LOMRAN.AccAMJ179.dbo.tblSanadDetail_MD

--کانورت 1378   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   22  ,   1378   , Name
              FROM            LOMRAN.AccAMJ178.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   22   ,  1378   ,IdGroup , Name
	        FROM            LOMRAN.AccAMJ178.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   22  ,   1378   ,IdKol ,Name
                  FROM   LOMRAN.AccAMJ178.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   22   ,   1378  , Name
                       FROM   LOMRAN.AccAMJ178.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   22   ,   1378   , Name
					FROM    LOMRAN.AccAMJ178.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   22  ,   1378    , IdTafsilyGroup , Name , IdTafsilyType
		           FROM    LOMRAN.AccAMJ178.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1378	,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
							FROM LOMRAN.AccAMJ178.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,   1378   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM   LOMRAN.AccAMJ178.dbo.tblSanadDetail_MD


----=====================================================================================================================
----کانورت اسناد حسابداری   پسماند
---- سال های 1398  تا 1402
delete olden.tblGroup           where AreaId = 23
delete olden.tblKol             where AreaId = 23
delete olden.tblMoien           where AreaId = 23
delete olden.tblSal_MD          where AreaId = 23
delete olden.tblSanadKind       where AreaId = 23
delete olden.tblSanadState      where AreaId = 23
delete olden.tblTafsily         where AreaId = 23
delete olden.tblSanad_MD        where AreaId = 23
delete olden.tblSanadDetail_MD  where AreaId = 23
insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  23   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LPASMAND.AccAMJ198.dbo.tblGroup CROSS JOIN
										 LPASMAND.AccAMJ198.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (8,9,11,12))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    23  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LPASMAND.AccAMJ198.dbo.tblKol CROSS JOIN
									 LPASMAND.AccAMJ198.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (8,9,11,12))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  23   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LPASMAND.AccAMJ198.dbo.tblSal_MD CROSS JOIN
										 LPASMAND.AccAMJ198.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (8,9,11,12))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  23   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LPASMAND.AccAMJ198.dbo.tblSal_MD CROSS JOIN
									 LPASMAND.AccAMJ198.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (8,9,11,12))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   23   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LPASMAND.AccAMJ198.dbo.tblSal_MD CROSS JOIN
                         LPASMAND.AccAMJ198.dbo.tblSanadState
WHERE        (tblSal_MD.Id IN (8,9,11,12))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   23  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LPASMAND.AccAMJ198.dbo.tblSal_MD CROSS JOIN
                         LPASMAND.AccAMJ198.dbo.tblTafsily
WHERE        (tblSal_MD.Id IN (8,9,11,12))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 8  then 1398
								        when IdSal_MD = 9  then 1399
										when IdSal_MD = 11 then 1400
										when IdSal_MD = 12 then 1401
									                                end ,   23   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPASMAND.AccAMJ198.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                        , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  , 
						   											     case when IdSalSanad_MD = 8   then 1398
										                                      when IdSalSanad_MD = 9   then 1399
																			  when IdSalSanad_MD = 11  then 1400
																			  when IdSalSanad_MD = 12  then 1401
										                                                                       end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPASMAND.AccAMJ198.dbo.tblSanadDetail_MD

 ---- کانورت سال 1397 پسماند-----------------------------------------------------------------------------------
 insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id ,  IdRecognition , IdKind, 23   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LPASMAND.AccAMJ197.dbo.tblGroup CROSS JOIN
										 LPASMAND.AccAMJ197.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=7)

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    23  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LPASMAND.AccAMJ197.dbo.tblKol CROSS JOIN
									 LPASMAND.AccAMJ197.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=7)
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  23   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LPASMAND.AccAMJ197.dbo.tblSal_MD CROSS JOIN
										 LPASMAND.AccAMJ197.dbo.tblMoien
				WHERE        (tblSal_MD.Id=7)

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  23   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LPASMAND.AccAMJ197.dbo.tblSal_MD CROSS JOIN
									 LPASMAND.AccAMJ197.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id=7)					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   23   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LPASMAND.AccAMJ197.dbo.tblSal_MD CROSS JOIN
                         LPASMAND.AccAMJ197.dbo.tblSanadState
WHERE        (tblSal_MD.Id=7)
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   23  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LPASMAND.AccAMJ197.dbo.tblSal_MD CROSS JOIN
                         LPASMAND.AccAMJ197.dbo.tblTafsily
WHERE        (tblSal_MD.Id=7)

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1397   ,   23   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPASMAND.AccAMJ197.dbo.tblSanad_MD	
										where IdSal_MD =7

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1397   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPASMAND.AccAMJ197.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 7

---- کانورت سال 1396 پسماند-----------------------------------------------------------------------------------
 insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id ,  IdRecognition , IdKind,  23   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LPASMAND.AccAMJ196.dbo.tblGroup CROSS JOIN
										 LPASMAND.AccAMJ196.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=8)

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    23  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LPASMAND.AccAMJ196.dbo.tblKol CROSS JOIN
									 LPASMAND.AccAMJ196.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=8)
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  23   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LPASMAND.AccAMJ196.dbo.tblSal_MD CROSS JOIN
										 LPASMAND.AccAMJ196.dbo.tblMoien
				WHERE        (tblSal_MD.Id=8)

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  23   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LPASMAND.AccAMJ196.dbo.tblSal_MD CROSS JOIN
									 LPASMAND.AccAMJ196.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id=8)					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   23   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LPASMAND.AccAMJ196.dbo.tblSal_MD CROSS JOIN
                         LPASMAND.AccAMJ196.dbo.tblSanadState
WHERE        (tblSal_MD.Id=8)
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   23  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LPASMAND.AccAMJ196.dbo.tblSal_MD CROSS JOIN
                         LPASMAND.AccAMJ196.dbo.tblTafsily
WHERE        (tblSal_MD.Id=8)

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1397   ,   23   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LPASMAND.AccAMJ196.dbo.tblSanad_MD	
										where IdSal_MD =8

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1397   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPASMAND.AccAMJ196.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 8

---- کانورت سال 1395 پسماند-----------------------------------------------------------------------------------
 insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name )
				SELECT      Id , IdRecognition , IdKind,  23   ,    1395  , Name
				FROM            LPASMAND.AccAMJ195.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol(id , AreaId , YearName , IdGroup , Name )
	            SELECT   Id ,   23   ,   1395   , IdGroup , Name
FROM            LPASMAND.AccAMJ195.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien( Id , AreaId , YearName  ,IdKol , Name)
					SELECT  Id ,   23   ,   1395    ,IdKol , Name
					FROM            LPASMAND.AccAMJ195.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind( Id , AreaId , YearName  , Name)
						SELECT  Id ,   23   ,   1395    , Name
					FROM            LPASMAND.AccAMJ195.dbo.tblSanadKind				 

				
insert into olden.tblSanadState(Id , AreaId , YearName  , Name)
						SELECT  Id ,   23   ,   1395    , Name
						FROM            LPASMAND.AccAMJ195.dbo.tblSanadState
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName , IdTafsilyGroup , Name , IdTafsilyType)
					SELECT   Id , IdSotooh ,   23  ,  1395    , IdTafsilyGroup , Name , IdTafsilyType
						FROM            LPASMAND.AccAMJ195.dbo.tblTafsily

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
				SELECT        Id ,   1395   ,   23   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
				FROM            LPASMAND.AccAMJ195.dbo.tblSanad_MD
				WHERE        (IdSal_MD = 8)

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1397   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPASMAND.AccAMJ195.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 8

---- کانورت سال 1394 پسماند-----------------------------------------------------------------------------------
 insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name )
				SELECT      Id , IdRecognition , IdKind,  23   ,    1394  , Name
				FROM            LPASMAND.AccAMJ194.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol(id , AreaId , YearName , IdGroup , Name )
	            SELECT   Id ,   23   ,   1394   , IdGroup , Name
FROM            LPASMAND.AccAMJ194.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien( Id , AreaId , YearName  ,IdKol , Name)
					SELECT  Id ,   23   ,   1394    ,IdKol , Name
					FROM            LPASMAND.AccAMJ194.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind( Id , AreaId , YearName  , Name)
						SELECT  Id ,   23   ,   1394    , Name
					FROM            LPASMAND.AccAMJ194.dbo.tblSanadKind				 

				
insert into olden.tblSanadState(Id , AreaId , YearName  , Name)
						SELECT  Id ,   23   ,   1394    , Name
						FROM            LPASMAND.AccAMJ194.dbo.tblSanadState
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName , IdTafsilyGroup , Name , IdTafsilyType)
					SELECT   Id , IdSotooh ,   23  ,  1394    , IdTafsilyGroup , Name , IdTafsilyType
						FROM            LPASMAND.AccAMJ194.dbo.tblTafsily

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
				SELECT        Id ,   1394   ,   23   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
				FROM            LPASMAND.AccAMJ194.dbo.tblSanad_MD

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPASMAND.AccAMJ194.dbo.tblSanadDetail_MD

---- کانورت سال 1393 پسماند-----------------------------------------------------------------------------------
 insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name )
				SELECT      Id , IdRecognition , IdKind,  23   ,    1393  , Name
				FROM            LPASMAND.AccAMJ193.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol(id , AreaId , YearName , IdGroup , Name )
	            SELECT   Id ,   23   ,   1393   , IdGroup , Name
FROM            LPASMAND.AccAMJ193.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien( Id , AreaId , YearName  ,IdKol , Name)
					SELECT  Id ,   23   ,   1393    ,IdKol , Name
					FROM            LPASMAND.AccAMJ193.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind( Id , AreaId , YearName  , Name)
						SELECT  Id ,   23   ,   1393    , Name
					FROM            LPASMAND.AccAMJ193.dbo.tblSanadKind				 

				
insert into olden.tblSanadState(Id , AreaId , YearName  , Name)
						SELECT  Id ,   23   ,   1393    , Name
						FROM            LPASMAND.AccAMJ193.dbo.tblSanadState
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName , IdTafsilyGroup , Name , IdTafsilyType)
					SELECT   Id , IdSotooh ,   23  ,  1393    , IdTafsilyGroup , Name , IdTafsilyType
						FROM            LPASMAND.AccAMJ193.dbo.tblTafsily

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
				SELECT        Id ,   1393   ,   23   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
				FROM            LPASMAND.AccAMJ193.dbo.tblSanad_MD

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPASMAND.AccAMJ193.dbo.tblSanadDetail_MD

---- کانورت سال 1392 پسماند-----------------------------------------------------------------------------------
 insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name )
				SELECT      Id , IdRecognition , IdKind ,  23   ,    1392  , Name
				FROM            LPASMAND.AccAMJ192.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol(id , AreaId , YearName , IdGroup , Name )
	            SELECT   Id ,   23   ,   1392   , IdGroup , Name
FROM            LPASMAND.AccAMJ192.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien( Id , AreaId , YearName  ,IdKol , Name)
					SELECT  Id ,   23   ,   1392    ,IdKol , Name
					FROM            LPASMAND.AccAMJ192.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind( Id , AreaId , YearName  , Name)
						SELECT  Id ,   23   ,   1392    , Name
					FROM            LPASMAND.AccAMJ192.dbo.tblSanadKind				 

				
insert into olden.tblSanadState(Id , AreaId , YearName  , Name)
						SELECT  Id ,   23   ,   1392    , Name
						FROM            LPASMAND.AccAMJ192.dbo.tblSanadState
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName , IdTafsilyGroup , Name , IdTafsilyType)
					SELECT   Id , IdSotooh ,   23  ,  1392    , IdTafsilyGroup , Name , IdTafsilyType
						FROM            LPASMAND.AccAMJ192.dbo.tblTafsily

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
				SELECT        Id ,   1392   ,   23   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
				FROM            LPASMAND.AccAMJ192.dbo.tblSanad_MD


insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPASMAND.AccAMJ192.dbo.tblSanadDetail_MD


---- کانورت سال 1391 پسماند-----------------------------------------------------------------------------------
 insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name )
				SELECT      Id , IdRecognition , IdKind,  23   ,    1391  , Name
				FROM            LPASMAND.AccAMJ191.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol(id , AreaId , YearName , IdGroup , Name )
	            SELECT   Id ,   23   ,   1391   , IdGroup , Name
FROM            LPASMAND.AccAMJ191.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien( Id , AreaId , YearName  ,IdKol , Name)
					SELECT  Id ,   23   ,   1391    ,IdKol , Name
					FROM            LPASMAND.AccAMJ191.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind( Id , AreaId , YearName  , Name)
						SELECT  Id ,   23   ,   1391    , Name
					FROM            LPASMAND.AccAMJ191.dbo.tblSanadKind				 

				
insert into olden.tblSanadState(Id , AreaId , YearName  , Name)
						SELECT  Id ,   23   ,   1391    , Name
						FROM            LPASMAND.AccAMJ191.dbo.tblSanadState
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName , IdTafsilyGroup , Name , IdTafsilyType)
					SELECT   Id , IdSotooh ,   23  ,  1391    , IdTafsilyGroup , Name , IdTafsilyType
						FROM            LPASMAND.AccAMJ191.dbo.tblTafsily

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
				SELECT        Id ,   1391   ,   23   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
				FROM            LPASMAND.AccAMJ191.dbo.tblSanad_MD


insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPASMAND.AccAMJ191.dbo.tblSanadDetail_MD


---- کانورت سال 1390 پسماند-----------------------------------------------------------------------------------
 insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name )
				SELECT      Id , IdRecognition , IdKind,  23   ,    1390  , Name
				FROM            LPASMAND.AccAMJ190.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol(id , AreaId , YearName , IdGroup , Name )
	            SELECT   Id ,   23   ,   1390   , IdGroup , Name
FROM            LPASMAND.AccAMJ190.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien( Id , AreaId , YearName  ,IdKol , Name)
					SELECT  Id ,   23   ,   1390    ,IdKol , Name
					FROM            LPASMAND.AccAMJ190.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind( Id , AreaId , YearName  , Name)
						SELECT  Id ,   23   ,   1390    , Name
					FROM            LPASMAND.AccAMJ190.dbo.tblSanadKind				 

				
insert into olden.tblSanadState(Id , AreaId , YearName  , Name)
						SELECT  Id ,   23   ,   1390    , Name
						FROM            LPASMAND.AccAMJ190.dbo.tblSanadState
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName , IdTafsilyGroup , Name , IdTafsilyType)
					SELECT   Id , IdSotooh ,   23  ,  1390    , IdTafsilyGroup , Name , IdTafsilyType
						FROM            LPASMAND.AccAMJ190.dbo.tblTafsily

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
				SELECT        Id ,   1390   ,   23   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
				FROM            LPASMAND.AccAMJ190.dbo.tblSanad_MD


insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPASMAND.AccAMJ190.dbo.tblSanadDetail_MD


---- کانورت سال 1389 پسماند-----------------------------------------------------------------------------------
 insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name )
				SELECT      Id , IdRecognition , IdKind,  23   ,    1389  , Name
				FROM            LPASMAND.AccAMJ189.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol(id , AreaId , YearName , IdGroup , Name )
	            SELECT   Id ,   23   ,   1389   , IdGroup , Name
FROM            LPASMAND.AccAMJ189.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien( Id , AreaId , YearName  ,IdKol , Name)
					SELECT  Id ,   23   ,   1389    ,IdKol , Name
					FROM            LPASMAND.AccAMJ189.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind( Id , AreaId , YearName  , Name)
						SELECT  Id ,   23   ,   1389    , Name
					FROM            LPASMAND.AccAMJ189.dbo.tblSanadKind				 

				
insert into olden.tblSanadState(Id , AreaId , YearName  , Name)
						SELECT  Id ,   23   ,   1389    , Name
						FROM            LPASMAND.AccAMJ189.dbo.tblSanadState
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName , IdTafsilyGroup , Name , IdTafsilyType)
					SELECT   Id , IdSotooh ,   23  ,  1389    , IdTafsilyGroup , Name , IdTafsilyType
						FROM            LPASMAND.AccAMJ189.dbo.tblTafsily

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
				SELECT        Id ,   1389   ,   23   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
				FROM            LPASMAND.AccAMJ189.dbo.tblSanad_MD


insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPASMAND.AccAMJ189.dbo.tblSanadDetail_MD


---- کانورت سال 1388 پسماند-----------------------------------------------------------------------------------
 insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name )
				SELECT      Id , IdRecognition , IdKind,  23   ,    1388  , Name
				FROM            LPASMAND.AccAMJ188.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol(id , AreaId , YearName , IdGroup , Name )
	            SELECT   Id ,   23   ,   1388   , IdGroup , Name
FROM            LPASMAND.AccAMJ188.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien( Id , AreaId , YearName  ,IdKol , Name)
					SELECT  Id ,   23   ,   1388    ,IdKol , Name
					FROM            LPASMAND.AccAMJ188.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind( Id , AreaId , YearName  , Name)
						SELECT  Id ,   23   ,   1388    , Name
					FROM            LPASMAND.AccAMJ188.dbo.tblSanadKind				 

				
insert into olden.tblSanadState(Id , AreaId , YearName  , Name)
						SELECT  Id ,   23   ,   1388    , Name
						FROM            LPASMAND.AccAMJ188.dbo.tblSanadState
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName , IdTafsilyGroup , Name , IdTafsilyType)
					SELECT   Id , IdSotooh ,   23  ,  1388    , IdTafsilyGroup , Name , IdTafsilyType
						FROM            LPASMAND.AccAMJ188.dbo.tblTafsily

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
				SELECT        Id ,   1388   ,   23   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
				FROM            LPASMAND.AccAMJ188.dbo.tblSanad_MD

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1388   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LPASMAND.AccAMJ188.dbo.tblSanadDetail_MD
--**********************************************************************************************************************
----=====================================================================================================================
----کانورت اسناد حسابداری   میادین
---- سال های 1400  تا 1402
delete olden.tblGroup           where AreaId = 24
delete olden.tblKol             where AreaId = 24
delete olden.tblMoien           where AreaId = 24
delete olden.tblSal_MD          where AreaId = 24
delete olden.tblSanadKind       where AreaId = 24
delete olden.tblSanadState      where AreaId = 24
delete olden.tblTafsily         where AreaId = 24
delete olden.tblSanad_MD        where AreaId = 24
delete olden.tblSanadDetail_MD  where AreaId = 24

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LMAYADIN.AccAMJ.dbo.tblGroup CROSS JOIN
										 LMAYADIN.AccAMJ.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (10,11))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    24  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LMAYADIN.AccAMJ.dbo.tblKol CROSS JOIN
									 LMAYADIN.AccAMJ.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (10,11))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  24   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LMAYADIN.AccAMJ.dbo.tblSal_MD CROSS JOIN
										 LMAYADIN.AccAMJ.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (10,11))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  24   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LMAYADIN.AccAMJ.dbo.tblSal_MD CROSS JOIN
									 LMAYADIN.AccAMJ.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (10,11))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   24   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LMAYADIN.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ.dbo.tblSanadState
WHERE        (tblSal_MD.Id IN (10,11))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   24  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LMAYADIN.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ.dbo.tblTafsily
WHERE        (tblSal_MD.Id IN ( 10,11))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 10  then 1400
								        when IdSal_MD = 11  then 1401
										                            end ,   24   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMAYADIN.AccAMJ.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                        , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  , 
						   											     case when IdSalSanad_MD = 10  then 1400
																		      when IdSalSanad_MD = 11  then 1401 
																			                                   end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMAYADIN.AccAMJ.dbo.tblSanadDetail_MD

----کانورت 1399 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LMAYADIN.AccAMJ199.dbo.tblGroup CROSS JOIN
										 LMAYADIN.AccAMJ199.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    24  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LMAYADIN.AccAMJ199.dbo.tblKol CROSS JOIN
									 LMAYADIN.AccAMJ199.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  24   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LMAYADIN.AccAMJ199.dbo.tblSal_MD CROSS JOIN
										 LMAYADIN.AccAMJ199.dbo.tblMoien
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  24   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LMAYADIN.AccAMJ199.dbo.tblSal_MD CROSS JOIN
									 LMAYADIN.AccAMJ199.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id=11)					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   24   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LMAYADIN.AccAMJ199.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ199.dbo.tblSanadState
WHERE        (tblSal_MD.Id=11)
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   24  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LMAYADIN.AccAMJ199.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ199.dbo.tblTafsily
WHERE        (tblSal_MD.Id=11)

				
insert into olden.tblSanad_MD(Id , YearName  , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1399    ,   24   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMAYADIN.AccAMJ199.dbo.tblSanad_MD		
										where IdSal_MD = 11

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1399   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMAYADIN.AccAMJ199.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

----کانورت 1398 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LMAYADIN.AccAMJ198.dbo.tblGroup CROSS JOIN
										 LMAYADIN.AccAMJ198.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    24  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LMAYADIN.AccAMJ198.dbo.tblKol CROSS JOIN
									 LMAYADIN.AccAMJ198.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  24   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LMAYADIN.AccAMJ198.dbo.tblSal_MD CROSS JOIN
										 LMAYADIN.AccAMJ198.dbo.tblMoien
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  24   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LMAYADIN.AccAMJ198.dbo.tblSal_MD CROSS JOIN
									 LMAYADIN.AccAMJ198.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id=11)					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   24   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LMAYADIN.AccAMJ198.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ198.dbo.tblSanadState
WHERE        (tblSal_MD.Id=11)
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   24  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LMAYADIN.AccAMJ198.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ198.dbo.tblTafsily
WHERE        (tblSal_MD.Id=11)

				
insert into olden.tblSanad_MD(Id , YearName  , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1398    ,   24   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMAYADIN.AccAMJ198.dbo.tblSanad_MD		
										where IdSal_MD = 11

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1398   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMAYADIN.AccAMJ198.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

----کانورت 1397 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LMAYADIN.AccAMJ197.dbo.tblGroup CROSS JOIN
										 LMAYADIN.AccAMJ197.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    24  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LMAYADIN.AccAMJ197.dbo.tblKol CROSS JOIN
									 LMAYADIN.AccAMJ197.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  24   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LMAYADIN.AccAMJ197.dbo.tblSal_MD CROSS JOIN
										 LMAYADIN.AccAMJ197.dbo.tblMoien
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  24   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LMAYADIN.AccAMJ197.dbo.tblSal_MD CROSS JOIN
									 LMAYADIN.AccAMJ197.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id=11)					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   24   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LMAYADIN.AccAMJ197.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ197.dbo.tblSanadState
WHERE        (tblSal_MD.Id=11)
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   24  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LMAYADIN.AccAMJ197.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ197.dbo.tblTafsily
WHERE        (tblSal_MD.Id=11)

				
insert into olden.tblSanad_MD(Id , YearName  , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1397    ,   24   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMAYADIN.AccAMJ197.dbo.tblSanad_MD		
										where IdSal_MD = 11

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1397   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMAYADIN.AccAMJ197.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

----کانورت 1396 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LMAYADIN.AccAMJ196.dbo.tblGroup CROSS JOIN
										 LMAYADIN.AccAMJ196.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    24  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LMAYADIN.AccAMJ196.dbo.tblKol CROSS JOIN
									 LMAYADIN.AccAMJ196.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  24   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LMAYADIN.AccAMJ196.dbo.tblSal_MD CROSS JOIN
										 LMAYADIN.AccAMJ196.dbo.tblMoien
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  24   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LMAYADIN.AccAMJ196.dbo.tblSal_MD CROSS JOIN
									 LMAYADIN.AccAMJ196.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id=11)					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   24   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LMAYADIN.AccAMJ196.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ196.dbo.tblSanadState
WHERE        (tblSal_MD.Id=11)
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   24  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LMAYADIN.AccAMJ196.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ196.dbo.tblTafsily
WHERE        (tblSal_MD.Id=11)

				
insert into olden.tblSanad_MD(Id , YearName  , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1396    ,   24   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMAYADIN.AccAMJ196.dbo.tblSanad_MD		
										where IdSal_MD = 11

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1396   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMAYADIN.AccAMJ196.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

----کانورت 1395 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LMAYADIN.AccAMJ195.dbo.tblGroup CROSS JOIN
										 LMAYADIN.AccAMJ195.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    24  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LMAYADIN.AccAMJ195.dbo.tblKol CROSS JOIN
									 LMAYADIN.AccAMJ195.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  24   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LMAYADIN.AccAMJ195.dbo.tblSal_MD CROSS JOIN
										 LMAYADIN.AccAMJ195.dbo.tblMoien
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  24   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LMAYADIN.AccAMJ195.dbo.tblSal_MD CROSS JOIN
									 LMAYADIN.AccAMJ195.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id=11)					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   24   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LMAYADIN.AccAMJ195.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ195.dbo.tblSanadState
WHERE        (tblSal_MD.Id=11)
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   24  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LMAYADIN.AccAMJ195.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ195.dbo.tblTafsily
WHERE        (tblSal_MD.Id=11)

				
insert into olden.tblSanad_MD(Id , YearName  , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1395    ,   24   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMAYADIN.AccAMJ195.dbo.tblSanad_MD		
										where IdSal_MD = 11

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1395   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMAYADIN.AccAMJ195.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

----کانورت 1394 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LMAYADIN.AccAMJ194.dbo.tblGroup CROSS JOIN
										 LMAYADIN.AccAMJ194.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    24  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LMAYADIN.AccAMJ194.dbo.tblKol CROSS JOIN
									 LMAYADIN.AccAMJ194.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  24   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LMAYADIN.AccAMJ194.dbo.tblSal_MD CROSS JOIN
										 LMAYADIN.AccAMJ194.dbo.tblMoien
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  24   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LMAYADIN.AccAMJ194.dbo.tblSal_MD CROSS JOIN
									 LMAYADIN.AccAMJ194.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id=11)					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   24   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LMAYADIN.AccAMJ194.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ194.dbo.tblSanadState
WHERE        (tblSal_MD.Id=11)
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   24  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LMAYADIN.AccAMJ194.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ194.dbo.tblTafsily
WHERE        (tblSal_MD.Id=11)

				
insert into olden.tblSanad_MD(Id , YearName  , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1399    ,   24   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMAYADIN.AccAMJ194.dbo.tblSanad_MD		
										where IdSal_MD = 11

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1399   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMAYADIN.AccAMJ194.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

----کانورت 1393 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LMAYADIN.AccAMJ193.dbo.tblGroup CROSS JOIN
										 LMAYADIN.AccAMJ193.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    24  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LMAYADIN.AccAMJ193.dbo.tblKol CROSS JOIN
									 LMAYADIN.AccAMJ193.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  24   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LMAYADIN.AccAMJ193.dbo.tblSal_MD CROSS JOIN
										 LMAYADIN.AccAMJ193.dbo.tblMoien
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  24   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LMAYADIN.AccAMJ193.dbo.tblSal_MD CROSS JOIN
									 LMAYADIN.AccAMJ193.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id=11)					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   24   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LMAYADIN.AccAMJ193.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ193.dbo.tblSanadState
WHERE        (tblSal_MD.Id=11)
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   24  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LMAYADIN.AccAMJ193.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ193.dbo.tblTafsily
WHERE        (tblSal_MD.Id=11)

				
insert into olden.tblSanad_MD(Id , YearName  , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1393    ,   24   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMAYADIN.AccAMJ193.dbo.tblSanad_MD		
										where IdSal_MD = 11

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMAYADIN.AccAMJ193.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

----کانورت 1392 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LMAYADIN.AccAMJ192.dbo.tblGroup CROSS JOIN
										 LMAYADIN.AccAMJ192.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    24  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LMAYADIN.AccAMJ192.dbo.tblKol CROSS JOIN
									 LMAYADIN.AccAMJ192.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  24   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LMAYADIN.AccAMJ192.dbo.tblSal_MD CROSS JOIN
										 LMAYADIN.AccAMJ192.dbo.tblMoien
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  24   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LMAYADIN.AccAMJ192.dbo.tblSal_MD CROSS JOIN
									 LMAYADIN.AccAMJ192.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id=11)					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   24   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LMAYADIN.AccAMJ192.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ192.dbo.tblSanadState
WHERE        (tblSal_MD.Id=11)
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   24  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LMAYADIN.AccAMJ192.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ192.dbo.tblTafsily
WHERE        (tblSal_MD.Id=11)

				
insert into olden.tblSanad_MD(Id , YearName  , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1392    ,   24   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMAYADIN.AccAMJ192.dbo.tblSanad_MD		
										where IdSal_MD = 11

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1399   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMAYADIN.AccAMJ192.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

----کانورت 1391 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LMAYADIN.AccAMJ191.dbo.tblGroup CROSS JOIN
										 LMAYADIN.AccAMJ191.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    24  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LMAYADIN.AccAMJ191.dbo.tblKol CROSS JOIN
									 LMAYADIN.AccAMJ191.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  24   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LMAYADIN.AccAMJ191.dbo.tblSal_MD CROSS JOIN
										 LMAYADIN.AccAMJ191.dbo.tblMoien
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  24   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LMAYADIN.AccAMJ191.dbo.tblSal_MD CROSS JOIN
									 LMAYADIN.AccAMJ191.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id=11)					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   24   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LMAYADIN.AccAMJ191.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ191.dbo.tblSanadState
WHERE        (tblSal_MD.Id=11)
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   24  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LMAYADIN.AccAMJ191.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ191.dbo.tblTafsily
WHERE        (tblSal_MD.Id=11)

				
insert into olden.tblSanad_MD(Id , YearName  , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1391    ,   24   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMAYADIN.AccAMJ191.dbo.tblSanad_MD		
										where IdSal_MD = 11

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMAYADIN.AccAMJ191.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

----کانورت 1390 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LMAYADIN.AccAMJ190.dbo.tblGroup CROSS JOIN
										 LMAYADIN.AccAMJ190.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    24  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LMAYADIN.AccAMJ190.dbo.tblKol CROSS JOIN
									 LMAYADIN.AccAMJ190.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  24   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LMAYADIN.AccAMJ190.dbo.tblSal_MD CROSS JOIN
										 LMAYADIN.AccAMJ190.dbo.tblMoien
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  24   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LMAYADIN.AccAMJ190.dbo.tblSal_MD CROSS JOIN
									 LMAYADIN.AccAMJ190.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id=11)					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   24   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LMAYADIN.AccAMJ190.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ190.dbo.tblSanadState
WHERE        (tblSal_MD.Id=11)
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   24  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LMAYADIN.AccAMJ190.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ190.dbo.tblTafsily
WHERE        (tblSal_MD.Id=11)

				
insert into olden.tblSanad_MD(Id , YearName  , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1390    ,   24   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMAYADIN.AccAMJ190.dbo.tblSanad_MD		
										where IdSal_MD = 11

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMAYADIN.AccAMJ190.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

							 
----کانورت 1389 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LMAYADIN.AccAMJ189.dbo.tblGroup CROSS JOIN
										 LMAYADIN.AccAMJ189.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    24  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LMAYADIN.AccAMJ189.dbo.tblKol CROSS JOIN
									 LMAYADIN.AccAMJ189.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id=11)
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  24   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LMAYADIN.AccAMJ189.dbo.tblSal_MD CROSS JOIN
										 LMAYADIN.AccAMJ189.dbo.tblMoien
				WHERE        (tblSal_MD.Id=11)

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  24   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LMAYADIN.AccAMJ189.dbo.tblSal_MD CROSS JOIN
									 LMAYADIN.AccAMJ189.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id=11)					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   24   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LMAYADIN.AccAMJ189.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ189.dbo.tblSanadState
WHERE        (tblSal_MD.Id=11)
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   24  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LMAYADIN.AccAMJ189.dbo.tblSal_MD CROSS JOIN
                         LMAYADIN.AccAMJ189.dbo.tblTafsily
WHERE        (tblSal_MD.Id=11)

				
insert into olden.tblSanad_MD(Id , YearName  , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1389    ,   24   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMAYADIN.AccAMJ189.dbo.tblSanad_MD		
										where IdSal_MD = 11

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMAYADIN.AccAMJ189.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11


----=====================================================================================================================
----کانورت اسناد حسابداری   فرهنگی
---- سال های 1394  تا 1402
delete olden.tblGroup           where AreaId = 25
delete olden.tblKol             where AreaId = 25
delete olden.tblMoien           where AreaId = 25
delete olden.tblSal_MD          where AreaId = 25
delete olden.tblSanadKind       where AreaId = 25
delete olden.tblSanadState      where AreaId = 25
delete olden.tblTafsily         where AreaId = 25
delete olden.tblSanad_MD        where AreaId = 25
delete olden.tblSanadDetail_MD  where AreaId = 25
insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  25   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LSPORT.AccAMJ.dbo.tblGroup CROSS JOIN
										 LSPORT.AccAMJ.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (4,6,8,9,10,11,12,13))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    25  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LSPORT.AccAMJ.dbo.tblKol CROSS JOIN
									 LSPORT.AccAMJ.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (4,6,8,9,10,11,12,13))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  25   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LSPORT.AccAMJ.dbo.tblSal_MD CROSS JOIN
										 LSPORT.AccAMJ.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (4,6,8,9,10,11,12,13))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  25   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LSPORT.AccAMJ.dbo.tblSal_MD CROSS JOIN
									 LSPORT.AccAMJ.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (4,6,8,9,10,11,12,13))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   25   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LSPORT.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         LSPORT.AccAMJ.dbo.tblSanadState
WHERE        (tblSal_MD.Id IN (4,6,8,9,10,11,12,13))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   25  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LSPORT.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         LSPORT.AccAMJ.dbo.tblTafsily
WHERE        (tblSal_MD.Id IN (4,6,8,9,10,11,12,13))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 4   then 1394
										when IdSal_MD = 6   then 1395
										when IdSal_MD = 8   then 1396
										when IdSal_MD = 9   then 1397
										when IdSal_MD = 10  then 1398
										when IdSal_MD = 11  then 1399
										when IdSal_MD = 12  then 1400
										when IdSal_MD = 13  then 1401
										                           end ,   25   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LSPORT.AccAMJ.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                      , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    25  , 
						   											     case when IdSalSanad_MD = 4   then 1394
																			  when IdSalSanad_MD = 6   then 1395
																			  when IdSalSanad_MD = 8   then 1396
																			  when IdSalSanad_MD = 9   then 1397
																			  when IdSalSanad_MD = 10  then 1398
																			  when IdSalSanad_MD = 11  then 1399
																			  when IdSalSanad_MD = 12  then 1400
																			  when IdSalSanad_MD = 13  then 1401
																			                                  end , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LSPORT.AccAMJ.dbo.tblSanadDetail_MD

----=====================================================================================================================
----کانورت اسناد حسابداری   ریلی
---- سال های 1395  تا 1401
delete olden.tblGroup           where AreaId = 26
delete olden.tblKol             where AreaId = 26
delete olden.tblMoien           where AreaId = 26
delete olden.tblSal_MD          where AreaId = 26
delete olden.tblSanadKind       where AreaId = 26
delete olden.tblSanadState      where AreaId = 26
delete olden.tblTafsily         where AreaId = 26
delete olden.tblSanad_MD        where AreaId = 26
delete olden.tblSanadDetail_MD  where AreaId = 26
insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  26   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LMETRO.AccAMJ195.dbo.tblGroup CROSS JOIN
										 LMETRO.AccAMJ195.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (5,7,9,10,12,13,14))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    26  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LMETRO.AccAMJ195.dbo.tblKol CROSS JOIN
									 LMETRO.AccAMJ195.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (5,7,9,10,12,13,14))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  26   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LMETRO.AccAMJ195.dbo.tblSal_MD CROSS JOIN
										 LMETRO.AccAMJ195.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (5,7,9,10,12,13,14))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  26   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LMETRO.AccAMJ195.dbo.tblSal_MD CROSS JOIN
									 LMETRO.AccAMJ195.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (5,7,9,10,12,13,14))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   26   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LMETRO.AccAMJ195.dbo.tblSal_MD CROSS JOIN
                         LMETRO.AccAMJ195.dbo.tblSanadState
WHERE        (tblSal_MD.Id IN (5,7,9,10,12,13,14))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   26  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LMETRO.AccAMJ195.dbo.tblSal_MD CROSS JOIN
                         LMETRO.AccAMJ195.dbo.tblTafsily
WHERE        (tblSal_MD.Id IN (5,7,9,10,12,13,14))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 5   then 1395
										when IdSal_MD = 7   then 1396
										when IdSal_MD = 9   then 1397
										when IdSal_MD = 10  then 1398
										when IdSal_MD = 12  then 1399
										when IdSal_MD = 13  then 1400
										when IdSal_MD = 14  then 1401
										                           end ,   26   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMETRO.AccAMJ195.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                      , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    26  , 
						   											     case when IdSalSanad_MD = 5   then 1395
																			  when IdSalSanad_MD = 7   then 1396
																			  when IdSalSanad_MD = 9   then 1397
																			  when IdSalSanad_MD = 10  then 1398
																			  when IdSalSanad_MD = 12  then 1399
																			  when IdSalSanad_MD = 13  then 1400
																			  when IdSalSanad_MD = 14  then 1401
										                                                                       end , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMETRO.AccAMJ195.dbo.tblSanadDetail_MD

--کانورت 1394 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  26   ,   1394   , Name
              FROM            LMETRO.AccAMJ194.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   26   ,  1394   ,IdGroup , Name
	        FROM            LMETRO.AccAMJ194.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   26  ,   1394   ,IdKol ,Name
                  FROM            LMETRO.AccAMJ194.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   26   ,   1394  , Name
                       FROM            LMETRO.AccAMJ194.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   26   ,   1394   , Name
					FROM            LMETRO.AccAMJ194.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   26  ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LMETRO.AccAMJ194.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1394	,   26   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMETRO.AccAMJ194.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   26   ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMETRO.AccAMJ194.dbo.tblSanadDetail_MD

--کانورت 1393 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  26   ,   1393   , Name
              FROM            LMETRO.AccAMJ193.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   26   ,  1393   ,IdGroup , Name
	        FROM            LMETRO.AccAMJ193.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   26  ,   1393   ,IdKol ,Name
                  FROM            LMETRO.AccAMJ193.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   26   ,   1393  , Name
                       FROM            LMETRO.AccAMJ193.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   26   ,   1393   , Name
					FROM            LMETRO.AccAMJ193.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   26  ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LMETRO.AccAMJ193.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1393	,   26   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMETRO.AccAMJ193.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   26   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMETRO.AccAMJ193.dbo.tblSanadDetail_MD

--کانورت 1392 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  26   ,   1392   , Name
              FROM            LMETRO.AccAMJ192.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   26   ,  1392   ,IdGroup , Name
	        FROM            LMETRO.AccAMJ192.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   26  ,   1392   ,IdKol ,Name
                  FROM            LMETRO.AccAMJ192.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   26   ,   1392  , Name
                       FROM            LMETRO.AccAMJ192.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   26   ,   1392   , Name
					FROM            LMETRO.AccAMJ192.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   26  ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LMETRO.AccAMJ192.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1392	,   26   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMETRO.AccAMJ192.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   26   ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMETRO.AccAMJ192.dbo.tblSanadDetail_MD

--کانورت 1391 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  26   ,   1391   , Name
              FROM            LMETRO.AccAMJ191.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   26   ,  1391   ,IdGroup , Name
	        FROM            LMETRO.AccAMJ191.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   26  ,   1391   ,IdKol ,Name
                  FROM            LMETRO.AccAMJ191.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   26   ,   1391  , Name
                       FROM            LMETRO.AccAMJ191.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   26   ,   1391   , Name
					FROM            LMETRO.AccAMJ191.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   26  ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LMETRO.AccAMJ191.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1391	,   26   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMETRO.AccAMJ191.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   26   ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMETRO.AccAMJ191.dbo.tblSanadDetail_MD

--کانورت 1390 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  26   ,   1390   , Name
              FROM            LMETRO.AccAMJ190.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   26   ,  1390   ,IdGroup , Name
	        FROM            LMETRO.AccAMJ190.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   26  ,   1390   ,IdKol ,Name
                  FROM            LMETRO.AccAMJ190.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   26   ,   1390  , Name
                       FROM            LMETRO.AccAMJ190.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   26   ,   1390   , Name
					FROM            LMETRO.AccAMJ190.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   26  ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LMETRO.AccAMJ190.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1390	,   26   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMETRO.AccAMJ190.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   26   ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMETRO.AccAMJ190.dbo.tblSanadDetail_MD

--کانورت 1389 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  26   ,   1389   , Name
              FROM            LMETRO.AccAMJ189.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   26   ,  1389   ,IdGroup , Name
	        FROM            LMETRO.AccAMJ189.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   26  ,   1389   ,IdKol ,Name
                  FROM            LMETRO.AccAMJ189.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   26   ,   1389  , Name
                       FROM            LMETRO.AccAMJ189.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   26   ,   1389   , Name
					FROM            LMETRO.AccAMJ189.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   26  ,   1389    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LMETRO.AccAMJ189.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1389	,   26   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMETRO.AccAMJ189.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   26   ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMETRO.AccAMJ189.dbo.tblSanadDetail_MD

--کانورت 1388 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  26   ,   1388   , Name
              FROM            LMETRO.AccAMJ188.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   26   ,  1388   ,IdGroup , Name
	        FROM            LMETRO.AccAMJ188.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   26  ,   1388   ,IdKol ,Name
                  FROM            LMETRO.AccAMJ188.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   26   ,   1388  , Name
                       FROM            LMETRO.AccAMJ188.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   26   ,   1388   , Name
					FROM            LMETRO.AccAMJ188.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   26  ,   1388    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LMETRO.AccAMJ188.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1388	,   26   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMETRO.AccAMJ188.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   26   ,   1388   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMETRO.AccAMJ188.dbo.tblSanadDetail_MD

--کانورت 1387 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  26   ,   1387   , Name
              FROM            LMETRO.AccAMJ187.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   26   ,  1387   ,IdGroup , Name
	        FROM            LMETRO.AccAMJ187.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   26  ,   1387   ,IdKol ,Name
                  FROM            LMETRO.AccAMJ187.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   26   ,   1387  , Name
                       FROM            LMETRO.AccAMJ187.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   26   ,   1387   , Name
					FROM            LMETRO.AccAMJ187.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   26  ,   1387    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LMETRO.AccAMJ187.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1387	,   26   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMETRO.AccAMJ187.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   26   ,   1387   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMETRO.AccAMJ187.dbo.tblSanadDetail_MD

--کانورت 1386 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  26   ,   1386   , Name
              FROM            LMETRO.AccAMJ186.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   26   ,  1386   ,IdGroup , Name
	        FROM            LMETRO.AccAMJ186.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   26  ,   1386   ,IdKol ,Name
                  FROM            LMETRO.AccAMJ186.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   26   ,   1386  , Name
                       FROM            LMETRO.AccAMJ186.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   26   ,   1386   , Name
					FROM            LMETRO.AccAMJ186.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   26  ,   1386    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LMETRO.AccAMJ186.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1386	,   26   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMETRO.AccAMJ186.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   26   ,   1386   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMETRO.AccAMJ186.dbo.tblSanadDetail_MD

--کانورت 1385 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  26   ,   1385   , Name
              FROM            LMETRO.AccAMJ185.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   26   ,  1385   ,IdGroup , Name
	        FROM            LMETRO.AccAMJ185.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   26  ,   1385   ,IdKol ,Name
                  FROM            LMETRO.AccAMJ185.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   26   ,   1385  , Name
                       FROM            LMETRO.AccAMJ185.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   26   ,   1385   , Name
					FROM            LMETRO.AccAMJ185.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   26  ,   1385    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LMETRO.AccAMJ185.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1385	,   26   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMETRO.AccAMJ185.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   26   ,   1385   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMETRO.AccAMJ185.dbo.tblSanadDetail_MD

--کانورت 1384 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  26   ,   1384   , Name
              FROM            LMETRO.AccAMJ184.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   26   ,  1384   ,IdGroup , Name
	        FROM            LMETRO.AccAMJ184.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   26  ,   1384   ,IdKol ,Name
                  FROM            LMETRO.AccAMJ184.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   26   ,   1384  , Name
                       FROM            LMETRO.AccAMJ184.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   26   ,   1384   , Name
					FROM            LMETRO.AccAMJ184.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   26  ,   1384    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LMETRO.AccAMJ184.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1384	,   26   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMETRO.AccAMJ184.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   26   ,   1384   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMETRO.AccAMJ184.dbo.tblSanadDetail_MD

--کانورت 1383 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  26   ,   1383   , Name
              FROM            LMETRO.AccAMJ183.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   26   ,  1383   ,IdGroup , Name
	        FROM            LMETRO.AccAMJ183.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   26  ,   1383   ,IdKol ,Name
                  FROM            LMETRO.AccAMJ183.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   26   ,   1383  , Name
                       FROM            LMETRO.AccAMJ183.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   26   ,   1383   , Name
					FROM            LMETRO.AccAMJ183.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   26  ,   1383    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LMETRO.AccAMJ183.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1383	,   26   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMETRO.AccAMJ183.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   26   ,   1383   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMETRO.AccAMJ183.dbo.tblSanadDetail_MD

--کانورت 1382 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,  26   ,   1382   , Name
              FROM            LMETRO.AccAMJ182.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   26   ,  1382   ,IdGroup , Name
	        FROM            LMETRO.AccAMJ182.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   26  ,   1382   ,IdKol ,Name
                  FROM            LMETRO.AccAMJ182.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   26   ,   1382  , Name
                       FROM            LMETRO.AccAMJ182.dbo.tblSanadKind AS tblSanadKind_1				 

insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   26   ,   1382   , Name
					FROM            LMETRO.AccAMJ182.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   26  ,   1382    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LMETRO.AccAMJ182.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1382	,   26   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LMETRO.AccAMJ182.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   26   ,   1382   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            LMETRO.AccAMJ182.dbo.tblSanadDetail_MD



END
GO
