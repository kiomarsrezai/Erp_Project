USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9900_Transfer_Akh_TO_Olden_TO_Budget_Sazman_140212345678910]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9900_Transfer_Akh_TO_Olden_TO_Budget_Sazman_140212345678910]
@AreaId int
AS
BEGIN

--فاوا  
if(@AreaId=11)
begin
delete olden.tblGroup           where AreaId = 11 and YearName = 1402
delete olden.tblKol             where AreaId = 11 and YearName = 1402
delete olden.tblMoien           where AreaId = 11 and YearName = 1402
delete olden.tblSanadKind       where AreaId = 11 and YearName = 1402
delete olden.tblSanadState      where AreaId = 11 and YearName = 1402
delete olden.tblTafsily         where AreaId = 11 and YearName = 1402
delete olden.tblSanad_MD        where AreaId = 11 and YearName = 1402
delete olden.tblSanadDetail_MD  where AreaId = 11 and YearName = 1402

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   11   ,    1402   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   11   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM           LFAVA.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=14 
UPDATE       tblBudgetDetailProjectArea
SET                Expense = 0
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE  (TblBudgets.TblYearId = 33) AND
       (TblBudgets.TblAreaId = 11) AND
	   (tblBudgetDetailProjectArea.AreaId = 11)

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bestankar) - SUM(olden.tblSanadDetail_MD.Bedehkar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 11) AND 
									  (olden.tblSanad_MD.AreaId = 11) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 11) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 11) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 6)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 11) AND 
									  (olden.tblSanad_MD.AreaId = 11) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 11) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 11) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 7)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id
return
end

--آتش نشانی  
if(@AreaId=12)
begin
delete olden.tblGroup           where AreaId = 12 and YearName = 1402
delete olden.tblKol             where AreaId = 12 and YearName = 1402
delete olden.tblMoien           where AreaId = 12 and YearName = 1402
delete olden.tblSanadKind       where AreaId = 12 and YearName = 1402
delete olden.tblSanadState      where AreaId = 12 and YearName = 1402
delete olden.tblTafsily         where AreaId = 12 and YearName = 1402
delete olden.tblSanad_MD        where AreaId = 12 and YearName = 1402
delete olden.tblSanadDetail_MD  where AreaId = 12 and YearName = 1402

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   12   ,    1402   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   12   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM         Lfire.AccAMJ295.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=13 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = 0
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE  (TblBudgets.TblYearId = 33) AND
       (TblBudgets.TblAreaId = 12) AND
	   (tblBudgetDetailProjectArea.AreaId = 12)

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bestankar) - SUM(olden.tblSanadDetail_MD.Bedehkar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 12) AND 
									  (olden.tblSanad_MD.AreaId = 12) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 12) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 12) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 4)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 12) AND 
									  (olden.tblSanad_MD.AreaId = 12) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 12) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 12) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 7)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id
return
end

--اتوبوسرانی
if(@AreaId=13)
begin
delete olden.tblGroup           where AreaId = 13 and YearName = 1402
delete olden.tblKol             where AreaId = 13 and YearName = 1402
delete olden.tblMoien           where AreaId = 13 and YearName = 1402
delete olden.tblSanadKind       where AreaId = 13 and YearName = 1402
delete olden.tblSanadState      where AreaId = 13 and YearName = 1402
delete olden.tblTafsily         where AreaId = 13 and YearName = 1402
delete olden.tblSanad_MD        where AreaId = 13 and YearName = 1402
delete olden.tblSanadDetail_MD  where AreaId = 13 and YearName = 1402

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   13   ,    1402   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   13   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM            Lbus.AccAMJ295.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=12 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = 0
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE  (TblBudgets.TblYearId = 33) AND
       (TblBudgets.TblAreaId = 13) AND
	   (tblBudgetDetailProjectArea.AreaId = 13)

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bestankar) - SUM(olden.tblSanadDetail_MD.Bedehkar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 13) AND 
									  (olden.tblSanad_MD.AreaId = 13) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 13) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 13) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 6)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 13) AND 
									  (olden.tblSanad_MD.AreaId = 13) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 13) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 13) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 5)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id
