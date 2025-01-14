USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9900_Akh_TO_Olden_Then_Budget_1402_Main]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9900_Akh_TO_Olden_Then_Budget_1402_Main]
@areaId int 
AS
BEGIN

delete olden.tblGroup           where AreaId = @areaId and YearName = 1402
delete olden.tblKol             where AreaId = @areaId and YearName = 1402
delete olden.tblMoien           where AreaId = @areaId and YearName = 1402
delete olden.tblSanadKind       where AreaId = @areaId and YearName = 1402
delete olden.tblSanadState      where AreaId = @areaId and YearName = 1402
delete olden.tblTafsily         where AreaId = @areaId and YearName = 1402
delete olden.tblSanad_MD        where AreaId = @areaId and YearName = 1402
delete olden.tblSanadDetail_MD  where AreaId = @areaId and YearName = 1402

if(@areaId = 1)
begin
insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT      Id , IdRecognition , IdKind ,   1   ,  1402    , Name
				FROM             AKH.AccAMJ1001.dbo.tblGroup

insert into olden.tblKol( id , AreaId , YearName , IdGroup , Name)
			SELECT        Id ,    1   ,   1402   , IdGroup , Name
			FROM            AKH.AccAMJ1001.dbo.tblKol


insert into olden.tblMoien( Id , AreaId , YearName, IdKol , Name )
				  SELECT    Id ,   1    ,  1402   , IdKol , Name
			    	FROM            AKH.AccAMJ1001.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId ,YearName , Name )
					   SELECT  Id ,   1    ,  1402   , Name
					     FROM     AKH.AccAMJ1001.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  1    ,   1402   , Name
				  FROM       AKH.AccAMJ1001.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   1    ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM     AKH.AccAMJ1001.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   1    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM             AKH.AccAMJ1001.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 19)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar ,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   1    ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar ,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM            AKH.AccAMJ1001.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=19 
end

if(@areaId = 2)
begin

insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT     Id ,IdRecognition  , IdKind ,   2   ,    1402   , Name
				FROM             AKH.AccAMJ1002.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,    2   ,   1402  , IdGroup , Name
			FROM            AKH.AccAMJ1002.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   2    ,  1402   ,IdKol , Name
			    	FROM            AKH.AccAMJ1002.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   2    ,    1402   , Name
					     FROM     AKH.AccAMJ1002.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  2    ,   1402   , Name
				  FROM       AKH.AccAMJ1002.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   2    ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM     AKH.AccAMJ1002.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   2    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM             AKH.AccAMJ1002.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 23)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   2    ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM            AKH.AccAMJ1002.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=23 
end

if(@areaId = 3)
begin

insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT      Id , IdRecognition , IdKind ,   3   ,    1402   , Name
				FROM             AKH.AccAMJ1003.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,    3   ,   1402  , IdGroup , Name
			FROM            AKH.AccAMJ1003.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   3    ,  1402   ,IdKol , Name
			    	FROM            AKH.AccAMJ1003.dbo.tblMoien

insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   3    ,    1402   , Name
					     FROM     AKH.AccAMJ1003.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  3    ,   1402   , Name
				  FROM       AKH.AccAMJ1003.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   3    ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM     AKH.AccAMJ1003.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   3    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM             AKH.AccAMJ1003.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 19)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   3    ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM            AKH.AccAMJ1003.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=19 
end

if(@areaId = 4)
begin

insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT      Id , IdRecognition , IdKind ,   4   ,    1402   , Name
				FROM             AKH.AccAMJ1004.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,    4   ,   1402  , IdGroup , Name
			FROM            AKH.AccAMJ1004.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   4    ,  1402   ,IdKol , Name
			    	FROM            AKH.AccAMJ1004.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   4    ,    1402   , Name
					     FROM     AKH.AccAMJ1004.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  4    ,   1402   , Name
				  FROM       AKH.AccAMJ1004.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   4    ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM     AKH.AccAMJ1004.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   4    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM             AKH.AccAMJ1004.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 17)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   4    ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM            AKH.AccAMJ1004.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=17 
end

if(@areaId = 5)
begin

insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId  , YearName , Name)
				SELECT     Id , IdRecognition , IdKind ,    5   ,    1402   , Name
				FROM             AKH.AccAMJ1005.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,    5   ,   1402  , IdGroup , Name
			FROM            AKH.AccAMJ1005.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   5    ,  1402   ,IdKol , Name
			    	FROM            AKH.AccAMJ1005.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   5    ,    1402   , Name
					     FROM     AKH.AccAMJ1005.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  5    ,   1402   , Name
				  FROM       AKH.AccAMJ1005.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   5    ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM     AKH.AccAMJ1005.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   5    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM             AKH.AccAMJ1005.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 16)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   5    ,  1402    , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM            AKH.AccAMJ1005.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=16 
end

if(@areaId = 6)
begin

insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT      Id , IdRecognition , IdKind ,   6   ,    1402   , Name
				FROM             AKH.AccAMJ1006.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,    6   ,   1402  , IdGroup , Name
			FROM            AKH.AccAMJ1006.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   6    ,  1402   ,IdKol , Name
			    	FROM            AKH.AccAMJ1006.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   6    ,    1402   , Name
					     FROM     AKH.AccAMJ1006.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  6    ,   1402   , Name
				  FROM       AKH.AccAMJ1006.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   6    ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM     AKH.AccAMJ1006.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   6    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM             AKH.AccAMJ1006.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 18)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   6    ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM            AKH.AccAMJ1006.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=18 
end

if(@areaId = 7)
begin

insert into olden.tblGroup( id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT      Id , IdRecognition , IdKind ,   7   ,    1402   , Name
				FROM             AKH.AccAMJ1007.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,    7   ,   1402  , IdGroup , Name
			FROM            AKH.AccAMJ1007.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   7    ,  1402   ,IdKol , Name
			    	FROM            AKH.AccAMJ1007.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   7    ,    1402   , Name
					     FROM     AKH.AccAMJ1007.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  7    ,   1402   , Name
				  FROM       AKH.AccAMJ1007.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   7    ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM     AKH.AccAMJ1007.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   7    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM             AKH.AccAMJ1007.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 14)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   7    ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM            AKH.AccAMJ1007.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=14
end

if(@areaId = 8)
begin

insert into olden.tblGroup(id  , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT      Id , IdRecognition , IdKind ,   8   ,    1402   , Name
				FROM             AKH.AccAMJ1008.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,    8   ,   1402  , IdGroup , Name
			FROM            AKH.AccAMJ1008.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   8    ,  1402   ,IdKol , Name
			    	FROM            AKH.AccAMJ1008.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   8    ,    1402   , Name
					     FROM     AKH.AccAMJ1008.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  8    ,   1402   , Name
				  FROM       AKH.AccAMJ1008.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   8    ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM     AKH.AccAMJ1008.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   8    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM             AKH.AccAMJ1008.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 14)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   8    ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM            AKH.AccAMJ1008.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=14
end

if(@areaId = 9)
begin

insert into olden.tblGroup(id , IdRecognition , IdKind , AreaId , YearName , Name)
				SELECT     Id , IdRecognition , IdKind ,    9   ,    1402   , Name
				FROM             AKH.AccAMJ1000.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,    9   ,   1402  , IdGroup , Name
			FROM            AKH.AccAMJ1000.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   9    ,  1402   ,IdKol , Name
			    	FROM            AKH.AccAMJ1000.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   9    ,    1402   , Name
					     FROM     AKH.AccAMJ1000.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  9    ,   1402   , Name
				  FROM       AKH.AccAMJ1000.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   9    ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM     AKH.AccAMJ1000.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   9    , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM             AKH.AccAMJ1000.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 12)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   9    ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM            AKH.AccAMJ1000.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=12 

end

--فاوا  
if(@areaId = 11)
begin

