USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP004_BudgetProposal_Inline_Delete]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP004_BudgetProposal_Inline_Delete]
@yearId int, 
@areaId int,
@budgetProcessId int,
@CodingId int
AS
BEGIN

--     declare @LevelNumber tinyint    = (select levelNumber from tblCoding where id = @CodingId)
-- 
--     if(@yearId<>34 or @budgetProcessId<>3 or @LevelNumber<>5)
-- 	begin
-- 	   select 'فعلا حذف برای سال 1403 و ردیف های عمرانی و سطح 5 امکان پذیر است' as Message_DB
-- 	   return
-- 	end

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
select ' تعداد رکورد بیشتر از یک مورد است. از بودجه مصوب اقدام نمایید ' as Message_DB
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
    
    
declare @isDelegateRecord int =(SELECT Id FROM     tblBudgetDetailProjectAreaDelegate where CostRecordId=@BudgetDetailProjectAreaId or NiabatiRecordId=@BudgetDetailProjectAreaId)
if(@isDelegateRecord is not null and @isDelegateRecord<>'')
begin
select 'این ردیف نیابتی است  و تنها از طریق تغییر ردیف بودجه نیابت دهنده قابل ویرایش می باشد' as Message_DB
    return
end

    
    -- delete naibat records if is niabati
declare @NiabatiRecordId int=0 ,@CostRecordId int=0
SELECT @NiabatiRecordId=NiabatiRecordId,@CostRecordId=CostRecordId FROM     tblBudgetDetailProjectAreaDelegate where BudgetDetailProjectAreaId=@BudgetDetailProjectAreaId
    if(@NiabatiRecordId>0 and @CostRecordId>0 )
begin
delete from tblBudgetDetailProjectAreaDelegate where BudgetDetailProjectAreaId=@BudgetDetailProjectAreaId
delete from tblBudgetDetailProjectArea where id in (@NiabatiRecordId,@CostRecordId)
end
    

    -- delete BudgetDetailProjectArea record
delete tblBudgetDetailProjectArea
where id in (SELECT  tblBudgetDetailProjectArea.id
											FROM     TblBudgets INNER JOIN
													 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
													 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
													 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
											WHERE   (TblBudgets.TblYearId = @yearId) AND
											        (TblBudgetDetails.tblCodingId = @CodingId) AND
                                                     ((tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaIdMain in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaIdMain in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29)))
											)

-- delete tblBudgetDetailProject record if has no another sub record

    declare @remainAreaRowCount int = (SELECT  count(*) as c
                                       FROM     TblBudgets INNER JOIN
                                                TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id 
                                           
                                       WHERE  (TblBudgets.TblYearId = @yearId) AND
                                              (TblBudgetDetails.tblCodingId = @CodingId))

if(@remainAreaRowCount=0)
begin

        delete tblBudgetDetailProject
        where id in (SELECT        tblBudgetDetailProject.Id
                     FROM            TblBudgets INNER JOIN
                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                     WHERE  (TblBudgets.TblYearId = @yearId) AND
                         (TblBudgetDetails.tblCodingId = @CodingId)
        )

end




END
GO
