add IsActive int to tblAmlakAdmin




UPDATE tblBudgetDetailProjectArea
SET tblBudgetDetailProjectArea.PishnahadiCash = tblBudgetDetailProjectArea.Pishnahadi
    FROM tblBudgetDetailProjectArea
INNER JOIN tblBudgetDetailProject ON tblBudgetDetailProjectArea.BudgetDetailProjectId = tblBudgetDetailProject.Id
    INNER JOIN TblBudgetDetails ON tblBudgetDetailProject.BudgetDetailId = TblBudgetDetails.Id
    INNER JOIN TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id
    INNER JOIN tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
WHERE tblCoding.TblBudgetProcessId = 3;









USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_Budget_Inline_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_Budget_Inline_Insert]
@Code nvarchar(50),
@Description nvarchar(2000),
@CodingId int,
@YearId int,
@AreaId int,
@Mosavab bigint,
@ProgramOperationDetailsId int,
@Pishnahadi bigint
 
AS
BEGIN
--if(@yearId<>34) begin  select 'برای سال 1403 مجاز هستید' as Message_DB  return end
declare @areaIdMain int=@areaId

declare @ExecuteId int
if(@areaId not in (30,31,32,33,34,35,36,42,43,44,53)) begin  set @ExecuteId = 8  end
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




    declare @budgetId        int      = (select Id from TblBudgets where TblYearId = @yearId and TblAreaId = @areaId)
    declare @LevelNumber   tinyint    = (select levelNumber from tblCoding where id = @CodingId) +1
	declare @MotherId        int      = @CodingId -- (select MotherId from tblCoding where id = @CodingId)
	declare @budgetProcessId int      = (select TblBudgetProcessId from tblCoding where id = @CodingId)

	declare @MaxCode   nvarchar(20) = (SELECT max(tblCoding.Code)
												FROM            TblBudgets INNER JOIN
																		 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
																		 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
																		 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
																		 tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
																WHERE   (TblBudgets.TblYearId in (@yearId , @yearId-1)) AND
																	    (tblCoding.MotherId = @MotherId) AND
																	    (tblCoding.TblBudgetProcessId = @budgetProcessId) )
	if(@MaxCode is null or @MaxCode='')
begin
	    --select CONCAT('خطا:',@MaxCode) as Message_DB
        declare @currentCode    nvarchar(20)   =  (select Code from tblCoding where id = @CodingId)

            SET @MaxCode= @currentCode+'00'
	 --return
end
	declare @MaxCode2 nvarchar(20)= cast(@MaxCode as bigint)+1 

	
	declare @ProjectId int 
	if(@BudgetProcessId in (1,9,10,11))   begin set @ProjectId = 1 end
	if(@BudgetProcessId = 2)              begin set @ProjectId = 2 end
	if(@BudgetProcessId in (3,4,5))       begin set @ProjectId = 3 end
	
	
	declare  @ProgramOperationDetailId int = (SELECT TblProgramOperationDetails.Id
													FROM    TblProgramOperations INNER JOIN
															TblProgramOperationDetails ON TblProgramOperations.Id = TblProgramOperationDetails.TblProgramOperationId INNER JOIN
															TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id
													WHERE  (TblProgramOperations.TblAreaId = @areaId) AND
													       (TblProgramOperations.TblProgramId = 10) AND
													       (TblProgramOperationDetails.TblProjectId = @ProjectId))

	         
declare @parentCount int = (SELECT      COUNT(*) AS Expr1
                            FROM TblBudgetDetails
                                     INNER JOIN TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id
                                     INNER JOIN tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId
                                     INNER JOIN tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
                                     INNER JOIN tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                            WHERE
                                    TblBudgets.TblYearId = @yearId and
                                    tblBudgetDetailProjectArea.AreaId=@areaId and
                                    tblCoding.TblBudgetProcessId=@budgetProcessId and
                                    tblCoding.Id= (select MotherId from tblCoding where id=@codingId)
);