return
end

--نوسازی 
if(@AreaId=14)
begin
delete olden.tblGroup           where AreaId = 14 and YearName = 1402
delete olden.tblKol             where AreaId = 14 and YearName = 1402
delete olden.tblMoien           where AreaId = 14 and YearName = 1402
delete olden.tblSanadKind       where AreaId = 14 and YearName = 1402
delete olden.tblSanadState      where AreaId = 14 and YearName = 1402
delete olden.tblTafsily         where AreaId = 14 and YearName = 1402
delete olden.tblSanad_MD        where AreaId = 14 and YearName = 1402
delete olden.tblSanadDetail_MD  where AreaId = 14 and YearName = 1402

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   14   ,    1402   , Name
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
		            WHERE        (IdSal_MD = 10)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   14   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM           Lbehsazi.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=10 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = 0
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE  (TblBudgets.TblYearId = 33) AND
       (TblBudgets.TblAreaId = 14) AND
	   (tblBudgetDetailProjectArea.AreaId = 14)

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bestankar) - SUM(olden.tblSanadDetail_MD.Bedehkar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 14) AND 
									  (olden.tblSanad_MD.AreaId = 14) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 14) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 14) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 7)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 14) AND 
									  (olden.tblSanad_MD.AreaId = 14) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 14) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 14) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 6)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id

return
end

--پارکها
if(@AreaId=15)
begin
delete olden.tblGroup           where AreaId = 15 and YearName = 1402
delete olden.tblKol             where AreaId = 15 and YearName = 1402
delete olden.tblMoien           where AreaId = 15 and YearName = 1402
delete olden.tblSanadKind       where AreaId = 15 and YearName = 1402
delete olden.tblSanadState      where AreaId = 15 and YearName = 1402
delete olden.tblTafsily         where AreaId = 15 and YearName = 1402
delete olden.tblSanad_MD        where AreaId = 15 and YearName = 1402
delete olden.tblSanadDetail_MD  where AreaId = 15 and YearName = 1402

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   15   ,    1402   , Name
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
		            WHERE        (IdSal_MD = 11)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   15   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM           LPARK.AccAmj196.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=11 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = 0
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE  (TblBudgets.TblYearId = 33) AND
       (TblBudgets.TblAreaId = 15) AND
	   (tblBudgetDetailProjectArea.AreaId = 15)

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bestankar) - SUM(olden.tblSanadDetail_MD.Bedehkar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 15) AND 
									  (olden.tblSanad_MD.AreaId = 15) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 15) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 15) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 6)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 15) AND 
									  (olden.tblSanad_MD.AreaId = 15) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 15) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 15) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 7)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id
return
end

--ترمینال ها
if(@AreaId=16)
begin
delete olden.tblGroup           where AreaId = 16 and YearName = 1402
delete olden.tblKol             where AreaId = 16 and YearName = 1402
delete olden.tblMoien           where AreaId = 16 and YearName = 1402
delete olden.tblSanadKind       where AreaId = 16 and YearName = 1402
delete olden.tblSanadState      where AreaId = 16 and YearName = 1402
delete olden.tblTafsily         where AreaId = 16 and YearName = 1402
delete olden.tblSanad_MD        where AreaId = 16 and YearName = 1402
delete olden.tblSanadDetail_MD  where AreaId = 16 and YearName = 1402

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   16   ,    1402   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   16   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM          LTERMINAL.AccAmj.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=12 
UPDATE       tblBudgetDetailProjectArea
SET                Expense = 0
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE  (TblBudgets.TblYearId = 33) AND
       (TblBudgets.TblAreaId = 16) AND
	   (tblBudgetDetailProjectArea.AreaId = 16)

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bestankar) - SUM(olden.tblSanadDetail_MD.Bedehkar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 16) AND 
									  (olden.tblSanad_MD.AreaId = 16) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 16) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 16) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 6)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 16) AND 
									  (olden.tblSanad_MD.AreaId = 16) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 16) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 16) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 7)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id
return
end

