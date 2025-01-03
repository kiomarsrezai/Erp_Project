USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9900_Akh_TO_Olden_Then_Budget_YearsAgo1401_Main]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9900_Akh_TO_Olden_Then_Budget_YearsAgo1401_Main]
@areaId int
AS
BEGIN
if(@areaId = 1)
begin
delete olden.tblGroup           where AreaId = 1 and YearName<=1401
delete olden.tblKol             where AreaId = 1 and YearName<=1401
delete olden.tblMoien           where AreaId = 1 and YearName<=1401
delete olden.tblSanadKind       where AreaId = 1 and YearName<=1401
delete olden.tblSanadState      where AreaId = 1 and YearName<=1401
delete olden.tblTafsily         where AreaId = 1 and YearName<=1401
delete olden.tblSanad_MD        where AreaId = 1 and YearName<=1401
delete olden.tblSanadDetail_MD  where AreaId = 1 and YearName<=1401

insert into olden.tblGroup(        id    , IdRecognition , IdKind, AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,   1    ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            AKH.AccAMJ1001.dbo.tblGroup CROSS JOIN
										 AKH.AccAMJ1001.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (9,11,13,17,18))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    1   , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            AKH.AccAMJ1001.dbo.tblKol CROSS JOIN
									 AKH.AccAMJ1001.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (9,11,13,17,18))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,   1   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            AKH.AccAMJ1001.dbo.tblSal_MD CROSS JOIN
										 AKH.AccAMJ1001.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (9,11,13,17,18))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,   1   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            AKH.AccAMJ1001.dbo.tblSal_MD CROSS JOIN
									 AKH.AccAMJ1001.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (9,11,13,17,18))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,    1   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
						FROM            AKH.AccAMJ1001.dbo.tblSal_MD CROSS JOIN
												 AKH.AccAMJ1001.dbo.tblSanadState
						WHERE        (tblSal_MD.Id IN (9,11,13,17,18))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   1  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
							FROM            AKH.AccAMJ1001.dbo.tblSal_MD CROSS JOIN
													 AKH.AccAMJ1001.dbo.tblTafsily
							WHERE        (tblSal_MD.Id IN (9,11,13,17,18))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 9  then 1397
										when IdSal_MD = 11 then 1398
										when IdSal_MD = 13 then 1399
										when IdSal_MD = 17 then 1400
										when IdSal_MD = 18 then 1401
										end ,   1   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ1001.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName              , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    1  , 
						   											case when IdSalSanad_MD = 9  then 1397
																		 when IdSalSanad_MD = 11 then 1398
																		 when IdSalSanad_MD = 13 then 1399
                                                                         when IdSalSanad_MD = 17 then 1400
																		 when IdSalSanad_MD = 18 then 1401
																		 end   ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ1001.dbo.tblSanadDetail_MD

------کانورت 1396 منطقه 01
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  1   ,   1396   , Name
FROM            AKH.AccAMJ9601.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   1   ,  1396   ,IdGroup , Name
	FROM            AKH.AccAMJ9601.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   1  ,   1396   ,IdKol ,Name
             FROM            AKH.AccAMJ9601.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 1     ,   1396  , Name
FROM            AKH.AccAMJ9601.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   1   ,   1396   , Name
					FROM            AKH.AccAMJ9601.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   1   ,   1396    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9601.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id ,YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1396	,   1    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9601.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD ,  1   ,   1396    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9601.dbo.tblSanadDetail_MD


------کانورت 1395 منطقه 01
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  1   ,   1395   , Name
FROM            AKH.AccAMJ9501.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   1   ,  1395   ,IdGroup , Name
	FROM            AKH.AccAMJ9501.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   1  ,   1395   ,IdKol ,Name
             FROM            AKH.AccAMJ9501.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 1     ,   1395  , Name
FROM            AKH.AccAMJ9501.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   1   ,   1395   , Name
					FROM            AKH.AccAMJ9501.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   1   ,   1395    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9501.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1395	,   1    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9501.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   1   ,   1395    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9501.dbo.tblSanadDetail_MD


------کانورت 1394 منطقه 01
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  1   ,   1394   , Name
FROM            AKH.AccAMJ9401.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   1   ,  1394   ,IdGroup , Name
	FROM            AKH.AccAMJ9401.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   1  ,   1394   ,IdKol ,Name
             FROM            AKH.AccAMJ9401.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 1     ,   1394  , Name
FROM            AKH.AccAMJ9401.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   1   ,   1394   , Name
					FROM            AKH.AccAMJ9401.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   1   ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9401.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1394	,   1    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9401.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   1   ,   1394    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9401.dbo.tblSanadDetail_MD

------کانورت 1393 منطقه 01
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  1   ,   1393   , Name
FROM            AKH.AccAMJ9301.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   1   ,  1393   ,IdGroup , Name
	FROM            AKH.AccAMJ9301.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   1  ,   1393   ,IdKol ,Name
             FROM            AKH.AccAMJ9301.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 1     ,   1393  , Name
FROM            AKH.AccAMJ9301.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   1   ,   1393   , Name
					FROM            AKH.AccAMJ9301.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   1   ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9301.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1393	,   1    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
						FROM AKH.AccAMJ9301.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   1   ,   1393    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9301.dbo.tblSanadDetail_MD

------کانورت 1392 منطقه 01
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  1   ,   1392   , Name
FROM            AKH.AccAMJ9201.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   1   ,  1392   ,IdGroup , Name
	FROM            AKH.AccAMJ9201.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   1  ,   1392   ,IdKol ,Name
             FROM            AKH.AccAMJ9201.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 1     ,   1392  , Name
FROM            AKH.AccAMJ9201.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   1   ,   1392   , Name
					FROM            AKH.AccAMJ9201.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   1   ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9201.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1392	,   1    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9201.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   1   ,   1392    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9201.dbo.tblSanadDetail_MD


------کانورت 1391 منطقه 01
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  1   ,   1391   , Name
FROM            AKH.AccAMJ9101.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   1   ,  1391   ,IdGroup , Name
	FROM            AKH.AccAMJ9101.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   1  ,   1391   ,IdKol ,Name
             FROM            AKH.AccAMJ9101.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 1     ,   1391  , Name
FROM            AKH.AccAMJ9101.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   1   ,   1391   , Name
					FROM            AKH.AccAMJ9101.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   1   ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9101.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1391	,   1    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9101.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   1   ,   1391    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9101.dbo.tblSanadDetail_MD

------کانورت 1390 منطقه 01
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  1   ,   1390   , Name
FROM            AKH.AccAMJ9001.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   1   ,  1390   ,IdGroup , Name
	FROM            AKH.AccAMJ9001.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   1  ,   1390   ,IdKol ,Name
             FROM            AKH.AccAMJ9001.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 1     ,   1390  , Name
FROM            AKH.AccAMJ9001.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   1   ,   1390   , Name
					FROM            AKH.AccAMJ9001.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   1   ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9001.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1390	,   1    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9001.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   1   ,   1390    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9001.dbo.tblSanadDetail_MD

------کانورت 1389 منطقه 01
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  1   ,   1389   , Name
FROM            AKH.AccAMJ8901.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   1   ,  1389   ,IdGroup , Name
	FROM            AKH.AccAMJ8901.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   1  ,   1389   ,IdKol ,Name
             FROM            AKH.AccAMJ8901.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 1     ,   1389  , Name
FROM            AKH.AccAMJ8901.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   1   ,   1389   , Name
					FROM            AKH.AccAMJ8901.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   1   ,   1389    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8901.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1389	,   1    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8901.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   1   ,   1389    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8901.dbo.tblSanadDetail_MD


------کانورت 1388 منطقه 01
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  1   ,   1388   , Name
FROM            AKH.AccAMJ8801.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   1   ,  1388   ,IdGroup , Name
	FROM            AKH.AccAMJ8801.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   1  ,   1388   ,IdKol ,Name
             FROM            AKH.AccAMJ8801.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    1   ,  1388   , Name
FROM            AKH.AccAMJ8801.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   1   ,   1388   , Name
					FROM            AKH.AccAMJ8801.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   1   ,   1388    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8801.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1388	,   1    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8801.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   1   ,   1388    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8801.dbo.tblSanadDetail_MD


------کانورت 1387 منطقه 01
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  1   ,   1387   , Name
FROM            AKH.AccAMJ8701.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   1   ,  1387   ,IdGroup , Name
	FROM            AKH.AccAMJ8701.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   1  ,   1387   ,IdKol ,Name
             FROM            AKH.AccAMJ8701.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 1     ,   1387  , Name
FROM            AKH.AccAMJ8701.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   1   ,   1387   , Name
					FROM            AKH.AccAMJ8701.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   1   ,   1387    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8701.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1387	,   1    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8701.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   1   ,   1387    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8701.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 1 and YearName <= 1401 and id in (4,7)

update olden.tblGroup
  set  id = 999
  Where AreaId = 1 and YearName <= 1401 and id in (5, 8)

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 1 and YearName <= 1401 and IdGroup in (4,7)

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 1 and YearName <= 1401 and IdGroup in (5, 8)
return
end
--****************************************************************************
--****************************************************************************
--****************************************************************************
if(@areaId = 2)
begin
delete olden.tblGroup           where AreaId = 2 and YearName <=1401
delete olden.tblKol             where AreaId = 2 and YearName <=1401
delete olden.tblMoien           where AreaId = 2 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 2 and YearName <=1401
delete olden.tblSanadState      where AreaId = 2 and YearName <=1401
delete olden.tblTafsily         where AreaId = 2 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 2 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 2 and YearName <=1401

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  2   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            AKH.AccAMJ1002.dbo.tblGroup CROSS JOIN
										 AKH.AccAMJ1002.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (9,12,17,20,21))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    2  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            AKH.AccAMJ1002.dbo.tblKol CROSS JOIN
									 AKH.AccAMJ1002.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (9,12,17,20,21))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  2   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            AKH.AccAMJ1002.dbo.tblSal_MD CROSS JOIN
										 AKH.AccAMJ1002.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (9,12,17,20,21))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  2   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            AKH.AccAMJ1002.dbo.tblSal_MD CROSS JOIN
									 AKH.AccAMJ1002.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (9,12,17,20,21))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   2   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
						FROM            AKH.AccAMJ1002.dbo.tblSal_MD CROSS JOIN
												 AKH.AccAMJ1002.dbo.tblSanadState
						WHERE        (tblSal_MD.Id IN (9,12,17,20,21))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   2  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
							FROM            AKH.AccAMJ1002.dbo.tblSal_MD CROSS JOIN
													 AKH.AccAMJ1002.dbo.tblTafsily
							WHERE        (tblSal_MD.Id IN (9,12,17,20,21))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 9  then 1397
										when IdSal_MD = 12 then 1398
										when IdSal_MD = 17 then 1399
										when IdSal_MD = 20 then 1400
										when IdSal_MD = 21 then 1401
										end ,   2   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ1002.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    2  , 
						   											case when IdSalSanad_MD = 9  then 1397
																		 when IdSalSanad_MD = 12 then 1398
																		 when IdSalSanad_MD = 17 then 1399
																		 when IdSalSanad_MD = 20 then 1400
																		 when IdSalSanad_MD = 21 then 1401
																		 end   ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ1002.dbo.tblSanadDetail_MD

------کانورت 1396 منطقه 02
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,   2   ,   1396   , Name
FROM            AKH.AccAMJ9602.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,    2   ,  1396   ,IdGroup , Name
	FROM            AKH.AccAMJ9602.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,    2  ,   1396   ,IdKol ,Name
             FROM            AKH.AccAMJ9602.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,  2     ,   1396  , Name
FROM            AKH.AccAMJ9602.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,    2   ,   1396   , Name
					FROM            AKH.AccAMJ9602.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   2   ,   1396    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9602.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1396	,   2    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9602.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,    2   ,   1396    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9602.dbo.tblSanadDetail_MD


------کانورت 1395 منطقه 02
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  2   ,    1395   , Name
FROM            AKH.AccAMJ9502.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   2   ,   1395   ,IdGroup , Name
	FROM            AKH.AccAMJ9502.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   2  ,    1395   ,IdKol ,Name
             FROM            AKH.AccAMJ9502.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 2     ,    1395  , Name
FROM            AKH.AccAMJ9502.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   2   ,    1395   , Name
					FROM            AKH.AccAMJ9502.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   2   ,   1395    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9502.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1395	,   2    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9502.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   2   ,   1395    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9502.dbo.tblSanadDetail_MD


------کانورت 1394 منطقه 02
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind, 2   ,   1394   , Name
FROM            AKH.AccAMJ9402.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   2   ,  1394   ,IdGroup , Name
	FROM            AKH.AccAMJ9402.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   2  ,   1394   ,IdKol ,Name
             FROM            AKH.AccAMJ9402.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 2     ,   1394  , Name
FROM            AKH.AccAMJ9402.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   2   ,   1394   , Name
					FROM            AKH.AccAMJ9402.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   2   ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9402.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1394	,   2    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9402.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   2   ,   1394    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9402.dbo.tblSanadDetail_MD

------کانورت 1393 منطقه 02
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  2   ,   1393   , Name
FROM            AKH.AccAMJ9302.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   2   ,  1393   ,IdGroup , Name
	FROM            AKH.AccAMJ9302.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   2  ,   1393   ,IdKol ,Name
             FROM            AKH.AccAMJ9302.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 2     ,   1393  , Name
FROM            AKH.AccAMJ9302.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   2   ,   1393   , Name
					FROM            AKH.AccAMJ9302.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   2   ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9302.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1393	,   2    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
						FROM AKH.AccAMJ9302.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   2   ,   1393    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9302.dbo.tblSanadDetail_MD

------کانورت 1392 منطقه 02
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  2   ,   1392   , Name
FROM            AKH.AccAMJ9202.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   2   ,  1392   ,IdGroup , Name
	FROM            AKH.AccAMJ9202.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   2  ,   1392   ,IdKol ,Name
             FROM            AKH.AccAMJ9202.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 2     ,   1392  , Name
FROM            AKH.AccAMJ9202.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   2   ,   1392   , Name
					FROM            AKH.AccAMJ9202.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   2   ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9202.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1392	,   2    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9202.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   2   ,   1392    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9202.dbo.tblSanadDetail_MD


------کانورت 1391 منطقه 02
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  2   ,   1391   , Name
FROM            AKH.AccAMJ9102.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   2   ,  1391   ,IdGroup , Name
	FROM            AKH.AccAMJ9102.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   2  ,   1391   ,IdKol ,Name
             FROM            AKH.AccAMJ9102.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 2     ,   1391  , Name
FROM            AKH.AccAMJ9102.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   2   ,   1391   , Name
					FROM            AKH.AccAMJ9102.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   2   ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9102.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1391	,   2    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9102.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   2   ,   1391    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9102.dbo.tblSanadDetail_MD

------کانورت 1390 منطقه 02
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  2   ,   1390   , Name
FROM            AKH.AccAMJ9002.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   2   ,  1390   ,IdGroup , Name
	FROM            AKH.AccAMJ9002.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   2  ,   1390   ,IdKol ,Name
             FROM            AKH.AccAMJ9002.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    2   ,   1390  , Name
FROM            AKH.AccAMJ9002.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   2   ,   1390   , Name
					FROM            AKH.AccAMJ9002.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   2   ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9002.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1390	,   2    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9002.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   2   ,   1390    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9002.dbo.tblSanadDetail_MD

------کانورت 1389 منطقه 02
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  2   ,   1389   , Name
FROM            AKH.AccAMJ8902.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   2   ,  1389   ,IdGroup , Name
	FROM            AKH.AccAMJ8902.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   2   ,   1389   ,IdKol ,Name
             FROM            AKH.AccAMJ8902.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    2   ,   1389  , Name
FROM            AKH.AccAMJ8902.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   2   ,   1389   , Name
					FROM            AKH.AccAMJ8902.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   2   ,   1389    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8902.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1389	,   2    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8902.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   2   ,   1389    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8902.dbo.tblSanadDetail_MD


------کانورت 1388 منطقه 02
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  2   ,   1388   , Name
FROM            AKH.AccAMJ8802.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   2   ,  1388   ,IdGroup , Name
	FROM            AKH.AccAMJ8802.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   2  ,   1388   ,IdKol ,Name
             FROM            AKH.AccAMJ8802.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    2   ,  1388   , Name
FROM            AKH.AccAMJ8802.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   2   ,   1388   , Name
					FROM            AKH.AccAMJ8802.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   2   ,   1388    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8802.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1388	,   2    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8802.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   2   ,   1388    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8802.dbo.tblSanadDetail_MD


------کانورت 1387 منطقه 02
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  2   ,   1387   , Name
FROM            AKH.AccAMJ8702.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   2   ,  1387   ,IdGroup , Name
	FROM            AKH.AccAMJ8702.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   2  ,   1387   ,IdKol ,Name
             FROM            AKH.AccAMJ8702.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    2   ,   1387  , Name
FROM            AKH.AccAMJ8702.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   2    ,   1387   , Name
					FROM            AKH.AccAMJ8702.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   2   ,   1387    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8702.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1387	,   2    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8702.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   2   ,   1387    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8702.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 2 and YearName <= 1401 and id in (4,7)

update olden.tblGroup
  set  id = 999
  Where AreaId = 2 and YearName <= 1401 and id in (5, 8)

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 2 and YearName <= 1401 and IdGroup in (4,7)

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 2 and YearName <= 1401 and IdGroup in (5, 8)
return
end
--*********************************************************************
--*********************************************************************
--*********************************************************************
if(@areaId = 3)
begin
delete olden.tblGroup           where AreaId = 3 and YearName <=1401
delete olden.tblKol             where AreaId = 3 and YearName <=1401
delete olden.tblMoien           where AreaId = 3 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 3 and YearName <=1401
delete olden.tblSanadState      where AreaId = 3 and YearName <=1401
delete olden.tblTafsily         where AreaId = 3 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 3 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 3 and YearName <=1401

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  3   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            AKH.AccAMJ1003.dbo.tblGroup CROSS JOIN
										 AKH.AccAMJ1003.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (8,9,11,17,18))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    3  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            AKH.AccAMJ1003.dbo.tblKol CROSS JOIN
									 AKH.AccAMJ1003.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (8,9,11,17,18))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  3    ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            AKH.AccAMJ1003.dbo.tblSal_MD CROSS JOIN
										 AKH.AccAMJ1003.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (8,9,11,17,18))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  3   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            AKH.AccAMJ1003.dbo.tblSal_MD CROSS JOIN
									 AKH.AccAMJ1003.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (8,9,11,17,18))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   3   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
						FROM            AKH.AccAMJ1003.dbo.tblSal_MD CROSS JOIN
												 AKH.AccAMJ1003.dbo.tblSanadState
						WHERE        (tblSal_MD.Id IN (8,9,11,17,18))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   3   ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
							FROM            AKH.AccAMJ1003.dbo.tblSal_MD CROSS JOIN
													 AKH.AccAMJ1003.dbo.tblTafsily
							WHERE        (tblSal_MD.Id IN (8,9,11,17,18))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 8  then 1397
										when IdSal_MD = 9 then 1398
										when IdSal_MD = 11 then 1399
										when IdSal_MD = 17 then 1400
										when IdSal_MD = 18 then 1401
										end ,   3   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ1003.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    3   , 
						   											case when IdSalSanad_MD = 8  then 1397
																		 when IdSalSanad_MD = 9  then 1398
																		 when IdSalSanad_MD = 11 then 1399
																		 when IdSalSanad_MD = 17 then 1400
																		 when IdSalSanad_MD = 18 then 1401
																		 end   ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ1003.dbo.tblSanadDetail_MD

------کانورت 1396 منطقه 03
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  3    ,   1396   , Name
FROM            AKH.AccAMJ9603.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   3    ,  1396   ,IdGroup , Name
	FROM            AKH.AccAMJ9603.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   3  ,   1396   ,IdKol ,Name
             FROM            AKH.AccAMJ9603.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,  3     ,   1396  , Name