if(@parentCount>0)
begin
select 'شما قبلا سرجمع این کدینگ را افزوده اید. ابتدا سرجمع را حذف نموده سپس این کدینگ را اضافه نمایید' as Message_DB
    return
end
    


-- if(@LevelNumber<>5 or @budgetProcessId<>3)
-- begin
--    select 'فعلا فقط برای سطح 5 و تملک سرمایه ای وارد شود' as Message_DB
-- return
-- end

--=========تست مانده


declare @Revenue bigint = (SELECT    sum(tblBudgetDetailProjectArea.Mosavab)
								FROM  TblBudgets INNER JOIN
									  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
								WHERE  (TblBudgets.TblYearId = @yearId) AND
								       (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
									   (tblCoding.TblBudgetProcessId = 1))
   
 --  declare @Revenue bigint 
 --if(@AreaId = 1) begin set @Revenue =  4600000000000  end
 --if(@AreaId = 2) begin set @Revenue =  12000000000000 end
 --if(@AreaId = 3) begin set @Revenue =  7300000000000  end
 --if(@AreaId = 4) begin set @Revenue =  5750000000000  end
 --if(@AreaId = 5) begin set @Revenue =  3000000000000  end
 --if(@AreaId = 6) begin set @Revenue =  1842000000000  end
 --if(@AreaId = 7) begin set @Revenue =  3900000000000  end
 --if(@AreaId = 8) begin set @Revenue =  5200000000000  end
 
declare @Current bigint = (SELECT   sum(tblBudgetDetailProjectArea.Mosavab)
								FROM  TblBudgets INNER JOIN
									  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
							   WHERE (TblBudgets.TblYearId = @yearId) AND
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
   
   


declare @Balance bigint = isnull(@Revenue,0) - isnull(@Current,0) - isnull(@Civil,0) - isnull(@Motomarkez,0) + isnull(@Komak,0) - isnull(@Mosavab,0)
--select dbo.seprator(cast(@Balance as nvarchar(100))) as Message_DB
--return

--if(@AreaId <=8 and @Balance<0)
--begin
--    select 'مانده منفی می شود' as Message_DB
--	return
--end
--============================================
--===============کنترل بودجه معاونت ها

if(@areaId not in (30,31,32,33,34,35,36))
begin  
	declare @CivilExecute bigint
	if(@ExecuteId = 4 ) begin set @CivilExecute = 6500000000000  end-- شهر سازی
	if(@ExecuteId = 10) begin set @CivilExecute = 15000000000000 end-- معاونت فنی عمرانی
	if(@ExecuteId = 2)  begin set @CivilExecute = 6800000000000  end -- حمل و نقل و ترافیک
	if(@ExecuteId = 1)  begin set @CivilExecute = 3200000000000  end--خدمات شهری
	if(@ExecuteId = 3)  begin set @CivilExecute = 1190000000000  end -- فرهنگی
	if(@ExecuteId = 7)  begin set @CivilExecute =       0        end -- مالی اقتصادی
	if(@ExecuteId = 6)  begin set @CivilExecute =       0        end--برنامه ریزی


select @Civil = (SELECT  SUM(tblBudgetDetailProjectArea.Mosavab) AS Expr1
                 FROM TblBudgets INNER JOIN
                      TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                      tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                      tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                      tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                 WHERE (TblBudgets.TblYearId = @yearId) AND
                     (tblBudgetDetailProjectArea.AreaId = 9) AND
                     (tblCoding.TblBudgetProcessId = 3) AND
                     (tblCoding.ExecuteId = @ExecuteId))

declare  @Balance2 bigint  = @CivilExecute - isnull(@Civil,0) + isnull(@Mosavab,0)
--if(@Balance2<0 and @ExecuteId<>10)
--begin
-- select ' به مبلغ '+dbo.seprator(cast(@Balance2 as nvarchar(100)))+' منفی می شود ' as Message_DB
--return
--end
end



if(@budgetProcessId<=4)
begin
        DECLARE @areaShare BIGINT;
        DECLARE @currentVal BIGINT;
        DECLARE @sql NVARCHAR(MAX);
        
        SET @sql = N'SELECT TOP(1) @areaShare = ShareProcessId' + CAST(@budgetProcessId AS NVARCHAR(10)) + ' FROM tblBudgetAreaShare WHERE AreaId = '+CAST(@areaIdMain AS NVARCHAR(10))+' AND YearId = '+CAST(@yearId AS NVARCHAR(10))+ ' AND Type = ''pishnahadi'';';
        
        -- Execute dynamic SQL and retrieve the value into @areaShare
EXEC sp_executesql @sql, N'@areaShare BIGINT OUTPUT', @areaShare OUTPUT;
        
        
        
        
        
        SET @currentVal= 0
        -- SET @currentVal= (select Pishnahadi from tblBudgetDetailProjectArea where id = @BudgetDetailProjectAreaId)
        
        declare @currentSum BIGINT =(SELECT  case @budgetProcessId when 3 then sum(tblBudgetDetailProjectArea.PishnahadiCash) else sum(tblBudgetDetailProjectArea.Pishnahadi) end
                                     FROM     TblBudgets INNER JOIN
                                              TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                              tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                              tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                              tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                                     WHERE   (tblCoding.TblBudgetProcessId = @budgetProcessId) AND
                                         (TblBudgets.TblYearId =@yearId) AND
                                         ((tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaIdMain in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                          (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaIdMain in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                             ))
        if(@areaShare is not null and @areaShare<@currentSum-@currentVal+@Pishnahadi)
begin
select CONCAT('خطا - سهم منطقه پیشنهادی ',@areaShare,' ریال می باشد و تنها',(@areaShare-@currentSum),'ریال آزاد می باشد') as Message_DB
    return
end
end


--==============================================================================================================================

insert into tblCoding ( MotherId ,   Code    ,  Description ,levelNumber  ,TblBudgetProcessId ,Show,Crud , ExecuteId )
values(@MotherId ,@MaxCode2  , @Description ,@LevelNumber , @budgetProcessId  ,  1 ,  1  ,@ExecuteId)
declare @Codeing_NewId int = SCOPE_IDENTITY()


insert into TblBudgetDetails ( BudgetId ,  tblCodingId   ,MosavabPublic)
                       values(@BudgetId , @Codeing_NewId ,   @Mosavab  )
declare @BudgetDetailId int = SCOPE_IDENTITY()

insert into tblBudgetDetailProject ( BudgetDetailId ,  ProgramOperationDetailsId , Mosavab )
						     values(@BudgetDetailId , @ProgramOperationDetailId  ,@Mosavab )
declare @BudgetDetailProjectId int = SCOPE_IDENTITY()

insert into tblBudgetDetailProjectArea( BudgetDetailProjectId ,  AreaId ,  Mosavab ,Pishnahadi)
							    values(@BudgetDetailProjectId , @areaId , @Mosavab ,@Pishnahadi)

return






END
GO













USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal3Area_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetModal3Area_Update]
@Id int,
@Pishnahadi bigint,
@Mosavab bigint,
@EditArea bigint
AS
BEGIN
 declare @BudgetNext bigint = @Mosavab
 declare @YearId int =(SELECT   top(1)     TblBudgets.TblYearId
								FROM            TblBudgets INNER JOIN
														 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
														 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
														 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
								WHERE        (tblBudgetDetailProjectArea.id = @Id))



declare @AreaId int =(SELECT   top(1)   tblBudgetDetailProjectArea.AreaId
								FROM    TblBudgets INNER JOIN
									   	TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
										tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
										tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
								WHERE  (tblBudgetDetailProjectArea.id = @Id))

declare @CodingId int =(SELECT   top(1)   TblBudgetDetails.tblCodingId
								FROM    TblBudgets INNER JOIN
									   	TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
										tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
										tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
								WHERE  (tblBudgetDetailProjectArea.id = @Id))


declare @BudgetProcessId int = (select TblBudgetProcessId from tblCoding where id = @CodingId)



 declare @isDelegateRecord int =(SELECT Id FROM     tblBudgetDetailProjectAreaDelegate where CostRecordId=@Id or NiabatiRecordId=@Id)

 if(@isDelegateRecord is not null and @isDelegateRecord<>'')
begin
select 'این ردیف نیابتی است  و تنها از طریق تغییر ردیف بودجه نیابت دهنده قابل ویرایش می باشد' as Message_DB
    return
end

 declare @hasDelegateRecord int =(SELECT Id FROM     tblBudgetDetailProjectAreaDelegate where BudgetDetailProjectAreaId=@Id )
 declare @currentPishnahadi1 bigint= isnull((select Pishnahadi from tblBudgetDetailProjectArea where id = @Id),0)
 if(@hasDelegateRecord>0 And @currentPishnahadi1<>@Pishnahadi)
begin
select 'این ردیف نیابت داده شده است. جهت ویرایش مبلغ پیشنهادی آن باید از بخش بودجه پیشنهادی اقدام نمایید.' as Message_DB
    return

end


 -- 
--  declare @MosavabAgo bigint =(SELECT   Mosavab
-- 								FROM      tblBudgetDetailProjectArea
-- 								WHERE     (id = @Id))
-- 
-- declare @Revenue bigint = (SELECT    sum(tblBudgetDetailProjectArea.Mosavab)
-- 								FROM  TblBudgets INNER JOIN
-- 									  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
-- 									  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
-- 									  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
-- 									  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
-- 								WHERE  (TblBudgets.TblYearId = @yearId) AND
-- 								       (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
-- 									   (tblCoding.TblBudgetProcessId = 1))
--  --declare @Revenue bigint 
--  --if(@AreaId = 1) begin set @Revenue =  4600000000000  end
--  --if(@AreaId = 2) begin set @Revenue =  12000000000000 end
--  --if(@AreaId = 3) begin set @Revenue =  7300000000000  end
--  --if(@AreaId = 4) begin set @Revenue =  6000000000000  end
--  --if(@AreaId = 5) begin set @Revenue =  3000000000000  end
--  --if(@AreaId = 6) begin set @Revenue =  1842000000000  end
--  --if(@AreaId = 7) begin set @Revenue =  4000000000000  end
--  --if(@AreaId = 8) begin set @Revenue =  5200000000000  end
--    
-- 
-- declare @Current bigint = (SELECT   sum(tblBudgetDetailProjectArea.Mosavab)
-- 								FROM  TblBudgets INNER JOIN
-- 									  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
-- 									  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
-- 									  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
-- 									  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
-- 							   WHERE (TblBudgets.TblYearId = @yearId) AND
-- 							         (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
-- 									 (tblCoding.TblBudgetProcessId = 2))  
--    
--  
-- 
--  --if(@AreaId = 1) begin set @Current =  4600000000000  end
--  --if(@AreaId = 2) begin set @Current =  4250000000000  end
--  --if(@AreaId = 3) begin set @Current =  3740000000000  end
--  --if(@AreaId = 4) begin set @Current =  3015000000000  end
--  --if(@AreaId = 5) begin set @Current =  2420000000000  end
--  --if(@AreaId = 6) begin set @Current =  2680000000000  end
--  --if(@AreaId = 7) begin set @Current =  2750000000000  end
--  --if(@AreaId = 8) begin set @Current =  2750000000000  end 
--   
-- 
--  
-- 
-- declare @Civil bigint = (SELECT    sum(tblBudgetDetailProjectArea.Mosavab)
-- 							FROM   TblBudgets INNER JOIN
-- 								   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
-- 								   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
-- 								   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
-- 								   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
-- 					       WHERE  (TblBudgets.TblYearId = @yearId) AND
-- 						          (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
-- 								  (tblCoding.TblBudgetProcessId = 3))   
--    
-- declare @Motomarkez bigint = (SELECT   sum(tblBudgetDetailProjectArea.Mosavab)
-- 								FROM   TblBudgets INNER JOIN
-- 									   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
-- 									   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
-- 									   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
-- 									   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
-- 								WHERE (TblBudgets.TblYearId = @yearId) AND
-- 									  (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
-- 									  (tblCoding.TblBudgetProcessId = 8))     
--    
--    
-- declare @Komak bigint = (SELECT  sum(tblBudgetDetailProjectArea.Mosavab)
-- 								FROM   TblBudgets INNER JOIN
-- 									   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
-- 									   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
-- 									   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
-- 									   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
-- 								WHERE (TblBudgets.TblYearId = @yearId) AND
-- 									  (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
-- 									  (tblCoding.TblBudgetProcessId = 10))     
--    
--    
-- 
-- 
-- declare @Balance bigint = isnull(@Revenue,0) - isnull(@Current,0) - isnull(@Civil,0) - isnull(@Motomarkez,0) + isnull(@Komak,0) + isnull(@MosavabAgo,0)-isnull(@BudgetNext,0)
-- 
-- --if(@AreaId <=8 AND @Balance<0 AND @BudgetProcessId=3 and @Mosavab>@MosavabAgo and @YearId=34)
-- --begin
-- --   select ' به مبلغ '+dbo.seprator(cast(@Balance as nvarchar(100)))+' منفی می شود ' as Message_DB
-- --	return
-- --end
-- 
-- --===============کنترل بودجه معاونت ها
--  	declare @ExecuteId int =(SELECT     tblCoding.ExecuteId
-- 									FROM   TblBudgets INNER JOIN
-- 										   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
-- 										   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
-- 										   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
-- 										   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
-- 									WHERE (tblBudgetDetailProjectArea.id = @Id))
-- if(@AreaId = 9) 
-- begin  
-- 	declare @CivilExecute bigint
-- 	if(@ExecuteId = 4 ) begin set @CivilExecute = 650000000000   end-- شهر سازی
-- 	if(@ExecuteId = 10) begin set @CivilExecute = 15000000000000 end-- معاونت فنی عمرانی
-- 	if(@ExecuteId = 2)  begin set @CivilExecute = 6800000000000  end -- حمل و نقل و ترافیک
-- 	if(@ExecuteId = 1)  begin set @CivilExecute = 3200000000000  end--خدمات شهری
-- 	if(@ExecuteId = 3)  begin set @CivilExecute = 1190000000000  end -- فرهنگی
-- 	if(@ExecuteId = 7)  begin set @CivilExecute =       0        end -- مالی اقتصادی
-- 	if(@ExecuteId = 6)  begin set @CivilExecute =       0        end--برنامه ریزی
-- 
-- 
-- select @Civil = (SELECT  SUM(tblBudgetDetailProjectArea.Mosavab) AS Expr1
-- 						FROM TblBudgets INNER JOIN
-- 						     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
-- 							 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
-- 							 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
-- 							 tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
-- 						WHERE (TblBudgets.TblYearId = @yearId) AND
-- 							  (tblBudgetDetailProjectArea.AreaId = 9) AND
-- 							  (tblCoding.TblBudgetProcessId = 3) AND
-- 							  (tblCoding.ExecuteId = @ExecuteId))  
-- 
-- declare  @Balance2 bigint  = @CivilExecute - isnull(@Civil,0) + isnull(@MosavabAgo,0)-isnull(@BudgetNext,0)
-- --if(@Balance2<0 AND @Mosavab>@MosavabAgo and @YearId = 34)
-- --begin
-- -- select ' به مبلغ '+dbo.seprator(cast(@Balance2 as nvarchar(100)))+' منفی می شود ' as Message_DB
-- --return
-- --end
-- 
-- end



if(@budgetProcessId<=4)
begin 
         DECLARE @areaSharePishnahadi Bigint;
         DECLARE @areaShareEdit Bigint;
         DECLARE @currentPishnahadi Bigint;
         DECLARE @currentMosavab Bigint;
         DECLARE @currentEdit Bigint;
         DECLARE @sqlPishnahadi NVARCHAR(MAX);
         DECLARE @sqlEdit NVARCHAR(MAX);
        
         SET @sqlPishnahadi = N'SELECT TOP(1) @areaShare = ShareProcessId' + CAST(@budgetProcessId AS NVARCHAR(10)) + ' FROM tblBudgetAreaShare WHERE AreaId = '+CAST(@areaId AS NVARCHAR(10))+' AND YearId = '+CAST(@yearId AS NVARCHAR(10))+' AND Type = ''pishnahadi'';';
EXEC sp_executesql @sqlPishnahadi, N'@areaShare BIGINT OUTPUT', @areaSharePishnahadi OUTPUT;
        
         SET @sqlEdit = N'SELECT TOP(1) @areaShare = ShareProcessId' + CAST(@budgetProcessId AS NVARCHAR(10)) + ' FROM tblBudgetAreaShare WHERE AreaId = '+CAST(@areaId AS NVARCHAR(10))+' AND YearId = '+CAST(@yearId AS NVARCHAR(10))+' AND Type = ''edit'';';
EXEC sp_executesql @sqlEdit, N'@areaShare BIGINT OUTPUT', @areaShareEdit OUTPUT;
        
        
        
         SET @currentPishnahadi= isnull((select Pishnahadi from tblBudgetDetailProjectArea where id = @Id),0)
         SET @currentEdit= isnull((select EditArea from tblBudgetDetailProjectArea where id = @Id),0)
        
         declare @currentSumPishnahadi Bigint =(SELECT   case @budgetProcessId when 3 then sum(tblBudgetDetailProjectArea.PishnahadiCash) else sum(tblBudgetDetailProjectArea.Pishnahadi) end
                                   FROM     TblBudgets INNER JOIN
                                            TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                            tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                            tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                            tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                                   WHERE   (tblCoding.TblBudgetProcessId = @budgetProcessId) AND
                                       (TblBudgets.TblYearId =@yearId) AND
                                       (tblBudgetDetailProjectArea.AreaId =@AreaId))
        
        -- 
--          declare @currentSumEdit Bigint =(SELECT  sum(tblBudgetDetailProjectArea.EditArea)
--                                    FROM     TblBudgets INNER JOIN
--                                             TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--                                             tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--                                             tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
--                                             tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
--                                    WHERE   (tblCoding.TblBudgetProcessId = @budgetProcessId) AND
--                                        (TblBudgets.TblYearId =@yearId) AND
--                                        (tblBudgetDetailProjectArea.AreaId =@AreaId))
        
         if(@areaSharePishnahadi is not null and @areaSharePishnahadi<@currentSumPishnahadi-@currentPishnahadi+@Pishnahadi)
begin
select CONCAT('خطا بودجه پیشنهادی - سهم منطقه ',@areaSharePishnahadi,' ریال می باشد و تنها',(@areaSharePishnahadi-@currentSumPishnahadi),'ریال آزاد می باشد') as Message_DB
    return
end
             
        
--          if(@areaShareEdit is not null and @areaShareEdit<@currentSumEdit-@currentEdit+@EditArea)
--              begin
--                  select CONCAT('خطا بودجه اصلاحی - سهم منطقه ',@areaShareEdit,' ریال می باشد و تنها',(@areaShareEdit-@currentSumEdit),'ریال آزاد می باشد') as Message_DB
--                  return
--              end

end
             
if(@budgetProcessId=3)
begin
update tblBudgetDetailProjectArea
set Pishnahadi = @Pishnahadi,
    PishnahadiCash = @Pishnahadi,
    Mosavab = @Mosavab,
    EditArea = @EditArea,
    ConfirmStatus=0
where id = @Id

end
else
begin
update tblBudgetDetailProjectArea
set Pishnahadi = @Pishnahadi,
    Mosavab = @Mosavab,
    EditArea = @EditArea,
    ConfirmStatus=0
where id = @Id
end







END
go

















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
@delegateTo int,
@delegateAmount bigint,
@delegatePercentage int
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

                    insert into tblBudgetDetailProjectArea( BudgetDetailProjectId ,  AreaId  ,Pishnahadi)
                    values(@BudgetDetailProjectId1 , @delegateTo  ,  @SupervisorNiabatAmount )

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