-- تاکسیرانی
if(@AreaId=17)
begin
delete olden.tblGroup           where AreaId = 17 and YearName = 1402
delete olden.tblKol             where AreaId = 17 and YearName = 1402
delete olden.tblMoien           where AreaId = 17 and YearName = 1402
delete olden.tblSanadKind       where AreaId = 17 and YearName = 1402
delete olden.tblSanadState      where AreaId = 17 and YearName = 1402
delete olden.tblTafsily         where AreaId = 17 and YearName = 1402
delete olden.tblSanad_MD        where AreaId = 17 and YearName = 1402
delete olden.tblSanadDetail_MD  where AreaId = 17 and YearName = 1402

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   17   ,    1402   , Name
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
		            WHERE        (IdSal_MD = 11)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   17   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM          LTAXI.AccAMJ1095.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=11 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = 0
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE  (TblBudgets.TblYearId = 33) AND
       (TblBudgets.TblAreaId = 17) AND
	   (tblBudgetDetailProjectArea.AreaId = 17)
	   
UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bestankar) - SUM(olden.tblSanadDetail_MD.Bedehkar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 17) AND 
									  (olden.tblSanad_MD.AreaId = 17) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 17) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 17) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 6)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 17) AND 
									  (olden.tblSanad_MD.AreaId = 17) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 17) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 17) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 7)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id
return
end

-- موتوری
if(@AreaId=18)
begin
delete olden.tblGroup           where AreaId = 18 and YearName = 1402
delete olden.tblKol             where AreaId = 18 and YearName = 1402
delete olden.tblMoien           where AreaId = 18 and YearName = 1402
delete olden.tblSanadKind       where AreaId = 18 and YearName = 1402
delete olden.tblSanadState      where AreaId = 18 and YearName = 1402
delete olden.tblTafsily         where AreaId = 18 and YearName = 1402
delete olden.tblSanad_MD        where AreaId = 18 and YearName = 1402
delete olden.tblSanadDetail_MD  where AreaId = 18 and YearName = 1402

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   18   ,    1402   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   18   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM         LMOTORI.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=16 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = 0
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE  (TblBudgets.TblYearId = 33) AND
       (TblBudgets.TblAreaId = 18) AND
	   (tblBudgetDetailProjectArea.AreaId = 18)


UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bestankar) - SUM(olden.tblSanadDetail_MD.Bedehkar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 18) AND 
									  (olden.tblSanad_MD.AreaId = 18) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 18) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 18) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 6)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 18) AND 
									  (olden.tblSanad_MD.AreaId = 18) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 18) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 18) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup in (7,8))
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id
return
end

--ارامستانها
if(@AreaId=19)
begin
delete olden.tblGroup           where AreaId = 19 and YearName = 1402
delete olden.tblKol             where AreaId = 19 and YearName = 1402
delete olden.tblMoien           where AreaId = 19 and YearName = 1402
delete olden.tblSanadKind       where AreaId = 19 and YearName = 1402
delete olden.tblSanadState      where AreaId = 19 and YearName = 1402
delete olden.tblTafsily         where AreaId = 19 and YearName = 1402
delete olden.tblSanad_MD        where AreaId = 19 and YearName = 1402
delete olden.tblSanadDetail_MD  where AreaId = 19 and YearName = 1402

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   19   ,    1402   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   19   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM         LBEHESHT.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=11 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = 0
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE  (TblBudgets.TblYearId = 33) AND
       (TblBudgets.TblAreaId = 19) AND
	   (tblBudgetDetailProjectArea.AreaId = 19)

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bestankar) - SUM(olden.tblSanadDetail_MD.Bedehkar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 19) AND 
									  (olden.tblSanad_MD.AreaId = 19) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 19) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 19) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 6)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 19) AND 
									  (olden.tblSanad_MD.AreaId = 19) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 19) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 19) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 7)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id
return
end