FROM            AKH.AccAMJ9603.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,    3   ,   1396   , Name
					FROM            AKH.AccAMJ9603.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   3   ,   1396    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9603.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1396	,   3    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9603.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   3   ,   1396    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9603.dbo.tblSanadDetail_MD


------کانورت 1395 منطقه 03
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  3   ,   1395   , Name
FROM            AKH.AccAMJ9503.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   3   ,  1395   ,IdGroup , Name
	FROM            AKH.AccAMJ9503.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   3  ,   1395   ,IdKol ,Name
             FROM            AKH.AccAMJ9503.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,  3     ,   1395  , Name
FROM            AKH.AccAMJ9503.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   3   ,   1395   , Name
					FROM            AKH.AccAMJ9503.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   3   ,   1395    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9503.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1395	,   3    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9503.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   3    ,   1395    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9503.dbo.tblSanadDetail_MD


------کانورت 1394 منطقه 02
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  3   ,   1394   , Name
FROM            AKH.AccAMJ9403.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   3    ,  1394   ,IdGroup , Name
	FROM            AKH.AccAMJ9403.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   3   ,   1394   ,IdKol ,Name
             FROM            AKH.AccAMJ9403.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,  3     ,   1394  , Name
FROM            AKH.AccAMJ9403.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,    3   ,   1394   , Name
					FROM            AKH.AccAMJ9403.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   3   ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9403.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1394	,   3    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9403.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   3    ,   1394    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9403.dbo.tblSanadDetail_MD

------کانورت 1393 منطقه 03
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  3    ,   1393   , Name
FROM            AKH.AccAMJ9303.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   3    ,  1393   ,IdGroup , Name
	FROM            AKH.AccAMJ9303.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   3   ,   1393   ,IdKol ,Name
             FROM            AKH.AccAMJ9303.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,  3     ,   1393  , Name
FROM            AKH.AccAMJ9303.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,    3   ,   1393   , Name
					FROM            AKH.AccAMJ9303.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   3   ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9303.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1393	,    3   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
						FROM AKH.AccAMJ9303.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   3    ,   1393    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9303.dbo.tblSanadDetail_MD

------کانورت 1392 منطقه 03
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  3    ,   1392   , Name
FROM            AKH.AccAMJ9203.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   3    ,  1392   ,IdGroup , Name
	FROM            AKH.AccAMJ9203.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   3   ,   1392   ,IdKol ,Name
             FROM            AKH.AccAMJ9203.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,  3     ,   1392  , Name
FROM            AKH.AccAMJ9203.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   3   ,   1392   , Name
					FROM            AKH.AccAMJ9203.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   3   ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9203.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1392	,   3    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9203.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   3   ,   1392    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9203.dbo.tblSanadDetail_MD


------کانورت 1391 منطقه 03
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  3   ,   1391   , Name
FROM            AKH.AccAMJ9103.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   3   ,  1391   ,IdGroup , Name
	FROM            AKH.AccAMJ9103.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   3  ,   1391   ,IdKol ,Name
             FROM            AKH.AccAMJ9103.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,  3     ,   1391  , Name
FROM            AKH.AccAMJ9103.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,    3   ,   1391   , Name
					FROM            AKH.AccAMJ9103.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   3   ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9103.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1391	,   3    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9103.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   3   ,   1391    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9103.dbo.tblSanadDetail_MD

------کانورت 1390 منطقه 03
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  3   ,   1390   , Name
FROM            AKH.AccAMJ9003.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   3   ,  1390   ,IdGroup , Name
	FROM            AKH.AccAMJ9003.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   3   ,   1390   ,IdKol ,Name
             FROM            AKH.AccAMJ9003.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    3   ,   1390  , Name
FROM            AKH.AccAMJ9003.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   3   ,   1390   , Name
					FROM            AKH.AccAMJ9003.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   3   ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9003.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1390	,   3    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9003.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   3   ,   1390    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9003.dbo.tblSanadDetail_MD

------کانورت 1389 منطقه 02
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  3   ,   1389   , Name
FROM            AKH.AccAMJ8903.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   3   ,  1389   ,IdGroup , Name
	FROM            AKH.AccAMJ8903.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   3   ,   1389   ,IdKol ,Name
             FROM            AKH.AccAMJ8903.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    3   ,   1389  , Name
FROM            AKH.AccAMJ8903.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   3   ,   1389   , Name
					FROM            AKH.AccAMJ8903.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   3   ,   1389    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8903.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1389	,   3    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8903.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   3   ,   1389    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8903.dbo.tblSanadDetail_MD


------کانورت 1388 منطقه 03
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  3   ,   1388   , Name
FROM            AKH.AccAMJ8803.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   3   ,  1388   ,IdGroup , Name
	FROM            AKH.AccAMJ8803.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   3  ,   1388   ,IdKol ,Name
             FROM            AKH.AccAMJ8803.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    3   ,  1388   , Name
FROM            AKH.AccAMJ8803.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   3   ,   1388   , Name
					FROM            AKH.AccAMJ8803.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   3   ,   1388    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8803.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1388	,   3    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8803.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   3   ,   1388    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8803.dbo.tblSanadDetail_MD


------کانورت 1387 منطقه 03
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  3    ,   1387   , Name
FROM            AKH.AccAMJ8703.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   3    ,  1387   ,IdGroup , Name
	FROM            AKH.AccAMJ8703.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   3   ,   1387   ,IdKol ,Name
             FROM            AKH.AccAMJ8703.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    3   ,   1387  , Name
FROM            AKH.AccAMJ8703.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   3    ,   1387   , Name
					FROM            AKH.AccAMJ8703.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   3   ,   1387    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8703.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1387	,   3    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8703.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   3   ,   1387    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8703.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 3 and YearName <= 1401 and id in (4,7)

update olden.tblGroup
  set  id = 999
  Where AreaId = 3 and YearName <= 1401 and id in (5, 8)

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 3 and YearName <= 1401 and IdGroup in (4,7)

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 3 and YearName <= 1401 and IdGroup in (5, 8)
return
end
--******************************************************************
--******************************************************************
--******************************************************************
if(@areaId = 4)
begin
delete olden.tblGroup           where AreaId = 4 and YearName <=1401
delete olden.tblKol             where AreaId = 4 and YearName <=1401
delete olden.tblMoien           where AreaId = 4 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 4 and YearName <=1401
delete olden.tblSanadState      where AreaId = 4 and YearName <=1401
delete olden.tblTafsily         where AreaId = 4 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 4 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 4 and YearName <=1401

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,   4   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            AKH.AccAMJ1004.dbo.tblGroup CROSS JOIN
										 AKH.AccAMJ1004.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (8,13,14,15,16))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    4   , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            AKH.AccAMJ1004.dbo.tblKol CROSS JOIN
									 AKH.AccAMJ1004.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (8,13,14,15,16))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  4   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            AKH.AccAMJ1004.dbo.tblSal_MD CROSS JOIN
										 AKH.AccAMJ1004.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (8,13,14,15,16))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,   4   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            AKH.AccAMJ1004.dbo.tblSal_MD CROSS JOIN
									 AKH.AccAMJ1004.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (8,13,14,15,16))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,    4   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
						FROM            AKH.AccAMJ1004.dbo.tblSal_MD CROSS JOIN
												 AKH.AccAMJ1004.dbo.tblSanadState
						WHERE        (tblSal_MD.Id IN (8,13,14,15,16))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   4   ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
							FROM            AKH.AccAMJ1004.dbo.tblSal_MD CROSS JOIN
													 AKH.AccAMJ1004.dbo.tblTafsily
							WHERE        (tblSal_MD.Id IN (8,13,14,15,16))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 8  then 1397
										when IdSal_MD = 13 then 1398
										when IdSal_MD = 14 then 1399
										when IdSal_MD = 15 then 1400
										when IdSal_MD = 16 then 1401
										end ,   4   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ1004.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    4  , 
						   											case when IdSalSanad_MD = 8  then 1397
																		 when IdSalSanad_MD = 13 then 1398
																		 when IdSalSanad_MD = 14 then 1399
																		 when IdSalSanad_MD = 15 then 1400
																		 when IdSalSanad_MD = 16 then 1401
																		 end   ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ1004.dbo.tblSanadDetail_MD

------کانورت 1396 منطقه 04
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  4   ,   1396   , Name
FROM            AKH.AccAMJ9604.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   4   ,  1396   ,IdGroup , Name
	FROM            AKH.AccAMJ9604.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   4  ,   1396   ,IdKol ,Name
             FROM            AKH.AccAMJ9604.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,  4     ,   1396  , Name
FROM            AKH.AccAMJ9604.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,    4   ,   1396   , Name
					FROM            AKH.AccAMJ9604.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   4   ,   1396    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9604.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1396	,   4    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9604.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   4   ,   1396    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9604.dbo.tblSanadDetail_MD


------کانورت 1395 منطقه 04
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  4    ,   1395   , Name
FROM            AKH.AccAMJ9504.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   4    ,  1395   ,IdGroup , Name
	FROM            AKH.AccAMJ9504.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   4   ,   1395   ,IdKol ,Name
             FROM            AKH.AccAMJ9504.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   4    ,   1395  , Name
FROM            AKH.AccAMJ9504.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   4    ,   1395   , Name
					FROM            AKH.AccAMJ9504.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   4   ,   1395    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9504.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1395	,   4    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9504.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName  , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   4    ,   1395    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9504.dbo.tblSanadDetail_MD


------کانورت 1394 منطقه 04
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,   4   ,   1394   , Name
FROM            AKH.AccAMJ9404.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,    4   ,  1394   ,IdGroup , Name
	FROM            AKH.AccAMJ9404.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,    4  ,   1394   ,IdKol ,Name
             FROM            AKH.AccAMJ9404.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,  4     ,   1394  , Name
FROM            AKH.AccAMJ9404.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,    4   ,   1394   , Name
					FROM            AKH.AccAMJ9404.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   4   ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9404.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1394	,   4    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9404.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   4   ,   1394    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9404.dbo.tblSanadDetail_MD

------کانورت 1393 منطقه 04
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  4   ,   1393   , Name
FROM            AKH.AccAMJ9304.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,    4   ,  1393   ,IdGroup , Name
	FROM            AKH.AccAMJ9304.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,    4  ,   1393   ,IdKol ,Name
             FROM            AKH.AccAMJ9304.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,  4     ,   1393  , Name
FROM            AKH.AccAMJ9304.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,    4   ,   1393   , Name
					FROM            AKH.AccAMJ9304.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   4   ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9304.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1393	,   4    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
						FROM AKH.AccAMJ9304.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,    4   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9304.dbo.tblSanadDetail_MD

------کانورت 1392 منطقه 04
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  4    ,   1392   , Name
FROM            AKH.AccAMJ9204.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,    4   ,  1392   ,IdGroup , Name
	FROM            AKH.AccAMJ9204.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,    4  ,   1392   ,IdKol ,Name
             FROM            AKH.AccAMJ9204.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,  4     ,   1392  , Name
FROM            AKH.AccAMJ9204.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,    4   ,   1392   , Name
					FROM            AKH.AccAMJ9204.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   4   ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9204.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1392	,   4    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9204.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   4   ,   1392    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9204.dbo.tblSanadDetail_MD


------کانورت 1391 منطقه 04
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,   4   ,   1391   , Name
FROM            AKH.AccAMJ9104.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,    4   ,  1391   ,IdGroup , Name
	FROM            AKH.AccAMJ9104.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,    4  ,   1391   ,IdKol ,Name
             FROM            AKH.AccAMJ9104.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,  4     ,   1391  , Name
FROM            AKH.AccAMJ9104.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,    4   ,   1391   , Name
					FROM            AKH.AccAMJ9104.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   4   ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9104.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1391	,   4    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9104.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   4   ,   1391    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9104.dbo.tblSanadDetail_MD

------کانورت 1390 منطقه 04
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,   4   ,   1390   , Name
FROM            AKH.AccAMJ9004.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,    4   ,  1390   ,IdGroup , Name
	FROM            AKH.AccAMJ9004.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,    4  ,   1390   ,IdKol ,Name
             FROM            AKH.AccAMJ9004.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    4   ,   1390  , Name
FROM            AKH.AccAMJ9004.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   4   ,   1390   , Name
					FROM            AKH.AccAMJ9004.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   4   ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9004.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1390	,   4    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9004.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   4   ,   1390    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9004.dbo.tblSanadDetail_MD

------کانورت 1389 منطقه 04
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  4    ,   1389   , Name
FROM            AKH.AccAMJ8904.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,    4   ,  1389   ,IdGroup , Name
	FROM            AKH.AccAMJ8904.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   4   ,   1389   ,IdKol ,Name
             FROM            AKH.AccAMJ8904.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    4   ,   1389  , Name
FROM            AKH.AccAMJ8904.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,    4   ,   1389   , Name
					FROM            AKH.AccAMJ8904.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   4   ,   1389    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8904.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1389	,   4    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8904.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,    4   ,   1389    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8904.dbo.tblSanadDetail_MD


------کانورت 1388 منطقه 04
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,   4   ,   1388   , Name
FROM            AKH.AccAMJ8804.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,    4   ,  1388   ,IdGroup , Name
	FROM            AKH.AccAMJ8804.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,    4  ,   1388   ,IdKol ,Name
             FROM            AKH.AccAMJ8804.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    4   ,  1388   , Name
FROM            AKH.AccAMJ8804.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,    4   ,   1388   , Name
					FROM            AKH.AccAMJ8804.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   4   ,   1388    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8804.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1388	,   4    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8804.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   4   ,   1388    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8804.dbo.tblSanadDetail_MD


------کانورت 1387 منطقه 04
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  4    ,   1387   , Name
FROM            AKH.AccAMJ8704.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   4    ,  1387   ,IdGroup , Name
	FROM            AKH.AccAMJ8704.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,    4  ,   1387   ,IdKol ,Name
             FROM            AKH.AccAMJ8704.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    4   ,   1387  , Name
FROM            AKH.AccAMJ8704.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   4    ,   1387   , Name
					FROM            AKH.AccAMJ8704.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   4   ,   1387    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8704.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1387	,   4    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8704.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   4   ,   1387    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8704.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 4 and YearName <= 1401 and id in (4,7)

update olden.tblGroup
  set  id = 999
  Where AreaId = 4 and YearName <= 1401 and id in (5, 8)

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 4 and YearName <= 1401 and IdGroup in (4,7)

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 4 and YearName <= 1401 and IdGroup in (5, 8)
return
end
--*********************************************************************
--*********************************************************************
--*********************************************************************
if(@areaId = 5)
begin
delete olden.tblGroup           where AreaId = 5 and YearName <=1401
delete olden.tblKol             where AreaId = 5 and YearName <=1401
delete olden.tblMoien           where AreaId = 5 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 5 and YearName <=1401
delete olden.tblSanadState      where AreaId = 5 and YearName <=1401
delete olden.tblTafsily         where AreaId = 5 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 5 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 5 and YearName <=1401

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,   5   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            AKH.AccAMJ1005.dbo.tblGroup CROSS JOIN
										 AKH.AccAMJ1005.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (10,11,13,14,15))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    5   , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            AKH.AccAMJ1005.dbo.tblKol CROSS JOIN
									 AKH.AccAMJ1005.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (10,11,13,14,15))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  5    ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            AKH.AccAMJ1005.dbo.tblSal_MD CROSS JOIN
										 AKH.AccAMJ1005.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (10,11,13,14,15))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  5    , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            AKH.AccAMJ1005.dbo.tblSal_MD CROSS JOIN
									 AKH.AccAMJ1005.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (10,11,13,14,15))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   5    , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
						FROM            AKH.AccAMJ1005.dbo.tblSal_MD CROSS JOIN
												 AKH.AccAMJ1005.dbo.tblSanadState
						WHERE        (tblSal_MD.Id IN (10,11,13,14,15))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   5  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
							FROM            AKH.AccAMJ1005.dbo.tblSal_MD CROSS JOIN
													 AKH.AccAMJ1005.dbo.tblTafsily
							WHERE        (tblSal_MD.Id IN (10,11,13,14,15))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 10 then 1397
										when IdSal_MD = 11 then 1398
										when IdSal_MD = 13 then 1399
										when IdSal_MD = 14 then 1400
										when IdSal_MD = 15 then 1401
										end ,   5   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ1005.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    5  , 
						   											case when IdSalSanad_MD = 10 then 1397
																		 when IdSalSanad_MD = 11 then 1398
																		 when IdSalSanad_MD = 13 then 1399
																		 when IdSalSanad_MD = 14 then 1400
																		 when IdSalSanad_MD = 15 then 1401
																		 end   ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ1005.dbo.tblSanadDetail_MD

------کانورت 1396 منطقه 05
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  5   ,   1396   , Name
FROM            AKH.AccAMJ9605.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   5   ,  1396   ,IdGroup , Name
	FROM            AKH.AccAMJ9605.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   5  ,   1396   ,IdKol ,Name
             FROM            AKH.AccAMJ9605.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 5     ,   1396  , Name
FROM            AKH.AccAMJ9605.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   5   ,   1396   , Name
					FROM            AKH.AccAMJ9605.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   5   ,   1396    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9605.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1396	,   5    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9605.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   5   ,   1396    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9605.dbo.tblSanadDetail_MD


------کانورت 1395 منطقه 05
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  5   ,   1395   , Name
FROM            AKH.AccAMJ9505.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   5   ,  1395   ,IdGroup , Name
	FROM            AKH.AccAMJ9505.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   5  ,   1395   ,IdKol ,Name
             FROM            AKH.AccAMJ9505.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 5     ,   1395  , Name
FROM            AKH.AccAMJ9505.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   5   ,   1395   , Name
					FROM            AKH.AccAMJ9505.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   5   ,   1395    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9505.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1395	,   5    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9505.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   5   ,   1395    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9505.dbo.tblSanadDetail_MD


--------کانورت 1394 منطقه 05
--insert into olden.tblGroup(id , AreaId , YearName , Name     )
--			      SELECT   Id ,   5   ,   1394   , Name
--FROM            AKH.AccAMJ9405.dbo.tblGroup AS tblGroup_1

--insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
--			SELECT        Id  ,   5   ,  1394   ,IdGroup , Name
--	FROM            AKH.AccAMJ1005.dbo.tblKol AS tblKol_1
	

--insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
--			   SELECT      Id ,   5  ,   1394   ,IdKol ,Name
--             FROM            AKH.AccAMJ1005.dbo.tblMoien AS tblMoien_1

--insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
--		         SELECT        Id , 5     ,   1394  , Name
--FROM            AKH.AccAMJ1005.dbo.tblSanadKind AS tblSanadKind_1				 

				
--insert into olden.tblSanadState(Id , AreaId , YearName , Name)
--					SELECT      Id ,   5   ,   1394   , Name
--					FROM            AKH.AccAMJ1005.dbo.tblSanadState AS tblSanadState_1
					  

--insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
--				    SELECT   Id , IdSotooh ,   5   ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
--		FROM            AKH.AccAMJ1005.dbo.tblTafsily 

				
--insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
--	                SELECT    Id ,   1394	,   5    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
--										FROM AKH.AccAMJ1005.dbo.tblSanad_MD				

