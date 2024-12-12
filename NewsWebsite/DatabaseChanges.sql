
insert into tblCoding ( Id,MotherId ,   Code    ,  Description ,levelNumber  ,TblBudgetProcessId ,Show,Crud  ) values
                                                                                                                (12720,5701 ,13010601  ,CONCAT('وجوه پرداختی شهرداری بابت اجرای پروژه ها (', 'سازمان فناوری اطلاعات و ارتباطات' ,')'),5, 9  ,  1 ,  1  ),
                                                                                                                (12721,5701 ,13010602  ,CONCAT('وجوه پرداختی شهرداری بابت اجرای پروژه ها (', 'سازمان آتش نشانی و خدمات ایمنی' ,')'),5, 9  ,  1 ,  1  ),
                                                                                                                (12722,5701 ,13010603  ,CONCAT('وجوه پرداختی شهرداری بابت اجرای پروژه ها (', 'سازمان اتوبوسرانی' ,')'),5, 9  ,  1 ,  1  ),
                                                                                                                (12723,5701 ,13010604  ,CONCAT('وجوه پرداختی شهرداری بابت اجرای پروژه ها (', 'سازمان بهسازی و نوسازی' ,')'),5, 9  ,  1 ,  1  ),
                                                                                                                (12724,5701 ,13010605  ,CONCAT('وجوه پرداختی شهرداری بابت اجرای پروژه ها (', 'سازمان پارکها و فضای سبز' ,')'),5, 9  ,  1 ,  1  ),
                                                                                                                (12725,5701 ,13010606  ,CONCAT('وجوه پرداختی شهرداری بابت اجرای پروژه ها (', 'سازمان پایانه های مسافربری' ,')'),5, 9  ,  1 ,  1  ),
                                                                                                                (12726,5701 ,13010607  ,CONCAT('وجوه پرداختی شهرداری بابت اجرای پروژه ها (', 'سازمان تاکسیرانی' ,')'),5, 9  ,  1 ,  1  ),
                                                                                                                (12727,5701 ,13010608  ,CONCAT('وجوه پرداختی شهرداری بابت اجرای پروژه ها (', 'سازمان خدمات موتوری' ,')'),5, 9  ,  1 ,  1  ),
                                                                                                                (12728,5701 ,13010609  ,CONCAT('وجوه پرداختی شهرداری بابت اجرای پروژه ها (', 'سازمان آرامستانها' ,')'),5, 9  ,  1 ,  1  ),
                                                                                                                (12729,5701 ,13010610  ,CONCAT('وجوه پرداختی شهرداری بابت اجرای پروژه ها (', 'سازمان حمل و نقل بار' ,')'),5, 9  ,  1 ,  1  ),
                                                                                                                (12730,5701 ,13010611  ,CONCAT('وجوه پرداختی شهرداری بابت اجرای پروژه ها (', 'سازمان زیبا سازی' ,')'),5, 9  ,  1 ,  1  ),
                                                                                                                (12731,5701 ,13010612  ,CONCAT('وجوه پرداختی شهرداری بابت اجرای پروژه ها (', 'سازمان عمران' ,')'),5, 9  ,  1 ,  1  ),
                                                                                                                (12732,5701 ,13010613  ,CONCAT('وجوه پرداختی شهرداری بابت اجرای پروژه ها (', 'سازمان پسماند' ,')'),5, 9  ,  1 ,  1  ),
                                                                                                                (12733,5701 ,13010614  ,CONCAT('وجوه پرداختی شهرداری بابت اجرای پروژه ها (', 'سازمان مشاغل شهری' ,')'),5, 9  ,  1 ,  1  ),
                                                                                                                (12734,5701 ,13010615  ,CONCAT('وجوه پرداختی شهرداری بابت اجرای پروژه ها (', 'سازمان فرهنگی اجتماعی ورزشی' ,')'),5, 9  ,  1 ,  1  ),
                                                                                                                (12735,5701 ,13010616  ,CONCAT('وجوه پرداختی شهرداری بابت اجرای پروژه ها (', 'سازمان حمل و نقل ریلی' ,')'),5, 9  ,  1 ,  1  ),
                                                                                                                (12736,5701 ,13010617  ,CONCAT('وجوه پرداختی شهرداری بابت اجرای پروژه ها (', 'سازمان  مشارکتها' ,')'),5, 9  ,  1 ,  1 )




    USE [ProgramBudDB]