-- بار
if(@AreaId = 20)
begin
delete olden.tblGroup           where AreaId = 20 and YearName = 1402
delete olden.tblKol             where AreaId = 20 and YearName = 1402
delete olden.tblMoien           where AreaId = 20 and YearName = 1402
delete olden.tblSanadKind       where AreaId = 20 and YearName = 1402
delete olden.tblSanadState      where AreaId = 20 and YearName = 1402
delete olden.tblTafsily         where AreaId = 20 and YearName = 1402
delete olden.tblSanad_MD        where AreaId = 20 and YearName = 1402
delete olden.tblSanadDetail_MD  where AreaId = 20 and YearName = 1402

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   20   ,    1402   , Name
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
		            WHERE        (IdSal_MD = 15)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   20   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM         LBAR.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=15 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = 0
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE  (TblBudgets.TblYearId = 33) AND
       (TblBudgets.TblAreaId = 20) AND
	   (tblBudgetDetailProjectArea.AreaId = 20)


UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bestankar) - SUM(olden.tblSanadDetail_MD.Bedehkar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 20) AND 
									  (olden.tblSanad_MD.AreaId = 20) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 20) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 20) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 4)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 20) AND 
									  (olden.tblSanad_MD.AreaId = 20) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 20) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 20) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 5)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id
return
end

--  زیبا سازی
if(@AreaId=21)
begin
delete olden.tblGroup           where AreaId = 21 and YearName = 1402
delete olden.tblKol             where AreaId = 21 and YearName = 1402
delete olden.tblMoien           where AreaId = 21 and YearName = 1402
delete olden.tblSanadKind       where AreaId = 21 and YearName = 1402
delete olden.tblSanadState      where AreaId = 21 and YearName = 1402
delete olden.tblTafsily         where AreaId = 21 and YearName = 1402
delete olden.tblSanad_MD        where AreaId = 21 and YearName = 1402
delete olden.tblSanadDetail_MD  where AreaId = 21 and YearName = 1402

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   21   ,    1402   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   21   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM         LZIBA.accamj297.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=14 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = 0
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE  (TblBudgets.TblYearId = 33) AND
       (TblBudgets.TblAreaId = 21) AND
	   (tblBudgetDetailProjectArea.AreaId = 21)


UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bestankar) - SUM(olden.tblSanadDetail_MD.Bedehkar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 21) AND 
									  (olden.tblSanad_MD.AreaId = 21) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 21) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 21) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 7)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 21) AND 
									  (olden.tblSanad_MD.AreaId = 21) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 21) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 21) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 6)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id
return
end

--عمران شهری
if(@AreaId=22)
begin
delete olden.tblGroup           where AreaId = 22 and YearName = 1402
delete olden.tblKol             where AreaId = 22 and YearName = 1402
delete olden.tblMoien           where AreaId = 22 and YearName = 1402
delete olden.tblSanadKind       where AreaId = 22 and YearName = 1402
delete olden.tblSanadState      where AreaId = 22 and YearName = 1402
delete olden.tblTafsily         where AreaId = 22 and YearName = 1402
delete olden.tblSanad_MD        where AreaId = 22 and YearName = 1402
delete olden.tblSanadDetail_MD  where AreaId = 22 and YearName = 1402

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   22   ,    1402   , Name
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
		            WHERE        (IdSal_MD = 11)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   22   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM         LOMRAN.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=11 

--UPDATE       tblBudgetDetailProjectArea
--SET                Expense = 0
--FROM            TblBudgets INNER JOIN
--                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
--WHERE  (TblBudgets.TblYearId = 33) AND
--       (TblBudgets.TblAreaId = 22) AND
--	   (tblBudgetDetailProjectArea.AreaId = 22)

--عمران شهری
--UPDATE       tblBudgetDetailProjectArea
--SET                Expense = der_Akhavan.Expense
--FROM            tblBudgetDetailProjectArea INNER JOIN
--                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bestankar) - SUM(olden.tblSanadDetail_MD.Bedehkar) AS Expense
--                                FROM            olden.tblSanadDetail_MD INNER JOIN
--                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
--                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
--                                                         TblBudgets INNER JOIN
--                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
--                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
--                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
--                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
--                                WHERE (TblBudgets.TblYearId = 33) AND
--								      (TblBudgets.TblAreaId = 22) AND 
--									  (olden.tblSanad_MD.AreaId = 22) AND
--									  (olden.tblSanad_MD.YearName = 1402) AND
--									  (olden.tblSanadDetail_MD.AreaId = 22) AND 
--                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
--									  (olden.tblKol.AreaId = 22) AND
--									  (olden.tblKol.YearName = 1402) --AND
--									  (olden.tblKol.IdGroup = 6)
--                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id