insert into olden.tblGroup( id , IdRecognition , IdKind , AreaId , YearName , Name)
				SELECT      Id , IdRecognition , IdKind ,   11   ,    1402   , Name
				FROM            LFAVA.AccAMJ.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   11   ,   1402  , IdGroup , Name
			FROM           LFAVA.AccAMJ.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   11   ,  1402   ,IdKol , Name
			    	FROM           LFAVA.AccAMJ.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   11   ,    1402   , Name
					     FROM    LFAVA.AccAMJ.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  11   ,   1402   , Name
				  FROM      LFAVA.AccAMJ.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   11   ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LFAVA.AccAMJ.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   11   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM            LFAVA.AccAMJ.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 14)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   11   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM           LFAVA.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=14 

update olden.tblGroup
  set  id = 888
  Where AreaId = 11 and YearName = 1402 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 11 and YearName = 1402 and id = 7

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 11 and YearName = 1402 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 11 and YearName = 1402 and IdGroup = 7



end

--آتش نشانی  
if(@areaId = 12)
begin

insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT     Id , IdRecognition , IdKind ,  12   ,    1402   , Name
				FROM          Lfire.AccAMJ295.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   12   ,   1402  , IdGroup , Name
			FROM           Lfire.AccAMJ295.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   12   ,  1402   ,IdKol , Name
			    	FROM       Lfire.AccAMJ295.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   12   ,    1402   , Name
					     FROM   Lfire.AccAMJ295.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  12   ,   1402   , Name
				  FROM     Lfire.AccAMJ295.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   12   ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    Lfire.AccAMJ295.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   12   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM            Lfire.AccAMJ295.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 13)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   12   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM         Lfire.AccAMJ295.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=13 

 update olden.tblGroup
  set  id = 888
  Where AreaId = 12 and YearName = 1402 and id = 4

update olden.tblGroup
  set  id = 999
  Where AreaId = 12 and YearName = 1402 and id = 7

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 12 and YearName = 1402 and IdGroup = 4

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 12 and YearName = 1402 and IdGroup = 7

end

--اتوبوسرانی
if(@areaId = 13)
begin

insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT     Id , IdRecognition , IdKind ,  13   ,    1402   , Name
				FROM            LBUS.AccAMJ295.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   13   ,   1402  , IdGroup , Name
			FROM            LBUS.AccAMJ295.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   13   ,  1402   ,IdKol , Name
			    	FROM            LBUS.AccAMJ295.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   13   ,    1402   , Name
					     FROM     LBUS.AccAMJ295.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  13   ,   1402   , Name
				  FROM       LBUS.AccAMJ295.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   13   ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LBUS.AccAMJ295.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   13   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM            LBUS.AccAMJ295.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 12)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   13   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM            Lbus.AccAMJ295.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=12 

update olden.tblGroup
  set  id = 888
  Where AreaId = 13 and YearName = 1402 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 13 and YearName = 1402 and id = 5

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 13 and YearName = 1402 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 13 and YearName = 1402 and IdGroup = 5

end

--نوسازی 
if(@areaId = 14)
begin

insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT     Id , IdRecognition , IdKind ,   14   ,    1402   , Name
				FROM        Lbehsazi.AccAMJ.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   14   ,   1402  , IdGroup , Name
			FROM            Lbehsazi.AccAMJ.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   14   ,  1402   ,IdKol , Name
			    	FROM     Lbehsazi.AccAMJ.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   14   ,    1402   , Name
					     FROM   Lbehsazi.AccAMJ.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  14   ,   1402   , Name
				  FROM     Lbehsazi.AccAMJ.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   14   ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    Lbehsazi.AccAMJ.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   14   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM           Lbehsazi.AccAMJ.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 12)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   14   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM           Lbehsazi.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=12 

update olden.tblGroup
  set  id = 888
  Where AreaId = 14 and YearName = 1402 and id = 7

update olden.tblGroup
  set  id = 999
  Where AreaId = 14 and YearName = 1402 and id = 6

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 14 and YearName = 1402 and IdGroup = 7

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 14 and YearName = 1402 and IdGroup = 6


end

--پارکها
if(@areaId = 15)
begin

insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT     Id , IdRecognition , IdKind ,  15   ,    1402   , Name
				FROM        LPARK.AccAmj196.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   15   ,   1402  , IdGroup , Name
			FROM            LPARK.AccAmj196.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   15   ,  1402   ,IdKol , Name
			    	FROM     LPARK.AccAmj196.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   15   ,    1402   , Name
					     FROM   LPARK.AccAmj196.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  15   ,   1402   , Name
				  FROM     LPARK.AccAmj196.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   15   ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LPARK.AccAmj196.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   15   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM           LPARK.AccAmj196.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 12)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   15   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM           LPARK.AccAmj196.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=12 

update olden.tblGroup
  set  id = 888
  Where AreaId = 15 and YearName = 1402 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 15 and YearName = 1402 and id in ( 9)

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 15 and YearName = 1402 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 15 and YearName = 1402 and IdGroup in ( 9)

end

--ترمینال ها
if(@areaId = 16)
begin

insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT     Id , IdRecognition , IdKind ,  16   ,    1402   , Name
				FROM        LTERMINAL.AccAmj.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   16   ,   1402  , IdGroup , Name
			FROM            LTERMINAL.AccAmj.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   16   ,  1402   ,IdKol , Name
			    	FROM     LTERMINAL.AccAmj.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   16   ,    1402   , Name
					     FROM   LTERMINAL.AccAmj.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  16   ,   1402   , Name
				  FROM     LTERMINAL.AccAmj.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   16   ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LTERMINAL.AccAmj.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   16   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM           LTERMINAL.AccAmj.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 12)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   16   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM          LTERMINAL.AccAmj.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=12 

update olden.tblGroup
  set  id = 888
  Where AreaId = 16 and YearName = 1402 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 16 and YearName = 1402 and id = 7

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 16 and YearName = 1402 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 16 and YearName = 1402 and IdGroup = 7

end

-- تاکسیرانی
if(@areaId = 17)
begin

insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT     Id , IdRecognition , IdKind ,  17   ,    1402   , Name
				FROM        LTAXI.AccAMJ1095.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   17   ,   1402  , IdGroup , Name
			FROM            LTAXI.AccAMJ1095.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   17   ,  1402   ,IdKol , Name
			    	FROM     LTAXI.AccAMJ1095.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   17   ,    1402   , Name
					     FROM   LTAXI.AccAMJ1095.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  17   ,   1402   , Name
				  FROM     LTAXI.AccAMJ1095.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   17   ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LTAXI.AccAMJ1095.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   17   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM           LTAXI.AccAMJ1095.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 12)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   17   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM          LTAXI.AccAMJ1095.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=12 

update olden.tblGroup
  set  id = 888
  Where AreaId = 17 and YearName = 1402 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 17 and YearName = 1402 and id = 7

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 17 and YearName = 1402 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 17 and YearName = 1402 and IdGroup = 7


end

-- موتوری
if(@areaId = 18)
begin

insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT     Id , IdRecognition , IdKind ,  18   ,    1402   , Name
				FROM        LMOTORI.AccAMJ.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   18   ,   1402  , IdGroup , Name
			FROM            LMOTORI.AccAMJ.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   18   ,  1402   ,IdKol , Name
			    	FROM    LMOTORI.AccAMJ.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   18   ,    1402   , Name
					     FROM   LMOTORI.AccAMJ.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  18   ,   1402   , Name
				  FROM     LMOTORI.AccAMJ.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   18   ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LMOTORI.AccAMJ.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   18   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM          LMOTORI.AccAMJ.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 16)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   18   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM         LMOTORI.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=16 

update olden.tblGroup
  set  id = 888
  Where AreaId = 18 and YearName = 1402 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 18 and YearName = 1402 and id in (7,8)

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 18 and YearName = 1402 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 18 and YearName = 1402 and IdGroup in (7,8)


end

--ارامستانها
if(@areaId = 19)
begin

insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT     Id , IdRecognition , IdKind ,  19   ,    1402   , Name
				FROM        LBEHESHT.AccAMJ.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   19   ,   1402  , IdGroup , Name
			FROM            LBEHESHT.AccAMJ.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   19   ,  1402   ,IdKol , Name
			    	FROM    LBEHESHT.AccAMJ.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   19   ,    1402   , Name
					     FROM   LBEHESHT.AccAMJ.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  19   ,   1402   , Name
				  FROM     LBEHESHT.AccAMJ.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   19   ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LBEHESHT.AccAMJ.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   19   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM          LBEHESHT.AccAMJ.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 11)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   19   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM         LBEHESHT.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=11
