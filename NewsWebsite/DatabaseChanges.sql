add Last3Month , Last9Month bigint  in tblBudgetDetailProjectArea



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
@delegateTo int,
@delegateAmount bigint,
@delegatePercentage int,
@Last3Month bigint,
@Last9Month bigint
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
 
declare @isDelegateRecord int =(SELECT Id FROM     tblBudgetDetailProjectAreaDelegate where CostRecordId=@BudgetDetailProjectAreaId or NiabatiRecordId=@BudgetDetailProjectAreaId)

if(@isDelegateRecord is not null and @isDelegateRecord<>'')
begin
select 'این ردیف نیابتی است  و تنها از طریق تغییر ردیف بودجه نیابت دهنده قابل ویرایش می باشد' as Message_DB
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
        
        
        
        
        
        SET @currentVal=  isnull((select Pishnahadi from tblBudgetDetailProjectArea where id = @BudgetDetailProjectAreaId),0)
        
        declare @currentSum BIGINT = isnull((SELECT  case @budgetProcessId when 3 then sum(tblBudgetDetailProjectArea.PishnahadiCash) else sum(tblBudgetDetailProjectArea.Pishnahadi) end 
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


if(@budgetProcessId=3)
begin
        set @PishnahadiCash=@Pishnahadi;
        set @PishnahadiNonCash=0;
end


update tblBudgetDetailProjectArea
set Pishnahadi = @Pishnahadi,
    PishnahadiCash= @PishnahadiCash,
    PishnahadiNonCash= @PishnahadiNonCash,
    ProctorId= @proctorId,
    executionId=@executionId,
    Last3Month=@Last3Month,
    Last9Month=@Last9Month,
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


----------- Delegate calculations
DECLARE @shouldAdd int=0
DECLARE @delegateAreaId INT, @NiabatiRecordId INT, @CostRecordId INT;
declare @delegateId int = (SELECT id FROM tblBudgetDetailProjectAreaDelegate where BudgetDetailProjectAreaId= @BudgetDetailProjectAreaId)
    
if(isnull(@delegateTo,0)>0)
begin
            declare @SupervisorNiabatAmount bigint = @delegateAmount
            declare @SupervisorCostAmount bigint = @delegateAmount*(100-@delegatePercentage)/100
            
            if(isnull(@delegateId,0)>0)
begin

SELECT @delegateAreaId = AreaId,@NiabatiRecordId = NiabatiRecordId,@CostRecordId = CostRecordId FROM tblBudgetDetailProjectAreaDelegate WHERE BudgetDetailProjectAreaId = @BudgetDetailProjectAreaId;

if(@delegateAreaId=@delegateTo) -- still this area
begin
Update  tblBudgetDetailProjectAreaDelegate set Pishnahadi=@delegateAmount, SupervisorPercent=@delegatePercentage where BudgetDetailProjectAreaId= @BudgetDetailProjectAreaId

Update  tblBudgetDetailProjectArea set Pishnahadi=@SupervisorNiabatAmount where id = @NiabatiRecordId

Update  tblBudgetDetailProjectArea set Pishnahadi=@SupervisorCostAmount ,PishnahadiNonCash=@SupervisorCostAmount where id= @CostRecordId

end
else  -- area changes
begin
Delete from tblBudgetDetailProjectAreaDelegate where id= @delegateId
Delete from tblBudgetDetailProjectArea where id= @NiabatiRecordId
Delete from tblBudgetDetailProjectArea where id= @CostRecordId
    set @shouldAdd=1
end


end
else
begin
                    set @shouldAdd=1
end





            if(@shouldAdd=1)
begin

                    -- add naibati daramad sazman
                    declare @MotherId int=0
                    if(@delegateTo = 11) begin set @MotherId = 12720  end  -- سازمان فناوری اطلاعات و ارتباطات
                    if(@delegateTo = 12) begin set @MotherId = 12721  end  -- سازمان آتش نشانی و خدمات ایمنی
                    if(@delegateTo = 13) begin set @MotherId = 12722  end  -- سازمان اتوبوسرانی
                    if(@delegateTo = 14) begin set @MotherId = 12723  end  -- سازمان بهسازی و نوسازی
                    if(@delegateTo = 15) begin set @MotherId = 12724  end  -- سازمان پارکها و فضای سبز
                    if(@delegateTo = 16) begin set @MotherId = 12725  end  -- سازمان پایانه های مسافربری
                    if(@delegateTo = 17) begin set @MotherId = 12726  end  -- سازمان تاکسیرانی
                    if(@delegateTo = 18) begin set @MotherId = 12727  end  -- سازمان خدمات موتوری
                    if(@delegateTo = 19) begin set @MotherId = 12728  end  -- سازمان آرامستانها
                    if(@delegateTo = 20) begin set @MotherId = 12729  end  -- سازمان حمل و نقل بار
                    if(@delegateTo = 21) begin set @MotherId = 12730  end  -- سازمان زیبا سازی
                    if(@delegateTo = 22) begin set @MotherId = 12731  end  -- سازمان عمران
                    if(@delegateTo = 23) begin set @MotherId = 12732  end  -- سازمان پسماند
                    if(@delegateTo = 24) begin set @MotherId = 12733  end  -- سازمان مشاغل شهری
                    if(@delegateTo = 25) begin set @MotherId = 12734  end  -- سازمان فرهنگی اجتماعی ورزشی
                    if(@delegateTo = 26) begin set @MotherId = 12735  end  -- سازمان حمل و نقل ریلی
                    if(@delegateTo = 29) begin set @MotherId = 12736  end  -- سازمان  مشارکتها



                    declare @MaxCode   nvarchar(20) = (SELECT max(tblCoding.Code)
                                                       FROM            TblBudgets INNER JOIN
                                                                       TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                                       tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                                       tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                       tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                                                       WHERE
                                                           --(TblBudgets.TblYearId in (@yearId , @yearId-1)) AND
                                                           (tblCoding.MotherId = @MotherId) AND
                                                           (tblCoding.TblBudgetProcessId = 9) )

                    if(@MaxCode is null or @MaxCode='')
begin
                            declare @currentCode    nvarchar(20)   =  (select Code from tblCoding where id = @MotherId)

                            SET @MaxCode= @currentCode+'001'
                            --return
end
                    declare @MaxCode2 nvarchar(20)= cast(@MaxCode as bigint)+1

                    declare @BudgetId int = (select id from TblBudgets  where TblYearId = @yearId and TblAreaId = 10)
                    declare @ProgramOperationDetailId int = (SELECT TblProgramOperationDetails.Id
                                                             FROM    TblProgramOperations INNER JOIN
                                                                     TblProgramOperationDetails ON TblProgramOperations.Id = TblProgramOperationDetails.TblProgramOperationId INNER JOIN
                                                                     TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id
                                                             WHERE  (TblProgramOperations.TblAreaId = @areaId) AND
                                                                 (TblProgramOperations.TblProgramId = 10) AND
                                                                 (TblProgramOperationDetails.TblProjectId = 1))

                    declare @Description varchar(1000)= (SELECT Description from tblCoding where id=@CodingId)
                    
                    insert into tblCoding ( MotherId ,   Code    ,  Description ,levelNumber  ,TblBudgetProcessId ,Show,Crud , ExecuteId )
                    values(@MotherId ,@MaxCode2  , CONCAT('نظارت و اجرا پروژه ',@Description) ,6 , 9  ,  1 ,  1  ,@ExecuteId)
                    declare  @NiabatCodingId int = SCOPE_IDENTITY()

                    insert into TblBudgetDetails ( BudgetId , tblCodingId ,MosavabPublic)
                    values(@BudgetId ,   @NiabatCodingId ,      0   )
                    declare @BudgetDetailId1 int = SCOPE_IDENTITY()

                    insert into tblBudgetDetailProject ( BudgetDetailId ,  ProgramOperationDetailsId ,Mosavab)
                    values(@BudgetDetailId1 , @ProgramOperationDetailId  ,  0 )
                    declare @BudgetDetailProjectId1 int = SCOPE_IDENTITY()

                    insert into tblBudgetDetailProjectArea( BudgetDetailProjectId ,  AreaId  ,Pishnahadi )
                    values(@BudgetDetailProjectId1 , @delegateTo  ,  @SupervisorNiabatAmount  )

                    set @NiabatiRecordId = SCOPE_IDENTITY()




                    -- add cost sazman


                    declare @BudgetDetailProjectId2    int = (SELECT TOP(1)    tblBudgetDetailProject.Id
                                                              FROM            TblBudgets INNER JOIN
                                                                              TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                                              tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                                              tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                              tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                                                              WHERE
                                                                      TblBudgets.TblYearId=@yearId AND
                                                                  (TblBudgetDetails.tblCodingId = @codingId) AND
                                                                      tblCoding.TblBudgetProcessId=@BudgetProcessId)

                    if(isnull(@BudgetDetailProjectId2,0)=0)
begin
insert into TblBudgetDetails ( BudgetId , tblCodingId ,MosavabPublic)
values(@BudgetId ,   @CodingId ,      0   )
declare @BudgetDetailId2 int = SCOPE_IDENTITY()

                            declare @ProgramOperationDetailsId int = (select ProgramOperationDetailsId from  tblBudgetDetailProject where  id = @BudgetDetailProjectId)
                            insert into tblBudgetDetailProject ( BudgetDetailId ,  ProgramOperationDetailsId ,Mosavab)
                            values(@BudgetDetailId2 , @ProgramOperationDetailsId  ,  0 )
                            set @BudgetDetailProjectId2  = SCOPE_IDENTITY()

end


insert into tblBudgetDetailProjectArea( BudgetDetailProjectId ,  AreaId  ,Pishnahadi,PishnahadiNonCash)
values(@BudgetDetailProjectId2 , @delegateTo  ,  @SupervisorCostAmount,@SupervisorCostAmount )

    set @CostRecordId  = SCOPE_IDENTITY()


-- add delegate for main row
INSERT INTO tblBudgetDetailProjectAreaDelegate (BudgetDetailProjectAreaId,AreaId,Pishnahadi,Mosavab,Edit,SupervisorPercent,NiabatiRecordId,CostRecordId)
VALUES (@BudgetDetailProjectAreaId,@delegateTo,@delegateAmount,0,0,@delegatePercentage,@NiabatiRecordId,@CostRecordId)
end
end
else
begin
            if(isnull(@delegateId,0)>0)
begin
SELECT @NiabatiRecordId = NiabatiRecordId, @CostRecordId = CostRecordId FROM tblBudgetDetailProjectAreaDelegate WHERE BudgetDetailProjectAreaId = @BudgetDetailProjectAreaId;

Delete from tblBudgetDetailProjectAreaDelegate where id= @delegateId
Delete from tblBudgetDetailProjectArea where id IN(@CostRecordId,@NiabatiRecordId)
end
end


END
go























USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP004_BudgetProposal_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP004_BudgetProposal_Read]
@yearId int, 
@areaId int,
@budgetProcessId int
AS
BEGIN

    if(@areaId  in (10,37,39,40,41 ,
                    30,31,32,33,34,35,36,42,43,44,53,
                    1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29,
                    45,46,47,48,49,50,51,52)) --گزارشات اداره کل منابع انسانی-- اداره کل پشتیبانی
begin

            declare @ExecuteId int
            if(@areaId=30) begin set @ExecuteId = 4  end
            if(@areaId=31) begin set @ExecuteId = 10 end
            if(@areaId=32) begin set @ExecuteId = 2  end
            if(@areaId=33) begin set @ExecuteId = 1  end
            if(@areaId=34) begin set @ExecuteId = 3  end
            if(@areaId=35) begin set @ExecuteId = 7  end
            if(@areaId=36) begin set @ExecuteId = 6  end
            if(@areaId=42) begin set @ExecuteId = 12 end
            if(@areaId=43) begin set @ExecuteId = 11 end
            if(@areaId=44) begin set @ExecuteId = 13 end
            if(@areaId=53) begin set @ExecuteId = 14 end

            declare @OnlyReport int
            if(@areaId = 45) begin set @OnlyReport = 1   end -- منابع انسانی
            if(@areaId = 46) begin set @OnlyReport = 2   end --اداره پشتیبانی
            if(@areaId = 47) begin set @OnlyReport = 3   end -- فرهنگی
            if(@areaId = 48) begin set @OnlyReport = 4   end -- خدمات شهری
            if(@areaId = 49) begin set @OnlyReport = 5   end --  روابط عمومی
            if(@areaId = 52) begin set @OnlyReport = 6   end -- سایر
            if(@areaId = 50) begin set @OnlyReport = 7   end -- بسیج
            if(@areaId = 51) begin set @OnlyReport = 8   end -- حقوقی


SELECT        tbl2.CodingId, tblCoding_4.Code , tblCoding_4.Description,tbl2.Mosavab,tbl2.Edit,tbl2.Supply as  CreditAmount,tbl2.Expense ,PishnahadiCash,PishnahadiNonCash,
              tbl2.Pishnahadi, tblCoding_4.levelNumber ,tblCoding_4.Crud,ConfirmStatus AS ConfirmStatus,isNewYear AS isNewYear,delegateTo,delegateAmount,delegatePercentage,DelegateArea.AreaName as DelegateToName,tbl2.ProctorId,tbl2.ExecutionId,tbl2.Last3Month,tbl2.Last9Month
FROM            (SELECT CodingId, isnull(SUM(Mosavab),0) AS Mosavab, isnull(SUM(EditArea),0) AS Edit , SUM(Supply) as Supply,isnull(SUM(Expense),0) AS Expense ,isnull(sum(PishnahadiCash),0) as PishnahadiCash,isnull(sum(PishnahadiNonCash),0) as PishnahadiNonCash,isnull(sum(Pishnahadi),0) as Pishnahadi,isnull(min(ConfirmStatus),0) AS ConfirmStatus ,
                        max(isNewYear) AS isNewYear ,isnull(max(delegateTo),0) AS delegateTo ,isnull(max(delegateAmount),0) AS delegateAmount ,isnull(max(delegatePercentage),0) AS delegatePercentage,isnull(sum(Last3Month),0) AS Last3Month,isnull(sum(Last9Month),0) AS Last9Month
                         ,CASE WHEN COUNT(DISTINCT ProctorId) = 0 THEN 0  WHEN COUNT(DISTINCT ProctorId) <=2 THEN MAX(ProctorId) ELSE -1 END AS ProctorId ,CASE WHEN COUNT(DISTINCT ExecutionId) = 0 THEN 0 WHEN COUNT(DISTINCT ExecutionId) <=2 THEN MAX(ExecutionId) ELSE -1 END AS ExecutionId
                 FROM            (

--سطح اول
                                     SELECT        tblCoding_5.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, 0 AS PishnahadiCash, 0 AS PishnahadiNonCash, 0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                     tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                                                     tblCoding AS tblCoding_5 ON tblCoding_4.MotherId = tblCoding_5.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                     WHERE        (TblBudgets.TblYearId = @YearId - 1) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)  AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29)) OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )
                                     UNION ALL
                                     SELECT        tblCoding_5.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage ,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,tblBudgetDetailProjectArea.Last3Month AS Last3Month,tblBudgetDetailProjectArea.Last9Month AS Last9Month
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                     tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                                                     tblCoding AS tblCoding_5 ON tblCoding_4.MotherId = tblCoding_5.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                     tblBudgetDetailProjectAreaDelegate ON tblBudgetDetailProjectAreaDelegate.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea.id
                                     WHERE  (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)  AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                     union all
