USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP555_Income_Insert]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP555_Income_Insert]

AS
BEGIN
delete olden.tblIncomeDetail
delete olden.tblIncome

INSERT INTO olden.tblIncome(Id ,AreaId , YearId , ShSerialFish , ShenaseGhabz , SDateSodoor , MablaghKol ,           Sanad_MD          ,Simak_MalekName)
		          SELECT    Id ,   1   ,   32   , ShSerialFish , ShenaseGhabz , SDateSodoor , MablaghKol , IdIncomeMunicipalitySanad_MD,Simak_MalekName
          FROM            AKH.AccAMJ1001.dbo.tblIncomeMunicipalityOperationAvarez
          WHERE        (IdSal_MD = 18)

INSERT INTO olden.tblIncome(Id ,AreaId , YearId , ShSerialFish , ShenaseGhabz , SDateSodoor , MablaghKol ,           Sanad_MD          ,Simak_MalekName)
		          SELECT    Id ,   2   ,   32   , ShSerialFish , ShenaseGhabz , SDateSodoor , MablaghKol , IdIncomeMunicipalitySanad_MD,Simak_MalekName
		FROM            AKH.AccAMJ1002.dbo.tblIncomeMunicipalityOperationAvarez
		WHERE        (IdSal_MD = 21)

INSERT INTO olden.tblIncome(Id ,AreaId , YearId , ShSerialFish , ShenaseGhabz , SDateSodoor , MablaghKol ,           Sanad_MD          ,Simak_MalekName)
		          SELECT    Id ,   3   ,   32   , ShSerialFish , ShenaseGhabz , SDateSodoor , MablaghKol , IdIncomeMunicipalitySanad_MD,Simak_MalekName
		FROM            AKH.AccAMJ1003.dbo.tblIncomeMunicipalityOperationAvarez
		WHERE        (IdSal_MD = 18)

INSERT INTO olden.tblIncome(Id ,AreaId , YearId , ShSerialFish , ShenaseGhabz , SDateSodoor , MablaghKol ,           Sanad_MD          ,Simak_MalekName)
		          SELECT    Id ,   4   ,   32   , ShSerialFish , ShenaseGhabz , SDateSodoor , MablaghKol , IdIncomeMunicipalitySanad_MD,Simak_MalekName
		FROM            AKH.AccAMJ1004.dbo.tblIncomeMunicipalityOperationAvarez
		WHERE        (IdSal_MD = 16)

INSERT INTO olden.tblIncome(Id ,AreaId , YearId , ShSerialFish , ShenaseGhabz , SDateSodoor , MablaghKol ,           Sanad_MD          ,Simak_MalekName)
		          SELECT    Id ,   5   ,   32   , ShSerialFish , ShenaseGhabz , SDateSodoor , MablaghKol , IdIncomeMunicipalitySanad_MD,Simak_MalekName
		FROM            AKH.AccAMJ1005.dbo.tblIncomeMunicipalityOperationAvarez
		WHERE        (IdSal_MD = 15)

INSERT INTO olden.tblIncome(Id ,AreaId , YearId , ShSerialFish , ShenaseGhabz , SDateSodoor , MablaghKol ,           Sanad_MD          ,Simak_MalekName)
		          SELECT    Id ,   6   ,   32   , ShSerialFish , ShenaseGhabz , SDateSodoor , MablaghKol , IdIncomeMunicipalitySanad_MD,Simak_MalekName
		FROM            AKH.AccAMJ1006.dbo.tblIncomeMunicipalityOperationAvarez
		WHERE        (IdSal_MD = 15)

INSERT INTO olden.tblIncome(Id ,AreaId , YearId , ShSerialFish , ShenaseGhabz , SDateSodoor , MablaghKol ,           Sanad_MD          ,Simak_MalekName)
		          SELECT    Id ,   7   ,   32   , ShSerialFish , ShenaseGhabz , SDateSodoor , MablaghKol , IdIncomeMunicipalitySanad_MD,Simak_MalekName
		FROM            AKH.AccAMJ1007.dbo.tblIncomeMunicipalityOperationAvarez
		WHERE        (IdSal_MD = 13)

INSERT INTO olden.tblIncome(Id ,AreaId , YearId , ShSerialFish , ShenaseGhabz , SDateSodoor , MablaghKol ,           Sanad_MD          ,Simak_MalekName)
		          SELECT    Id ,   8   ,   32   , ShSerialFish , ShenaseGhabz , SDateSodoor , MablaghKol , IdIncomeMunicipalitySanad_MD,Simak_MalekName
		FROM            AKH.AccAMJ1008.dbo.tblIncomeMunicipalityOperationAvarez
		WHERE        (IdSal_MD = 13)