update olden.tblGroup
  set  id = 888
  Where AreaId = 19 and YearName = 1402 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 19 and YearName = 1402 and id =7

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 19 and YearName = 1402 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 19 and YearName = 1402 and IdGroup = 7
  

end

-- بار
if(@areaId = 20)
begin

insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT     Id , IdRecognition , IdKind ,  20   ,    1402   , Name
				FROM        LBAR.AccAMJ.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   20   ,   1402  , IdGroup , Name
			FROM            LBAR.AccAMJ.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   20   ,  1402   ,IdKol , Name
			    	FROM    LBAR.AccAMJ.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   20   ,    1402   , Name
					     FROM   LBAR.AccAMJ.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  20   ,   1402   , Name
				  FROM     LBAR.AccAMJ.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   20   ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LBAR.AccAMJ.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   20   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM          LBAR.AccAMJ.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 17)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   20   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM         LBAR.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=17 

update olden.tblGroup
  set  id = 888
  Where AreaId = 20 and YearName = 1402 and id = 4

update olden.tblGroup
  set  id = 999
  Where AreaId = 20 and YearName = 1402 and id =5

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 20 and YearName = 1402 and IdGroup = 4

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 20 and YearName = 1402 and IdGroup = 5

end

--  زیبا سازی
if(@areaId = 21)
begin

insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT     Id , IdRecognition , IdKind ,  21   ,    1402   , Name
				FROM        LZIBA.accamj297.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   21   ,   1402  , IdGroup , Name
			FROM            LZIBA.accamj297.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   21   ,  1402   ,IdKol , Name
			    	FROM    LZIBA.accamj297.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   21   ,    1402   , Name
					     FROM   LZIBA.accamj297.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  21   ,   1402   , Name
				  FROM     LZIBA.accamj297.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   21   ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LZIBA.accamj297.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   21   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM          LZIBA.accamj297.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 14)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD, AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,  21   ,  1402   , IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM   LZIBA.accamj297.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=14 

update olden.tblGroup
  set  id = 888
  Where AreaId = 21 and YearName = 1402 and id = 7

update olden.tblGroup
  set  id = 999
  Where AreaId = 21 and YearName = 1402 and id =6

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 21 and YearName = 1402 and IdGroup = 7

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 21 and YearName = 1402 and IdGroup = 6

end

--عمران شهری
if(@areaId = 22)
begin

insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT      Id ,IdRecognition , IdKind ,  22   ,    1402   , Name
				FROM        LOMRAN.AccAMJ.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   22   ,   1402  , IdGroup , Name
			FROM            LOMRAN.AccAMJ.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   22   ,  1402   ,IdKol , Name
			    	FROM    LOMRAN.AccAMJ.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   22   ,    1402   , Name
					     FROM   LOMRAN.AccAMJ.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  22   ,   1402   , Name
				  FROM     LOMRAN.AccAMJ.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   22   ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LOMRAN.AccAMJ.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   22   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM          LOMRAN.AccAMJ.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 12)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   22   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM         LOMRAN.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=12 

update olden.tblGroup
  set  id = 888
  Where AreaId = 22 and YearName = 1402 and id = 7

update olden.tblGroup
  set  id = 999
  Where AreaId = 22 and YearName = 1402 and id =6

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 22 and YearName = 1402 and IdGroup = 7

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 22 and YearName = 1402 and IdGroup = 6
end

--پسماند
if(@areaId = 23)
begin

insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT     Id , IdRecognition , IdKind ,  23   ,    1402   , Name
				FROM        LPASMAND.AccAMJ198.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   23   ,   1402  , IdGroup , Name
			FROM            LPASMAND.AccAMJ198.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   23   ,  1402   ,IdKol , Name
			    	FROM    LPASMAND.AccAMJ198.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   23   ,    1402   , Name
					     FROM   LPASMAND.AccAMJ198.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  23   ,   1402   , Name
				  FROM     LPASMAND.AccAMJ198.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   23   ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LPASMAND.AccAMJ198.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   23   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM          LPASMAND.AccAMJ198.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 13)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   23   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM        LPASMAND.AccAMJ198.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=13 

update olden.tblGroup
  set  id = 888
  Where AreaId = 23 and YearName = 1402 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 23 and YearName = 1402 and id =7

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 23 and YearName = 1402 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 23 and YearName = 1402 and IdGroup = 7


end

-- میادین
if(@areaId = 24)
begin

insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT     Id , IdRecognition , IdKind ,  24   ,    1402   , Name
				FROM        LMAYADIN.AccAMJ.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   24   ,   1402  , IdGroup , Name
			FROM            LMAYADIN.AccAMJ.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   24   ,  1402   ,IdKol , Name
			    	FROM    LMAYADIN.AccAMJ.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   24   ,    1402   , Name
					     FROM   LMAYADIN.AccAMJ.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  24   ,   1402   , Name
				  FROM     LMAYADIN.AccAMJ.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   24   ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LMAYADIN.AccAMJ.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   24   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM          LMAYADIN.AccAMJ.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 12)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   24   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM        LMAYADIN.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=12 

update olden.tblGroup
  set  id = 888
  Where AreaId = 24 and YearName = 1402 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 24 and YearName = 1402 and id =7

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 24 and YearName = 1402 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 24 and YearName = 1402 and IdGroup = 7


end

--فرهنگی
if(@areaId = 25)
begin

insert into olden.tblGroup(id , IdRecognition , IdKind ,AreaId , YearName , Name)
				SELECT     Id , IdRecognition , IdKind ,  25   ,    1402   , Name
				FROM        LSPORT.AccAMJ.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   25   ,   1402  , IdGroup , Name
			FROM            LSPORT.AccAMJ.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   25   ,  1402   ,IdKol , Name
			    	FROM    LSPORT.AccAMJ.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   25   ,    1402   , Name
					     FROM   LSPORT.AccAMJ.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  25   ,   1402   , Name
				  FROM     LSPORT.AccAMJ.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   25   ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM    LSPORT.AccAMJ.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   25   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM          LSPORT.AccAMJ.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 14)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   25   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM        LSPORT.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=14 

update olden.tblGroup
  set  id = 888
  Where AreaId = 25 and YearName = 1402 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 25 and YearName = 1402 and id =7

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 25 and YearName = 1402 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 25 and YearName = 1402 and IdGroup = 7


end

-- ریلی
if(@areaId = 26)
begin

insert into olden.tblGroup(id , IdRecognition , IdKind , AreaId , YearName , Name)
				SELECT     Id , IdRecognition , IdKind ,   26   ,    1402   , Name
				FROM      LMETRO.AccAMJ195.dbo.tblGroup

insert into olden.tblKol( id , AreaId ,YearName , IdGroup , Name)
			SELECT        Id ,   26   ,   1402  , IdGroup , Name
			FROM      LMETRO.AccAMJ195.dbo.tblKol


insert into olden.tblMoien( Id , AreaId ,YearName ,IdKol , Name )
				  SELECT    Id ,   26   ,  1402   ,IdKol , Name
			    	FROM     LMETRO.AccAMJ195.dbo.tblMoien


insert into olden.tblSanadKind(Id , AreaId , YearName  , Name )
					   SELECT  Id ,   26   ,    1402   , Name
					     FROM    LMETRO.AccAMJ195.dbo.tblSanadKind
				
insert into olden.tblSanadState(Id ,AreaId ,YearName  , Name )
				      SELECT    Id ,  26   ,   1402   , Name
				  FROM      LMETRO.AccAMJ195.dbo.tblSanadState

insert into olden.tblTafsily(Id , IdSotooh , AreaId , YearName , IdTafsilyGroup , Name ,IdTafsilyType )
					 SELECT  Id , IdSotooh ,   26   ,   1402   , IdTafsilyGroup , Name ,IdTafsilyType
						FROM     LMETRO.AccAMJ195.dbo.tblTafsily
				
