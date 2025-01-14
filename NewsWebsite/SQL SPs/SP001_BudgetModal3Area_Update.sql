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
        
         if(@areaSharePishnahadi is not null and @areaSharePishnahadi<@currentSumPishnahadi-@currentPishnahadi+@Pishnahadi and @Pishnahadi>@currentPishnahadi )
begin
select CONCAT('خطا بودجه پیشنهادی - سهم منطقه ',@areaSharePishnahadi,' ریال می باشد و تنها',(@areaSharePishnahadi-@currentSumPishnahadi),'ریال آزاد می باشد') as Message_DB
    return
end
             
        
--          if(@areaShareEdit is not null and @areaShareEdit<@currentSumEdit-@currentEdit+@EditArea  and @EditArea>@currentEdit)
--              begin
--                  select CONCAT('خطا بودجه اصلاحی - سهم منطقه ',@areaShareEdit,' ریال می باشد و تنها',(@areaShareEdit-@currentSumEdit),'ریال آزاد می باشد') as Message_DB
--                  return
--              end

end


 if(@budgetProcessId=3)
begin
update tblBudgetDetailProjectArea
set Pishnahadi = @Pishnahadi,
    PishnahadiCash = @Pishnahadi, -- منابع داخلی
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