INSERT INTO olden.tblIncome(Id ,AreaId , YearId , ShSerialFish , ShenaseGhabz , SDateSodoor , MablaghKol ,           Sanad_MD          ,Simak_MalekName)
		          SELECT    Id ,   9   ,   32   , ShSerialFish , ShenaseGhabz , SDateSodoor , MablaghKol , IdIncomeMunicipalitySanad_MD,Simak_MalekName
		FROM            AKH.AccAMJ1000.dbo.tblIncomeMunicipalityOperationAvarez
		WHERE        (IdSal_MD = 11)
--============================================================================================================================
insert into olden.tblIncomeDetail(YearId , 
                                  AreaId ,
								  Id     ,
							      IncomeId ,
								  Semak_CodingId ,
								  Semak_JozDaramadId ,
								  Amount ,
								  Semak_CodingName ,
								  IdKol ,
								  IdMoien ,
								  IdTafsily4 ,
								  IdTafsily5)
						SELECT      32   ,   
						            1    , 
									Id   , 
									IdIncomeMunicipalityOperationAvarez , 
                                    BaseStructDaramdAndSarfasl_IdSIncomeMunicipalityIdECity,
                                    BaseStructDaramdAndSarfasl_IdSIncomeMunicipalityJozDaramad,
                                    MablaghDetail, 
									BaseStructDaramdAndSarfasl_Name,			
						            IdKol, 
						            IdMoien,
						            IdTafsily4, 
						            IdTafsily5 
						FROM            AKH.AccAMJ1001.dbo.tblIncomeMunicipalityOperationAvarez_Details
						WHERE        (IdSal_MD = 18) 

insert into olden.tblIncomeDetail(YearId , 
                                  AreaId ,
								  Id     ,
							      IncomeId ,
								  Semak_CodingId ,
								  Semak_JozDaramadId ,
								  Amount ,
								  Semak_CodingName ,
								  IdKol ,
								  IdMoien ,
								  IdTafsily4 ,
								  IdTafsily5)
						SELECT      32   ,   
						            2    , 
									Id   , 
									IdIncomeMunicipalityOperationAvarez , 
                                    BaseStructDaramdAndSarfasl_IdSIncomeMunicipalityIdECity,
                                    BaseStructDaramdAndSarfasl_IdSIncomeMunicipalityJozDaramad,
                                    MablaghDetail, 
									BaseStructDaramdAndSarfasl_Name,			
						            IdKol, 
						            IdMoien,
						            IdTafsily4, 
						            IdTafsily5 
						FROM            AKH.AccAMJ1002.dbo.tblIncomeMunicipalityOperationAvarez_Details
						WHERE        (IdSal_MD = 21) 

insert into olden.tblIncomeDetail(YearId , 
                                  AreaId ,
								  Id     ,
							      IncomeId ,
								  Semak_CodingId ,
								  Semak_JozDaramadId ,
								  Amount ,
								  Semak_CodingName ,
								  IdKol ,
								  IdMoien ,
								  IdTafsily4 ,
								  IdTafsily5)
						SELECT      32   ,   
						            3    , 
									Id   , 
									IdIncomeMunicipalityOperationAvarez , 
                                    BaseStructDaramdAndSarfasl_IdSIncomeMunicipalityIdECity,
                                    BaseStructDaramdAndSarfasl_IdSIncomeMunicipalityJozDaramad,
                                    MablaghDetail, 
									BaseStructDaramdAndSarfasl_Name,			
						            IdKol, 
						            IdMoien,
						            IdTafsily4, 
						            IdTafsily5 
						FROM            AKH.AccAMJ1003.dbo.tblIncomeMunicipalityOperationAvarez_Details
						WHERE        (IdSal_MD = 18) 

insert into olden.tblIncomeDetail(YearId , 
                                  AreaId ,
								  Id     ,
							      IncomeId ,
								  Semak_CodingId ,
								  Semak_JozDaramadId ,
								  Amount ,
								  Semak_CodingName ,
								  IdKol ,
								  IdMoien ,
								  IdTafsily4 ,
								  IdTafsily5)
						SELECT      32   ,   
						            4    , 
									Id   , 
									IdIncomeMunicipalityOperationAvarez , 
                                    BaseStructDaramdAndSarfasl_IdSIncomeMunicipalityIdECity,
                                    BaseStructDaramdAndSarfasl_IdSIncomeMunicipalityJozDaramad,
                                    MablaghDetail, 
									BaseStructDaramdAndSarfasl_Name,			
						            IdKol, 
						            IdMoien,
						            IdTafsily4, 
						            IdTafsily5 
						FROM            AKH.AccAMJ1004.dbo.tblIncomeMunicipalityOperationAvarez_Details
						WHERE        (IdSal_MD = 16) 