insert into olden.tblSanad_MD(Id , YearName , AreaId , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD)
					 SELECT   Id ,   1402   ,   26   , SanadDateS , IdSanadkind , IdSanadState , DescSanad_MD
		           FROM           LMETRO.AccAMJ195.dbo.tblSanad_MD 
		            WHERE        (IdSal_MD = 15)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3)
						   SELECT   Id , IdSanad_MD ,   26   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar,AtfCh ,AtfDt ,AtfCh2	,AtfCh3
							 FROM         LMETRO.AccAMJ195.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=15 

update olden.tblGroup
  set  id = 888
  Where AreaId = 26 and YearName = 1402 and id = 6

update olden.tblGroup
  set  id = 999
  Where AreaId = 26 and YearName = 1402 and id =7

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = 26 and YearName = 1402 and IdGroup = 6

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = 26 and YearName = 1402 and IdGroup = 7

end


if(@areaId <=9)
begin
update olden.tblGroup
  set  id = 888
  Where AreaId = @areaId and YearName = 1402 and id = 7

update olden.tblGroup
  set  id = 999
  Where AreaId = @areaId and YearName = 1402 and id = 8

update olden.tblKol
  set  IdGroup = 888
  Where AreaId = @areaId and YearName = 1402 and IdGroup = 7

update olden.tblKol
  set  IdGroup = 999
  Where AreaId = @areaId and YearName = 1402 and IdGroup = 8

INSERT INTO TblCodingsMapSazman(          YearId       ,               AreaId              ,  CodingId     )
					SELECT        TblBudgets.TblYearId , tblBudgetDetailProjectArea.AreaId , tblCoding.Id
					FROM            TblBudgetDetails INNER JOIN
											 TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
											 tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
											 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
											 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
					WHERE (TblBudgets.TblYearId = 33) AND
						 -- (TblBudgets.TblAreaId = 10) AND
						  (tblCoding.TblBudgetProcessId in (1,2,3,4)) AND
						  (tblBudgetDetailProjectArea.AreaId = @areaId) AND (tblCoding.Id NOT IN
																	 (SELECT        CodingId
																		FROM            TblCodingsMapSazman
																		WHERE        (AreaId = @areaId) AND (YearId = 33)))

UPDATE       tblBudgetDetailProjectArea
SET                Expense = 0
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
					WHERE (TblBudgets.TblYearId = 33) AND
					     -- (TblBudgets.TblAreaId = 10) AND
						  (tblBudgetDetailProjectArea.AreaId = @areaId) AND
						  (tblCoding.TblBudgetProcessId in (1,2,3,4))

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        id, SUM(Expense) AS Expense
                                FROM            (SELECT        tblBudgetDetailProjectArea_1.id, 
                                                                                    CASE WHEN olden.tblGroup.Id = 999 THEN olden.tblSanadDetail_MD.Bedehkar - olden.tblSanadDetail_MD.Bestankar 
																					     WHEN olden.tblGroup.Id = 888 THEN olden.tblSanadDetail_MD.Bestankar - olden.tblSanadDetail_MD.Bedehkar
                                                                                         END  AS Expense
                                                           FROM            olden.tblSanadDetail_MD INNER JOIN
                                                                                    olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                                                    olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                                                    TblBudgets INNER JOIN
                                                                                    TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                                                    tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                                                    tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                                                    tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                                                    TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetShahrdari = TblCodingsMapSazman.CodeVasetShahrdari INNER JOIN
                                                                                    olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id INNER JOIN
                                                                                    olden.tblGroup ON olden.tblKol.IdGroup = olden.tblGroup.Id
                                                           WHERE        (TblBudgets.TblYearId = 33) AND
														             --   (TblBudgets.TblAreaId = 10) AND
																		(olden.tblSanad_MD.AreaId = @areaId) AND
																		(olden.tblSanad_MD.YearName = 1402) AND
																		(olden.tblSanadDetail_MD.AreaId = @areaId) AND 
                                                                        (olden.tblSanadDetail_MD.YearName = 1402) AND
																		(olden.tblKol.AreaId = @areaId) AND
																		(olden.tblKol.YearName = 1402) AND
																		--(olden.tblKol.IdGroup = 7) AND
																		(TblCodingsMapSazman.AreaId = @areaId) AND 
                                                                        (TblCodingsMapSazman.YearId = 33) AND
																		(tblBudgetDetailProjectArea_1.AreaId = @areaId) AND
																		(tblCoding.TblBudgetProcessId in (1,2,3,4)) AND
																		(olden.tblGroup.AreaId = @areaId) AND
																		(olden.tblGroup.YearName = 1402)) 
                                                         AS tbl1
                                GROUP BY id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id