--insert into olden.tblSanadDetail_MD(Id , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
--						   SELECT   Id ,   5   ,   1394    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
--							 FROM            AKH.AccAMJ1005.dbo.tblSanadDetail_MD

--------کانورت 1393 منطقه 05
--insert into olden.tblGroup(id , AreaId , YearName , Name     )
--			      SELECT   Id ,   5   ,   1393   , Name
--FROM            AKH.AccAMJ1005.dbo.tblGroup AS tblGroup_1

--insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
--			SELECT        Id  ,   5   ,  1393   ,IdGroup , Name
--	FROM            AKH.AccAMJ1005.dbo.tblKol AS tblKol_1
	

--insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
--			   SELECT      Id ,   5  ,   1393   ,IdKol ,Name
--             FROM            AKH.AccAMJ1005.dbo.tblMoien AS tblMoien_1

--insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
--		         SELECT        Id , 5     ,   1393  , Name
--FROM            AKH.AccAMJ1005.dbo.tblSanadKind AS tblSanadKind_1				 

				
--insert into olden.tblSanadState(Id , AreaId , YearName , Name)
--					SELECT      Id ,   5   ,   1393   , Name
--					FROM            AKH.AccAMJ1005.dbo.tblSanadState AS tblSanadState_1
					  

--insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
--				    SELECT   Id , IdSotooh ,   5   ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
--		FROM            AKH.AccAMJ1005.dbo.tblTafsily 

				
--insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
--	                SELECT    Id ,   1393	,   5    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
--						FROM AKH.AccAMJ1005.dbo.tblSanad_MD				

--insert into olden.tblSanadDetail_MD(Id , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
--						   SELECT   Id ,   5   ,   1393    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
--							 FROM            AKH.AccAMJ1005.dbo.tblSanadDetail_MD

--------کانورت 1392 منطقه 05
--insert into olden.tblGroup(id , AreaId , YearName , Name     )
--			      SELECT   Id ,   5   ,   1392   , Name
--FROM            AKH.AccAMJ1005.dbo.tblGroup AS tblGroup_1

--insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
--			SELECT        Id  ,   5   ,  1392   ,IdGroup , Name
--	FROM            AKH.AccAMJ1005.dbo.tblKol AS tblKol_1
	

--insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
--			   SELECT      Id ,   5   ,   1392   ,IdKol ,Name
--             FROM            AKH.AccAMJ1005.dbo.tblMoien AS tblMoien_1

--insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
--		         SELECT        Id , 5      ,   1392  , Name
--FROM            AKH.AccAMJ1005.dbo.tblSanadKind AS tblSanadKind_1				 

				
--insert into olden.tblSanadState(Id , AreaId , YearName , Name)
--					SELECT      Id ,   5    ,   1392   , Name
--					FROM            AKH.AccAMJ1005.dbo.tblSanadState AS tblSanadState_1
					  

--insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
--				    SELECT   Id , IdSotooh ,   5   ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
--		FROM            AKH.AccAMJ1005.dbo.tblTafsily 

				
--insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
--	                SELECT    Id ,   1392	,   5    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
--										FROM AKH.AccAMJ1005.dbo.tblSanad_MD				

--insert into olden.tblSanadDetail_MD(Id , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
--						   SELECT   Id ,   5   ,   1392    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
--							 FROM            AKH.AccAMJ1005.dbo.tblSanadDetail_MD


--------کانورت 1391 منطقه 05
--insert into olden.tblGroup(id , AreaId , YearName , Name     )
--			      SELECT   Id ,   5    ,   1391   , Name
--FROM            AKH.AccAMJ1005.dbo.tblGroup AS tblGroup_1

--insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
--			SELECT        Id  ,    5   ,  1391   ,IdGroup , Name
--	FROM            AKH.AccAMJ1005.dbo.tblKol AS tblKol_1
	

--insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
--			   SELECT      Id ,   5  ,   1391   ,IdKol ,Name
--             FROM            AKH.AccAMJ1005.dbo.tblMoien AS tblMoien_1

--insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
--		         SELECT        Id ,  5     ,   1391  , Name
--FROM            AKH.AccAMJ1005.dbo.tblSanadKind AS tblSanadKind_1				 

				
--insert into olden.tblSanadState(Id , AreaId , YearName , Name)
--					SELECT      Id ,   5   ,   1391   , Name
--					FROM            AKH.AccAMJ1005.dbo.tblSanadState AS tblSanadState_1
					  

--insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
--				    SELECT   Id , IdSotooh ,   5   ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
--		FROM            AKH.AccAMJ1005.dbo.tblTafsily 

				
--insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
--	                SELECT    Id ,   1391	,   5    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
--										FROM AKH.AccAMJ1005.dbo.tblSanad_MD				

--insert into olden.tblSanadDetail_MD(Id , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
--						   SELECT   Id ,   5   ,   1391    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
--							 FROM            AKH.AccAMJ1005.dbo.tblSanadDetail_MD

--------کانورت 1390 منطقه 05
--insert into olden.tblGroup(id , AreaId , YearName , Name     )
--			      SELECT   Id ,   5   ,   1390   , Name
--FROM            AKH.AccAMJ1005.dbo.tblGroup AS tblGroup_1

--insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
--			SELECT        Id  ,   5   ,  1390   ,IdGroup , Name
--	FROM            AKH.AccAMJ1005.dbo.tblKol AS tblKol_1
	

--insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
--			   SELECT      Id ,   5  ,   1390   ,IdKol ,Name
--             FROM            AKH.AccAMJ1005.dbo.tblMoien AS tblMoien_1

--insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
--		         SELECT        Id ,    5   ,   1390  , Name
--FROM            AKH.AccAMJ1005.dbo.tblSanadKind AS tblSanadKind_1				 

				
--insert into olden.tblSanadState(Id , AreaId , YearName , Name)
--					SELECT      Id ,   5   ,   1390   , Name
--					FROM            AKH.AccAMJ1005.dbo.tblSanadState AS tblSanadState_1
					  

--insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
--				    SELECT   Id , IdSotooh ,   5   ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
--		FROM            AKH.AccAMJ1005.dbo.tblTafsily 

				
--insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
--	                SELECT    Id ,   1390	,   5    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
--										FROM AKH.AccAMJ1005.dbo.tblSanad_MD				

--insert into olden.tblSanadDetail_MD(Id , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
--						   SELECT   Id ,   5   ,   1390    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
--							 FROM            AKH.AccAMJ1005.dbo.tblSanadDetail_MD

--------کانورت 1389 منطقه 05
--insert into olden.tblGroup(id , AreaId , YearName , Name     )
--			      SELECT   Id ,   5   ,   1389   , Name
--FROM            AKH.AccAMJ1005.dbo.tblGroup AS tblGroup_1

--insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
--			SELECT        Id  ,   5   ,  1389   ,IdGroup , Name
--	FROM            AKH.AccAMJ1005.dbo.tblKol AS tblKol_1
	

--insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
--			   SELECT      Id ,   5   ,   1389   ,IdKol ,Name
--             FROM            AKH.AccAMJ1005.dbo.tblMoien AS tblMoien_1

--insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
--		         SELECT        Id ,    5   ,   1389  , Name
--FROM            AKH.AccAMJ1005.dbo.tblSanadKind AS tblSanadKind_1				 

				
--insert into olden.tblSanadState(Id , AreaId , YearName , Name)
--					SELECT      Id ,   5   ,   1389   , Name
--					FROM            AKH.AccAMJ1005.dbo.tblSanadState AS tblSanadState_1
					  

--insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
--				    SELECT   Id , IdSotooh ,   5   ,   1389    , IdTafsilyGroup , Name , IdTafsilyType
--		FROM            AKH.AccAMJ1005.dbo.tblTafsily 

				
--insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
--	                SELECT    Id ,   1389	,   5    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
--										FROM AKH.AccAMJ1005.dbo.tblSanad_MD				

--insert into olden.tblSanadDetail_MD(Id , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
--						   SELECT   Id ,   5   ,   1389    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
--							 FROM            AKH.AccAMJ1005.dbo.tblSanadDetail_MD


--------کانورت 1388 منطقه 05
--insert into olden.tblGroup(id , AreaId , YearName , Name     )
--			      SELECT   Id ,   5   ,   1388   , Name
--FROM            AKH.AccAMJ1005.dbo.tblGroup AS tblGroup_1

--insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
--			SELECT        Id  ,   5   ,  1388   ,IdGroup , Name
--	FROM            AKH.AccAMJ1005.dbo.tblKol AS tblKol_1
	

--insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
--			   SELECT      Id ,   5  ,   1388   ,IdKol ,Name
--             FROM            AKH.AccAMJ1005.dbo.tblMoien AS tblMoien_1

--insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
--		         SELECT        Id ,    5   ,  1388   , Name
--FROM            AKH.AccAMJ1005.dbo.tblSanadKind AS tblSanadKind_1				 

				
--insert into olden.tblSanadState(Id , AreaId , YearName , Name)
--					SELECT      Id ,   5   ,   1388   , Name
--					FROM            AKH.AccAMJ1005.dbo.tblSanadState AS tblSanadState_1
					  

--insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
--				    SELECT   Id , IdSotooh ,   5   ,   1388    , IdTafsilyGroup , Name , IdTafsilyType
--		FROM            AKH.AccAMJ1005.dbo.tblTafsily 

				
--insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
--	                SELECT    Id ,   1388	,   5    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
--										FROM AKH.AccAMJ1005.dbo.tblSanad_MD				

--insert into olden.tblSanadDetail_MD(Id , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
--						   SELECT   Id ,   5   ,   1388    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
--							 FROM            AKH.AccAMJ1005.dbo.tblSanadDetail_MD


--------کانورت 1387 منطقه 05
--insert into olden.tblGroup(id , AreaId , YearName , Name     )
--			      SELECT   Id ,   5   ,   1387   , Name
--FROM            AKH.AccAMJ1005.dbo.tblGroup AS tblGroup_1

--insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
--			SELECT        Id  ,   5   ,  1387   ,IdGroup , Name
--	FROM            AKH.AccAMJ1005.dbo.tblKol AS tblKol_1
	

--insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
--			   SELECT      Id ,   5  ,   1387   ,IdKol ,Name
--             FROM            AKH.AccAMJ1005.dbo.tblMoien AS tblMoien_1

--insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
--		         SELECT        Id ,    5   ,   1387  , Name
--FROM            AKH.AccAMJ1005.dbo.tblSanadKind AS tblSanadKind_1				 

				
--insert into olden.tblSanadState(Id , AreaId , YearName , Name)
--					SELECT      Id ,   5    ,   1387   , Name
--					FROM            AKH.AccAMJ1005.dbo.tblSanadState AS tblSanadState_1
					  

--insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
--				    SELECT   Id , IdSotooh ,   5   ,   1387    , IdTafsilyGroup , Name , IdTafsilyType
--		FROM            AKH.AccAMJ1005.dbo.tblTafsily 

				
--insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
--	                SELECT    Id ,   1387	,   5    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
--										FROM AKH.AccAMJ1005.dbo.tblSanad_MD				

--insert into olden.tblSanadDetail_MD(Id , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
--						   SELECT   Id ,   5   ,   1387    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
--							 FROM            AKH.AccAMJ1005.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 5 and YearName <= 1401 and id in (4,7)

update olden.tblGroup
  set  id = 999
  Where AreaId = 5 and YearName <= 1401 and id in (5, 8)

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 5 and YearName <= 1401 and IdGroup in (4,7)

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 5 and YearName <= 1401 and IdGroup in (5, 8)
return
end

--*****************************************************************************
--*****************************************************************************
--*****************************************************************************
if(@areaId = 6)
begin
delete olden.tblGroup           where AreaId = 6 and YearName <=1401
delete olden.tblKol             where AreaId = 6 and YearName <=1401
delete olden.tblMoien           where AreaId = 6 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 6 and YearName <=1401
delete olden.tblSanadState      where AreaId = 6 and YearName <=1401
delete olden.tblTafsily         where AreaId = 6 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 6 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 6 and YearName <=1401

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  6   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            AKH.AccAMJ1006.dbo.tblGroup CROSS JOIN
										 AKH.AccAMJ1006.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (8,9,11,14,15))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    6  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            AKH.AccAMJ1006.dbo.tblKol CROSS JOIN
									 AKH.AccAMJ1006.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (8,9,11,14,15))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  6   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            AKH.AccAMJ1006.dbo.tblSal_MD CROSS JOIN
										 AKH.AccAMJ1006.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (8,9,11,14,15))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  6   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            AKH.AccAMJ1006.dbo.tblSal_MD CROSS JOIN
									 AKH.AccAMJ1006.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (8,9,11,14,15))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   6   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
						FROM            AKH.AccAMJ1006.dbo.tblSal_MD CROSS JOIN
												 AKH.AccAMJ1006.dbo.tblSanadState
						WHERE        (tblSal_MD.Id IN (8,9,11,14,15))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   6  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
							FROM            AKH.AccAMJ1006.dbo.tblSal_MD CROSS JOIN
													 AKH.AccAMJ1006.dbo.tblTafsily
							WHERE        (tblSal_MD.Id IN (8,9,11,14,15))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 8  then 1397
										when IdSal_MD = 9  then 1398
										when IdSal_MD = 11 then 1399
										when IdSal_MD = 14 then 1400
										when IdSal_MD = 15 then 1401
										end ,   6   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ1006.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    6  , 
						   											case when IdSalSanad_MD = 8  then 1397
																		 when IdSalSanad_MD = 9  then 1398
																		 when IdSalSanad_MD = 11 then 1399
																		 when IdSalSanad_MD = 14 then 1400
																		 when IdSalSanad_MD = 15 then 1401
																		 end   ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ1006.dbo.tblSanadDetail_MD

------کانورت 1396 منطقه 06
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  6   ,   1396   , Name
FROM            AKH.AccAMJ9606.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   6   ,  1396   ,IdGroup , Name
	FROM            AKH.AccAMJ9606.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   6  ,   1396   ,IdKol ,Name
             FROM            AKH.AccAMJ9606.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 6     ,   1396  , Name
FROM            AKH.AccAMJ9606.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   6   ,   1396   , Name
					FROM            AKH.AccAMJ9606.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   6   ,   1396    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9606.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1396	,   6    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9606.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   6   ,   1396    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9606.dbo.tblSanadDetail_MD


------کانورت 1395 منطقه 06
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  6   ,   1395   , Name
FROM            AKH.AccAMJ9506.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   6   ,  1395   ,IdGroup , Name
	FROM            AKH.AccAMJ9506.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   6  ,   1395   ,IdKol ,Name
             FROM            AKH.AccAMJ9506.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 6     ,   1395  , Name
FROM            AKH.AccAMJ9506.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   6   ,   1395   , Name
					FROM            AKH.AccAMJ9506.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   6   ,   1395    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9506.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1395	,   6    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9506.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   6   ,   1395    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9506.dbo.tblSanadDetail_MD


------کانورت 1394 منطقه 06
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  6   ,   1394   , Name
FROM            AKH.AccAMJ9406.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   6   ,  1394   ,IdGroup , Name
	FROM            AKH.AccAMJ9406.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   6  ,   1394   ,IdKol ,Name
             FROM            AKH.AccAMJ9406.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 6     ,   1394  , Name
FROM            AKH.AccAMJ9406.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   6   ,   1394   , Name
					FROM            AKH.AccAMJ9406.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   6   ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9406.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1394	,   6    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9406.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   6   ,   1394    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9406.dbo.tblSanadDetail_MD

------کانورت 1393 منطقه 06
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  6   ,   1393   , Name
FROM            AKH.AccAMJ9306.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   6   ,  1393   ,IdGroup , Name
	FROM            AKH.AccAMJ9306.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   6  ,   1393   ,IdKol ,Name
             FROM            AKH.AccAMJ9306.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 6     ,   1393  , Name
FROM            AKH.AccAMJ9306.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   6   ,   1393   , Name
					FROM            AKH.AccAMJ9306.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   6   ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9306.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1393	,   6    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
						FROM AKH.AccAMJ9306.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   6   ,   1393    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9306.dbo.tblSanadDetail_MD

------کانورت 1392 منطقه 06
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  6   ,   1392   , Name
FROM            AKH.AccAMJ9206.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   6   ,  1392   ,IdGroup , Name
	FROM            AKH.AccAMJ9206.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   6  ,   1392   ,IdKol ,Name
             FROM            AKH.AccAMJ9206.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 6     ,   1392  , Name
FROM            AKH.AccAMJ9206.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   6   ,   1392   , Name
					FROM            AKH.AccAMJ9206.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   6   ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9206.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1392	,   6    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9206.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   6   ,   1392    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9206.dbo.tblSanadDetail_MD


------کانورت 1391 منطقه 06
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  6   ,   1391   , Name
FROM            AKH.AccAMJ9106.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   6   ,  1391   ,IdGroup , Name
	FROM            AKH.AccAMJ9106.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   6  ,   1391   ,IdKol ,Name
             FROM            AKH.AccAMJ9106.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 6     ,   1391  , Name
FROM            AKH.AccAMJ9106.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   6   ,   1391   , Name
					FROM            AKH.AccAMJ9106.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   6   ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9106.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1391	,   6    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9106.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   6   ,   1391    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9106.dbo.tblSanadDetail_MD

------کانورت 1390 منطقه 06
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  6   ,   1390   , Name
FROM            AKH.AccAMJ9006.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   6   ,  1390   ,IdGroup , Name
	FROM            AKH.AccAMJ9006.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   6  ,   1390   ,IdKol ,Name
             FROM            AKH.AccAMJ9006.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    6   ,   1390  , Name
FROM            AKH.AccAMJ9006.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   6   ,   1390   , Name
					FROM            AKH.AccAMJ9006.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   6   ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9006.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1390	,   6    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9006.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   6   ,   1390    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9006.dbo.tblSanadDetail_MD

------کانورت 1389 منطقه 06
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  6   ,   1389   , Name
FROM            AKH.AccAMJ8906.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   6   ,  1389   ,IdGroup , Name
	FROM            AKH.AccAMJ8906.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   6   ,   1389   ,IdKol ,Name
             FROM            AKH.AccAMJ8906.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    6   ,   1389  , Name
FROM            AKH.AccAMJ8906.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   6   ,   1389   , Name
					FROM            AKH.AccAMJ8906.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   6   ,   1389    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8906.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1389	,   6    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8906.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   6   ,   1389    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8906.dbo.tblSanadDetail_MD


------کانورت 1388 منطقه 06
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  6   ,   1388   , Name
FROM            AKH.AccAMJ8806.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   6   ,  1388   ,IdGroup , Name
	FROM            AKH.AccAMJ8806.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   6  ,   1388   ,IdKol ,Name
             FROM            AKH.AccAMJ8806.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    6   ,  1388   , Name
FROM            AKH.AccAMJ8806.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   6   ,   1388   , Name
					FROM            AKH.AccAMJ8806.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   6   ,   1388    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8806.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1388	,   6    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8806.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   6   ,   1388    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8806.dbo.tblSanadDetail_MD


------کانورت 1387 منطقه 06
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  6   ,   1387   , Name
FROM            AKH.AccAMJ8706.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   6   ,  1387   ,IdGroup , Name
	FROM            AKH.AccAMJ8706.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   6  ,   1387   ,IdKol ,Name
             FROM            AKH.AccAMJ8706.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    6   ,   1387  , Name
FROM            AKH.AccAMJ8706.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   6    ,   1387   , Name
					FROM            AKH.AccAMJ8706.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   6   ,   1387    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8706.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1387	,   6    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8706.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   6   ,   1387    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8706.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 6 and YearName <= 1401 and id in (4,7)

update olden.tblGroup
  set  id = 999
  Where AreaId = 6 and YearName <= 1401 and id in (5, 8)

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 6 and YearName <= 1401 and IdGroup in (4,7)

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 6 and YearName <= 1401 and IdGroup in (5, 8)
return
end

--***********************************************************************
--***********************************************************************
--***********************************************************************
if(@areaId = 7)
begin
delete olden.tblGroup           where AreaId = 7 and YearName <=1401
delete olden.tblKol             where AreaId = 7 and YearName <=1401
delete olden.tblMoien           where AreaId = 7 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 7 and YearName <=1401
delete olden.tblSanadState      where AreaId = 7 and YearName <=1401
delete olden.tblTafsily         where AreaId = 7 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 7 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 7 and YearName <=1401

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  7   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            AKH.AccAMJ1007.dbo.tblGroup CROSS JOIN
										 AKH.AccAMJ1007.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (8,9,11,12,13))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    7  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            AKH.AccAMJ1007.dbo.tblKol CROSS JOIN
									 AKH.AccAMJ1007.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (8,9,11,12,13))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  7   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            AKH.AccAMJ1007.dbo.tblSal_MD CROSS JOIN
										 AKH.AccAMJ1007.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (8,9,11,12,13))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  7   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            AKH.AccAMJ1007.dbo.tblSal_MD CROSS JOIN
									 AKH.AccAMJ1007.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (8,9,11,12,13))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   7   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
						FROM            AKH.AccAMJ1007.dbo.tblSal_MD CROSS JOIN
												 AKH.AccAMJ1007.dbo.tblSanadState
						WHERE        (tblSal_MD.Id IN (8,9,11,12,13))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   7  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
							FROM            AKH.AccAMJ1007.dbo.tblSal_MD CROSS JOIN
													 AKH.AccAMJ1007.dbo.tblTafsily
							WHERE        (tblSal_MD.Id IN (8,9,11,12,13))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 8  then 1397
										when IdSal_MD = 9  then 1398
										when IdSal_MD = 11 then 1399
										when IdSal_MD = 12 then 1400
										when IdSal_MD = 13 then 1401
										end ,   7   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ1007.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    7  , 
						   											case when IdSalSanad_MD = 8  then 1397
																		 when IdSalSanad_MD = 9  then 1398
																		 when IdSalSanad_MD = 11 then 1399
																		 when IdSalSanad_MD = 12 then 1400
																		 when IdSalSanad_MD = 13 then 1401
																		 end   ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ1007.dbo.tblSanadDetail_MD

