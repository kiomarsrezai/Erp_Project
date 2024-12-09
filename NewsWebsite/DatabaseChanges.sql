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
        
        declare @currentSum BIGINT =(SELECT  sum(tblBudgetDetailProjectArea.Pishnahadi)
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
/****** Object:  StoredProcedure [dbo].[SP001_BudgetCodingMainModal]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetCodingMainModal] 
@BudgetProcessId tinyint,
@yearId int,
@areaId int
AS
BEGIN
if(@BudgetProcessId =1)
begin
SELECT        Id, Code, Description, levelNumber
FROM            tblCoding
WHERE        (TblBudgetProcessId = 1) and (levelNumber in (2,3,4,5)) and ( Code not like '0%')
    return
end

if(@BudgetProcessId =2)
begin
SELECT        Id, Code, Description, levelNumber
FROM            tblCoding
WHERE        (TblBudgetProcessId = 2) and (levelNumber in (3,4,5))
    return
end

if(@BudgetProcessId =3)
begin
SELECT        Id, Code, Description, levelNumber
FROM            tblCoding
WHERE        (TblBudgetProcessId = 3) and (levelNumber in (4,5,6))
    return
end

if(@BudgetProcessId =4)
begin
SELECT        Id, Code, Description, levelNumber
FROM            tblCoding
WHERE        (TblBudgetProcessId = 4)
    return
end


if(@BudgetProcessId =5)
begin
SELECT        Id, Code, Description, levelNumber
FROM            tblCoding
WHERE        (TblBudgetProcessId = 5)
    return
end

if(@BudgetProcessId =8)
begin
SELECT        Id, Code, Description, levelNumber
FROM            tblCoding
WHERE        (TblBudgetProcessId = 8)
    return
end

if(@BudgetProcessId =9)
begin
SELECT        Id, Code, Description, levelNumber
FROM            tblCoding
WHERE        (TblBudgetProcessId = 9)
order by Code
    return
end

if(@BudgetProcessId =10)
begin
SELECT        Id, Code, Description, levelNumber
FROM            tblCoding
WHERE        (TblBudgetProcessId = 10)
order by Code
    return
end

if(@BudgetProcessId =11)
begin
SELECT        Id, Code, Description, levelNumber
FROM            tblCoding
WHERE        (TblBudgetProcessId = 11)
order by Code
    return
end
END
GO




USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal1Coding_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetModal1Coding_Insert]
@codingId int ,
@areaId int ,
@yearId int ,
@BudgetProcessId tinyint
AS
BEGIN
declare @ExecuteId int
declare @MainAreaId int=areaId
if(@areaId not in (30,31,32,33,34,35,36,42,43,44,53)) begin  set @ExecuteId = 8  end
if(@areaId = 30) begin set @areaId=9  set @ExecuteId = 4  end
if(@areaId = 31) begin set @areaId=9  set @ExecuteId = 10 end
if(@areaId = 32) begin set @areaId=9  set @ExecuteId = 2  end
if(@areaId = 33) begin set @areaId=9  set @ExecuteId = 1  end
if(@areaId = 34) begin set @areaId=9  set @ExecuteId = 3  end
if(@areaId = 35) begin set @areaId=9  set @ExecuteId = 7  end
if(@areaId = 36) begin set @areaId=9  set @ExecuteId = 6  end
if(@areaId = 42) begin set @areaId=9 set @ExecuteId = 12 end
if(@areaId = 43) begin set @areaId=9 set @ExecuteId = 11 end
if(@areaId = 44) begin set @areaId=9 set @ExecuteId = 13 end
if(@areaId = 53) begin set @areaId=9 set @ExecuteId = 14 end


    declare @BudgetId int = (select id from TblBudgets  where TblYearId = @yearId and TblAreaId = 10) 
	declare @ProjectId int 
	if(@BudgetProcessId in (1,9,10,11))   begin set @ProjectId = 1 end
	if(@BudgetProcessId = 2) begin set @ProjectId = 2 end
	if(@BudgetProcessId in (3,4,5)) begin set @ProjectId = 3 end
	
	declare @ProgramOperationDetailId int = (SELECT TblProgramOperationDetails.Id
													FROM    TblProgramOperations INNER JOIN
															TblProgramOperationDetails ON TblProgramOperations.Id = TblProgramOperationDetails.TblProgramOperationId INNER JOIN
															TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id
													WHERE  (TblProgramOperations.TblAreaId = @areaId) AND
													       (TblProgramOperations.TblProgramId = 10) AND
													       (TblProgramOperationDetails.TblProjectId = @ProjectId))

	declare @Count int = (SELECT        COUNT(*) 
							FROM     TblBudgetDetails INNER JOIN
									 TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
									 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
							WHERE   (TblBudgets.TblYearId = @yearId) AND
							       -- (tblBudgetDetailProjectArea.AreaId = @areaId) AND
							        (TblBudgetDetails.tblCodingId = @codingId))

declare @BudgetDetailId int=0

	if(@Count>0)
begin
          SET @BudgetDetailId = (SELECT   TOP(1)    TblBudgetDetails.Id
                                FROM     TblBudgetDetails INNER JOIN
                                         TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                                WHERE   (TblBudgets.TblYearId = @yearId) AND
                                  -- (tblBudgetDetailProjectArea.AreaId = @areaId) AND
                                    (TblBudgetDetails.tblCodingId = @codingId) AND 
                                    tblCoding.TblBudgetProcessId=@BudgetProcessId)
                                  
-- 	     select 'آی دی کد بودجه تکراری است' as Message_DB
-- 		 return
end

    declare @Hcode nvarchar(20)=(select Code from tblCoding where id = @codingId and TblBudgetProcessId=@BudgetProcessId )
    declare @Count_Code int = (SELECT      COUNT(*) AS Expr1
									FROM   TblBudgetDetails INNER JOIN
										   TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
										   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
										   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
										   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
									WHERE (TblBudgets.TblYearId = @yearId) AND
									      (tblBudgetDetailProjectArea.AreaId = @areaId) AND
									      (TblBudgetDetails.tblCodingId = @codingId) AND
									      (tblCoding.Code = @Hcode))
  if(@Count_Code>0)
begin
select 'کد بودجه تکراری است' as Message_DB
    return
end

-- 	if(@Count=0)
-- 	  begin
          if(@BudgetDetailId=0)
begin
insert into TblBudgetDetails ( BudgetId , tblCodingId ,MosavabPublic)
values(@BudgetId ,   @codingId ,      1000   )

    SET @BudgetDetailId = SCOPE_IDENTITY()

end

insert into tblBudgetDetailProject ( BudgetDetailId ,  ProgramOperationDetailsId ,Mosavab)
values(@BudgetDetailId , @ProgramOperationDetailId  ,  1000 )
declare @BudgetDetailProjectId int = SCOPE_IDENTITY()

    		insert into tblBudgetDetailProjectArea( BudgetDetailProjectId ,  AreaId  ,Mosavab)
										    values(@BudgetDetailProjectId , @areaId  ,  1000 )
-- 	  end

if(@MainAreaId not in (30,31,32,33,34,35,36,42,43,44,53)) begin
update tblCoding
set ExecuteId = @ExecuteId
where id = @codingId
end


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



 declare @MosavabAgo bigint =(SELECT   Mosavab
								FROM      tblBudgetDetailProjectArea
								WHERE     (id = @Id))

declare @Revenue bigint = (SELECT    sum(tblBudgetDetailProjectArea.Mosavab)
								FROM  TblBudgets INNER JOIN
									  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
								WHERE  (TblBudgets.TblYearId = @yearId) AND
								       (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
									   (tblCoding.TblBudgetProcessId = 1))
 --declare @Revenue bigint 
 --if(@AreaId = 1) begin set @Revenue =  4600000000000  end
 --if(@AreaId = 2) begin set @Revenue =  12000000000000 end
 --if(@AreaId = 3) begin set @Revenue =  7300000000000  end
 --if(@AreaId = 4) begin set @Revenue =  6000000000000  end
 --if(@AreaId = 5) begin set @Revenue =  3000000000000  end
 --if(@AreaId = 6) begin set @Revenue =  1842000000000  end
 --if(@AreaId = 7) begin set @Revenue =  4000000000000  end
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
   
 

 --if(@AreaId = 1) begin set @Current =  4600000000000  end
 --if(@AreaId = 2) begin set @Current =  4250000000000  end
 --if(@AreaId = 3) begin set @Current =  3740000000000  end
 --if(@AreaId = 4) begin set @Current =  3015000000000  end
 --if(@AreaId = 5) begin set @Current =  2420000000000  end
 --if(@AreaId = 6) begin set @Current =  2680000000000  end
 --if(@AreaId = 7) begin set @Current =  2750000000000  end
 --if(@AreaId = 8) begin set @Current =  2750000000000  end 
  

 

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
   
   


declare @Balance bigint = isnull(@Revenue,0) - isnull(@Current,0) - isnull(@Civil,0) - isnull(@Motomarkez,0) + isnull(@Komak,0) + isnull(@MosavabAgo,0)-isnull(@BudgetNext,0)

--if(@AreaId <=8 AND @Balance<0 AND @BudgetProcessId=3 and @Mosavab>@MosavabAgo and @YearId=34)
--begin
--   select ' به مبلغ '+dbo.seprator(cast(@Balance as nvarchar(100)))+' منفی می شود ' as Message_DB
--	return
--end

--===============کنترل بودجه معاونت ها
 	declare @ExecuteId int =(SELECT     tblCoding.ExecuteId
									FROM   TblBudgets INNER JOIN
										   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
										   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
										   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
										   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
									WHERE (tblBudgetDetailProjectArea.id = @Id))
if(@AreaId = 9)
begin  
	declare @CivilExecute bigint
	if(@ExecuteId = 4 ) begin set @CivilExecute = 650000000000   end-- شهر سازی
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

declare  @Balance2 bigint  = @CivilExecute - isnull(@Civil,0) + isnull(@MosavabAgo,0)-isnull(@BudgetNext,0)
--if(@Balance2<0 AND @Mosavab>@MosavabAgo and @YearId = 34)
--begin
-- select ' به مبلغ '+dbo.seprator(cast(@Balance2 as nvarchar(100)))+' منفی می شود ' as Message_DB
--return
--end

end



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
        
        
        
         SET @currentPishnahadi= (select Pishnahadi from tblBudgetDetailProjectArea where id = @Id)
         SET @currentEdit= (select EditArea from tblBudgetDetailProjectArea where id = @Id)
        
         declare @currentSumPishnahadi Bigint =(SELECT  sum(tblBudgetDetailProjectArea.Pishnahadi)
                                   FROM     TblBudgets INNER JOIN
                                            TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                            tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                            tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                            tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                                   WHERE   (tblCoding.TblBudgetProcessId = @budgetProcessId) AND
                                       (TblBudgets.TblYearId =@yearId) AND
                                       (tblBudgetDetailProjectArea.AreaId =@AreaId))
        
        -- 
         declare @currentSumEdit Bigint =(SELECT  sum(tblBudgetDetailProjectArea.EditArea)
                                   FROM     TblBudgets INNER JOIN
                                            TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                            tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                            tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                            tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                                   WHERE   (tblCoding.TblBudgetProcessId = @budgetProcessId) AND
                                       (TblBudgets.TblYearId =@yearId) AND
                                       (tblBudgetDetailProjectArea.AreaId =@AreaId))
        
         if(@areaSharePishnahadi is not null and @areaSharePishnahadi<@currentSumPishnahadi-@currentPishnahadi+@Pishnahadi)
begin
select CONCAT('خطا بودجه پیشنهادی - سهم منطقه ',@areaSharePishnahadi,' ریال می باشد و تنها',(@areaSharePishnahadi-@currentSumPishnahadi),'ریال آزاد می باشد') as Message_DB
    return
end
             
        
         if(@areaShareEdit is not null and @areaShareEdit<@currentSumEdit-@currentEdit+@EditArea)
begin
select CONCAT('خطا بودجه اصلاحی - سهم منطقه ',@areaShareEdit,' ریال می باشد و تنها',(@areaShareEdit-@currentSumEdit),'ریال آزاد می باشد') as Message_DB
    return
end
end
     
     
--if(@YearId in (33,34))
--begin
update tblBudgetDetailProjectArea
set Pishnahadi = @Pishnahadi,
    Mosavab = @Mosavab,
    EditArea = @EditArea,
    ConfirmStatus=0
where id = @Id
--return
--end



--if(@YearId Not in (33,34))
--begin
--      update tblBudgetDetailProjectArea
--	   set --Mosavab = @Mosavab,
--		  --EditArea = @EditArea,
--		  Expense = @Mosavab
--		  where id = @Id
--END



END
GO




USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP004_BudgetProposal_Inline_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP004_BudgetProposal_Inline_Insert]
@yearId int, 
@areaId int,
@budgetProcessId int,
@CodingId int
AS
BEGIN



declare @ExecuteId int
if(@areaId not in (30,31,32,33,34,35,36)) begin  set @ExecuteId = 8  end
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

    declare @budgetId      int      = (select Id from TblBudgets where TblYearId = @yearId and TblAreaId = @areaId)
    declare @LevelNumber tinyint    = (select levelNumber from tblCoding where id = @CodingId)
	declare @MotherId      int      = (select MotherId from tblCoding where id = @CodingId)
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
select 'خطا' as Message_DB
    return
end
	declare @MaxCode2 nvarchar(20)= cast(@MaxCode as bigint)+1 

	
	declare @ProjectId int 
	if(@BudgetProcessId in (1,9,10,11))   begin set @ProjectId = 1 end
	if(@BudgetProcessId = 2)         begin set @ProjectId = 2 end
	if(@BudgetProcessId in (3,4,5))  begin set @ProjectId = 3 end
	
	
	declare  @ProgramOperationDetailId int = (SELECT TblProgramOperationDetails.Id
													FROM    TblProgramOperations INNER JOIN
															TblProgramOperationDetails ON TblProgramOperations.Id = TblProgramOperationDetails.TblProgramOperationId INNER JOIN
															TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id
													WHERE  (TblProgramOperations.TblAreaId = @areaId) AND
													       (TblProgramOperations.TblProgramId = 10) AND
													       (TblProgramOperationDetails.TblProjectId = @ProjectId))


if(@LevelNumber<>5 or @budgetProcessId<>3 or @yearId<>34)
begin
select 'فعلا فقط برای سطح 5 و تملک سرمایه ای تست شود' as Message_DB
    return
end

insert into tblCoding ( MotherId ,   Code    ,            Description        ,levelNumber  ,TblBudgetProcessId ,Show,Crud , ExecuteId )
values(@MotherId ,@MaxCode2  , 'لطفا شرح را اصلاح فرمائید' ,@LevelNumber  , @budgetProcessId  ,  1 ,  1  ,@ExecuteId)
declare @Codeing_NewId int = SCOPE_IDENTITY()


insert into TblBudgetDetails ( BudgetId ,  tblCodingId   ,MosavabPublic)
                       values(@BudgetId , @Codeing_NewId ,   1000     )
declare @BudgetDetailId int = SCOPE_IDENTITY()

insert into tblBudgetDetailProject ( BudgetDetailId ,  ProgramOperationDetailsId ,Mosavab)
						     values(@BudgetDetailId , @ProgramOperationDetailId  ,  1000 )
declare @BudgetDetailProjectId int = SCOPE_IDENTITY()

insert into tblBudgetDetailProjectArea( BudgetDetailProjectId ,  AreaId  ,Mosavab)
							    values(@BudgetDetailProjectId , @areaId  ,  1000 )

END
GO