end


if(@areaId >=11)
begin
INSERT INTO TblCodingsMapSazman(          YearId       ,               AreaId              ,  CodingId     )
					SELECT        TblBudgets.TblYearId , tblBudgetDetailProjectArea.AreaId , tblCoding.Id
					FROM            TblBudgetDetails INNER JOIN
											 TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
											 tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
											 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
											 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
					WHERE (TblBudgets.TblYearId = 33) AND
						 -- (TblBudgets.TblAreaId = @areaId) AND
						  (tblCoding.TblBudgetProcessId in (1,2,3,4,9,10)) AND
						  (tblBudgetDetailProjectArea.AreaId = @areaId) AND (tblCoding.Id NOT IN
																	 (SELECT        CodingId
																		FROM            TblCodingsMapSazman
																		WHERE  (AreaId = @areaId) AND
																		       (YearId = 33)))

UPDATE       tblBudgetDetailProjectArea
SET                Expense = 0
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
					WHERE (TblBudgets.TblYearId = 33) AND
					    --  (TblBudgets.TblAreaId = @areaId) AND
						  (tblBudgetDetailProjectArea.AreaId = @areaId) AND
						  (tblCoding.TblBudgetProcessId in (1,2,3,9,10))

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        id, SUM(Expense) AS Expense
                                FROM            (SELECT        tblBudgetDetailProjectArea_1.id, 
                                                                                    CASE WHEN olden.tblGroup.Id = 999 THEN olden.tblSanadDetail_MD.Bedehkar - olden.tblSanadDetail_MD.Bestankar 
																					     WHEN olden.tblGroup.Id = 888 THEN olden.tblSanadDetail_MD.Bestankar - olden.tblSanadDetail_MD.Bedehkar
                                                                                         END AS Expense
                                                           FROM            olden.tblSanadDetail_MD INNER JOIN
                                                                                    olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                                                    olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                                                    olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id INNER JOIN
                                                                                    olden.tblGroup ON olden.tblKol.IdGroup = olden.tblGroup.Id INNER JOIN
                                                                                    TblBudgets INNER JOIN
                                                                                    TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                                                    tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                                                    tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                                                    tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                                                    TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc
                                                           WHERE (TblBudgets.TblYearId = 33) AND
														     --    (TblBudgets.TblAreaId = @areaId) AND
																 (olden.tblSanad_MD.AreaId = @areaId) AND
																 (olden.tblSanad_MD.YearName = 1402) AND 
                                                                 (olden.tblSanadDetail_MD.AreaId = @areaId) AND
																 (olden.tblSanadDetail_MD.YearName = 1402) AND
																 (olden.tblSanadDetail_MD.Description NOT LIKE '%بستن حساب%') AND
																 (olden.tblKol.AreaId = @areaId) AND
																 (olden.tblKol.YearName = 1402) AND 
                                                                 (TblCodingsMapSazman.AreaId = @areaId) AND
																 (TblCodingsMapSazman.YearId = 33) AND
																 (tblBudgetDetailProjectArea_1.AreaId = @areaId) AND
																 (tblCoding.TblBudgetProcessId IN (1,2,3,9,10)) AND 
                                                                 (olden.tblGroup.AreaId = @areaId) AND
																 (olden.tblGroup.YearName = 1402)) AS tbl1
                                GROUP BY id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id
end

END
GO