------کانورت 1396 منطقه 07
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  7   ,   1396   , Name
FROM            AKH.AccAMJ9607.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   7   ,  1396   ,IdGroup , Name
	FROM            AKH.AccAMJ9607.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   7  ,   1396   ,IdKol ,Name
             FROM            AKH.AccAMJ9607.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 7     ,   1396  , Name
FROM            AKH.AccAMJ9607.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   7   ,   1396   , Name
					FROM            AKH.AccAMJ9607.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   7   ,   1396    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9607.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1396	,   7    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9607.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   7   ,   1396    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9607.dbo.tblSanadDetail_MD


------کانورت 1395 منطقه 07
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  7   ,   1395   , Name
FROM            AKH.AccAMJ9507.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   7   ,  1395   ,IdGroup , Name
	FROM            AKH.AccAMJ9507.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   7  ,   1395   ,IdKol ,Name
             FROM            AKH.AccAMJ9507.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 7     ,   1395  , Name
FROM            AKH.AccAMJ9507.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   7   ,   1395   , Name
					FROM            AKH.AccAMJ9507.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   7   ,   1395    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9507.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1395	,   7    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9507.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   7   ,   1395    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9507.dbo.tblSanadDetail_MD


------کانورت 1394 منطقه 07
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  7   ,   1394   , Name
FROM            AKH.AccAMJ9407.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   7   ,  1394   ,IdGroup , Name
	FROM            AKH.AccAMJ9407.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   7  ,   1394   ,IdKol ,Name
             FROM            AKH.AccAMJ9407.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 7     ,   1394  , Name
FROM            AKH.AccAMJ9407.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   7   ,   1394   , Name
					FROM            AKH.AccAMJ9407.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   7   ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9407.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1394	,   7    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9407.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   7   ,   1394    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9407.dbo.tblSanadDetail_MD

------کانورت 1393 منطقه 07
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  7   ,   1393   , Name
FROM            AKH.AccAMJ9307.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   7   ,  1393   ,IdGroup , Name
	FROM            AKH.AccAMJ9307.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   7  ,   1393   ,IdKol ,Name
             FROM            AKH.AccAMJ9307.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 7     ,   1393  , Name
FROM            AKH.AccAMJ9307.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   7   ,   1393   , Name
					FROM            AKH.AccAMJ9307.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   7   ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9307.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1393	,   7    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
						FROM AKH.AccAMJ9307.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   7   ,   1393    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9307.dbo.tblSanadDetail_MD

------کانورت 1392 منطقه 02
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  7   ,   1392   , Name
FROM            AKH.AccAMJ9207.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   7   ,  1392   ,IdGroup , Name
	FROM            AKH.AccAMJ9207.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   7  ,   1392   ,IdKol ,Name
             FROM            AKH.AccAMJ9207.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 7     ,   1392  , Name
FROM            AKH.AccAMJ9207.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   7   ,   1392   , Name
					FROM            AKH.AccAMJ9207.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   7   ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9207.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1392	,   7    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9207.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   7   ,   1392    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9207.dbo.tblSanadDetail_MD


------کانورت 1391 منطقه 07
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  7   ,   1391   , Name
FROM            AKH.AccAMJ9107.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   7   ,  1391   ,IdGroup , Name
	FROM            AKH.AccAMJ9107.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   7  ,   1391   ,IdKol ,Name
             FROM            AKH.AccAMJ9107.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 7     ,   1391  , Name
FROM            AKH.AccAMJ9107.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   7   ,   1391   , Name
					FROM            AKH.AccAMJ9107.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   7   ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9107.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1391	,   7    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9107.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   7   ,   1391    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9107.dbo.tblSanadDetail_MD

------کانورت 1390 منطقه 07
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  7   ,   1390   , Name
FROM            AKH.AccAMJ9007.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   7   ,  1390   ,IdGroup , Name
	FROM            AKH.AccAMJ9007.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   7  ,   1390   ,IdKol ,Name
             FROM            AKH.AccAMJ9007.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    7   ,   1390  , Name
FROM            AKH.AccAMJ9007.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   7   ,   1390   , Name
					FROM            AKH.AccAMJ9007.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   7   ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9007.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1390	,   7    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9007.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   7   ,   1390    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9007.dbo.tblSanadDetail_MD

------کانورت 1389 منطقه 07
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  7   ,   1389   , Name
FROM            AKH.AccAMJ8907.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   7   ,  1389   ,IdGroup , Name
	FROM            AKH.AccAMJ8907.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   7   ,   1389   ,IdKol ,Name
             FROM            AKH.AccAMJ8907.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    7   ,   1389  , Name
FROM            AKH.AccAMJ8907.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   7   ,   1389   , Name
					FROM            AKH.AccAMJ8907.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   7   ,   1389    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8907.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1389	,   7    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8907.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   7   ,   1389    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8907.dbo.tblSanadDetail_MD


------کانورت 1388 منطقه 07
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  7   ,   1388   , Name
FROM            AKH.AccAMJ8807.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   7   ,  1388   ,IdGroup , Name
	FROM            AKH.AccAMJ8807.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   7  ,   1388   ,IdKol ,Name
             FROM            AKH.AccAMJ8807.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    7   ,  1388   , Name
FROM            AKH.AccAMJ8807.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   7   ,   1388   , Name
					FROM            AKH.AccAMJ8807.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   7   ,   1388    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8807.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1388	,   7    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8807.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   7   ,   1388    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8807.dbo.tblSanadDetail_MD


------کانورت 1387 منطقه 07
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  7   ,   1387   , Name
FROM            AKH.AccAMJ8707.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   7   ,  1387   ,IdGroup , Name
	FROM            AKH.AccAMJ8707.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   7  ,   1387   ,IdKol ,Name
             FROM            AKH.AccAMJ8707.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    7   ,   1387  , Name
FROM            AKH.AccAMJ8707.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   7    ,   1387   , Name
					FROM            AKH.AccAMJ8707.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   7   ,   1387    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8707.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1387	,   7    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8707.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   7   ,   1387    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8707.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 7 and YearName <= 1401 and id in (4,7)

update olden.tblGroup
  set  id = 999
  Where AreaId = 7 and YearName <= 1401 and id in (5, 8)

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 7 and YearName <= 1401 and IdGroup in (4,7)

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 7 and YearName <= 1401 and IdGroup in (5, 8)
return
end

if(@areaId = 8)
begin
delete olden.tblGroup           where AreaId = 8 and YearName <=1401
delete olden.tblKol             where AreaId = 8 and YearName <=1401
delete olden.tblMoien           where AreaId = 8 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 8 and YearName <=1401
delete olden.tblSanadState      where AreaId = 8 and YearName <=1401
delete olden.tblTafsily         where AreaId = 8 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 8 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 8 and YearName <=1401

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  8   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            AKH.AccAMJ1008.dbo.tblGroup CROSS JOIN
										 AKH.AccAMJ1008.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (7,8,10,12,13))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    8  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            AKH.AccAMJ1008.dbo.tblKol CROSS JOIN
									 AKH.AccAMJ1008.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (7,8,10,12,13))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  8   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            AKH.AccAMJ1008.dbo.tblSal_MD CROSS JOIN
										 AKH.AccAMJ1008.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (7,8,10,12,13))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  8   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            AKH.AccAMJ1008.dbo.tblSal_MD CROSS JOIN
									 AKH.AccAMJ1008.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (7,8,10,12,13))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   8   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
						FROM            AKH.AccAMJ1008.dbo.tblSal_MD CROSS JOIN
												 AKH.AccAMJ1008.dbo.tblSanadState
						WHERE        (tblSal_MD.Id IN (7,8,10,12,13))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   8  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
							FROM            AKH.AccAMJ1008.dbo.tblSal_MD CROSS JOIN
													 AKH.AccAMJ1008.dbo.tblTafsily
							WHERE        (tblSal_MD.Id IN (7,8,10,12,13))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 7  then 1397
										when IdSal_MD = 8  then 1398
										when IdSal_MD = 10 then 1399
										when IdSal_MD = 12 then 1400
										when IdSal_MD = 13 then 1401
										end ,   8   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ1008.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    8  , 
						   											case when IdSalSanad_MD = 7  then 1397
																		 when IdSalSanad_MD = 8  then 1398
																		 when IdSalSanad_MD = 10 then 1399
																		 when IdSalSanad_MD = 12 then 1400
																		 when IdSalSanad_MD = 13 then 1401
																		 end   ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ1008.dbo.tblSanadDetail_MD

------کانورت 1396 منطقه 08
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  8   ,   1396   , Name
FROM            AKH.AccAMJ9608.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   8   ,  1396   ,IdGroup , Name
	FROM            AKH.AccAMJ9608.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   8  ,   1396   ,IdKol ,Name
             FROM            AKH.AccAMJ9608.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 8     ,   1396  , Name
FROM            AKH.AccAMJ9608.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   8   ,   1396   , Name
					FROM            AKH.AccAMJ9608.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   8   ,   1396    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9608.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1396	,   8    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9608.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   8   ,   1396    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9608.dbo.tblSanadDetail_MD


------کانورت 1395 منطقه 08
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  8   ,   1395   , Name
FROM            AKH.AccAMJ9508.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   8   ,  1395   ,IdGroup , Name
	FROM            AKH.AccAMJ9508.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   8  ,   1395   ,IdKol ,Name
             FROM            AKH.AccAMJ9508.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 8     ,   1395  , Name
FROM            AKH.AccAMJ9508.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   8   ,   1395   , Name
					FROM            AKH.AccAMJ9508.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   8   ,   1395    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9508.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1395	,   8    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9508.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   8   ,   1395    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9508.dbo.tblSanadDetail_MD


------کانورت 1394 منطقه 08
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  8   ,   1394   , Name
FROM            AKH.AccAMJ9408.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   8   ,  1394   ,IdGroup , Name
	FROM            AKH.AccAMJ9408.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   8  ,   1394   ,IdKol ,Name
             FROM            AKH.AccAMJ9408.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 8     ,   1394  , Name
FROM            AKH.AccAMJ9408.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   8   ,   1394   , Name
					FROM            AKH.AccAMJ9408.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   8   ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9408.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1394	,   8    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9408.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   8   ,   1394    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9408.dbo.tblSanadDetail_MD

------کانورت 1393 منطقه 08
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  8   ,   1393   , Name
FROM            AKH.AccAMJ9308.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   8   ,  1393   ,IdGroup , Name
	FROM            AKH.AccAMJ9308.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   8  ,   1393   ,IdKol ,Name
             FROM            AKH.AccAMJ9308.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 8     ,   1393  , Name
FROM            AKH.AccAMJ9308.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   8   ,   1393   , Name
					FROM            AKH.AccAMJ9308.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   8   ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9308.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1393	,   8    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
						FROM AKH.AccAMJ9308.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   8   ,   1393    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9308.dbo.tblSanadDetail_MD

------کانورت 1392 منطقه 08
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  8   ,   1392   , Name
FROM            AKH.AccAMJ9208.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   8   ,  1392   ,IdGroup , Name
	FROM            AKH.AccAMJ9208.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   8  ,   1392   ,IdKol ,Name
             FROM            AKH.AccAMJ9208.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 8     ,   1392  , Name
FROM            AKH.AccAMJ9208.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   8   ,   1392   , Name
					FROM            AKH.AccAMJ9208.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   8   ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9208.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1392	,   8    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9208.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   8   ,   1392    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9208.dbo.tblSanadDetail_MD


------کانورت 1391 منطقه 08
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  8   ,   1391   , Name
FROM            AKH.AccAMJ9108.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   8   ,  1391   ,IdGroup , Name
	FROM            AKH.AccAMJ9108.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   8  ,   1391   ,IdKol ,Name
             FROM            AKH.AccAMJ9108.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 8     ,   1391  , Name
FROM            AKH.AccAMJ9108.dbo.tblSanadKind 			 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   8   ,   1391   , Name
					FROM            AKH.AccAMJ9108.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   8   ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9108.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1391	,   8    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9108.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   8   ,   1391    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9108.dbo.tblSanadDetail_MD

------کانورت 1390 منطقه 08
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  8   ,   1390   , Name
FROM            AKH.AccAMJ9008.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   8   ,  1390   ,IdGroup , Name
	FROM            AKH.AccAMJ9008.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   8  ,   1390   ,IdKol ,Name
             FROM            AKH.AccAMJ9008.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    8   ,   1390  , Name
FROM            AKH.AccAMJ9008.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   8   ,   1390   , Name
					FROM            AKH.AccAMJ9008.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   8   ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9008.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1390	,   8    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9008.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   8   ,   1390    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9008.dbo.tblSanadDetail_MD

------کانورت 1389 منطقه 08
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  8   ,   1389   , Name
FROM            AKH.AccAMJ8908.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   8   ,  1389   ,IdGroup , Name
	FROM            AKH.AccAMJ8908.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   8   ,   1389   ,IdKol ,Name
             FROM            AKH.AccAMJ8908.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    8   ,   1389  , Name
FROM            AKH.AccAMJ8908.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   8   ,   1389   , Name
					FROM            AKH.AccAMJ8908.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   8   ,   1389    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8908.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1389	,   8    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8908.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   8   ,   1389    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8908.dbo.tblSanadDetail_MD


------کانورت 1388 منطقه 08
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  8   ,   1388   , Name
FROM            AKH.AccAMJ8808.dbo.tblGroup 

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   8   ,  1388   ,IdGroup , Name
	FROM            AKH.AccAMJ8808.dbo.tblKol 
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   8  ,   1388   ,IdKol ,Name
             FROM            AKH.AccAMJ8808.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    8   ,  1388   , Name
FROM            AKH.AccAMJ8808.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   8   ,   1388   , Name
					FROM            AKH.AccAMJ8808.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   8   ,   1388    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8808.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1388	,   8    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8808.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   8   ,   1388    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8808.dbo.tblSanadDetail_MD


------کانورت 1387 منطقه 08
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  8   ,   1387   , Name
FROM            AKH.AccAMJ8708.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   8   ,  1387   ,IdGroup , Name
	FROM            AKH.AccAMJ8708.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   8  ,   1387   ,IdKol ,Name
             FROM            AKH.AccAMJ8708.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    8   ,   1387  , Name
FROM            AKH.AccAMJ8708.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   8    ,   1387   , Name
					FROM            AKH.AccAMJ8708.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   8   ,   1387    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ8708.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1387	,   8    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ8708.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   8   ,   1387    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ8708.dbo.tblSanadDetail_MD

update olden.tblGroup
  set  id = 888
  Where AreaId = 8 and YearName <= 1401 and id in (4,7)

update olden.tblGroup
  set  id = 999
  Where AreaId = 8 and YearName <= 1401 and id in (5, 8)

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 8 and YearName <= 1401 and IdGroup in (4,7)

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 8 and YearName <= 1401 and IdGroup in (5, 8)
return
end							 

--********************************************************************
--********************************************************************
--********************************************************************
--********************************************************************

if(@areaId = 9)
begin

delete olden.tblGroup           where AreaId = 9 and YearName <=1401
delete olden.tblKol             where AreaId = 9 and YearName <=1401
delete olden.tblMoien           where AreaId = 9 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 9 and YearName <=1401
delete olden.tblSanadState      where AreaId = 9 and YearName <=1401
delete olden.tblTafsily         where AreaId = 9 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 9 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 9 and YearName <=1401

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  9   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            AKH.AccAMJ1000.dbo.tblGroup CROSS JOIN
										 AKH.AccAMJ1000.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (7,8,9,10,11))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    9  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            AKH.AccAMJ1000.dbo.tblKol CROSS JOIN
									 AKH.AccAMJ1000.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (7,8,9,10,11))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  9   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            AKH.AccAMJ1000.dbo.tblSal_MD CROSS JOIN
										 AKH.AccAMJ1000.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (7,8,9,10,11))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  9   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            AKH.AccAMJ1000.dbo.tblSal_MD CROSS JOIN
									 AKH.AccAMJ1000.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (7,8,9,10,11))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   9   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
						FROM            AKH.AccAMJ1000.dbo.tblSal_MD CROSS JOIN
												 AKH.AccAMJ1000.dbo.tblSanadState
						WHERE        (tblSal_MD.Id IN (7,8,9,10,11))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   9  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
							FROM            AKH.AccAMJ1000.dbo.tblSal_MD CROSS JOIN
													 AKH.AccAMJ1000.dbo.tblTafsily
							WHERE        (tblSal_MD.Id IN (7,8,9,10,11))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 7  then 1397
										when IdSal_MD = 8  then 1398
										when IdSal_MD = 9  then 1399
										when IdSal_MD = 10 then 1400
										when IdSal_MD = 11 then 1401
										end ,   9   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ1000.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                  , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    9  , 
						   											case when IdSalSanad_MD = 7  then 1397
																		 when IdSalSanad_MD = 8  then 1398
																		 when IdSalSanad_MD = 9  then 1399
																		 when IdSalSanad_MD = 10 then 1400
																		 when IdSalSanad_MD = 11 then 1401
																		 end  ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ1000.dbo.tblSanadDetail_MD

------کانورت 1396 مرکزی 
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  9   ,   1396   , Name
FROM            AKH.AccAMJ9600.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   9   ,  1396   ,IdGroup , Name
	FROM            AKH.AccAMJ9600.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   9   ,   1396   ,IdKol ,Name
             FROM            AKH.AccAMJ9600.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,     9  ,   1396  , Name
FROM            AKH.AccAMJ9600.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   9   ,   1396   , Name
					FROM            AKH.AccAMJ9600.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   9   ,   1396    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9600.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1396	,   9    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9600.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   9   ,   1396    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9600.dbo.tblSanadDetail_MD


------کانورت 1395 مرکزی 
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  9    ,   1395   , Name
FROM            AKH.AccAMJ9500.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   9    ,  1395   ,IdGroup , Name
	FROM            AKH.AccAMJ9500.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   9  ,   1395   ,IdKol ,Name
             FROM            AKH.AccAMJ9500.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,    9   ,   1395  , Name
FROM            AKH.AccAMJ9500.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   9    ,  1395    , Name
					FROM            AKH.AccAMJ9500.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   9   ,   1395    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            AKH.AccAMJ9500.dbo.tblTafsily 

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1395	,   9    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM AKH.AccAMJ9500.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD,   9   ,   1395    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            AKH.AccAMJ9500.dbo.tblSanadDetail_MD


--------کانورت 1394 مرکزی 
--insert into olden.tblGroup(id , AreaId , YearName , Name     )
--			      SELECT   Id ,   9   ,   1394   , Name
--FROM            AKH.AccAMJ1000.dbo.tblGroup AS tblGroup_1

--insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
--			SELECT        Id  ,   9   ,  1394   ,IdGroup , Name
--	FROM            AKH.AccAMJ1000.dbo.tblKol AS tblKol_1
	

--insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
--			   SELECT      Id ,   9  ,   1394   ,IdKol ,Name
--             FROM            AKH.AccAMJ1000.dbo.tblMoien AS tblMoien_1

--insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
--		         SELECT        Id , 9     ,   1394  , Name
--FROM            AKH.AccAMJ1000.dbo.tblSanadKind AS tblSanadKind_1				 

				
--insert into olden.tblSanadState(Id , AreaId , YearName , Name)
--					SELECT      Id ,   9   ,   1394   , Name
--					FROM            AKH.AccAMJ1000.dbo.tblSanadState AS tblSanadState_1
					  

--insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
--				    SELECT   Id , IdSotooh ,   9   ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
--		FROM            AKH.AccAMJ1000.dbo.tblTafsily 

				
--insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
--	                SELECT    Id ,   1394	,   9    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
--										FROM AKH.AccAMJ1000.dbo.tblSanad_MD				

--insert into olden.tblSanadDetail_MD(Id , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
--						   SELECT   Id ,   9   ,   1394    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
--							 FROM            AKH.AccAMJ1000.dbo.tblSanadDetail_MD

--------کانورت 1393  مرکزی
--insert into olden.tblGroup(id , AreaId , YearName , Name     )
--			      SELECT   Id ,   9   ,   1393   , Name
--FROM            AKH.AccAMJ1000.dbo.tblGroup AS tblGroup_1

--insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
--			SELECT        Id  ,   9   ,  1393   ,IdGroup , Name
--	FROM            AKH.AccAMJ1000.dbo.tblKol AS tblKol_1
	

--insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
--			   SELECT      Id ,   9  ,   1393   ,IdKol ,Name
--             FROM            AKH.AccAMJ1000.dbo.tblMoien AS tblMoien_1

--insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
--		         SELECT        Id , 9     ,   1393  , Name
--FROM            AKH.AccAMJ1000.dbo.tblSanadKind AS tblSanadKind_1				 

				
--insert into olden.tblSanadState(Id , AreaId , YearName , Name)
--					SELECT      Id ,   9   ,   1393   , Name
--					FROM            AKH.AccAMJ1000.dbo.tblSanadState AS tblSanadState_1
					  

--insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
--				    SELECT   Id , IdSotooh ,   9   ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
--		FROM            AKH.AccAMJ1000.dbo.tblTafsily 

				
--insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
--	                SELECT    Id ,   1393	,   9    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
--						FROM AKH.AccAMJ1000.dbo.tblSanad_MD				

--insert into olden.tblSanadDetail_MD(Id , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
--						   SELECT   Id ,   9   ,   1393    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
--							 FROM            AKH.AccAMJ1000.dbo.tblSanadDetail_MD

--------کانورت 1392 مرکزی 
--insert into olden.tblGroup(id , AreaId , YearName , Name     )
--			      SELECT   Id ,   9   ,   1392   , Name
--FROM            AKH.AccAMJ1000.dbo.tblGroup AS tblGroup_1

--insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
--			SELECT        Id  ,   9   ,  1392   ,IdGroup , Name
--	FROM            AKH.AccAMJ1000.dbo.tblKol AS tblKol_1
	

--insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
--			   SELECT      Id ,   9  ,   1392   ,IdKol ,Name
--             FROM            AKH.AccAMJ1000.dbo.tblMoien AS tblMoien_1

--insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
--		         SELECT        Id , 9     ,   1392  , Name
--FROM            AKH.AccAMJ1000.dbo.tblSanadKind AS tblSanadKind_1				 

				
--insert into olden.tblSanadState(Id , AreaId , YearName , Name)
--					SELECT      Id ,   9   ,   1392   , Name
--					FROM            AKH.AccAMJ1000.dbo.tblSanadState AS tblSanadState_1
					  

--insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
--				    SELECT   Id , IdSotooh ,   9   ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
--		FROM            AKH.AccAMJ1000.dbo.tblTafsily 

				
--insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
--	                SELECT    Id ,   1392	,   9    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
--										FROM AKH.AccAMJ1000.dbo.tblSanad_MD				

--insert into olden.tblSanadDetail_MD(Id , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
--						   SELECT   Id ,   9   ,   1392    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
--							 FROM            AKH.AccAMJ1000.dbo.tblSanadDetail_MD


--------کانورت 1391 مرکزی 
--insert into olden.tblGroup(id , AreaId , YearName , Name     )
--			      SELECT   Id ,   9   ,   1391   , Name
--FROM            AKH.AccAMJ1000.dbo.tblGroup AS tblGroup_1

--insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
--			SELECT        Id  ,   9   ,  1391   ,IdGroup , Name
--	FROM            AKH.AccAMJ1000.dbo.tblKol AS tblKol_1
	

--insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
--			   SELECT      Id ,   9  ,   1391   ,IdKol ,Name
--             FROM            AKH.AccAMJ1000.dbo.tblMoien AS tblMoien_1

--insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
--		         SELECT        Id , 9     ,   1391  , Name
--FROM            AKH.AccAMJ1000.dbo.tblSanadKind AS tblSanadKind_1				 

				
--insert into olden.tblSanadState(Id , AreaId , YearName , Name)
--					SELECT      Id ,   9   ,   1391   , Name
--					FROM            AKH.AccAMJ1000.dbo.tblSanadState AS tblSanadState_1
					  

--insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
--				    SELECT   Id , IdSotooh ,   9   ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
--		FROM            AKH.AccAMJ1000.dbo.tblTafsily 

				
--insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
--	                SELECT    Id ,   1391	,   9    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
--										FROM AKH.AccAMJ1000.dbo.tblSanad_MD				

--insert into olden.tblSanadDetail_MD(Id , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
--						   SELECT   Id ,   9   ,   1391    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
--							 FROM            AKH.AccAMJ1000.dbo.tblSanadDetail_MD

--------کانورت 1390  مرکزی
--insert into olden.tblGroup(id , AreaId , YearName , Name     )
--			      SELECT   Id ,   9   ,   1390   , Name
--FROM            AKH.AccAMJ1000.dbo.tblGroup AS tblGroup_1

--insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
--			SELECT        Id  ,   9   ,  1390   ,IdGroup , Name
--	FROM            AKH.AccAMJ1000.dbo.tblKol AS tblKol_1
	

--insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
--			   SELECT      Id ,   9  ,   1390   ,IdKol ,Name
--             FROM            AKH.AccAMJ1000.dbo.tblMoien AS tblMoien_1

--insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
--		         SELECT        Id ,    9   ,   1390  , Name
--FROM            AKH.AccAMJ1000.dbo.tblSanadKind AS tblSanadKind_1				 

				
--insert into olden.tblSanadState(Id , AreaId , YearName , Name)
--					SELECT      Id ,   9   ,   1390   , Name
--					FROM            AKH.AccAMJ1000.dbo.tblSanadState AS tblSanadState_1
					  

--insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
--				    SELECT   Id , IdSotooh ,   9   ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
--		FROM            AKH.AccAMJ1000.dbo.tblTafsily 

				
--insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
--	                SELECT    Id ,   1390	,   9    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
--										FROM AKH.AccAMJ1000.dbo.tblSanad_MD				

--insert into olden.tblSanadDetail_MD(Id , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
--						   SELECT   Id ,   9   ,   1390    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
--							 FROM            AKH.AccAMJ1000.dbo.tblSanadDetail_MD

--------کانورت 1389 مرکزی 
--insert into olden.tblGroup(id , AreaId , YearName , Name     )
--			      SELECT   Id ,   9   ,   1389   , Name
--FROM            AKH.AccAMJ1000.dbo.tblGroup AS tblGroup_1

--insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
--			SELECT        Id  ,   9   ,  1389   ,IdGroup , Name
--	FROM            AKH.AccAMJ1000.dbo.tblKol AS tblKol_1
	

--insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
--			   SELECT      Id ,   9   ,   1389   ,IdKol ,Name
--             FROM            AKH.AccAMJ1000.dbo.tblMoien AS tblMoien_1

--insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
--		         SELECT        Id ,    9   ,   1389  , Name
--FROM            AKH.AccAMJ1000.dbo.tblSanadKind AS tblSanadKind_1				 

				
--insert into olden.tblSanadState(Id , AreaId , YearName , Name)
--					SELECT      Id ,   9   ,   1389   , Name
--					FROM            AKH.AccAMJ1000.dbo.tblSanadState AS tblSanadState_1
					  

--insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
--				    SELECT   Id , IdSotooh ,   9   ,   1389    , IdTafsilyGroup , Name , IdTafsilyType
--		FROM            AKH.AccAMJ1000.dbo.tblTafsily 

				
--insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
--	                SELECT    Id ,   1389	,   9    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
--										FROM AKH.AccAMJ1000.dbo.tblSanad_MD				

--insert into olden.tblSanadDetail_MD(Id , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
--						   SELECT   Id ,   9   ,   1389    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
--							 FROM            AKH.AccAMJ1000.dbo.tblSanadDetail_MD


--------کانورت 1388 مرکزی 
--insert into olden.tblGroup(id , AreaId , YearName , Name     )
--			      SELECT   Id ,   9   ,   1388   , Name
--FROM            AKH.AccAMJ1000.dbo.tblGroup AS tblGroup_1

--insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
--			SELECT        Id  ,   9   ,  1388   ,IdGroup , Name
--	FROM            AKH.AccAMJ1000.dbo.tblKol AS tblKol_1
	

--insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
--			   SELECT      Id ,   9  ,   1388   ,IdKol ,Name
--             FROM            AKH.AccAMJ1000.dbo.tblMoien AS tblMoien_1

--insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
--		         SELECT        Id ,    9   ,  1388   , Name
--FROM            AKH.AccAMJ1000.dbo.tblSanadKind AS tblSanadKind_1				 

				
--insert into olden.tblSanadState(Id , AreaId , YearName , Name)
--					SELECT      Id ,   9   ,   1388   , Name
--					FROM            AKH.AccAMJ1000.dbo.tblSanadState AS tblSanadState_1
					  

--insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
--				    SELECT   Id , IdSotooh ,   9   ,   1388    , IdTafsilyGroup , Name , IdTafsilyType
--		FROM            AKH.AccAMJ1000.dbo.tblTafsily 

				
--insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
--	                SELECT    Id ,   1388	,   9    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
--										FROM AKH.AccAMJ1000.dbo.tblSanad_MD				

--insert into olden.tblSanadDetail_MD(Id , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
--						   SELECT   Id ,   9   ,   1388    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
--							 FROM            AKH.AccAMJ1000.dbo.tblSanadDetail_MD


--------کانورت 1387 مرکزی 
--insert into olden.tblGroup(id , AreaId , YearName , Name     )
--			      SELECT   Id ,   9   ,   1387   , Name
--FROM            AKH.AccAMJ1000.dbo.tblGroup AS tblGroup_1

--insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
--			SELECT        Id  ,   9   ,  1387   ,IdGroup , Name
--	FROM            AKH.AccAMJ1000.dbo.tblKol AS tblKol_1
	

--insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
--			   SELECT      Id ,   9  ,   1387   ,IdKol ,Name
--             FROM            AKH.AccAMJ1000.dbo.tblMoien AS tblMoien_1

--insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
--		         SELECT        Id ,    9   ,   1387  , Name
--FROM            AKH.AccAMJ1000.dbo.tblSanadKind AS tblSanadKind_1				 

				
--insert into olden.tblSanadState(Id , AreaId , YearName , Name)
--					SELECT      Id ,   9    ,   1387   , Name
--					FROM            AKH.AccAMJ1000.dbo.tblSanadState AS tblSanadState_1
					  

--insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
--				    SELECT   Id , IdSotooh ,   9   ,   1387    , IdTafsilyGroup , Name , IdTafsilyType
--		FROM            AKH.AccAMJ1000.dbo.tblTafsily 

				
--insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
--	                SELECT    Id ,   1387	,   9    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
--										FROM AKH.AccAMJ1000.dbo.tblSanad_MD				

--insert into olden.tblSanadDetail_MD(Id , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
--						   SELECT   Id ,   9   ,   1387    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
--							 FROM            AKH.AccAMJ1000.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 9 and YearName <= 1401 and id in (4,7)

update olden.tblGroup
  set  id = 999
  Where AreaId = 9 and YearName <= 1401 and id in (5, 8)

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 9 and YearName <= 1401 and IdGroup in (4,7)

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 9 and YearName <= 1401 and IdGroup in (5, 8)
return
end

if(@areaId = 11)
begin
delete olden.tblGroup           where AreaId = 11 and YearName <=1401
delete olden.tblKol             where AreaId = 11 and YearName <=1401
delete olden.tblMoien           where AreaId = 11 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 11 and YearName <=1401
delete olden.tblSanadState      where AreaId = 11 and YearName <=1401
delete olden.tblTafsily         where AreaId = 11 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 11 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 11 and YearName <=1401

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  11   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LFAVA.AccAMJ.dbo.tblGroup CROSS JOIN
										 LFAVA.AccAMJ.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (8, 9, 10,12))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    11  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            LFAVA.AccAMJ.dbo.tblKol CROSS JOIN
									 LFAVA.AccAMJ.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (8, 9, 10,12))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  11   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            LFAVA.AccAMJ.dbo.tblSal_MD CROSS JOIN
										 LFAVA.AccAMJ.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (8, 9, 10,12))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  11   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            LFAVA.AccAMJ.dbo.tblSal_MD CROSS JOIN
									 LFAVA.AccAMJ.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (8, 9, 10,12))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   11   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LFAVA.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         LFAVA.AccAMJ.dbo.tblSanadState
WHERE        (tblSal_MD.Id IN (8, 9, 10,12))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   11  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM            LFAVA.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         LFAVA.AccAMJ.dbo.tblTafsily
WHERE        (tblSal_MD.Id IN (8, 9, 10,12))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								case when IdSal_MD = 8  then 1398
										when IdSal_MD = 9  then 1399
										when IdSal_MD = 10 then 1400
										when IdSal_MD = 12 then 1401
										end ,   11   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LFAVA.AccAMJ.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    11  , 
						   											case when IdSalSanad_MD = 8  then 1398
																		 when IdSalSanad_MD = 9  then 1399
																		 when IdSalSanad_MD = 10 then 1400
																		 when IdSalSanad_MD = 12 then 1401
																		 end   ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LFAVA.AccAMJ.dbo.tblSanadDetail_MD

--کانورت 1397 فاوا
insert into olden.tblGroup(id , IdRecognition , IdKind,AreaId , YearName , Name     )
			      SELECT   Id , IdRecognition , IdKind,  11   ,   1397   , Name
FROM            LFAVA.AccAMJ1397.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   11   ,  1397   ,IdGroup , Name
	FROM            LFAVA.AccAMJ1397.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   11  ,   1397   ,IdKol ,Name
             FROM            LFAVA.AccAMJ1397.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id , 11     ,   1397  , Name
FROM            LFAVA.AccAMJ1397.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   11   ,   1397   , Name
					FROM            LFAVA.AccAMJ1397.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   11  ,   1397    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LFAVA.AccAMJ1397.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1397	,   11   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LFAVA.AccAMJ1397.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,IdSanad_MD ,   11   ,   1397   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LFAVA.AccAMJ1397.dbo.tblSanadDetail_MD

--کانورت 1396 فاوا
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   11  ,   1396   , Name
FROM            LFAVA.AccAMJ1396.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   11   ,  1396   ,IdGroup , Name
	FROM            LFAVA.AccAMJ1396.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   11  ,   1396   ,IdKol ,Name
             FROM            LFAVA.AccAMJ1396.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   11   ,   1396  , Name
FROM            LFAVA.AccAMJ1396.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   11   ,   1396   , Name
					FROM            LFAVA.AccAMJ1396.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   11  ,   1396    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LFAVA.AccAMJ1396.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1396	,   11   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LFAVA.AccAMJ1396.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD,  11   ,   1396   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LFAVA.AccAMJ1396.dbo.tblSanadDetail_MD
--کانورت 1395 فاوا
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   11  ,   1395   , Name
FROM            LFAVA.AccAMJ1395.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   11   ,  1395   ,IdGroup , Name
	FROM            LFAVA.AccAMJ1395.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   11  ,   1395   ,IdKol ,Name
             FROM            LFAVA.AccAMJ1395.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   11   ,   1395  , Name
FROM            LFAVA.AccAMJ1395.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   11   ,   1395   , Name
					FROM            LFAVA.AccAMJ1395.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   11  ,   1395    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LFAVA.AccAMJ1395.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1395	,   11   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LFAVA.AccAMJ1395.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   11   ,   1395   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LFAVA.AccAMJ1395.dbo.tblSanadDetail_MD
--کانورت 1394 فاوا
insert into olden.tblGroup( id , IdRecognition , IdKind , AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,    11  ,   1394   , Name
FROM            LFAVA.AccAMJ1394.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   11   ,  1394   ,IdGroup , Name
	FROM            LFAVA.AccAMJ1394.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   11  ,   1394   ,IdKol ,Name
             FROM            LFAVA.AccAMJ1394.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   11   ,   1394  , Name
FROM            LFAVA.AccAMJ1394.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   11   ,   1394   , Name
					FROM            LFAVA.AccAMJ1394.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   11  ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LFAVA.AccAMJ1394.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1394	,   11   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LFAVA.AccAMJ1394.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  11   ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LFAVA.AccAMJ1394.dbo.tblSanadDetail_MD
-- کانورت 1393  فاوا
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   11  ,   1393   , Name
FROM            LFAVA.AccAMJ1393.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   11   ,  1393   ,IdGroup , Name
	FROM            LFAVA.AccAMJ1393.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   11  ,   1393   ,IdKol ,Name
             FROM            LFAVA.AccAMJ1393.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   11   ,   1393  , Name
FROM            LFAVA.AccAMJ1393.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   11   ,   1393   , Name
					FROM            LFAVA.AccAMJ1393.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   11  ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LFAVA.AccAMJ1393.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1393	,   11   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LFAVA.AccAMJ1393.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  11   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LFAVA.AccAMJ1393.dbo.tblSanadDetail_MD
--کانورت 1392  فاوا
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   11  ,   1392   , Name
FROM            LFAVA.AccAMJ1392.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   11   ,  1392   ,IdGroup , Name
	FROM            LFAVA.AccAMJ1392.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   11  ,   1392   ,IdKol ,Name
             FROM            LFAVA.AccAMJ1392.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   11   ,   1392  , Name
FROM            LFAVA.AccAMJ1392.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   11   ,   1392   , Name
					FROM            LFAVA.AccAMJ1392.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   11  ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LFAVA.AccAMJ1392.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1392	,   11   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LFAVA.AccAMJ1392.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   11   ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LFAVA.AccAMJ1392.dbo.tblSanadDetail_MD
--کانورت 1391  فاوا
insert into olden.tblGroup( id , IdRecognition , IdKind , AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,    11  ,   1391   , Name
FROM            LFAVA.AccAMJ1391.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   11   ,  1391   ,IdGroup , Name
	FROM            LFAVA.AccAMJ1391.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   11  ,   1391   ,IdKol ,Name
             FROM            LFAVA.AccAMJ1391.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   11   ,   1391  , Name
FROM            LFAVA.AccAMJ1391.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   11   ,   1391   , Name
					FROM            LFAVA.AccAMJ1391.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   11  ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LFAVA.AccAMJ1391.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1391	,   11   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LFAVA.AccAMJ1391.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  11   ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LFAVA.AccAMJ1391.dbo.tblSanadDetail_MD
-- کانورت 1390 فاوا
insert into olden.tblGroup( id , IdRecognition , IdKind, AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,    11  ,   1390   , Name
FROM            LFAVA.AccAMJ1390.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   11   ,  1390   ,IdGroup , Name
	FROM            LFAVA.AccAMJ1390.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   11  ,   1390   ,IdKol ,Name
             FROM            LFAVA.AccAMJ1390.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   11   ,   1390  , Name
FROM            LFAVA.AccAMJ1390.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   11   ,   1390   , Name
					FROM            LFAVA.AccAMJ1390.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   11  ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LFAVA.AccAMJ1390.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1390	,   11   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LFAVA.AccAMJ1390.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  11   ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LFAVA.AccAMJ1390.dbo.tblSanadDetail_MD
--کانورت 1389 فاوا
insert into olden.tblGroup( id , IdRecognition , IdKind , AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,    11  ,   1389   , Name
FROM            LFAVA.AccAMJ1389.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   11   ,  1389   ,IdGroup , Name
	FROM            LFAVA.AccAMJ1389.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   11  ,   1389   ,IdKol ,Name
             FROM            LFAVA.AccAMJ1389.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   11   ,   1389  , Name
FROM            LFAVA.AccAMJ1389.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   11   ,   1389   , Name
					FROM            LFAVA.AccAMJ1389.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   11  ,   1389    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LFAVA.AccAMJ1389.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1389	,   11   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LFAVA.AccAMJ1389.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  11   ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LFAVA.AccAMJ1389.dbo.tblSanadDetail_MD
--کانورت 1388 فاوا
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   11  ,   1388   , Name
FROM            LFAVA.AccAMJ1388.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   11   ,  1388   ,IdGroup , Name
	FROM            LFAVA.AccAMJ1388.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   11  ,   1388   ,IdKol ,Name
             FROM            LFAVA.AccAMJ1388.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   11   ,   1388  , Name
FROM            LFAVA.AccAMJ1388.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   11   ,   1388   , Name
					FROM            LFAVA.AccAMJ1388.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   11  ,   1388    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LFAVA.AccAMJ1388.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1388	,   11   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LFAVA.AccAMJ1388.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  11   ,   1388   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LFAVA.AccAMJ1388.dbo.tblSanadDetail_MD
--کانورت 1387 فاوا
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   11  ,   1387   , Name
FROM            LFAVA.AccAMJ1387.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   11   ,  1387   ,IdGroup , Name
	FROM            LFAVA.AccAMJ1387.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   11  ,   1387   ,IdKol ,Name
             FROM            LFAVA.AccAMJ1387.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   11   ,   1387  , Name
FROM            LFAVA.AccAMJ1387.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   11   ,   1387   , Name
					FROM            LFAVA.AccAMJ1387.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   11  ,   1387    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LFAVA.AccAMJ1387.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1387	,   11   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LFAVA.AccAMJ1387.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  11   ,   1387   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LFAVA.AccAMJ1387.dbo.tblSanadDetail_MD
--کانورت 1386 فاوا
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   11  ,   1386   , Name
FROM            LFAVA.AccAMJ1386.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   11   ,  1386   ,IdGroup , Name
	FROM            LFAVA.AccAMJ1386.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   11  ,   1386   ,IdKol ,Name
             FROM            LFAVA.AccAMJ1386.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   11   ,   1386  , Name
FROM            LFAVA.AccAMJ1386.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   11   ,   1386   , Name
					FROM            LFAVA.AccAMJ1386.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   11  ,   1386    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LFAVA.AccAMJ1386.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1386	,   11   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LFAVA.AccAMJ1386.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  11   ,   1386   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LFAVA.AccAMJ1386.dbo.tblSanadDetail_MD
--کانورت 1385 فاوا
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   11  ,   1385   , Name
FROM            LFAVA.AccAMJ1385.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   11   ,  1385   ,IdGroup , Name
	FROM            LFAVA.AccAMJ1385.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   11  ,   1385   ,IdKol ,Name
             FROM            LFAVA.AccAMJ1385.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   11   ,   1385  , Name
FROM            LFAVA.AccAMJ1385.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   11   ,   1385  , Name
					FROM            LFAVA.AccAMJ1385.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   11  ,   1385    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LFAVA.AccAMJ1385.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1385	,   11   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LFAVA.AccAMJ1385.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  11   ,   1385   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LFAVA.AccAMJ1385.dbo.tblSanadDetail_MD
--کانورت 1384 فاوا
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   11  ,   1384   , Name
FROM            LFAVA.AccAMJ1384.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   11   ,  1384   ,IdGroup , Name
	FROM            LFAVA.AccAMJ1384.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   11  ,   1384   ,IdKol ,Name
             FROM            LFAVA.AccAMJ1384.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   11   ,   1384  , Name
FROM            LFAVA.AccAMJ1384.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   11   ,   1384   , Name
					FROM            LFAVA.AccAMJ1384.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   11  ,   1384    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            LFAVA.AccAMJ1384.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1384	,   11   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LFAVA.AccAMJ1384.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  11   ,   1384   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LFAVA.AccAMJ1384.dbo.tblSanadDetail_MD

update olden.tblGroup
  set  id = 888
  Where AreaId = 11 and YearName <= 1401 and id in (6)

update olden.tblGroup
  set  id = 999
  Where AreaId = 11 and YearName <= 1401 and id in (7)

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 11 and YearName <= 1401 and IdGroup in (6)

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 11 and YearName <= 1401 and IdGroup in (7)
return
end

--**********************************************************************
--**********************************************************************
--**********************************************************************

if(@areaId = 12)
begin
delete olden.tblGroup           where AreaId = 12 and YearName <=1401
delete olden.tblKol             where AreaId = 12 and YearName <=1401
delete olden.tblMoien           where AreaId = 12 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 12 and YearName <=1401
delete olden.tblSanadState      where AreaId = 12 and YearName <=1401
delete olden.tblTafsily         where AreaId = 12 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 12 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 12 and YearName <=1401

insert into olden.tblGroup(        id    , IdRecognition , IdKind,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind,  12   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            Lfire.AccAMJ295.dbo.tblGroup CROSS JOIN
										 Lfire.AccAMJ295.dbo.tblSal_MD
						WHERE        (tblSal_MD.Id IN (5,6,7,8,9,10,12))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    12  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            Lfire.AccAMJ295.dbo.tblKol CROSS JOIN
									 Lfire.AccAMJ295.dbo.tblSal_MD
						WHERE        (tblSal_MD.Id IN (5,6,7,8,9,10,12))


insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  12   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            Lfire.AccAMJ295.dbo.tblSal_MD CROSS JOIN
										 Lfire.AccAMJ295.dbo.tblMoien
                        WHERE        (tblSal_MD.Id IN (5,6,7,8,9,10,12))


insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  12   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            Lfire.AccAMJ295.dbo.tblSal_MD CROSS JOIN
									 Lfire.AccAMJ295.dbo.tblSanadKind
                         WHERE        (tblSal_MD.Id IN (5,6,7,8,9,10,12))
				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   12   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            Lfire.AccAMJ295.dbo.tblSal_MD CROSS JOIN
                         Lfire.AccAMJ295.dbo.tblSanadState
 				          WHERE        (tblSal_MD.Id IN (5,6,7,8,9,10,12))


insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   12  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM            Lfire.AccAMJ295.dbo.tblSal_MD CROSS JOIN
                         Lfire.AccAMJ295.dbo.tblTafsily
						   WHERE        (tblSal_MD.Id IN (5,6,7,8,9,10,12))
				
insert into olden.tblSanad_MD(Id ,      YearName                 , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								CASE WHEN IdSal_MD = 5  THEN 1395 
								     WHEN IdSal_MD = 6  THEN 1396 
									 WHEN IdSal_MD = 7  THEN 1397 
									 WHEN IdSal_MD = 8  THEN 1398 
									 WHEN IdSal_MD = 9  THEN 1399 
									 WHEN IdSal_MD = 10 THEN 1400
									 WHEN IdSal_MD = 12 THEN 1401
									 END                         ,   12  , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lfire.AccAMJ295.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId ,         YearName                    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   12   , CASE WHEN IdSalSanad_MD = 5  THEN 1395 
						                                            WHEN IdSalSanad_MD = 6  THEN 1396 
																	WHEN IdSalSanad_MD = 7  THEN 1397 
																	WHEN IdSalSanad_MD = 8  THEN 1398 
																	WHEN IdSalSanad_MD = 9  THEN 1399 
																	WHEN IdSalSanad_MD = 10 THEN 1400
																	WHEN IdSalSanad_MD = 12 THEN 1401
																	END                              ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            Lfire.AccAMJ295.dbo.tblSanadDetail_MD


--کانورت 1394 آتش نشانی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   12  ,   1394   , Name
FROM            Lfire.AccAMJ294.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   12   ,  1394   ,IdGroup , Name
	FROM            Lfire.AccAMJ294.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   12  ,   1394   ,IdKol ,Name
             FROM            Lfire.AccAMJ294.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   12   ,   1394  , Name
FROM            Lfire.AccAMJ294.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   12   ,   1394   , Name
					FROM            Lfire.AccAMJ294.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   12  ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            Lfire.AccAMJ294.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1394	,   12   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lfire.AccAMJ294.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  12   ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            Lfire.AccAMJ294.dbo.tblSanadDetail_MD

-- کانورت 1393  آتش نشانی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   12  ,   1393   , Name
FROM            Lfire.AccAMJ293.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   12   ,  1393   ,IdGroup , Name
	FROM            Lfire.AccAMJ293.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   12  ,   1393   ,IdKol ,Name
             FROM            Lfire.AccAMJ293.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   12   ,   1393  , Name
FROM            Lfire.AccAMJ293.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   12   ,   1393   , Name
					FROM            Lfire.AccAMJ293.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   12  ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            Lfire.AccAMJ293.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1393	,   12   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lfire.AccAMJ293.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  12   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            Lfire.AccAMJ293.dbo.tblSanadDetail_MD

--کانورت 1392  آتش نشانی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   12  ,   1392   , Name
                  FROM Lfire.AccAMJ192.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   12   ,  1392   ,IdGroup , Name
	           FROM Lfire.AccAMJ192.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   12  ,   1392   ,IdKol ,Name
                  FROM   Lfire.AccAMJ192.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   12   ,   1392  , Name
                 FROM  Lfire.AccAMJ192.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   12   ,   1392   , Name
					FROM   Lfire.AccAMJ192.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   12  ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            Lfire.AccAMJ192.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1392	,   12   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lfire.AccAMJ192.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  12   ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            Lfire.AccAMJ192.dbo.tblSanadDetail_MD

--کانورت 1391  آتش نشانی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   12  ,   1391   , Name
FROM            Lfire.AccAMJ191.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   12   ,  1391   ,IdGroup , Name
	FROM            Lfire.AccAMJ191.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   12  ,   1391   ,IdKol ,Name
                  FROM  Lfire.AccAMJ191.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   12   ,   1391  , Name
                    FROM Lfire.AccAMJ191.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   12   ,   1391   , Name
					FROM      Lfire.AccAMJ191.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   12  ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
		            FROM    Lfire.AccAMJ191.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1391	,   12   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
						FROM Lfire.AccAMJ191.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  12   ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM      Lfire.AccAMJ191.dbo.tblSanadDetail_MD


-- کانورت 1390 آتش نشانی
insert into olden.tblGroup( id , IdRecognition , IdKind , AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   12  ,   1390   , Name
FROM            Lfire.AccAMJ190.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   12   ,  1390   ,IdGroup , Name
	FROM            Lfire.AccAMJ190.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   12  ,   1390   ,IdKol ,Name
             FROM            Lfire.AccAMJ190.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   12   ,   1390  , Name
                  FROM  Lfire.AccAMJ190.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   12   ,   1390   , Name
					FROM       Lfire.AccAMJ190.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   12  ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
		             FROM  Lfire.AccAMJ190.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1390	,   12   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
					FROM Lfire.AccAMJ190.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  12   ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   Lfire.AccAMJ190.dbo.tblSanadDetail_MD

--کانورت 1389 آتش نشانی
insert into olden.tblGroup( id , IdRecognition , IdKind , AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,    12  ,   1389   , Name
FROM            Lfire.AccAMJ189.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   12   ,  1389   ,IdGroup , Name
	FROM           Lfire.AccAMJ189.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   12  ,   1389   ,IdKol ,Name
             FROM            Lfire.AccAMJ189.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   12   ,   1389  , Name
FROM           Lfire.AccAMJ189.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   12   ,   1389   , Name
					FROM           Lfire.AccAMJ189.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   12  ,   1389    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            Lfire.AccAMJ189.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1389	,   12   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lfire.AccAMJ189.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  12   ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            Lfire.AccAMJ189.dbo.tblSanadDetail_MD

--کانورت 1388 آتش نشانی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   12  ,   1388   , Name
FROM            Lfire.AccAMJ188.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   12   ,  1388   ,IdGroup , Name
	FROM            Lfire.AccAMJ188.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   12  ,   1388   ,IdKol ,Name
             FROM           Lfire.AccAMJ188.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   12   ,   1388  , Name
FROM         Lfire.AccAMJ188.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   12   ,   1388   , Name
					FROM            Lfire.AccAMJ188.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   12  ,   1388    , IdTafsilyGroup , Name , IdTafsilyType
		FROM           Lfire.AccAMJ188.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1388	,   12   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM  Lfire.AccAMJ188.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  12   ,   1388   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            Lfire.AccAMJ188.dbo.tblSanadDetail_MD
--کانورت 1387 آتش نشانی
insert into olden.tblGroup( id , IdRecognition , IdKind , AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,    12  ,   1387   , Name
FROM            Lfire.AccAMJ187.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   12   ,  1387   ,IdGroup , Name
	FROM            Lfire.AccAMJ187.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   12  ,   1387   ,IdKol ,Name
             FROM            Lfire.AccAMJ187.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   12   ,   1387  , Name
FROM            Lfire.AccAMJ187.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   12   ,   1387   , Name
					FROM            Lfire.AccAMJ187.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   12  ,   1387    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            Lfire.AccAMJ187.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1387	,   12   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lfire.AccAMJ187.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  12   ,   1387   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            Lfire.AccAMJ187.dbo.tblSanadDetail_MD
--کانورت 1386 آتش نشانی
insert into olden.tblGroup( id , IdRecognition , IdKind , AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,    12  ,   1386   , Name
FROM            Lfire.AccAMJ186.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   12   ,  1386   ,IdGroup , Name
	FROM           Lfire.AccAMJ186.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   12  ,   1386   ,IdKol ,Name
             FROM            Lfire.AccAMJ186.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   12   ,   1386  , Name
FROM           Lfire.AccAMJ186.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   12   ,   1386   , Name
					FROM          Lfire.AccAMJ186.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   12  ,   1386    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            Lfire.AccAMJ186.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1386	,   12   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lfire.AccAMJ186.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  12   ,   1386   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            Lfire.AccAMJ186.dbo.tblSanadDetail_MD
--کانورت 1385 آتش نشانی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   12  ,   1385   , Name
FROM            Lfire.AccAMJ185.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   12   ,  1385   ,IdGroup , Name
	FROM            Lfire.AccAMJ185.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   12  ,   1385   ,IdKol ,Name
             FROM            Lfire.AccAMJ185.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   12   ,   1385  , Name
FROM            Lfire.AccAMJ185.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   12   ,   1385  , Name
					FROM            Lfire.AccAMJ185.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   12  ,   1385    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            Lfire.AccAMJ185.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1385	,   12   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lfire.AccAMJ185.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  12   ,   1385   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            Lfire.AccAMJ185.dbo.tblSanadDetail_MD
--کانورت 1384 آتش نشانی
insert into olden.tblGroup( id , IdRecognition , IdKind,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind,   12  ,   1384   , Name
FROM            Lfire.AccAMJ184.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   12   ,  1384   ,IdGroup , Name
	FROM            Lfire.AccAMJ184.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   12  ,   1384   ,IdKol ,Name
             FROM            Lfire.AccAMJ184.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   12   ,   1384  , Name
FROM            Lfire.AccAMJ184.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   12   ,   1384   , Name
					FROM            Lfire.AccAMJ184.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   12  ,   1384    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            Lfire.AccAMJ184.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1384	,   12   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lfire.AccAMJ184.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  12   ,   1384   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            Lfire.AccAMJ184.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 12 and YearName <= 1401 and id = 4

update olden.tblGroup
  set  id = 999
  Where AreaId = 12 and YearName <= 1401 and id = 7

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 12 and YearName <= 1401 and IdGroup = 4

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 12 and YearName <= 1401 and IdGroup = 7
return
end
--***********************************************************
--***********************************************************
--***********************************************************

if(@areaId = 13)
begin
delete olden.tblGroup           where AreaId = 13 and YearName <=1401
delete olden.tblKol             where AreaId = 13 and YearName <=1401
delete olden.tblMoien           where AreaId = 13 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 13 and YearName <=1401
delete olden.tblSanadState      where AreaId = 13 and YearName <=1401
delete olden.tblTafsily         where AreaId = 13 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 13 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 13 and YearName <=1401

insert into olden.tblGroup(        id    ,  IdRecognition , IdKind, AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id ,  IdRecognition , IdKind,   13   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            Lbus.AccAMJ295.dbo.tblGroup CROSS JOIN
										 Lbus.AccAMJ295.dbo.tblSal_MD
								  WHERE        (tblSal_MD.Id IN (5,6,7,8,9,10,11))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    13  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            Lbus.AccAMJ295.dbo.tblKol CROSS JOIN
									 Lbus.AccAMJ295.dbo.tblSal_MD
                                  WHERE        (tblSal_MD.Id IN (5,6,7,8,9,10,11))

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  13   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            Lbus.AccAMJ295.dbo.tblSal_MD CROSS JOIN
										 Lbus.AccAMJ295.dbo.tblMoien
                                   WHERE        (tblSal_MD.Id IN (5,6,7,8,9,10,11))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  13   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            Lbus.AccAMJ295.dbo.tblSal_MD CROSS JOIN
									 Lbus.AccAMJ295.dbo.tblSanadKind
				                    WHERE        (tblSal_MD.Id IN (5,6,7,8,9,10,11))

insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   13   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            Lbus.AccAMJ295.dbo.tblSal_MD CROSS JOIN
                         Lbus.AccAMJ295.dbo.tblSanadState
						   WHERE        (tblSal_MD.Id IN (5,6,7,8,9,10,11))

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   13  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM            Lbus.AccAMJ295.dbo.tblSal_MD CROSS JOIN
                         Lbus.AccAMJ295.dbo.tblTafsily
						   WHERE        (tblSal_MD.Id IN (5,6,7,8,9,10,11))
				
insert into olden.tblSanad_MD(Id ,      YearName                 , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								CASE WHEN IdSal_MD = 5  THEN 1395 
								     WHEN IdSal_MD = 6  THEN 1396 
									 WHEN IdSal_MD = 7  THEN 1397 
									 WHEN IdSal_MD = 8  THEN 1398 
									 WHEN IdSal_MD = 9  THEN 1399 
									 WHEN IdSal_MD = 10 THEN 1400 
									 WHEN IdSal_MD = 11 THEN 1401 
									 END                         ,   13  , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lbus.AccAMJ295.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId ,         YearName                    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   13   , CASE WHEN IdSalSanad_MD = 5  THEN 1395 
						                                            WHEN IdSalSanad_MD = 6  THEN 1396 
																	WHEN IdSalSanad_MD = 7  THEN 1397 
																	WHEN IdSalSanad_MD = 8  THEN 1398 
																	WHEN IdSalSanad_MD = 9  THEN 1399 
																	WHEN IdSalSanad_MD = 10 THEN 1400 
																	WHEN IdSalSanad_MD = 11 THEN 1401 
																    END                              ,IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            Lbus.AccAMJ295.dbo.tblSanadDetail_MD


--کانورت 1394  اتوبوسرانی
insert into olden.tblGroup( id ,  IdRecognition , IdKind , AreaId , YearName , Name )
	          SELECT        Id ,  IdRecognition , IdKind ,    13  ,   1394   , Name
FROM            Lbus.AccAMJ294.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   13   ,  1394   ,IdGroup , Name
	FROM            Lbus.AccAMJ294.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   13  ,   1394   ,IdKol ,Name
             FROM            Lbus.AccAMJ294.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   13   ,   1394  , Name
FROM            Lbus.AccAMJ294.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   13   ,   1394   , Name
					FROM            Lbus.AccAMJ294.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   13  ,   1394    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            Lbus.AccAMJ294.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1394	,   13   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lbus.AccAMJ294.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  13   ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            Lbus.AccAMJ294.dbo.tblSanadDetail_MD

-- کانورت 1393  اتوبوسرانی
insert into olden.tblGroup( id ,  IdRecognition , IdKind , AreaId , YearName , Name )
	          SELECT        Id ,  IdRecognition , IdKind ,    13  ,   1393   , Name
FROM            Lbus.AccAMJ293.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   13   ,  1393   ,IdGroup , Name
	FROM            Lbus.AccAMJ293.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   13  ,   1393   ,IdKol ,Name
             FROM            Lbus.AccAMJ293.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   13   ,   1393  , Name
FROM            Lbus.AccAMJ293.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   13   ,   1393   , Name
					FROM            Lbus.AccAMJ293.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   13  ,   1393    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            Lbus.AccAMJ293.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1393	,   13   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lbus.AccAMJ293.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  13   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            Lbus.AccAMJ293.dbo.tblSanadDetail_MD

--کانورت 1392  اتوبوسرانی
insert into olden.tblGroup( id , IdRecognition , IdKind , AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   13   ,   1392   , Name
                  FROM Lbus.AccAMJ292.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   13   ,  1392   ,IdGroup , Name
	           FROM Lbus.AccAMJ292.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   13  ,   1392   ,IdKol ,Name
                  FROM   Lbus.AccAMJ292.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   13   ,   1392  , Name
                 FROM  Lbus.AccAMJ292.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   13   ,   1392   , Name
					FROM   Lbus.AccAMJ292.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   13  ,   1392    , IdTafsilyGroup , Name , IdTafsilyType
		FROM            Lbus.AccAMJ292.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1392	,   13   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lbus.AccAMJ292.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,  IdSanad_MD ,  13   ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            Lbus.AccAMJ292.dbo.tblSanadDetail_MD

--کانورت 1391  اتوبوسرانی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   13  ,   1391   , Name
FROM            Lbus.AccAMJ291.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   13   ,  1391   ,IdGroup , Name
	FROM            Lbus.AccAMJ291.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   13  ,   1391   ,IdKol ,Name
                  FROM  Lbus.AccAMJ291.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   13   ,   1391  , Name
                    FROM Lbus.AccAMJ291.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   13   ,   1391   , Name
					FROM      Lbus.AccAMJ291.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   13  ,   1391    , IdTafsilyGroup , Name , IdTafsilyType
		            FROM    Lbus.AccAMJ291.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1391	,   13   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
						FROM Lbus.AccAMJ291.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,  IdSanad_MD ,  13   ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM      Lbus.AccAMJ291.dbo.tblSanadDetail_MD

-- کانورت 1390 اتوبوسرانی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   13  ,   1390   , Name
FROM            Lbus.AccAMJ290.dbo.tblGroup AS tblGroup_1

insert into olden.tblKol( id  , AreaId ,YearName ,IdGroup , Name )
			SELECT        Id  ,   13   ,  1390   ,IdGroup , Name
	FROM            Lbus.AccAMJ290.dbo.tblKol AS tblKol_1
	

insert into olden.tblMoien(Id ,AreaId , YearName ,IdKol ,Name)
			   SELECT      Id ,   13  ,   1390   ,IdKol ,Name
             FROM            Lbus.AccAMJ290.dbo.tblMoien AS tblMoien_1

insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
		         SELECT        Id ,   13   ,   1390  , Name
                  FROM  Lbus.AccAMJ290.dbo.tblSanadKind AS tblSanadKind_1				 

				
insert into olden.tblSanadState(Id , AreaId , YearName , Name)
					SELECT      Id ,   13   ,   1390   , Name
					FROM       Lbus.AccAMJ290.dbo.tblSanadState AS tblSanadState_1
					  

insert into olden.tblTafsily(Id , IdSotooh , AreaId, YearName  , IdTafsilyGroup , Name , IdTafsilyType )
				    SELECT   Id , IdSotooh ,   13  ,   1390    , IdTafsilyGroup , Name , IdTafsilyType
		             FROM  Lbus.AccAMJ290.dbo.tblTafsily AS tblTafsily_1

				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,   1390	,   13   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
					FROM Lbus.AccAMJ290.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,  IdSanad_MD ,  13   ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   Lbus.AccAMJ290.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 13 and YearName <= 1401 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 13 and YearName <= 1401 and id = 5

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 13 and YearName <= 1401 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 13 and YearName <= 1401 and IdGroup = 5
return
end
--***********************************************************
--***********************************************************
--***********************************************************
if(@areaId = 14)
begin
delete olden.tblGroup           where AreaId = 14 and YearName <=1401
delete olden.tblKol             where AreaId = 14 and YearName <=1401
delete olden.tblMoien           where AreaId = 14 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 14 and YearName <=1401
delete olden.tblSanadState      where AreaId = 14 and YearName <=1401
delete olden.tblTafsily         where AreaId = 14 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 14 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 14 and YearName <=1401

insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  14   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            Lbehsazi.AccAMJ.dbo.tblGroup CROSS JOIN
										 Lbehsazi.AccAMJ.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (5, 6, 7, 8, 9, 11,10))

insert into olden.tblKol(   id     , AreaId ,      YearName       ,     IdGroup   ,    Name    )
				SELECT   tblKol.Id ,    14  , tblSal_MD.IdSal_MD_S, tblKol.IdGroup, tblKol.Name 
			FROM            Lbehsazi.AccAMJ.dbo.tblKol CROSS JOIN
									 Lbehsazi.AccAMJ.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN (5, 6, 7, 8, 9, 11,10))
	

insert into olden.tblMoien(         Id   ,AreaId ,       YearName     ,      IdKol    ,     Name     )
				SELECT       tblMoien.Id ,  14   ,tblSal_MD.IdSal_MD_S, tblMoien.IdKol, tblMoien.Name
				FROM            Lbehsazi.AccAMJ.dbo.tblSal_MD CROSS JOIN
										 Lbehsazi.AccAMJ.dbo.tblMoien
				WHERE        (tblSal_MD.Id IN (5, 6, 7, 8, 9, 11,10))

insert into olden.tblSanadKind(    Id    ,AreaId ,      YearName       ,        Name      )
			SELECT        tblSanadKind.Id,  14   , tblSal_MD.IdSal_MD_S,tblSanadKind.Name 
			FROM            Lbehsazi.AccAMJ.dbo.tblSal_MD CROSS JOIN
									 Lbehsazi.AccAMJ.dbo.tblSanadKind
			WHERE        (tblSal_MD.Id IN (5, 6, 7, 8, 9, 11,10))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   14   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            Lbehsazi.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         Lbehsazi.AccAMJ.dbo.tblSanadState
WHERE        (tblSal_MD.Id IN (5, 6, 7, 8, 9, 11,10))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   14  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM            Lbehsazi.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         Lbehsazi.AccAMJ.dbo.tblTafsily
WHERE        (tblSal_MD.Id IN (5, 6, 7, 8, 9,  11,10))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 5  then 1395
										when IdSal_MD = 6  then 1396
										when IdSal_MD = 7  then 1397
										when IdSal_MD = 8  then 1398
										when IdSal_MD = 9  then 1400
										when IdSal_MD = 11 then 1399
										when IdSal_MD = 10  then 1401
										end ,   14   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM Lbehsazi.AccAMJ.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                        , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    14  , 
						   											     case when IdSalSanad_MD = 5  then 1395
										                                      when IdSalSanad_MD = 6  then 1396
										                                      when IdSalSanad_MD = 7  then 1397
										                                      when IdSalSanad_MD = 8  then 1398
										                                      when IdSalSanad_MD = 9  then 1400
										                                      when IdSalSanad_MD = 11 then 1399
																			  when IdSalSanad_MD = 10 then 1401
																			  end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            Lbehsazi.AccAMJ.dbo.tblSanadDetail_MD


--کانورت 1394 نوسازی بهسازی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   14  ,   1394   , Name
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

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,  IdSanad_MD ,  14   ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   14   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   14   ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  14   ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            Lbehsazi.AccAMJ191.dbo.tblSanadDetail_MD

-- کانورت 1390 نوسازی بهسازی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   14  ,   1390   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  14   ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            Lbehsazi.AccAMJ190.dbo.tblSanadDetail_MD

------------------------کانورت 1389 نوسازی بهسازی----------------------------------------------
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  14  ,   1389   , Name
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

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,  IdSanad_MD ,  14   ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            Lbehsazi.AccAMJ189.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 14 and YearName <= 1401 and id = 7

update olden.tblGroup
  set  id = 999
  Where AreaId = 14 and YearName <= 1401 and id = 6

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 14 and YearName <= 1401 and IdGroup = 7

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 14 and YearName <= 1401 and IdGroup = 6
return
end
--*************************************************************
--*************************************************************
--*************************************************************
if(@areaId = 15)
begin
delete olden.tblGroup           where AreaId = 15 and YearName <= 1401
delete olden.tblKol             where AreaId = 15 and YearName <= 1401
delete olden.tblMoien           where AreaId = 15 and YearName <= 1401
delete olden.tblSanadKind       where AreaId = 15 and YearName <= 1401
delete olden.tblSanadState      where AreaId = 15 and YearName <= 1401
delete olden.tblTafsily         where AreaId = 15 and YearName <= 1401
delete olden.tblSanad_MD        where AreaId = 15 and YearName <= 1401
delete olden.tblSanadDetail_MD  where AreaId = 15 and YearName <= 1401
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                        , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    15  , 
						   											     case when IdSalSanad_MD = 6  then 1396
										                                      when IdSalSanad_MD = 7  then 1397
										                                      when IdSalSanad_MD = 8  then 1398
										                                      when IdSalSanad_MD = 9  then 1399
										                                      when IdSalSanad_MD = 10 then 1400
																			  when IdSalSanad_MD = 11 then 1401
																			  end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,  IdSanad_MD ,  15   ,   1395   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,  IdSanad_MD ,  15   ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,  IdSanad_MD ,  15   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,  IdSanad_MD ,  15   ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,  IdSanad_MD ,  15   ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  15   ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,  IdSanad_MD ,  15   ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,  IdSanad_MD ,  15   ,   1388   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   15   ,   1387   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   15   ,   1386   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   15   ,   1385   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   15   ,   1384   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LPARK.AccAMJ184.dbo.tblSanadDetail_MD

--کانورت 1383  پارکها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   15  ,   1383   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   15   ,   1383   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   15   ,   1382   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   15   ,   1381   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   15   ,   1380   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  15   ,   1379   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,  IdSanad_MD ,   15  ,   1378   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   15   ,   1377   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   15   ,   1376   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LPARK.AccAMJ176.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 15 and YearName <= 1401 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 15 and YearName <= 1401 and id = 7

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 15 and YearName <= 1401 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 15 and YearName <= 1401 and IdGroup = 7
return
end
--***********************************************************
--***********************************************************
--***********************************************************
if(@areaId = 16)
begin
delete olden.tblGroup           where AreaId = 16 and YearName <=1401
delete olden.tblKol             where AreaId = 16 and YearName <=1401
delete olden.tblMoien           where AreaId = 16 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 16 and YearName <=1401
delete olden.tblSanadState      where AreaId = 16 and YearName <=1401
delete olden.tblTafsily         where AreaId = 16 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 16 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 16 and YearName <=1401

insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  16   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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
			WHERE        (tblSal_MD.Id IN (8, 9, 10,11 ))					 

				
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                          , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    16  , 
						   											     case when IdSalSanad_MD = 8   then 1398
										                                      when IdSalSanad_MD = 9   then 1399
										                                      when IdSalSanad_MD = 10  then 1400
																			  when IdSalSanad_MD = 11  then 1401
																			  end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTERMINAL.AccAmj.dbo.tblSanadDetail_MD


--کانورت 1397  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   16  ,   1397   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   16   ,   1397   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTERMINAL.AccAMJ197.dbo.tblSanadDetail_MD

--کانورت 1396  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   16  ,   1396   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   16   ,   1396   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTERMINAL.AccAMJ196.dbo.tblSanadDetail_MD

--کانورت 1395  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  16   ,   1395   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   16   ,   1395   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTERMINAL.AccAMJ195.dbo.tblSanadDetail_MD


--کانورت 1394  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   16  ,   1394   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   16   ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTERMINAL.AccAMJ194.dbo.tblSanadDetail_MD

--کانورت 1393  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   16  ,   1393   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   16   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTERMINAL.AccAMJ193.dbo.tblSanadDetail_MD

--کانورت 1392  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   16  ,   1392   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   16   ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTERMINAL.AccAMJ192.dbo.tblSanadDetail_MD

--کانورت 1391  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   16  ,   1391   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   16   ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTERMINAL.AccAMJ191.dbo.tblSanadDetail_MD

--کانورت 1390  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   16  ,   1390   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   16   ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTERMINAL.AccAMJ190.dbo.tblSanadDetail_MD

--کانورت 1389  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   16  ,   1389   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   16   ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTERMINAL.AccAMJ189.dbo.tblSanadDetail_MD

--کانورت 1388  پایانه ها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   16  ,   1388   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   16   ,   1388   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTERMINAL.AccAMJ188.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 16 and YearName <= 1401 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 16 and YearName <= 1401 and id = 7

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 16 and YearName <= 1401 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 16 and YearName <= 1401 and IdGroup = 7
return
end
--*******************************************************
--*******************************************************
--*******************************************************
--*******************************************************
if(@areaId = 17)
begin
delete olden.tblGroup           where AreaId = 17 and YearName <=1401
delete olden.tblKol             where AreaId = 17 and YearName <=1401
delete olden.tblMoien           where AreaId = 17 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 17 and YearName <=1401
delete olden.tblSanadState      where AreaId = 17 and YearName <=1401
delete olden.tblTafsily         where AreaId = 17 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 17 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 17 and YearName <=1401
insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  17   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                         , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    17  , 
						   											     case when IdSalSanad_MD = 6   then 1396
										                                      when IdSalSanad_MD = 7   then 1397
																			  when IdSalSanad_MD = 8   then 1398
										                                      when IdSalSanad_MD = 9   then 1399
										                                      when IdSalSanad_MD = 10  then 1400
																			  when IdSalSanad_MD = 11  then 1401
																			  end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTAXI.AccAMJ1095.dbo.tblSanadDetail_MD


--کانورت 1395  تاکسیرانی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   17  ,   1395   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   17   ,   1395   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTAXI.AccAMJ1195.dbo.tblSanadDetail_MD

 --کانورت 1394  تاکسیرانی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   17  ,   1394   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   17   ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTAXI.AccAMJ1094.dbo.tblSanadDetail_MD

--کانورت 1393  تاکسیرانی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   17  ,   1393   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   17   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTAXI.AccAMJ1093.dbo.tblSanadDetail_MD

--کانورت 1392  تاکسیرانی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   17  ,   1392   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   17   ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTAXI.AccAMJ1092.dbo.tblSanadDetail_MD

--کانورت 1391  تاکسیرانی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   17  ,   1391   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   17   ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTAXI.AccAMJ1091.dbo.tblSanadDetail_MD

--کانورت 1390  تاکسیرانی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   17  ,   1390   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   17   ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTAXI.AccAMJ1090.dbo.tblSanadDetail_MD

--کانورت 1389  تاکسیرانی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   17  ,   1389   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   17   ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTAXI.AccAMJ1089.dbo.tblSanadDetail_MD

--کانورت 1388  تاکسیرانی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   17  ,   1388   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   17   ,   1388   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LTAXI.AccAMJ1088.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 17 and YearName <= 1401 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 17 and YearName <= 1401 and id = 7

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 17 and YearName <= 1401 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 17 and YearName <= 1401 and IdGroup = 7
return
end
--**********************************************************
--**********************************************************
--**********************************************************
if(@areaId = 18)
begin
delete olden.tblGroup           where AreaId = 18 and YearName<=1401
delete olden.tblKol             where AreaId = 18 and YearName<=1401
delete olden.tblMoien           where AreaId = 18 and YearName<=1401
delete olden.tblSanadKind       where AreaId = 18 and YearName<=1401
delete olden.tblSanadState      where AreaId = 18 and YearName<=1401
delete olden.tblTafsily         where AreaId = 18 and YearName<=1401
delete olden.tblSanad_MD        where AreaId = 18 and YearName<=1401
delete olden.tblSanadDetail_MD  where AreaId = 18 and YearName<=1401
insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  18   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                        , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
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
										                                      when IdSalSanad_MD = 27  then 1399 end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM  LMOTORI.AccAMJ1399.dbo.tblSanadDetail_MD

-- سال های  1400  تا 1402 موتوری

insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  18   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
				FROM            LMOTORI.AccAMJ.dbo.tblGroup CROSS JOIN
										 LMOTORI.AccAMJ.dbo.tblSal_MD
				WHERE        (tblSal_MD.Id IN ( 10,14))

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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                          , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,   18   ,   
						   											     case when IdSalSanad_MD = 10  then 1400
																		      when IdSalSanad_MD = 14  then 1401
																		 end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM  LMOTORI.AccAMJ.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 18 and YearName <= 1401 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 18 and YearName <= 1401 and id in (7,8)

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 18 and YearName <= 1401 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 18 and YearName <= 1401 and IdGroup in(7,8)
return
end
--********************************************************
--********************************************************
--********************************************************
if(@areaId = 19)
begin
delete olden.tblGroup           where AreaId = 19 and YearName <=1401
delete olden.tblKol             where AreaId = 19 and YearName <=1401
delete olden.tblMoien           where AreaId = 19 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 19 and YearName <=1401
delete olden.tblSanadState      where AreaId = 19 and YearName <=1401
delete olden.tblTafsily         where AreaId = 19 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 19 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 19 and YearName <=1401
insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  19   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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
								   case when IdSal_MD = 7   then 1399
								        when IdSal_MD = 9   then 1400
										when IdSal_MD = 10  then 1401
										                            end ,   19   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LBEHESHT.AccAMJ.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                     , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,   19   , 
						   											     case when IdSalSanad_MD = 7   then 1399
										                                      when IdSalSanad_MD = 9   then 1400
																			  when IdSalSanad_MD = 10  then 1401
																			                                end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM  LBEHESHT.AccAMJ.dbo.tblSanadDetail_MD

--کانورت 1398  آرامستانها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  19   ,   1398   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   19   ,   1398   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LBEHESHT.AccAmj198.dbo.tblSanadDetail_MD

--کانورت 1397  آرامستانها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  19   ,   1397   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   19   ,   1397   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LBEHESHT.AccAmj197.dbo.tblSanadDetail_MD

--کانورت 1396  آرامستانها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  19   ,   1396   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   19   ,   1396   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LBEHESHT.AccAmj196.dbo.tblSanadDetail_MD

--کانورت 1395  آرامستانها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  19   ,   1395   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   19   ,   1395   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LBEHESHT.AccAmj195.dbo.tblSanadDetail_MD

--کانورت 1394  آرامستانها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  19   ,   1394   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   19   ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LBEHESHT.AccAmj194.dbo.tblSanadDetail_MD

--کانورت 1393  آرامستانها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  19   ,   1393   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   19   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LBEHESHT.AccAmj193.dbo.tblSanadDetail_MD

--کانورت 1392  آرامستانها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  19   ,   1392   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   19   ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LBEHESHT.AccAmj192.dbo.tblSanadDetail_MD

--کانورت 1391  آرامستانها

insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  19   ,   1391   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   19   ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LBEHESHT.AccAmj191.dbo.tblSanadDetail_MD


--کانورت 1390  آرامستانها
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  19   ,   1390   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   19   ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  19   ,   1388   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   19   ,   1388   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LBEHESHT.AccAmj188.dbo.tblSanadDetail_MD

--کانورت 1387  آرامستانها

insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  19   ,   1387   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   19   ,   1387   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  19   ,   1385   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   19   ,   1385   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LBEHESHT.AccAmj185.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 19 and YearName <= 1401 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 19 and YearName <= 1401 and id = 7

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 19 and YearName <= 1401 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 19 and YearName <= 1401 and IdGroup = 7
return
end
--***********************************************************
--***********************************************************
--***********************************************************
--***********************************************************
if(@areaId = 20)
begin
delete olden.tblGroup           where AreaId = 20 and YearName <= 1401
delete olden.tblKol             where AreaId = 20 and YearName <= 1401
delete olden.tblMoien           where AreaId = 20 and YearName <= 1401
delete olden.tblSanadKind       where AreaId = 20 and YearName <= 1401
delete olden.tblSanadState      where AreaId = 20 and YearName <= 1401
delete olden.tblTafsily         where AreaId = 20 and YearName <= 1401
delete olden.tblSanad_MD        where AreaId = 20 and YearName <= 1401
delete olden.tblSanadDetail_MD  where AreaId = 20 and YearName <= 1401
insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  20   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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
			WHERE        (tblSal_MD.Id IN (8 , 9 , 10 , 13 , 15 ))					 

				
insert into olden.tblSanadState(      Id    , AreaId ,       YearName       ,        Name        )
					SELECT tblSanadState.Id ,   20   , tblSal_MD.IdSal_MD_S ,  tblSanadState.Name
FROM            LBAR.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         LBAR.AccAMJ.dbo.tblSanadState
WHERE        (tblSal_MD.Id IN (8 , 9 , 10 , 13 , 15 ))
					  

insert into olden.tblTafsily(     Id    ,      IdSotooh      , AreaId,    YearName        ,     IdTafsilyGroup      ,       Name     ,      IdTafsilyType     )
					SELECT tblTafsily.Id, tblTafsily.IdSotooh,   20  ,tblSal_MD.IdSal_MD_S,tblTafsily.IdTafsilyGroup, tblTafsily.Name ,tblTafsily.IdTafsilyType 
FROM           LBAR.AccAMJ.dbo.tblSal_MD CROSS JOIN
                         LBAR.AccAMJ.dbo.tblTafsily
WHERE        (tblSal_MD.Id IN (8 , 9 , 10 , 13 , 15 ))

				
insert into olden.tblSanad_MD(Id ,      YearName                        , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
	                SELECT    Id ,    
								   case when IdSal_MD = 8  then 1397
								        when IdSal_MD = 9  then 1398
										when IdSal_MD = 10 then 1399
										when IdSal_MD = 13 then 1400
										when IdSal_MD = 15 then 1401
										                             end ,   20   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD   
										FROM LBAR.AccAMJ.dbo.tblSanad_MD				

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                        , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,   20   , 
						   											     case when IdSalSanad_MD = 8  then 1397
										                                      when IdSalSanad_MD = 9  then 1398
																		      when IdSalSanad_MD = 10 then 1399
																			  when IdSalSanad_MD = 13 then 1400
																			  when IdSalSanad_MD = 15 then 1401
																			                                   end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM  LBAR.AccAMJ.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 20 and YearName <= 1401 and id = 4

update olden.tblGroup
  set  id = 999
  Where AreaId = 20 and YearName <= 1401 and id = 5

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 20 and YearName <= 1401 and IdGroup = 4

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 20 and YearName <= 1401 and IdGroup = 5
return
end
--************************************************************************
--************************************************************************
--************************************************************************
if(@areaId = 21)
begin
delete olden.tblGroup           where AreaId = 21 and YearName <=1401
delete olden.tblKol             where AreaId = 21 and YearName <=1401
delete olden.tblMoien           where AreaId = 21 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 21 and YearName <=1401
delete olden.tblSanadState      where AreaId = 21 and YearName <=1401
delete olden.tblTafsily         where AreaId = 21 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 21 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 21 and YearName <=1401
insert into olden.tblGroup(        id    , IdRecognition , IdKind , AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,   21   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                        , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    21  , 
						   											     case when IdSalSanad_MD = 6   then 1396
										                                      when IdSalSanad_MD = 7   then 1397
																			  when IdSalSanad_MD = 8   then 1398
										                                      when IdSalSanad_MD = 9   then 1399
										                                      when IdSalSanad_MD = 10  then 1400
																			  when IdSalSanad_MD = 11  then 1401
																			                                   end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LZIBA.accamj297.dbo.tblSanadDetail_MD


--کانورت 1395  زیبا سازی
insert into olden.tblGroup( id , IdRecognition , IdKind , AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,    21  ,   1395   , Name
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

insert into olden.tblSanadDetail_MD(Id ,  IdSanad_MD ,AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id ,  IdSanad_MD ,  21   ,   1395   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LZIBA.AccAMJ295.dbo.tblSanadDetail_MD

--کانورت 1394  زیبا سازی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   21  ,   1394   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   21   ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LZIBA.AccAMJ294.dbo.tblSanadDetail_MD

--کانورت 1393  زیبا سازی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   21  ,   1393   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   21   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LZIBA.AccAMJ293.dbo.tblSanadDetail_MD

--کانورت 1392  زیبا سازی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   21  ,   1392   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   21   ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LZIBA.AccAMJ292.dbo.tblSanadDetail_MD

--کانورت 1391  زیبا سازی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   21  ,   1391   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   21   ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LZIBA.AccAMJ291.dbo.tblSanadDetail_MD

--کانورت 1390  زیبا سازی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   21  ,   1390   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   21   ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LZIBA.AccAMJ290.dbo.tblSanadDetail_MD

--کانورت 1389  زیبا سازی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   21  ,   1389   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   21   ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   21   ,   1388   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LZIBA.AccAMJ288.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 21 and YearName <= 1401 and id = 7

update olden.tblGroup
  set  id = 999
  Where AreaId = 21 and YearName <= 1401 and id = 6

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 21 and YearName <= 1401 and IdGroup = 7

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 21 and YearName <= 1401 and IdGroup = 6
return
end
if(@areaId = 22)
begin
delete olden.tblGroup           where AreaId = 22 and YearName <=1401
delete olden.tblKol             where AreaId = 22 and YearName <=1401
delete olden.tblMoien           where AreaId = 22 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 22 and YearName <=1401
delete olden.tblSanadState      where AreaId = 22 and YearName <=1401
delete olden.tblTafsily         where AreaId = 22 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 22 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 22 and YearName <=1401
insert into olden.tblGroup(        id    , IdRecognition , IdKind , AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,   22   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                        , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    22  , 
						   											     case when IdSalSanad_MD = 6   then 1396
										                                      when IdSalSanad_MD = 7   then 1397
																			  when IdSalSanad_MD = 8   then 1398
										                                      when IdSalSanad_MD = 9   then 1399
										                                      when IdSalSanad_MD = 10  then 1400
																			  when IdSalSanad_MD = 11  then 1401
																			                                    end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LOMRAN.AccAMJ.dbo.tblSanadDetail_MD


--کانورت 1395   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind , AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,    22  ,   1395   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   22   ,   1395   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   LOMRAN.AccAMJ195.dbo.tblSanadDetail_MD

--کانورت 1394   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   22  ,   1394   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   22   ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   LOMRAN.AccAMJ194.dbo.tblSanadDetail_MD

--کانورت 1393   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   22  ,   1393   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   22   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   LOMRAN.AccAMJ193.dbo.tblSanadDetail_MD

--کانورت 1392   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind , AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   22   ,   1392   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   22   ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   LOMRAN.AccAMJ192.dbo.tblSanadDetail_MD

--کانورت 1391   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind , AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   22   ,   1391   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   22   ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   LOMRAN.AccAMJ191.dbo.tblSanadDetail_MD

--کانورت 1390   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind , AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,    22  ,   1390   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   22   ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   LOMRAN.AccAMJ190.dbo.tblSanadDetail_MD

--کانورت 1389   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   22  ,   1389   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   22   ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   LOMRAN.AccAMJ189.dbo.tblSanadDetail_MD

--کانورت 1388   عمران شهری
insert into olden.tblGroup( id , AreaId , YearName , Name )
	          SELECT        Id ,    22  ,   1388   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   22   ,   1388   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   LOMRAN.AccAMJ188.dbo.tblSanadDetail_MD

--کانورت 1387   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   22  ,   1387   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   22   ,   1387   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   LOMRAN.AccAMJ187.dbo.tblSanadDetail_MD

--کانورت 1386   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   22  ,   1386   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   22   ,   1386   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   LOMRAN.AccAMJ186.dbo.tblSanadDetail_MD

--کانورت 1385   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   22  ,   1385   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   22   ,   1385   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   LOMRAN.AccAMJ185.dbo.tblSanadDetail_MD

--کانورت 1384   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   22  ,   1384   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   22   ,   1384   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   LOMRAN.AccAMJ184.dbo.tblSanadDetail_MD

--کانورت 1383   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   22  ,   1383   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   22   ,   1383   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   LOMRAN.AccAMJ183.dbo.tblSanadDetail_MD

--کانورت 1382   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   22  ,   1382   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   22   ,   1382   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   LOMRAN.AccAMJ182.dbo.tblSanadDetail_MD

--کانورت 1381   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   22  ,   1381   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   22   ,   1381   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   LOMRAN.AccAMJ181.dbo.tblSanadDetail_MD

--کانورت 1380   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   22  ,   1380   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   22   ,   1380   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   LOMRAN.AccAMJ180.dbo.tblSanadDetail_MD

--کانورت 1379   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   22  ,   1379   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   22   ,   1379   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   LOMRAN.AccAMJ179.dbo.tblSanadDetail_MD

--کانورت 1378   عمران شهری
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,   22  ,   1378   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   22   ,   1378   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM   LOMRAN.AccAMJ178.dbo.tblSanadDetail_MD

update olden.tblGroup
  set  id = 888
  Where AreaId = 22 and YearName <= 1401 and id = 7

update olden.tblGroup
  set  id = 999
  Where AreaId = 22 and YearName <= 1401 and id =6

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 22 and YearName <= 1401 and IdGroup = 7

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 22 and YearName <= 1401 and IdGroup = 6
return
end
if(@areaId = 23)
begin
delete olden.tblGroup           where AreaId = 23 and YearName <=1401
delete olden.tblKol             where AreaId = 23 and YearName <=1401
delete olden.tblMoien           where AreaId = 23 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 23 and YearName <=1401
delete olden.tblSanadState      where AreaId = 23 and YearName <=1401
delete olden.tblTafsily         where AreaId = 23 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 23 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 23 and YearName <=1401
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                        , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  , 
						   											     case when IdSalSanad_MD = 8   then 1398
										                                      when IdSalSanad_MD = 9   then 1399
																			  when IdSalSanad_MD = 11  then 1400
																			  when IdSalSanad_MD = 12  then 1401
										                                                                       end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LPASMAND.AccAMJ198.dbo.tblSanadDetail_MD

 ---- کانورت سال 1397 پسماند-----------------------------------------------------------------------------------
 insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id ,  IdRecognition , IdKind , 23   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1397   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LPASMAND.AccAMJ197.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 7

---- کانورت سال 1396 پسماند-----------------------------------------------------------------------------------
 insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id ,  IdRecognition , IdKind ,  23   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1397   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LPASMAND.AccAMJ196.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 8

---- کانورت سال 1395 پسماند-----------------------------------------------------------------------------------
 insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name )
				SELECT      Id , IdRecognition , IdKind ,  23   ,    1395  , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1397   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LPASMAND.AccAMJ195.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 8

---- کانورت سال 1394 پسماند-----------------------------------------------------------------------------------
 insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name )
				SELECT      Id , IdRecognition , IdKind ,  23   ,    1394  , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LPASMAND.AccAMJ194.dbo.tblSanadDetail_MD

---- کانورت سال 1393 پسماند-----------------------------------------------------------------------------------
 insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name )
				SELECT      Id , IdRecognition , IdKind ,  23   ,    1393  , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
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


insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LPASMAND.AccAMJ192.dbo.tblSanadDetail_MD


---- کانورت سال 1391 پسماند-----------------------------------------------------------------------------------
 insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name )
				SELECT      Id , IdRecognition , IdKind ,  23   ,    1391  , Name
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


insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LPASMAND.AccAMJ191.dbo.tblSanadDetail_MD


---- کانورت سال 1390 پسماند-----------------------------------------------------------------------------------
 insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name )
				SELECT      Id , IdRecognition , IdKind ,  23   ,    1390  , Name
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


insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LPASMAND.AccAMJ190.dbo.tblSanadDetail_MD


---- کانورت سال 1389 پسماند-----------------------------------------------------------------------------------
 insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name )
				SELECT      Id , IdRecognition , IdKind ,  23   ,    1389  , Name
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


insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LPASMAND.AccAMJ189.dbo.tblSanadDetail_MD


---- کانورت سال 1388 پسماند-----------------------------------------------------------------------------------
 insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name )
				SELECT      Id , IdRecognition , IdKind ,  23   ,    1388  , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    23  ,   1388   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LPASMAND.AccAMJ188.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 23 and YearName <= 1401 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 23 and YearName <= 1401 and id = 7

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 23 and YearName <= 1401 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 23 and YearName <= 1401 and IdGroup = 7
return
end
--*************************************************************
--*************************************************************
--*************************************************************
if(@areaId = 24)
begin
delete olden.tblGroup           where AreaId = 24 and YearName <=1401
delete olden.tblKol             where AreaId = 24 and YearName <=1401
delete olden.tblMoien           where AreaId = 24 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 24 and YearName <=1401
delete olden.tblSanadState      where AreaId = 24 and YearName <=1401
delete olden.tblTafsily         where AreaId = 24 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 24 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 24 and YearName <=1401

insert into olden.tblGroup(        id    , IdRecognition , IdKind , AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,   24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                        , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  , 
						   											     case when IdSalSanad_MD = 10  then 1400
																		      when IdSalSanad_MD = 11  then 1401
																			                                   end   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMAYADIN.AccAMJ.dbo.tblSanadDetail_MD

----کانورت 1399 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1399   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMAYADIN.AccAMJ199.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

----کانورت 1398 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1398   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMAYADIN.AccAMJ198.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

----کانورت 1397 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1397   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMAYADIN.AccAMJ197.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

----کانورت 1396 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1396   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMAYADIN.AccAMJ196.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

----کانورت 1395 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1395   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMAYADIN.AccAMJ195.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

----کانورت 1394 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1399   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMAYADIN.AccAMJ194.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

----کانورت 1393 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMAYADIN.AccAMJ193.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

----کانورت 1392 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1399   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMAYADIN.AccAMJ192.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

----کانورت 1391 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMAYADIN.AccAMJ191.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

----کانورت 1390 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMAYADIN.AccAMJ190.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11

							 
----کانورت 1389 میادین--------------------------------------------------------------------------------------

insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  24   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    24  ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMAYADIN.AccAMJ189.dbo.tblSanadDetail_MD
							 where IdSalSanad_MD = 11
update olden.tblGroup
  set  id = 888
  Where AreaId = 24 and YearName <= 1401 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 24 and YearName <= 1401 and id = 7

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 24 and YearName <= 1401 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 24 and YearName <= 1401 and IdGroup = 7
return
end
--********************************************************
--********************************************************
--********************************************************
if(@areaId = 25)
begin
delete olden.tblGroup           where AreaId = 25 and YearName <=1401
delete olden.tblKol             where AreaId = 25 and YearName <=1401
delete olden.tblMoien           where AreaId = 25 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 25 and YearName <=1401
delete olden.tblSanadState      where AreaId = 25 and YearName <=1401
delete olden.tblTafsily         where AreaId = 25 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 25 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 25 and YearName <=1401
insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  25   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                      , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    25  , 
						   											     case when IdSalSanad_MD = 4   then 1394
																			  when IdSalSanad_MD = 6   then 1395
																			  when IdSalSanad_MD = 8   then 1396
																			  when IdSalSanad_MD = 9   then 1397
																			  when IdSalSanad_MD = 10  then 1398
																			  when IdSalSanad_MD = 11  then 1399
																			  when IdSalSanad_MD = 12  then 1400
																			  when IdSalSanad_MD = 13  then 1401
																			                                  end , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LSPORT.AccAMJ.dbo.tblSanadDetail_MD

update olden.tblGroup
  set  id = 888
  Where AreaId = 25 and YearName <= 1401 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 25 and YearName <= 1401 and id = 7

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 25 and YearName <= 1401 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 25 and YearName <= 1401 and IdGroup = 7
return
end
--****************************************************************
--****************************************************************
--****************************************************************
if(@areaId = 26)
begin
delete olden.tblGroup           where AreaId = 26 and YearName <=1401
delete olden.tblKol             where AreaId = 26 and YearName <=1401
delete olden.tblMoien           where AreaId = 26 and YearName <=1401
delete olden.tblSanadKind       where AreaId = 26 and YearName <=1401
delete olden.tblSanadState      where AreaId = 26 and YearName <=1401
delete olden.tblTafsily         where AreaId = 26 and YearName <=1401
delete olden.tblSanad_MD        where AreaId = 26 and YearName <=1401
delete olden.tblSanadDetail_MD  where AreaId = 26 and YearName <=1401
insert into olden.tblGroup(        id    , IdRecognition , IdKind ,AreaId ,        YearName       ,     Name     )
				SELECT       tblGroup.Id , IdRecognition , IdKind ,  26   ,  tblSal_MD.IdSal_MD_S , tblGroup.Name 
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , IdSalSanad_MD , AreaId ,       YearName                      , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD , IdSalSanad_MD ,    26  , 
						   											     case when IdSalSanad_MD = 5   then 1395
																			  when IdSalSanad_MD = 7   then 1396
																			  when IdSalSanad_MD = 9   then 1397
																			  when IdSalSanad_MD = 10  then 1398
																			  when IdSalSanad_MD = 12  then 1399
																			  when IdSalSanad_MD = 13  then 1400
																			  when IdSalSanad_MD = 14  then 1401
										                                                                       end , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMETRO.AccAMJ195.dbo.tblSanadDetail_MD

--کانورت 1394 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  26   ,   1394   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   26   ,   1394   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMETRO.AccAMJ194.dbo.tblSanadDetail_MD

--کانورت 1393 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  26   ,   1393   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   26   ,   1393   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMETRO.AccAMJ193.dbo.tblSanadDetail_MD

--کانورت 1392 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  26   ,   1392   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   26   ,   1392   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMETRO.AccAMJ192.dbo.tblSanadDetail_MD

--کانورت 1391 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  26   ,   1391   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   26   ,   1391   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMETRO.AccAMJ191.dbo.tblSanadDetail_MD

--کانورت 1390 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  26   ,   1390   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   26   ,   1390   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMETRO.AccAMJ190.dbo.tblSanadDetail_MD

--کانورت 1389 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  26   ,   1389   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   26   ,   1389   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMETRO.AccAMJ189.dbo.tblSanadDetail_MD

--کانورت 1388 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  26   ,   1388   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   26   ,   1388   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMETRO.AccAMJ188.dbo.tblSanadDetail_MD

--کانورت 1387 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  26   ,   1387   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   26   ,   1387   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMETRO.AccAMJ187.dbo.tblSanadDetail_MD

--کانورت 1386 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  26   ,   1386   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   26   ,   1386   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMETRO.AccAMJ186.dbo.tblSanadDetail_MD

--کانورت 1385 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  26   ,   1385   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   26   ,   1385   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMETRO.AccAMJ185.dbo.tblSanadDetail_MD

--کانورت 1384 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  26   ,   1384   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   26   ,   1384   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMETRO.AccAMJ184.dbo.tblSanadDetail_MD

--کانورت 1383 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  26   ,   1383   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   26   ,   1383   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMETRO.AccAMJ183.dbo.tblSanadDetail_MD

--کانورت 1382 ریلی
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name )
	          SELECT        Id , IdRecognition , IdKind ,  26   ,   1382   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   26   ,   1382   , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh,AtfDt,AtfCh2,AtfCh3
							 FROM            LMETRO.AccAMJ182.dbo.tblSanadDetail_MD
update olden.tblGroup
  set  id = 888
  Where AreaId = 26 and YearName <= 1401 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 26 and YearName <= 1401 and id = 7

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 26 and YearName <= 1401 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 26 and YearName <= 1401 and IdGroup = 7
return
end



END
GO
