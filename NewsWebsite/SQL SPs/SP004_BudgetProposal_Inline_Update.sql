USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP004_BudgetProposal_Inline_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP004_BudgetProposal_Inline_Update]
@yearId int, 
@areaId int,
@budgetProcessId int,
@CodingId int,
@PishnahadiCash bigint,
@PishnahadiNonCash bigint,
@Pishnahadi bigint,
@executionId int,
@proctorId int,
@Description nvarchar(1000)
AS
BEGIN
if(@areaId=10)
begin
    select ' فعلا برای مناطق و مرکز کاربردی نیست ' as Message_DB
return
end
declare @ExecuteId int
declare @areaIdMain int=@areaId

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

 if(@budgetProcessId<=4)
begin
    DECLARE @areaShare BIGINT;
    DECLARE @currentVal BIGINT;
    DECLARE @sql NVARCHAR(MAX);
    
    SET @sql = N'SELECT TOP(1) @areaShare = ShareProcessId' + CAST(@budgetProcessId AS NVARCHAR(10)) + ' FROM tblBudgetAreaShare WHERE AreaId = '+CAST(@areaIdMain AS NVARCHAR(10))+' AND YearId = '+CAST(@yearId AS NVARCHAR(10))+ ' AND Type = ''pishnahadi'';';
    
    -- Execute dynamic SQL and retrieve the value into @areaShare
    EXEC sp_executesql @sql, N'@areaShare BIGINT OUTPUT', @areaShare OUTPUT;
    
    
    
    
    
    SET @currentVal= isnull((select Pishnahadi from tblBudgetDetailProjectArea where id = @BudgetDetailProjectAreaId),0)
    
    declare @currentSum BIGINT = isnull((SELECT  sum(tblBudgetDetailProjectArea.Pishnahadi)
                                        FROM     TblBudgets INNER JOIN
                                                 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                 tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                                        WHERE   (tblCoding.TblBudgetProcessId = @budgetProcessId) AND
                                                (TblBudgets.TblYearId =@yearId) AND
                                                ((tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaIdMain in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaIdMain in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                                    )),0)
    
    if(@areaShare is not null and @areaShare<@currentSum-@currentVal+@Pishnahadi)
     begin
           select CONCAT('خطا - سهم منطقه ',@areaShare,' ریال می باشد و تنها',(@areaShare-@currentSum),'ریال آزاد می باشد') as Message_DB
        return
     end
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

--declare @Balance bigint = isnull(@ShareCivil,0) - isnull(@CivilSum,0)+isnull(@MosavabAgo,0)-isnull(@Pishnahadi,0)

--if(@Balance<0)
--begin
--    select 'مانده منفی می شود' as Message_DB
--	return
--end
--declare @Pishnahadi_Roned bigint
--set @Pishnahadi_Roned = @Pishnahadi-right(@Pishnahadi,7)
 --select dbo.seprator(cast(@Pishnahadi_Roned as nvarchar(50))) as Message_DB
	--return 

update tblBudgetDetailProjectArea
    set Pishnahadi = @Pishnahadi,
	PishnahadiCash= @PishnahadiCash,
    PishnahadiNonCash= @PishnahadiNonCash,
	ProctorId= @proctorId,
	executionId=@executionId,
        ConfirmStatus=0
       where id = @BudgetDetailProjectAreaId

update tblBudgetDetailProject
    set Mosavab = @Pishnahadi
       where id = @BudgetDetailProjectId

update TblBudgetDetails
    set MosavabPublic = @Pishnahadi
             where id = @BudgetDetailId

--update tblCoding
--set Description = @Description
--       where id = @CodingId

END
GO