--UPDATE       tblBudgetDetailProjectArea
--SET                Expense = der_Akhavan.Expense
--FROM            tblBudgetDetailProjectArea INNER JOIN
--                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
--                                FROM            olden.tblSanadDetail_MD INNER JOIN
--                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
--                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
--                                                         TblBudgets INNER JOIN
--                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
--                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
--                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
--                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
--                                WHERE (TblBudgets.TblYearId = 33) AND
--								      (TblBudgets.TblAreaId = 22) AND 
--									  (olden.tblSanad_MD.AreaId = 22) AND
--									  (olden.tblSanad_MD.YearName = 1402) AND
--									  (olden.tblSanadDetail_MD.AreaId = 22) AND 
--                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
--									  (olden.tblKol.AreaId = 22) AND
--									  (olden.tblKol.YearName = 1402) AND
--									  (olden.tblKol.IdGroup = 7)
--                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id
return
end

--پسماند
if(@AreaId=23)
begin
delete olden.tblGroup           where AreaId = 23 and YearName = 1402
delete olden.tblKol             where AreaId = 23 and YearName = 1402
delete olden.tblMoien           where AreaId = 23 and YearName = 1402
delete olden.tblSanadKind       where AreaId = 23 and YearName = 1402
delete olden.tblSanadState      where AreaId = 23 and YearName = 1402
delete olden.tblTafsily         where AreaId = 23 and YearName = 1402
delete olden.tblSanad_MD        where AreaId = 23 and YearName = 1402
delete olden.tblSanadDetail_MD  where AreaId = 23 and YearName = 1402

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   23   ,    1402   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   23   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM        LPASMAND.AccAMJ198.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=13 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = 0
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE  (TblBudgets.TblYearId = 33) AND
       (TblBudgets.TblAreaId = 23) AND
	   (tblBudgetDetailProjectArea.AreaId = 23)


UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bestankar) - SUM(olden.tblSanadDetail_MD.Bedehkar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 23) AND 
									  (olden.tblSanad_MD.AreaId = 23) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 23) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 23) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 6)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 23) AND 
									  (olden.tblSanad_MD.AreaId = 23) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 23) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 23) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 7)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id
return
end

-- میادین
if(@AreaId=24)
begin
delete olden.tblGroup           where AreaId = 24 and YearName = 1402
delete olden.tblKol             where AreaId = 24 and YearName = 1402
delete olden.tblMoien           where AreaId = 24 and YearName = 1402
delete olden.tblSanadKind       where AreaId = 24 and YearName = 1402
delete olden.tblSanadState      where AreaId = 24 and YearName = 1402
delete olden.tblTafsily         where AreaId = 24 and YearName = 1402
delete olden.tblSanad_MD        where AreaId = 24 and YearName = 1402
delete olden.tblSanadDetail_MD  where AreaId = 24 and YearName = 1402

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   24   ,    1402   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   24   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM        LMAYADIN.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=12 


UPDATE       tblBudgetDetailProjectArea
SET                Expense = 0
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE  (TblBudgets.TblYearId = 33) AND
       (TblBudgets.TblAreaId = 24) AND
	   (tblBudgetDetailProjectArea.AreaId = 24)

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bestankar) - SUM(olden.tblSanadDetail_MD.Bedehkar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 24) AND 
									  (olden.tblSanad_MD.AreaId = 24) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 24) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 24) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 6)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 24) AND 
									  (olden.tblSanad_MD.AreaId = 24) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 24) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 24) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 7)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id
return
end