----------سطح 2	

                                     SELECT        tblCoding_4.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear  , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                     tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                     WHERE        (TblBudgets.TblYearId = @YearId - 1) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)  AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                     UNION ALL

                                     SELECT        tblCoding_4.MotherId AS CodingId, 0 as Mosavab, 0 as EditArea,0 as supply, 0 as Expense , tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear ,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,tblBudgetDetailProjectArea.Last3Month AS Last3Month,tblBudgetDetailProjectArea.Last9Month AS Last9Month
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                     tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                     tblBudgetDetailProjectAreaDelegate ON tblBudgetDetailProjectAreaDelegate.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea.id
                                     WHERE  (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                     union all

----سطح 3
                                     SELECT        tblCoding_1.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear  , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                     WHERE        (TblBudgets.TblYearId = @YearId - 1) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                     UNION ALL

                                     SELECT tblCoding_1.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear ,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,tblBudgetDetailProjectArea.Last3Month AS Last3Month,tblBudgetDetailProjectArea.Last9Month AS Last9Month
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                     tblBudgetDetailProjectAreaDelegate ON tblBudgetDetailProjectAreaDelegate.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea.id
                                     WHERE  (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )


--سطح 4
                                     union all
                                     SELECT        tblCoding_3.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear  , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                     WHERE        (TblBudgets.TblYearId = @YearId - 1) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                     union all
                                     SELECT        tblCoding_3.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,tblBudgetDetailProjectArea.Last3Month AS Last3Month,tblBudgetDetailProjectArea.Last9Month AS Last9Month
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                     tblBudgetDetailProjectAreaDelegate ON tblBudgetDetailProjectAreaDelegate.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea.id
                                     WHERE  (TblBudgets.TblYearId = @YearId) AND(tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                     UNION ALL
--سطح 5
                                     SELECT        tblCoding_2.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea,tblBudgetDetailProjectArea.Supply,tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear  , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                                     FROM            TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                     tblCoding AS tblCoding_2 ON tblCoding.MotherId = tblCoding_2.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                     WHERE        (TblBudgets.TblYearId = @YearId - 1) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )
                                     UNION ALL
                                     SELECT        tblCoding_2.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,tblBudgetDetailProjectArea.Last3Month AS Last3Month,tblBudgetDetailProjectArea.Last9Month AS Last9Month
                                     FROM            TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                     tblCoding AS tblCoding_2 ON tblCoding.MotherId = tblCoding_2.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                     tblBudgetDetailProjectAreaDelegate ON tblBudgetDetailProjectAreaDelegate.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea.id
                                     WHERE  (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )
                                     union all
--سطح 6
                                     SELECT        tblCoding_3.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                                     FROM            TblBudgets AS TblBudgets_2 INNER JOIN
                                                     TblBudgetDetails AS TblBudgetDetails_2 ON TblBudgets_2.Id = TblBudgetDetails_2.BudgetId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON TblBudgetDetails_2.tblCodingId = tblCoding_3.Id INNER JOIN
                                                     tblBudgetDetailProject AS tblBudgetDetailProject_2 ON TblBudgetDetails_2.Id = tblBudgetDetailProject_2.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                     WHERE        (TblBudgets_2.TblYearId = @YearId - 1) AND (tblCoding_3.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding_3.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding_3.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                     union all
                                     SELECT  tblCoding_3.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea, 0 as supply,0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,tblBudgetDetailProjectArea.Last3Month AS Last3Month,tblBudgetDetailProjectArea.Last9Month AS Last9Month
                                     FROM            TblBudgets AS TblBudgets_2 INNER JOIN
                                                     TblBudgetDetails AS TblBudgetDetails_2 ON TblBudgets_2.Id = TblBudgetDetails_2.BudgetId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON TblBudgetDetails_2.tblCodingId = tblCoding_3.Id INNER JOIN
                                                     tblBudgetDetailProject AS tblBudgetDetailProject_2 ON TblBudgetDetails_2.Id = tblBudgetDetailProject_2.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                     tblBudgetDetailProjectAreaDelegate ON tblBudgetDetailProjectAreaDelegate.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea.id
                                     WHERE  (TblBudgets_2.TblYearId = @YearId) AND (tblCoding_3.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding_3.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding_3.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                     UNION ALL
--سطح 7
                                     SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea,tblBudgetDetailProjectArea.Supply,tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear  , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                                     FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                     TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                     tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                     tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId  INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                     WHERE        (TblBudgets_1.TblYearId = @YearId - 1) AND (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding_1.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding_1.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                     union all

                                     SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,tblBudgetDetailProjectArea.Last3Month AS Last3Month,tblBudgetDetailProjectArea.Last9Month AS Last9Month
                                     FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                     TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                     tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                     tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                     tblBudgetDetailProjectAreaDelegate ON tblBudgetDetailProjectAreaDelegate.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea.id
                                     WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding_1.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding_1.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                 ) AS tbl1
                 GROUP BY CodingId) AS tbl2 INNER JOIN
                tblCoding AS tblCoding_4 ON tbl2.CodingId = tblCoding_4.Id LEFT JOIN
                TblAreas AS DelegateArea ON tbl2.delegateTo = DelegateArea.Id

ORDER BY  tblCoding_4.Code,tblCoding_4.levelNumber
    return
end

END
go






CREATE PROCEDURE SP500_BudgetBook_Codings
    @YearId INT,
    @AreaId INT,
    @BudgetProcessId INT,
    @Codings NVARCHAR(MAX)
AS
BEGIN
    -- Temporary table to store the results
CREATE TABLE #Results (
                          Code NVARCHAR(50),
                          Pishnahadi BIGINT,
                          Mosavab BIGINT
);

-- Split the @Codings string into individual codes
DECLARE @Code NVARCHAR(50);
    DECLARE @Pos INT;
    SET @Codings = LTRIM(RTRIM(@Codings)) + ','; -- Ensure trailing comma for processing
    SET @Pos = CHARINDEX(',', @Codings);

    WHILE @Pos > 0
BEGIN
            SET @Code = LTRIM(RTRIM(LEFT(@Codings, @Pos - 1)));
            SET @Codings = SUBSTRING(@Codings, @Pos + 1, LEN(@Codings));
            SET @Pos = CHARINDEX(',', @Codings);

            -- Perform the calculation for the current code
INSERT INTO #Results (Code, Pishnahadi, Mosavab)
SELECT
    @Code AS Code,
    SUM(isnull(tblBudgetDetailProjectArea.Pishnahadi,0)) AS Pishnahadi,
    SUM(isnull(tblBudgetDetailProjectArea.Mosavab,0)) AS Mosavab
FROM
    TblBudgets
        INNER JOIN TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId
        INNER JOIN tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId
        INNER JOIN tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
        INNER JOIN TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
        INNER JOIN tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
        LEFT JOIN tblCoding AS tblCoding_2 ON tblCoding.MotherId = tblCoding_2.Id
        LEFT JOIN tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id
        LEFT JOIN tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id
        LEFT JOIN tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id
        LEFT JOIN tblCoding AS tblCoding_5 ON tblCoding_4.MotherId = tblCoding_5.Id
WHERE
        TblBudgets.TblYearId = @YearId
  AND tblCoding.TblBudgetProcessId = @BudgetProcessId
  AND (@Code IN (tblCoding.Code, tblCoding_2.Code, tblCoding_3.Code, tblCoding_1.Code, tblCoding_4.Code, tblCoding_5.Code));
END;

    -- Return the results
SELECT * FROM #Results;

-- Clean up
DROP TABLE #Results;
END;
go