GO

/****** Object:  Table [dbo].[tblBudgetDetailProjectAreaDelegate]    Script Date: 12/12/2024 1:46:59 PM ******/
SET ANSI_NULLS ON
    GO

    SET QUOTED_IDENTIFIER ON
    GO

CREATE TABLE [dbo].[tblBudgetDetailProjectAreaDelegate](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [BudgetDetailProjectAreaId] [int] NULL,
    [AreaId] [int] NULL,
    [Pishnahadi] [bigint] NULL,
    [Mosavab] [bigint] NULL,
    [Edit] [bigint] NULL,
    [SupervisorPercent] [int] NULL,
    [NiabatiRecordId] [int] NULL,
    [CostRecordId] [int] NULL,
    CONSTRAINT [PK_tblBudgetDetailProjectAreaDelegate] PRIMARY KEY CLUSTERED
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO



    
    
    

    GO
/****** Object:  StoredProcedure [dbo].[SP000_Area]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP000_Area]
@areaForm tinyint
AS
BEGIN

--@AreaForm = 1 فرم بودجه پیشنهادی
--@AreaForm = 2 بودجه تفکیکی
--@AreaForm = 3  فرم واسط سازمانها

if(@areaForm=1)
begin
SELECT        Id, AreaName,AreaNameShort
FROM            TblAreas
WHERE    id not in ( 38  ,45,46,47,48,49,50,51,52)
order by Id
    return
end

if(@areaForm=2)
begin
SELECT        Id, AreaName,AreaNameShort
FROM            TblAreas
WHERE        (Id NOT IN (10,27,28     ,38      ,45,46,47,48,49,50,51,52))
    return
end

if(@areaForm=3)
begin
SELECT        Id, AreaName,AreaNameShort
FROM            TblAreas
WHERE        (Id NOT IN (27,28     ,38    ,45,46,47,48,49,50,51,52))
    return
end

-- sazman ha
if(@areaForm=4)
begin
SELECT        Id, AreaName,AreaNameShort
FROM            TblAreas
WHERE        (Id IN (11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
    return
end



END
go








GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal3Area_Delete]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP001_BudgetModal3Area_Delete]
   @Id int
AS
BEGIN


    declare @isDelegateRecord int =(SELECT Id FROM tblBudgetDetailProjectAreaDelegate where CostRecordId = @Id or NiabatiRecordId = @Id)

    if (@isDelegateRecord is not null and @isDelegateRecord <> '')
begin
select 'این ردیف نیابتی است  و تنها از طریق تغییر ردیف بودجه نیابت دهنده قابل ویرایش می باشد' as Message_DB
    return
end


    declare @Count1 int = (select count(*) from tblRequestBudget where BudgetDetailProjectAreaId = @Id)
    if (@Count1 > 0)
begin
select 'از ردیف فوق در درخواستها استفاده شده است' as Message_DB
    return
end


-- delete naibat records if is niabati
    declare @NiabatiRecordId int=0 ,@CostRecordId int=0
SELECT @NiabatiRecordId = NiabatiRecordId, @CostRecordId = CostRecordId FROM tblBudgetDetailProjectAreaDelegate where BudgetDetailProjectAreaId = @Id
    if (@NiabatiRecordId > 0 and @CostRecordId > 0)
begin
delete from tblBudgetDetailProjectAreaDelegate where BudgetDetailProjectAreaId = @Id
delete from tblBudgetDetailProjectArea where id in (@NiabatiRecordId, @CostRecordId)
end


    delete tblBudgetDetailProjectAreaDepartment
    where BudgetDetailProjectAreaId = @Id

    delete tblBudgetDetailProjectArea
    where id = @Id
END
go



















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
ALTER PROCEDURE [dbo].[SP001_BudgetModal3Area_Update]
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
             
        
--          if(@areaShareEdit is not null and @areaShareEdit<@currentSumEdit-@currentEdit+@EditArea)
--              begin
--                  select CONCAT('خطا بودجه اصلاحی - سهم منطقه ',@areaShareEdit,' ریال می باشد و تنها',(@areaShareEdit-@currentSumEdit),'ریال آزاد می باشد') as Message_DB
--                  return
--              end

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
go





















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
ALTER PROCEDURE [dbo].[SP004_BudgetProposal_Inline_Delete]
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
ALTER PROCEDURE [dbo].[SP004_BudgetProposal_Inline_Update]
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
        
--         if(@areaShare is not null and @areaShare<@currentSum-@currentVal+@Pishnahadi)
--          begin
--                select CONCAT('خطا - سهم منطقه ',@areaShare,' ریال می باشد و تنها',(@areaShare-@currentSum),'ریال آزاد می باشد') as Message_DB
--             return
--          end

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


----------- Delegate calculations
DECLARE @shouldAdd int=0
DECLARE @delegateAreaId INT, @NiabatiRecordId INT, @CostRecordId INT;
declare @delegateId int = (SELECT id FROM tblBudgetDetailProjectAreaDelegate where BudgetDetailProjectAreaId= @BudgetDetailProjectAreaId)
    
if(isnull(@delegateTo,0)>0)
begin
            declare @SupervisorNiabatAmount int = @delegateAmount*(@delegatePercentage+100)/100
            declare @SupervisorCostAmount int = @delegateAmount
            
            if(isnull(@delegateId,0)>0)
begin

SELECT @delegateAreaId = AreaId,@NiabatiRecordId = NiabatiRecordId,@CostRecordId = CostRecordId FROM tblBudgetDetailProjectAreaDelegate WHERE BudgetDetailProjectAreaId = @BudgetDetailProjectAreaId;

if(@delegateAreaId=@delegateTo) -- still this area
begin
Update  tblBudgetDetailProjectAreaDelegate set Pishnahadi=@delegateAmount, SupervisorPercent=@delegatePercentage where BudgetDetailProjectAreaId= @BudgetDetailProjectAreaId

Update  tblBudgetDetailProjectArea set Pishnahadi=@SupervisorNiabatAmount where id = @NiabatiRecordId

Update  tblBudgetDetailProjectArea set Pishnahadi=@SupervisorCostAmount where id= @CostRecordId

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
                    if(@delegateTo = 11) begin set @MotherId = 11202  end  -- سازمان فناوری اطلاعات و ارتباطات
                    if(@delegateTo = 12) begin set @MotherId = 11203  end  -- سازمان آتش نشانی و خدمات ایمنی
                    if(@delegateTo = 13) begin set @MotherId = 11204  end  -- سازمان اتوبوسرانی
                    if(@delegateTo = 14) begin set @MotherId = 11205  end  -- سازمان بهسازی و نوسازی
                    if(@delegateTo = 15) begin set @MotherId = 11206  end  -- سازمان پارکها و فضای سبز
                    if(@delegateTo = 16) begin set @MotherId = 11207  end  -- سازمان پایانه های مسافربری
                    if(@delegateTo = 17) begin set @MotherId = 11208  end  -- سازمان تاکسیرانی
                    if(@delegateTo = 18) begin set @MotherId = 11209  end  -- سازمان خدمات موتوری
                    if(@delegateTo = 19) begin set @MotherId = 11210  end  -- سازمان آرامستانها
                    if(@delegateTo = 20) begin set @MotherId = 11211  end  -- سازمان حمل و نقل بار
                    if(@delegateTo = 21) begin set @MotherId = 11212  end  -- سازمان زیبا سازی
                    if(@delegateTo = 22) begin set @MotherId = 11213  end  -- سازمان عمران
                    if(@delegateTo = 23) begin set @MotherId = 11214  end  -- سازمان پسماند
                    if(@delegateTo = 24) begin set @MotherId = 11215  end  -- سازمان مشاغل شهری
                    if(@delegateTo = 25) begin set @MotherId = 11216  end  -- سازمان فرهنگی اجتماعی ورزشی
                    if(@delegateTo = 26) begin set @MotherId = 11217  end  -- سازمان حمل و نقل ریلی
                    if(@delegateTo = 29) begin set @MotherId = 11218  end  -- سازمان  مشارکتها

        
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


insert into tblBudgetDetailProjectArea( BudgetDetailProjectId ,  AreaId  ,Pishnahadi)
values(@BudgetDetailProjectId2 , @delegateTo  ,  @SupervisorCostAmount )

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
GO



















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
ALTER PROCEDURE [dbo].[SP004_BudgetProposal_Read]
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
              tbl2.Pishnahadi, tblCoding_4.levelNumber ,tblCoding_4.Crud,ConfirmStatus AS ConfirmStatus,isNewYear AS isNewYear,delegateTo,delegateAmount,delegatePercentage,DelegateArea.AreaName as DelegateToName,tbl2.ProctorId,tbl2.ExecutionId
FROM            (SELECT CodingId, isnull(SUM(Mosavab),0) AS Mosavab, isnull(SUM(EditArea),0) AS Edit , SUM(Supply) as Supply,isnull(SUM(Expense),0) AS Expense ,isnull(sum(PishnahadiCash),0) as PishnahadiCash,isnull(sum(PishnahadiNonCash),0) as PishnahadiNonCash,isnull(sum(Pishnahadi),0) as Pishnahadi,isnull(min(ConfirmStatus),0) AS ConfirmStatus ,
                        max(isNewYear) AS isNewYear ,isnull(max(delegateTo),0) AS delegateTo ,isnull(max(delegateAmount),0) AS delegateAmount ,isnull(max(delegatePercentage),0) AS delegatePercentage
                         ,CASE WHEN COUNT(DISTINCT ProctorId) = 0 THEN 0  WHEN COUNT(DISTINCT ProctorId) <=2 THEN MAX(ProctorId) ELSE -1 END AS ProctorId ,CASE WHEN COUNT(DISTINCT ExecutionId) = 0 THEN 0 WHEN COUNT(DISTINCT ExecutionId) <=2 THEN MAX(ExecutionId) ELSE -1 END AS ExecutionId
                 FROM            (

--سطح اول
                                     SELECT        tblCoding_5.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, 0 AS PishnahadiCash, 0 AS PishnahadiNonCash, 0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId
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
                                     SELECT        tblCoding_5.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage ,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId
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

                                     SELECT        tblCoding_4.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear  , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId
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

                                     SELECT        tblCoding_4.MotherId AS CodingId, 0 as Mosavab, 0 as EditArea,0 as supply, 0 as Expense , tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear ,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId
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
                                     SELECT        tblCoding_1.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear  , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId
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

                                     SELECT tblCoding_1.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear ,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId
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
                                     SELECT        tblCoding_3.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear  , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId
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
                                     SELECT        tblCoding_3.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId
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
                                     SELECT        tblCoding_2.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea,tblBudgetDetailProjectArea.Supply,tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear  , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId
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
                                     SELECT        tblCoding_2.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId
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
                                     SELECT        tblCoding_3.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId
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
                                     SELECT  tblCoding_3.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea, 0 as supply,0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId
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
                                     SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea,tblBudgetDetailProjectArea.Supply,tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear  , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId
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

                                     SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId
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
ALTER PROCEDURE [dbo].[SP001_BudgetModal1Coding_Insert]
@codingId int ,
@areaId int ,
@yearId int ,
@BudgetProcessId tinyint
AS
BEGIN
declare @ExecuteId int
declare @MainAreaId int=@areaId
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

  
declare @subCount int = (SELECT      COUNT(*) AS Expr1
                            FROM TblBudgetDetails
                                     INNER JOIN TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id
                                     INNER JOIN tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId
                                     INNER JOIN tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
                                     INNER JOIN tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                            WHERE
                                    TblBudgets.TblYearId = @yearId and
                                    tblBudgetDetailProjectArea.AreaId=@areaId and
                                    tblCoding.TblBudgetProcessId=@budgetProcessId and
                                    tblCoding.MotherId = @codingId);

if(@subCount>0)
begin
select 'شما ردیف های زیرمجموعه این کدینگ را افزوده اید. لطفا آنها را مقداردهی نمایید' as Message_DB
    return
end

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

if(@MainAreaId in (30,31,32,33,34,35,36,42,43,44,53)) begin
update tblCoding
set ExecuteId = @ExecuteId
where id = @codingId
end


END
GO























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
ALTER PROCEDURE [dbo].[SP001_Budget_Inline_Insert]
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
