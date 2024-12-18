USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP004_BudgetProposal_BalanceTextbox_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP004_BudgetProposal_BalanceTextbox_Read]
@yearId int ,
@AreaId int,
@budgetProcessId int
AS
BEGIN

if(@AreaId = 10)
 begin
     declare @CivilSumkol   bigint
	declare @Balancekol bigint 

declare @Revenuekol bigint = (SELECT        SUM(tblBudgetDetailProjectArea.Mosavab) AS Expr1
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
WHERE        (TblBudgets.TblYearId = @yearId) AND
(tblCoding.TblBudgetProcessId = 1) AND
(TblAreas.StructureId = 1))


declare @Currentkol bigint = (SELECT        SUM(tblBudgetDetailProjectArea.Mosavab) AS Expr1
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
WHERE        (TblBudgets.TblYearId = @yearId) AND (tblCoding.TblBudgetProcessId = 2) AND (TblAreas.StructureId = 1)) 

declare @Civilkol bigint = (SELECT        SUM(tblBudgetDetailProjectArea.Mosavab) AS Expr1
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
WHERE        (TblBudgets.TblYearId = @yearId) AND (tblCoding.TblBudgetProcessId = 3) AND (TblAreas.StructureId = 1))   
   
declare @Motomarkezkol bigint = (SELECT        SUM(tblBudgetDetailProjectArea.Mosavab) AS Expr1
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
WHERE        (TblBudgets.TblYearId = @yearId) AND (tblCoding.TblBudgetProcessId = 8) AND (TblAreas.StructureId = 1))     
   
   
declare @Komakkol bigint = (SELECT        SUM(tblBudgetDetailProjectArea.Mosavab) AS Expr1
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
WHERE        (TblBudgets.TblYearId = @yearId) AND (tblCoding.TblBudgetProcessId = 10) AND (TblAreas.StructureId = 1))     
   
declare @Tamalok_Mailkol bigint = (SELECT        SUM(tblBudgetDetailProjectArea.Mosavab) AS Expr1
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
WHERE        (TblBudgets.TblYearId = @yearId) AND (tblCoding.TblBudgetProcessId = 4) AND (TblAreas.StructureId = 1))  
									  

declare @Tabsarehkol bigint = (SELECT        SUM(tblBudgetDetailProjectArea.Mosavab) AS Expr1
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
WHERE        (TblBudgets.TblYearId = @yearId) AND (tblCoding.TblBudgetProcessId = 5) AND (TblAreas.StructureId = 1))  




select   @Balancekol = isnull(@Revenuekol,0) - isnull(@Currentkol,0) - isnull(@Civilkol,0) - isnull(@Motomarkezkol,0) + isnull(@Komakkol,0)-isnull(@Tamalok_Mailkol,0) -isnull(@Tabsarehkol,0)
 select @Balancekol as Balance
 return
 end

if(@AreaId in (30,31,32,33,34,35,36))
begin
declare @CivilSumEx  bigint
	declare @BalanceEx bigint 
	declare @CivilExecute bigint
	declare @ExecuteId int
	if(@AreaId = 30 ) begin set @ExecuteId = 4  set @CivilExecute = 466000000000   end-- شهر سازی
	if(@AreaId = 31)  begin set @ExecuteId = 10 set @CivilExecute = 25068000000000 end-- معاونت فنی عمرانی
	if(@AreaId = 32)  begin set @ExecuteId = 2  set @CivilExecute = 4150000000000  end -- حمل و نقل و ترافیک
	if(@AreaId = 33)  begin set @ExecuteId = 1  set @CivilExecute = 2792000000000  end--خدمات شهری
	if(@AreaId = 34)  begin set @ExecuteId = 3  set @CivilExecute = 2822000000000  end -- فرهنگی
	if(@AreaId = 35)  begin set @ExecuteId = 7  set @CivilExecute = 3952000000000  end -- مالی اقتصادی
	if(@AreaId = 36)  begin set @ExecuteId = 6  set @CivilExecute = 652000000000   end--برنامه ریزی


      select @CivilSumEx   = (SELECT        SUM(tblBudgetDetailProjectArea.Mosavab) AS Expr1
								FROM     TblBudgets INNER JOIN
										 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
										 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
										 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
										 tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
										 WHERE  (tblCoding.TblBudgetProcessId = 3) AND
												(TblBudgets.TblYearId = @yearId) AND
												(tblBudgetDetailProjectArea.AreaId = 9) AND
												(tblCoding.ExecuteId = @ExecuteId))


 select   @BalanceEx = isnull(@CivilExecute,0) -isnull(@CivilSumEx,0)   
 select @BalanceEx as Balance
return
end

if(@AreaId not in (10,30,31,32,33,34,35,36))
begin
declare @CivilSum   bigint
	declare @Balance bigint 


declare @Revenue bigint = (SELECT    sum(tblBudgetDetailProjectArea.Mosavab)
								FROM  TblBudgets INNER JOIN
									  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
							  WHERE  (TblBudgets.TblYearId = @yearId) AND
							         (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
								     (tblCoding.TblBudgetProcessId = 1))


declare @Current bigint = (SELECT    sum(tblBudgetDetailProjectArea.Mosavab)
							FROM   TblBudgets INNER JOIN
								   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
								   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
								   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
								   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
					       WHERE  (TblBudgets.TblYearId = @yearId) AND
						          (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
								  (tblCoding.TblBudgetProcessId = 2)) 

declare @Civil bigint = (SELECT    sum(tblBudgetDetailProjectArea.Mosavab)
							FROM   TblBudgets INNER JOIN
								   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
								   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
								   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
								   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
					       WHERE  (TblBudgets.TblYearId = @yearId) AND
						          (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
								  (tblCoding.TblBudgetProcessId = 3))   
   
declare @Motomarkez bigint = (SELECT   sum(tblBudgetDetailProjectArea.Mosavab)
								FROM   TblBudgets INNER JOIN
									   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
								WHERE (TblBudgets.TblYearId = @yearId) AND
									  (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
									  (tblCoding.TblBudgetProcessId = 8))     
   
   
declare @Komak bigint = (SELECT  sum(tblBudgetDetailProjectArea.Mosavab)
								FROM   TblBudgets INNER JOIN
									   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
								WHERE (TblBudgets.TblYearId = @yearId) AND
									  (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
									  (tblCoding.TblBudgetProcessId = 10))     
   
declare @Tamalok_Mail bigint = (SELECT  sum(tblBudgetDetailProjectArea.Mosavab)
								FROM   TblBudgets INNER JOIN
									   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
								WHERE (TblBudgets.TblYearId = @yearId) AND
									  (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
									  (tblCoding.TblBudgetProcessId = 4))  
									  

declare @Tabsareh bigint = (SELECT  sum(tblBudgetDetailProjectArea.Mosavab)
								FROM   TblBudgets INNER JOIN
									   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
								WHERE (TblBudgets.TblYearId = @yearId) AND
									  (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
									  (tblCoding.TblBudgetProcessId = 5))  




select   @Balance = isnull(@Revenue,0) - isnull(@Current,0) - isnull(@Civil,0) - isnull(@Motomarkez,0) + isnull(@Komak,0)-isnull(@Tamalok_Mail,0) -isnull(@Tabsareh,0)
 select @Balance as Balance
return
end

 


END
GO
