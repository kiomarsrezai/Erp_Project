USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP004_BudgetProposalEdit_Inline_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP004_BudgetProposalEdit_Inline_Update]
@yearId int, 
@areaId int,
@budgetProcessId int,
@CodingId int,
@executionId int,
@proctorId int,
@BudgetNext bigint,
@Description nvarchar(1000)
AS
BEGIN
if(@areaId=10)
begin
    select ' فعلا برای مناطق و مرکز کاربردی نیست ' as Message_DB
return
end
declare @ExecuteId int

if(@areaId = 30) begin set @areaId=9  set @ExecuteId = 4  end
if(@areaId = 31) begin set @areaId=9  set @ExecuteId = 10 end
if(@areaId = 32) begin set @areaId=9  set @ExecuteId = 2  end
if(@areaId = 33) begin set @areaId=9  set @ExecuteId = 1  end
if(@areaId = 34) begin set @areaId=9  set @ExecuteId = 3  end
if(@areaId = 35) begin set @areaId=9  set @ExecuteId = 7  end
if(@areaId = 36) begin set @areaId=9  set @ExecuteId = 6  end
if(@areaId = 42) begin set @areaId=9  set @ExecuteId = 12 end
if(@areaId = 43) begin set @areaId=9  set @ExecuteId = 11 end
if(@areaId = 44) begin set @areaId=9  set @ExecuteId = 13 end
if(@areaId = 53) begin set @areaId=9  set @ExecuteId = 14 end

declare @Count_BudgetDetailProjectAreaId int =(SELECT count(*)
												FROM            TblBudgets INNER JOIN
																		 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
																		 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
																		 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
												WHERE       (TblBudgets.TblYearId = @yearId) AND
															(tblBudgetDetailProjectArea.AreaId = @areaId) AND
															(TblBudgetDetails.tblCodingId = @CodingId))

if(@Count_BudgetDetailProjectAreaId>=2)
 begin
    select ' تعداد رکورد بیشتر از یک مورد است ' as Message_DB
	return
 end

declare @BudgetDetailProjectAreaId int =(SELECT tblBudgetDetailProjectArea.id
												FROM            TblBudgets INNER JOIN
																		 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
																		 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
																		 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
												WHERE       (TblBudgets.TblYearId = @yearId) AND
															(tblBudgetDetailProjectArea.AreaId = @areaId) AND
															(TblBudgetDetails.tblCodingId = @CodingId))

if(@BudgetDetailProjectAreaId is null or @BudgetDetailProjectAreaId='')
 begin
    select 'خطا در BudgetDetailProjectAreaId' as Message_DB
	return
 end

declare @BudgetDetailProjectId int =(SELECT tblBudgetDetailProject.Id
										FROM        TblBudgets INNER JOIN
																 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
																 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
																 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
										WHERE       (TblBudgets.TblYearId = @yearId) AND
													(tblBudgetDetailProjectArea.AreaId = @areaId) AND
													(TblBudgetDetails.tblCodingId = @CodingId))

if(@BudgetDetailProjectId is null or @BudgetDetailProjectId='')
 begin
    select 'خطا در @BudgetDetailProjectId' as Message_DB
	return
 end

declare @BudgetDetailId int =(SELECT TblBudgetDetails.Id
										FROM     TblBudgets INNER JOIN
												 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
												 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
												 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
										WHERE   (TblBudgets.TblYearId = @yearId) AND
												(tblBudgetDetailProjectArea.AreaId = @areaId) AND
												(TblBudgetDetails.tblCodingId = @CodingId))

if(@BudgetDetailId is null or @BudgetDetailId='')
 begin
    select 'خطا در @BudgetDetailId' as Message_DB
	return
 end
 --declare @MosavabAgo bigint =(SELECT tblBudgetDetailProjectArea.Mosavab
	--											FROM            TblBudgets INNER JOIN
	--																	 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
	--																	 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
	--																	 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
	--											WHERE       (TblBudgets.TblYearId = @yearId) AND
	--														(tblBudgetDetailProjectArea.AreaId = @areaId) AND
	--														(TblBudgetDetails.tblCodingId = @CodingId))

   --declare @ShareCivil bigint = (select ShareCivil from TblBudgets where TblYearId = @yearId and TblAreaId = @AreaId)
   --declare @CivilSum   bigint = (SELECT  sum(tblBudgetDetailProjectArea.Mosavab)
			--						FROM     TblBudgets INNER JOIN
			--								 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
			--								 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
			--								 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
			--								 tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
			--						WHERE   (tblCoding.TblBudgetProcessId = 3) AND
			--							    (TblBudgets.TblYearId = @yearId) AND
			--							    (tblBudgetDetailProjectArea.AreaId = @AreaId))

--declare @Balance bigint = isnull(@ShareCivil,0) - isnull(@CivilSum,0)+isnull(@MosavabAgo,0)-isnull(@BudgetNext,0)

--if(@Balance<0)
--begin
--    select 'مانده منفی می شود' as Message_DB
--	return
--end
--declare @BudgetNext_Roned bigint
--set @BudgetNext_Roned = @BudgetNext-right(@BudgetNext,7)
 --select dbo.seprator(cast(@BudgetNext_Roned as nvarchar(50))) as Message_DB
	--return 

update tblBudgetDetailProjectArea
    set EditArea = @BudgetNext,
	ProctorId= @proctorId,
	executionId=@executionId
       where id = @BudgetDetailProjectAreaId

update tblBudgetDetailProject
    set Mosavab = @BudgetNext
       where id = @BudgetDetailProjectId

update TblBudgetDetails
    set MosavabPublic = @BudgetNext
             where id = @BudgetDetailId

--update tblCoding
--set Description = @Description
--       where id = @CodingId

END
GO