--فرهنگی
if(@AreaId=25)
begin
delete olden.tblGroup           where AreaId = 25 and YearName = 1402
delete olden.tblKol             where AreaId = 25 and YearName = 1402
delete olden.tblMoien           where AreaId = 25 and YearName = 1402
delete olden.tblSanadKind       where AreaId = 25 and YearName = 1402
delete olden.tblSanadState      where AreaId = 25 and YearName = 1402
delete olden.tblTafsily         where AreaId = 25 and YearName = 1402
delete olden.tblSanad_MD        where AreaId = 25 and YearName = 1402
delete olden.tblSanadDetail_MD  where AreaId = 25 and YearName = 1402

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   25   ,    1402   , Name
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

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   25   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM        LSPORT.AccAMJ.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=14 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = 0
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE  (TblBudgets.TblYearId = 33) AND
       (TblBudgets.TblAreaId = 25) AND
	   (tblBudgetDetailProjectArea.AreaId = 25)


UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bestankar) - SUM(olden.tblSanadDetail_MD.Bedehkar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 25) AND 
									  (olden.tblSanad_MD.AreaId = 25) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 25) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 25) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 6)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 25) AND 
									  (olden.tblSanad_MD.AreaId = 25) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 25) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 25) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 7)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id
return
end

-- ریلی
if(@AreaId=26)
begin
delete olden.tblGroup           where AreaId = 26 and YearName = 1402
delete olden.tblKol             where AreaId = 26 and YearName = 1402
delete olden.tblMoien           where AreaId = 26 and YearName = 1402
delete olden.tblSanadKind       where AreaId = 26 and YearName = 1402
delete olden.tblSanadState      where AreaId = 26 and YearName = 1402
delete olden.tblTafsily         where AreaId = 26 and YearName = 1402
delete olden.tblSanad_MD        where AreaId = 26 and YearName = 1402
delete olden.tblSanadDetail_MD  where AreaId = 26 and YearName = 1402

insert into olden.tblGroup( id , AreaId , YearName  , Name)
				SELECT      Id ,   26   ,    1402   , Name
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
		            WHERE        (IdSal_MD = 14)			

insert into olden.tblSanadDetail_MD(Id , IdSanad_MD , AreaId , YearName , IdKol , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar)
						   SELECT   Id , IdSanad_MD ,   26   ,  1402    ,IdKol  , IdMoien , IdTafsily4 , IdSotooh4 , IdTafsily5 , IdSotooh5 , IdTafsily6 , IdSotooh6 , Description , Bedehkar , Bestankar
							 FROM         LMETRO.AccAMJ195.dbo.tblSanadDetail_MD
							   where IdSalSanad_MD=14 

UPDATE       tblBudgetDetailProjectArea
SET                Expense = 0
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE  (TblBudgets.TblYearId = 33) AND
       (TblBudgets.TblAreaId = 26) AND
	   (tblBudgetDetailProjectArea.AreaId = 26)


UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bestankar) - SUM(olden.tblSanadDetail_MD.Bedehkar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 26) AND 
									  (olden.tblSanad_MD.AreaId = 26) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 26) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 26) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 6)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id

UPDATE       tblBudgetDetailProjectArea
SET                Expense = der_Akhavan.Expense
FROM            tblBudgetDetailProjectArea INNER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.id, SUM(olden.tblSanadDetail_MD.Bedehkar) - SUM(olden.tblSanadDetail_MD.Bestankar) AS Expense
                                FROM            olden.tblSanadDetail_MD INNER JOIN
                                                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                                                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName INNER JOIN
                                                         TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId ON olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc INNER JOIN
                                                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id
                                WHERE (TblBudgets.TblYearId = 33) AND
								      (TblBudgets.TblAreaId = 26) AND 
									  (olden.tblSanad_MD.AreaId = 26) AND
									  (olden.tblSanad_MD.YearName = 1402) AND
									  (olden.tblSanadDetail_MD.AreaId = 26) AND 
                                      (olden.tblSanadDetail_MD.YearName = 1402) AND
									  (olden.tblKol.AreaId = 26) AND
									  (olden.tblKol.YearName = 1402) AND
									  (olden.tblKol.IdGroup = 7)
                                GROUP BY tblBudgetDetailProjectArea_1.id) AS der_Akhavan ON tblBudgetDetailProjectArea.id = der_Akhavan.id
return

END

END
GO