insert into olden.tblIncomeDetail(YearId , 
                                  AreaId ,
								  Id     ,
							      IncomeId ,
								  Semak_CodingId ,
								  Semak_JozDaramadId ,
								  Amount ,
								  Semak_CodingName ,
								  IdKol ,
								  IdMoien ,
								  IdTafsily4 ,
								  IdTafsily5)
						SELECT      32   ,   
						            5    , 
									Id   , 
									IdIncomeMunicipalityOperationAvarez , 
                                    BaseStructDaramdAndSarfasl_IdSIncomeMunicipalityIdECity,
                                    BaseStructDaramdAndSarfasl_IdSIncomeMunicipalityJozDaramad,
                                    MablaghDetail, 
									BaseStructDaramdAndSarfasl_Name,			
						            IdKol, 
						            IdMoien,
						            IdTafsily4, 
						            IdTafsily5 
						FROM            AKH.AccAMJ1005.dbo.tblIncomeMunicipalityOperationAvarez_Details
						WHERE        (IdSal_MD = 15) 

insert into olden.tblIncomeDetail(YearId , 
                                  AreaId ,
								  Id     ,
							      IncomeId ,
								  Semak_CodingId ,
								  Semak_JozDaramadId ,
								  Amount ,
								  Semak_CodingName ,
								  IdKol ,
								  IdMoien ,
								  IdTafsily4 ,
								  IdTafsily5)
						SELECT      32   ,   
						            6    , 
									Id   , 
									IdIncomeMunicipalityOperationAvarez , 
                                    BaseStructDaramdAndSarfasl_IdSIncomeMunicipalityIdECity,
                                    BaseStructDaramdAndSarfasl_IdSIncomeMunicipalityJozDaramad,
                                    MablaghDetail, 
									BaseStructDaramdAndSarfasl_Name,			
						            IdKol, 
						            IdMoien,
						            IdTafsily4, 
						            IdTafsily5 
						FROM            AKH.AccAMJ1006.dbo.tblIncomeMunicipalityOperationAvarez_Details
						WHERE        (IdSal_MD = 15) 

insert into olden.tblIncomeDetail(YearId , 
                                  AreaId ,
								  Id     ,
							      IncomeId ,
								  Semak_CodingId ,
								  Semak_JozDaramadId ,
								  Amount ,
								  Semak_CodingName ,
								  IdKol ,
								  IdMoien ,
								  IdTafsily4 ,
								  IdTafsily5)
						SELECT      32   ,   
						            7    , 
									Id   , 
									IdIncomeMunicipalityOperationAvarez , 
                                    BaseStructDaramdAndSarfasl_IdSIncomeMunicipalityIdECity,
                                    BaseStructDaramdAndSarfasl_IdSIncomeMunicipalityJozDaramad,
                                    MablaghDetail, 
									BaseStructDaramdAndSarfasl_Name,			
						            IdKol, 
						            IdMoien,
						            IdTafsily4, 
						            IdTafsily5 
						FROM            AKH.AccAMJ1007.dbo.tblIncomeMunicipalityOperationAvarez_Details
						WHERE        (IdSal_MD = 13) 

insert into olden.tblIncomeDetail(YearId , 
                                  AreaId ,
								  Id     ,
							      IncomeId ,
								  Semak_CodingId ,
								  Semak_JozDaramadId ,
								  Amount ,
								  Semak_CodingName ,
								  IdKol ,
								  IdMoien ,
								  IdTafsily4 ,
								  IdTafsily5)
						SELECT      32   ,   
						            8    , 
									Id   , 
									IdIncomeMunicipalityOperationAvarez , 
                                    BaseStructDaramdAndSarfasl_IdSIncomeMunicipalityIdECity,
                                    BaseStructDaramdAndSarfasl_IdSIncomeMunicipalityJozDaramad,
                                    MablaghDetail, 
									BaseStructDaramdAndSarfasl_Name,			
						            IdKol, 
						            IdMoien,
						            IdTafsily4, 
						            IdTafsily5 
						FROM            AKH.AccAMJ1008.dbo.tblIncomeMunicipalityOperationAvarez_Details
						WHERE        (IdSal_MD = 13) 

insert into olden.tblIncomeDetail(YearId , 
                                  AreaId ,
								  Id     ,
							      IncomeId ,
								  Semak_CodingId ,
								  Semak_JozDaramadId ,
								  Amount ,
								  Semak_CodingName ,
								  IdKol ,
								  IdMoien ,
								  IdTafsily4 ,
								  IdTafsily5)
						SELECT      32   ,   
						            9    , 
									Id   , 
									IdIncomeMunicipalityOperationAvarez , 
                                    BaseStructDaramdAndSarfasl_IdSIncomeMunicipalityIdECity,
                                    BaseStructDaramdAndSarfasl_IdSIncomeMunicipalityJozDaramad,
                                    MablaghDetail, 
									BaseStructDaramdAndSarfasl_Name,			
						            IdKol, 
						            IdMoien,
						            IdTafsily4, 
						            IdTafsily5 
						FROM            AKH.AccAMJ1000.dbo.tblIncomeMunicipalityOperationAvarez_Details
						WHERE        (IdSal_MD = 11) 




END
GO
