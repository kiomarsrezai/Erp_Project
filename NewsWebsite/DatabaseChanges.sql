delete [SP500_Abstract_Eslahi]
       
       
       privateDocHistory add LetterNumber  nvarchar(50)
privateDocHistory add LetterNumber  datetime

amlakPRivateNew delete column typeUsing                  
amlakPRivateNew delete column entryDate                  
amlakPRivateNew add column DocumentDate after InternalDate

tblAmlakPrivateDocHistory add column Type nvarchar(50)
update tblAmlakPrivateDocHistory set Type='general'

tblAmlakArchive change plaque1 to MainPlateNumber
tblAmlakArchive change plaque2 to SubPlateNumber
                                 
tblBudgetDetailProjectArea add   PishnahadiCash bigint default 0
tblBudgetDetailProjectArea add   PishnahadiNonCash bigint default 0
update tblBudgetDetailProjectArea set PishnahadiCash=0 , PishnahadiNonCash=0

    tblBudgetAreaShare add Type nvarchar(50)

update tblBudgetAreaShare set type='edit'




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


DECLARE @areaShare INT;
DECLARE @currentVal INT;
DECLARE @sql NVARCHAR(MAX);

SET @sql = N'SELECT TOP(1) @areaShare = ShareProcessId' + CAST(@budgetProcessId AS NVARCHAR(10)) + ' FROM tblBudgetAreaShare WHERE AreaId = '+CAST(@areaId AS NVARCHAR(10))+' AND YearId = '+CAST(@yearId AS NVARCHAR(10))+ ' AND Type = ''pishnahadi'';';

-- Execute dynamic SQL and retrieve the value into @areaShare
EXEC sp_executesql @sql, N'@areaShare BIGINT OUTPUT', @areaShare OUTPUT;





SET @currentVal= (select Pishnahadi from tblBudgetDetailProjectArea where id = @BudgetDetailProjectAreaId)

declare @currentSum int =(SELECT  sum(tblBudgetDetailProjectArea.Pishnahadi)
									FROM     TblBudgets INNER JOIN
											 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
											 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
											 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
											 tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
									WHERE   (tblCoding.TblBudgetProcessId = @budgetProcessId) AND
										    (TblBudgets.TblYearId =@yearId) AND
										    (tblBudgetDetailProjectArea.AreaId =@areaId))

if(@areaShare is not null and @areaShare<@currentSum-@currentVal+@Pishnahadi)
begin
select CONCAT('خطا - سهم منطقه ',@areaShare,' ریال می باشد و تنها',(@areaShare-@currentSum),'ریال آزاد می باشد') as Message_DB
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
go
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
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


------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------

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



-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP500_Abstract]
@YearId int,
@type NVARCHAR(50)
AS
BEGIN
    
    if (@type='mosavab')
BEGIN
SELECT       Id, AreaName, MosavabRevenue, MosavabPayMotomarkez, MosavabDar_Khazane,MosavabNeyabati , Resoures, MosavabCurrent, MosavabCivil, MosavabFinancial, MosavabSanavati, balanceMosavab
FROM            (SELECT        TblAreas.Id, TblAreas.AreaNameShort AS AreaName,
                               ISNULL(der_Revenue.MosavabRevenue, 0) AS MosavabRevenue,
                               ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0) AS MosavabPayMotomarkez,
                               ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) AS MosavabDar_Khazane,
                               ISNULL(der_Neyabati.MosavabNeyabati,0) AS MosavabNeyabati ,
                               ISNULL(der_Revenue.MosavabRevenue, 0) -
                               ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0)+
                               ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) +
                               ISNULL(der_Neyabati.MosavabNeyabati,0)  AS Resoures,
                               ISNULL(der_Current.MosavabCurrent, 0) AS MosavabCurrent,
                               ISNULL(der_Civil.MosavabCivil, 0) AS MosavabCivil,
                               ISNULL(der_Financial.MosavabFinancial,0) AS MosavabFinancial,
                               ISNULL(der_Doyon.MosavabSanavati, 0) AS MosavabSanavati,
                               ISNULL(der_Revenue.MosavabRevenue, 0) -
                               ISNULL(der_Current.MosavabCurrent, 0) -
                               ISNULL(der_Civil.MosavabCivil, 0) -
                               ISNULL(der_Doyon.MosavabSanavati, 0) -
                               ISNULL(der_Financial.MosavabFinancial, 0) -
                               ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0) +
                               ISNULL(der_Neyabati.MosavabNeyabati,0) +
                               ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) AS balanceMosavab

                 FROM            TblAreas LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Mosavab) AS MosavabNeyabati, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseNeyabati
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 9) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Neyabati ON TblAreas.Id = der_Neyabati.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Mosavab) AS MosavabDar_Khazane, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseDar_Khazane
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId=10) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Mahromeyat ON TblAreas.Id = der_Mahromeyat.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Mosavab) AS MosavabPayMotomarkez, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpensePayMotomarkez
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 8) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Motomarkez ON TblAreas.Id = der_Motomarkez.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Mosavab) AS MosavabSanavati, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseDoyonSanavatiGhatei
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 5) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Doyon ON TblAreas.Id = der_Doyon.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_3.AreaId, SUM(tblBudgetDetailProjectArea_3.Mosavab) AS MosavabFinancial, SUM(tblBudgetDetailProjectArea_3.Expense) AS ExpenseFinancial
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_3 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_3 ON tblBudgetDetailProject_3.Id = tblBudgetDetailProjectArea_3.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_3 ON tblBudgetDetailProject_3.BudgetDetailId = TblBudgetDetails_3.Id INNER JOIN
                                                  tblCoding AS tblCoding_3 ON TblBudgetDetails_3.tblCodingId = tblCoding_3.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_3 ON TblBudgetDetails_3.BudgetId = TblBudgets_3.Id
                                  WHERE   (tblCoding_3.TblBudgetProcessId = 4) AND
                                      (TblBudgets_3.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_3.AreaId) AS der_Financial ON TblAreas.Id = der_Financial.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_2.AreaId, SUM(tblBudgetDetailProjectArea_2.Mosavab) AS MosavabCivil, SUM(tblBudgetDetailProjectArea_2.Expense) AS ExpenseCivil
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_2 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_2 ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea_2.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_2 ON tblBudgetDetailProject_2.BudgetDetailId = TblBudgetDetails_2.Id INNER JOIN
                                                  tblCoding AS tblCoding_2 ON TblBudgetDetails_2.tblCodingId = tblCoding_2.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_2 ON TblBudgetDetails_2.BudgetId = TblBudgets_2.Id
                                  WHERE   (tblCoding_2.TblBudgetProcessId = 3) AND
                                      (TblBudgets_2.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_2.AreaId) AS der_Civil ON TblAreas.Id = der_Civil.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_1.AreaId, SUM(tblBudgetDetailProjectArea_1.Mosavab) AS MosavabCurrent, SUM(tblBudgetDetailProjectArea_1.Expense) AS ExpenseCurrent
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_1 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON tblBudgetDetailProject_1.BudgetDetailId = TblBudgetDetails_1.Id INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_1 ON TblBudgetDetails_1.BudgetId = TblBudgets_1.Id
                                  WHERE   (tblCoding_1.TblBudgetProcessId = 2) AND
                                      (TblBudgets_1.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_1.AreaId) AS der_Current ON TblAreas.Id = der_Current.AreaId LEFT OUTER JOIN
                                 (SELECT   tblBudgetDetailProjectArea.AreaId, SUM(tblBudgetDetailProjectArea.Mosavab) AS MosavabRevenue, SUM(tblBudgetDetailProjectArea.Expense) AS ExpenseRevenue
                                  FROM            tblBudgetDetailProject INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails ON tblBudgetDetailProject.BudgetDetailId = TblBudgetDetails.Id INNER JOIN
                                                  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                  TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id
                                  WHERE   (tblCoding.TblBudgetProcessId = 1) AND
                                      (TblBudgets.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea.AreaId) AS der_Revenue ON TblAreas.Id = der_Revenue.AreaId
                ) AS tbl1

END

ELSE IF (@type='eslahi')
BEGIN

SELECT       Id, AreaName, MosavabRevenue, MosavabPayMotomarkez, MosavabDar_Khazane,MosavabNeyabati , Resoures, MosavabCurrent, MosavabCivil, MosavabFinancial, MosavabSanavati, balanceMosavab
FROM            (SELECT        TblAreas.Id, TblAreas.AreaNameShort AS AreaName,
                               ISNULL(der_Revenue.MosavabRevenue, 0) AS MosavabRevenue,
                               ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0) AS MosavabPayMotomarkez,
                               ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) AS MosavabDar_Khazane,
                               ISNULL(der_Neyabati.MosavabNeyabati,0) AS MosavabNeyabati ,
                               ISNULL(der_Revenue.MosavabRevenue, 0) -
                               ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0)+
                               ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) +
                               ISNULL(der_Neyabati.MosavabNeyabati,0)  AS Resoures,
                               ISNULL(der_Current.MosavabCurrent, 0) AS MosavabCurrent,
                               ISNULL(der_Civil.MosavabCivil, 0) AS MosavabCivil,
                               ISNULL(der_Financial.MosavabFinancial,0) AS MosavabFinancial,
                               ISNULL(der_Doyon.MosavabSanavati, 0) AS MosavabSanavati,
                               ISNULL(der_Revenue.MosavabRevenue, 0) -
                               ISNULL(der_Current.MosavabCurrent, 0) -
                               ISNULL(der_Civil.MosavabCivil, 0) -
                               ISNULL(der_Doyon.MosavabSanavati, 0) -
                               ISNULL(der_Financial.MosavabFinancial, 0) -
                               ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0) +
                               ISNULL(der_Neyabati.MosavabNeyabati,0) +
                               ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) AS balanceMosavab

                 FROM            TblAreas LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.EditArea) AS MosavabNeyabati, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseNeyabati
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 9) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Neyabati ON TblAreas.Id = der_Neyabati.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.EditArea) AS MosavabDar_Khazane, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseDar_Khazane
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId=10) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Mahromeyat ON TblAreas.Id = der_Mahromeyat.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.EditArea) AS MosavabPayMotomarkez, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpensePayMotomarkez
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 8) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Motomarkez ON TblAreas.Id = der_Motomarkez.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.EditArea) AS MosavabSanavati, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseDoyonSanavatiGhatei
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 5) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Doyon ON TblAreas.Id = der_Doyon.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_3.AreaId, SUM(tblBudgetDetailProjectArea_3.EditArea) AS MosavabFinancial, SUM(tblBudgetDetailProjectArea_3.Expense) AS ExpenseFinancial
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_3 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_3 ON tblBudgetDetailProject_3.Id = tblBudgetDetailProjectArea_3.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_3 ON tblBudgetDetailProject_3.BudgetDetailId = TblBudgetDetails_3.Id INNER JOIN
                                                  tblCoding AS tblCoding_3 ON TblBudgetDetails_3.tblCodingId = tblCoding_3.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_3 ON TblBudgetDetails_3.BudgetId = TblBudgets_3.Id
                                  WHERE   (tblCoding_3.TblBudgetProcessId = 4) AND
                                      (TblBudgets_3.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_3.AreaId) AS der_Financial ON TblAreas.Id = der_Financial.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_2.AreaId, SUM(tblBudgetDetailProjectArea_2.EditArea) AS MosavabCivil, SUM(tblBudgetDetailProjectArea_2.Expense) AS ExpenseCivil
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_2 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_2 ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea_2.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_2 ON tblBudgetDetailProject_2.BudgetDetailId = TblBudgetDetails_2.Id INNER JOIN
                                                  tblCoding AS tblCoding_2 ON TblBudgetDetails_2.tblCodingId = tblCoding_2.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_2 ON TblBudgetDetails_2.BudgetId = TblBudgets_2.Id
                                  WHERE   (tblCoding_2.TblBudgetProcessId = 3) AND
                                      (TblBudgets_2.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_2.AreaId) AS der_Civil ON TblAreas.Id = der_Civil.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_1.AreaId, SUM(tblBudgetDetailProjectArea_1.EditArea) AS MosavabCurrent, SUM(tblBudgetDetailProjectArea_1.Expense) AS ExpenseCurrent
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_1 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON tblBudgetDetailProject_1.BudgetDetailId = TblBudgetDetails_1.Id INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_1 ON TblBudgetDetails_1.BudgetId = TblBudgets_1.Id
                                  WHERE   (tblCoding_1.TblBudgetProcessId = 2) AND
                                      (TblBudgets_1.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_1.AreaId) AS der_Current ON TblAreas.Id = der_Current.AreaId LEFT OUTER JOIN
                                 (SELECT   tblBudgetDetailProjectArea.AreaId, SUM(tblBudgetDetailProjectArea.EditArea) AS MosavabRevenue, SUM(tblBudgetDetailProjectArea.Expense) AS ExpenseRevenue
                                  FROM            tblBudgetDetailProject INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails ON tblBudgetDetailProject.BudgetDetailId = TblBudgetDetails.Id INNER JOIN
                                                  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                  TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id
                                  WHERE   (tblCoding.TblBudgetProcessId = 1) AND
                                      (TblBudgets.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea.AreaId) AS der_Revenue ON TblAreas.Id = der_Revenue.AreaId
                ) AS tbl1


END
ELSE IF (@type='pishnahadi')
BEGIN

SELECT       Id, AreaName, MosavabRevenue, MosavabPayMotomarkez, MosavabDar_Khazane,MosavabNeyabati , Resoures, MosavabCurrent, MosavabCivil, MosavabFinancial, MosavabSanavati, balanceMosavab
FROM            (SELECT        TblAreas.Id, TblAreas.AreaNameShort AS AreaName,
                               ISNULL(der_Revenue.MosavabRevenue, 0) AS MosavabRevenue,
                               ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0) AS MosavabPayMotomarkez,
                               ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) AS MosavabDar_Khazane,
                               ISNULL(der_Neyabati.MosavabNeyabati,0) AS MosavabNeyabati ,
                               ISNULL(der_Revenue.MosavabRevenue, 0) -
                               ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0)+
                               ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) +
                               ISNULL(der_Neyabati.MosavabNeyabati,0)  AS Resoures,
                               ISNULL(der_Current.MosavabCurrent, 0) AS MosavabCurrent,
                               ISNULL(der_Civil.MosavabCivil, 0) AS MosavabCivil,
                               ISNULL(der_Financial.MosavabFinancial,0) AS MosavabFinancial,
                               ISNULL(der_Doyon.MosavabSanavati, 0) AS MosavabSanavati,
                               ISNULL(der_Revenue.MosavabRevenue, 0) -
                               ISNULL(der_Current.MosavabCurrent, 0) -
                               ISNULL(der_Civil.MosavabCivil, 0) -
                               ISNULL(der_Doyon.MosavabSanavati, 0) -
                               ISNULL(der_Financial.MosavabFinancial, 0) -
                               ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0) +
                               ISNULL(der_Neyabati.MosavabNeyabati,0) +
                               ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) AS balanceMosavab

                 FROM            TblAreas LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Pishnahadi) AS MosavabNeyabati, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseNeyabati
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 9) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Neyabati ON TblAreas.Id = der_Neyabati.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Pishnahadi) AS MosavabDar_Khazane, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseDar_Khazane
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId=10) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Mahromeyat ON TblAreas.Id = der_Mahromeyat.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Pishnahadi) AS MosavabPayMotomarkez, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpensePayMotomarkez
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 8) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Motomarkez ON TblAreas.Id = der_Motomarkez.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Pishnahadi) AS MosavabSanavati, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseDoyonSanavatiGhatei
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 5) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Doyon ON TblAreas.Id = der_Doyon.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_3.AreaId, SUM(tblBudgetDetailProjectArea_3.Pishnahadi) AS MosavabFinancial, SUM(tblBudgetDetailProjectArea_3.Expense) AS ExpenseFinancial
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_3 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_3 ON tblBudgetDetailProject_3.Id = tblBudgetDetailProjectArea_3.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_3 ON tblBudgetDetailProject_3.BudgetDetailId = TblBudgetDetails_3.Id INNER JOIN
                                                  tblCoding AS tblCoding_3 ON TblBudgetDetails_3.tblCodingId = tblCoding_3.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_3 ON TblBudgetDetails_3.BudgetId = TblBudgets_3.Id
                                  WHERE   (tblCoding_3.TblBudgetProcessId = 4) AND
                                      (TblBudgets_3.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_3.AreaId) AS der_Financial ON TblAreas.Id = der_Financial.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_2.AreaId, SUM(tblBudgetDetailProjectArea_2.Pishnahadi) AS MosavabCivil, SUM(tblBudgetDetailProjectArea_2.Expense) AS ExpenseCivil
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_2 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_2 ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea_2.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_2 ON tblBudgetDetailProject_2.BudgetDetailId = TblBudgetDetails_2.Id INNER JOIN
                                                  tblCoding AS tblCoding_2 ON TblBudgetDetails_2.tblCodingId = tblCoding_2.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_2 ON TblBudgetDetails_2.BudgetId = TblBudgets_2.Id
                                  WHERE   (tblCoding_2.TblBudgetProcessId = 3) AND
                                      (TblBudgets_2.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_2.AreaId) AS der_Civil ON TblAreas.Id = der_Civil.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_1.AreaId, SUM(tblBudgetDetailProjectArea_1.Pishnahadi) AS MosavabCurrent, SUM(tblBudgetDetailProjectArea_1.Expense) AS ExpenseCurrent
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_1 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON tblBudgetDetailProject_1.BudgetDetailId = TblBudgetDetails_1.Id INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_1 ON TblBudgetDetails_1.BudgetId = TblBudgets_1.Id
                                  WHERE   (tblCoding_1.TblBudgetProcessId = 2) AND
                                      (TblBudgets_1.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_1.AreaId) AS der_Current ON TblAreas.Id = der_Current.AreaId LEFT OUTER JOIN
                                 (SELECT   tblBudgetDetailProjectArea.AreaId, SUM(tblBudgetDetailProjectArea.Pishnahadi) AS MosavabRevenue, SUM(tblBudgetDetailProjectArea.Expense) AS ExpenseRevenue
                                  FROM            tblBudgetDetailProject INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails ON tblBudgetDetailProject.BudgetDetailId = TblBudgetDetails.Id INNER JOIN
                                                  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                  TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id
                                  WHERE   (tblCoding.TblBudgetProcessId = 1) AND
                                      (TblBudgets.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea.AreaId) AS der_Revenue ON TblAreas.Id = der_Revenue.AreaId
                ) AS tbl1


END

    --INNER JOIN 
						--     TblAreas ON Tbl1.Id = TblAreas.Id
						--	 where TblAreas.StructureId = 1

--SELECT       Id, AreaName, MosavabRevenue, MosavabPayMotomarkez, MosavabDar_Khazane,MosavabNeyabati , Resoures, MosavabCurrent, MosavabCivil, MosavabFinancial, MosavabSanavati, balanceMosavab
--FROM            (SELECT        TblAreas.Id, TblAreas.AreaNameShort AS AreaName, 
--                          ISNULL(der_Revenue.MosavabRevenue, 0) AS MosavabRevenue, 
--						  ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0) AS MosavabPayMotomarkez, 
--                          ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) AS MosavabDar_Khazane, 
--                          ISNULL(der_Neyabati.MosavabNeyabati,0) AS MosavabNeyabati ,
--						   ISNULL(der_Revenue.MosavabRevenue, 0) - 
--						   ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0)+ 
--						   ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) + 
--						   ISNULL(der_Neyabati.MosavabNeyabati,0)  AS Resoures, 
--						  ISNULL(der_Current.MosavabCurrent, 0) AS MosavabCurrent, 
--						  ISNULL(der_Civil.MosavabCivil, 0) AS MosavabCivil, 
--						  ISNULL(der_Financial.MosavabFinancial,0) AS MosavabFinancial,
--						  ISNULL(der_Doyon.MosavabSanavati, 0) AS MosavabSanavati, 
--						   ISNULL(der_Revenue.MosavabRevenue, 0) -
--						   ISNULL(der_Current.MosavabCurrent, 0) - 
--						   ISNULL(der_Civil.MosavabCivil, 0) - 
--						   ISNULL(der_Doyon.MosavabSanavati, 0) - 
--						   ISNULL(der_Financial.MosavabFinancial, 0) - 
--						   ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0) +
--						   ISNULL(der_Neyabati.MosavabNeyabati,0) +
--						   ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) AS balanceMosavab 
                        
--FROM            TblAreas LEFT OUTER JOIN
--                             (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.EditArea) AS MosavabNeyabati, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseNeyabati
--                               FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
--                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
--                                                         TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
--                                                         tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
--                                                         TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
--                               WHERE   (tblCoding_4.TblBudgetProcessId = 9) AND
--							           (TblBudgets_4.TblYearId = @YearId)
--                               GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Neyabati ON TblAreas.Id = der_Neyabati.AreaId LEFT OUTER JOIN
--                             (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.EditArea) AS MosavabDar_Khazane, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseDar_Khazane
--                               FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
--                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
--                                                         TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
--                                                         tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
--                                                         TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
--                               WHERE   (tblCoding_4.TblBudgetProcessId=10) AND
--							           (TblBudgets_4.TblYearId = @YearId)
--                               GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Mahromeyat ON TblAreas.Id = der_Mahromeyat.AreaId LEFT OUTER JOIN
--                             (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.EditArea) AS MosavabPayMotomarkez, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpensePayMotomarkez
--                               FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
--                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
--                                                         TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
--                                                         tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
--                                                         TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
--                               WHERE   (tblCoding_4.TblBudgetProcessId = 8) AND
--							           (TblBudgets_4.TblYearId = @YearId)
--                               GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Motomarkez ON TblAreas.Id = der_Motomarkez.AreaId LEFT OUTER JOIN
--                             (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.EditArea) AS MosavabSanavati, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseDoyonSanavatiGhatei
--                               FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
--                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
--                                                         TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
--                                                         tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
--                                                         TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
--                               WHERE   (tblCoding_4.TblBudgetProcessId = 5) AND
--							           (TblBudgets_4.TblYearId = @YearId)
--                               GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Doyon ON TblAreas.Id = der_Doyon.AreaId LEFT OUTER JOIN
--                             (SELECT        tblBudgetDetailProjectArea_3.AreaId, SUM(tblBudgetDetailProjectArea_3.EditArea) AS MosavabFinancial, SUM(tblBudgetDetailProjectArea_3.Expense) AS ExpenseFinancial
--                               FROM            tblBudgetDetailProject AS tblBudgetDetailProject_3 INNER JOIN
--                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_3 ON tblBudgetDetailProject_3.Id = tblBudgetDetailProjectArea_3.BudgetDetailProjectId INNER JOIN
--                                                         TblBudgetDetails AS TblBudgetDetails_3 ON tblBudgetDetailProject_3.BudgetDetailId = TblBudgetDetails_3.Id INNER JOIN
--                                                         tblCoding AS tblCoding_3 ON TblBudgetDetails_3.tblCodingId = tblCoding_3.Id INNER JOIN
--                                                         TblBudgets AS TblBudgets_3 ON TblBudgetDetails_3.BudgetId = TblBudgets_3.Id
--                               WHERE   (tblCoding_3.TblBudgetProcessId = 4) AND
--							           (TblBudgets_3.TblYearId = @YearId)
--                               GROUP BY tblBudgetDetailProjectArea_3.AreaId) AS der_Financial ON TblAreas.Id = der_Financial.AreaId LEFT OUTER JOIN
--                             (SELECT        tblBudgetDetailProjectArea_2.AreaId, SUM(tblBudgetDetailProjectArea_2.EditArea) AS MosavabCivil, SUM(tblBudgetDetailProjectArea_2.Expense) AS ExpenseCivil
--                               FROM            tblBudgetDetailProject AS tblBudgetDetailProject_2 INNER JOIN
--                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_2 ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea_2.BudgetDetailProjectId INNER JOIN
--                                                         TblBudgetDetails AS TblBudgetDetails_2 ON tblBudgetDetailProject_2.BudgetDetailId = TblBudgetDetails_2.Id INNER JOIN
--                                                         tblCoding AS tblCoding_2 ON TblBudgetDetails_2.tblCodingId = tblCoding_2.Id INNER JOIN
--                                                         TblBudgets AS TblBudgets_2 ON TblBudgetDetails_2.BudgetId = TblBudgets_2.Id
--                               WHERE   (tblCoding_2.TblBudgetProcessId = 3) AND
--							           (TblBudgets_2.TblYearId = @YearId)
--                               GROUP BY tblBudgetDetailProjectArea_2.AreaId) AS der_Civil ON TblAreas.Id = der_Civil.AreaId LEFT OUTER JOIN
--                             (SELECT        tblBudgetDetailProjectArea_1.AreaId, SUM(tblBudgetDetailProjectArea_1.EditArea) AS MosavabCurrent, SUM(tblBudgetDetailProjectArea_1.Expense) AS ExpenseCurrent
--                               FROM            tblBudgetDetailProject AS tblBudgetDetailProject_1 INNER JOIN
--                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
--                                                         TblBudgetDetails AS TblBudgetDetails_1 ON tblBudgetDetailProject_1.BudgetDetailId = TblBudgetDetails_1.Id INNER JOIN
--                                                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
--                                                         TblBudgets AS TblBudgets_1 ON TblBudgetDetails_1.BudgetId = TblBudgets_1.Id
--                               WHERE   (tblCoding_1.TblBudgetProcessId = 2) AND
--							           (TblBudgets_1.TblYearId = @YearId)
--                               GROUP BY tblBudgetDetailProjectArea_1.AreaId) AS der_Current ON TblAreas.Id = der_Current.AreaId LEFT OUTER JOIN
--                             (SELECT   tblBudgetDetailProjectArea.AreaId, SUM(tblBudgetDetailProjectArea.EditArea) AS MosavabRevenue, SUM(tblBudgetDetailProjectArea.Expense) AS ExpenseRevenue
--                               FROM            tblBudgetDetailProject INNER JOIN
--                                                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
--                                                         TblBudgetDetails ON tblBudgetDetailProject.BudgetDetailId = TblBudgetDetails.Id INNER JOIN
--                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
--                                                         TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id
--                               WHERE   (tblCoding.TblBudgetProcessId = 1) AND
--							           (TblBudgets.TblYearId = @YearId)
--                               GROUP BY tblBudgetDetailProjectArea.AreaId) AS der_Revenue ON TblAreas.Id = der_Revenue.AreaId
--                        ) AS tbl1 
END
go



------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------
-- 
-- 
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
if(@areaId not in (30,31,32,33,34,35,36)) begin  set @ExecuteId = 8  end
if(@areaId = 30) begin set @areaId=9  set @ExecuteId = 4  end
if(@areaId = 31) begin set @areaId=9  set @ExecuteId = 10 end
if(@areaId = 32) begin set @areaId=9  set @ExecuteId = 2  end
if(@areaId = 33) begin set @areaId=9  set @ExecuteId = 1  end
if(@areaId = 34) begin set @areaId=9  set @ExecuteId = 7  end
if(@areaId = 36) begin set @areaId=9  set @ExecuteId = 6  end



    declare @BudgetId int = (select id from TblBudgets  where TblYearId = @yearId and TblAreaId = 10) 
	declare @ProjectId int 
	if(@BudgetProcessId = 1) begin set @ProjectId = 1 end
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

update tblCoding
set ExecuteId = @ExecuteId
where id = @codingId

END
go




--------------------------------------------
--------------------------------------------
--------------------------------------------
--------------------------------------------
--------------------------------------------




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
                    30,31,32,33,34,35,36,42,43,44,
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
              tbl2.Pishnahadi, tblCoding_4.levelNumber ,tblCoding_4.Crud,ConfirmStatus AS ConfirmStatus
FROM            (SELECT        CodingId, isnull(SUM(Mosavab),0) AS Mosavab, isnull(SUM(EditArea),0) AS Edit ,
                               SUM(Supply) as Supply,isnull(SUM(Expense),0) AS Expense ,isnull(sum(PishnahadiCash),0) as PishnahadiCash,isnull(sum(PishnahadiNonCash),0) as PishnahadiNonCash,isnull(sum(Pishnahadi),0) as Pishnahadi,isnull(min(ConfirmStatus),0) AS ConfirmStatus
                 FROM            (

--سطح اول
                                     SELECT        tblCoding_5.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, 0 AS PishnahadiCash, 0 AS PishnahadiNonCash, 0 AS Pishnahadi,1 AS ConfirmStatus
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
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29)) OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )
                                     UNION ALL
                                     SELECT        tblCoding_5.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus
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
                                     WHERE  (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)  AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                     union all
----------سطح 2	

                                     SELECT        tblCoding_4.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea,
                                                   tblBudgetDetailProjectArea.Supply,tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus
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
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                     UNION ALL

                                     SELECT        tblCoding_4.MotherId AS CodingId, 0 as Mosavab, 0 as EditArea,0 as supply, 0 as Expense , tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus
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
                                     WHERE  (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                     union all

----سطح 3
                                     SELECT        tblCoding_1.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus
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
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                     UNION ALL

                                     SELECT tblCoding_1.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                     WHERE  (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )


--سطح 4
                                     union all
                                     SELECT        tblCoding_3.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus
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
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                     union all
                                     SELECT        tblCoding_3.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                     WHERE  (TblBudgets.TblYearId = @YearId) AND(tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                     UNION ALL
--سطح 5
                                     SELECT        tblCoding_2.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea,
                                                   tblBudgetDetailProjectArea.Supply,tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus
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
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )
                                     UNION ALL
                                     SELECT        tblCoding_2.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus
                                     FROM            TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                     tblCoding AS tblCoding_2 ON tblCoding.MotherId = tblCoding_2.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                     WHERE  (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )
                                     union all
--سطح 6
                                     SELECT        tblCoding_3.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea,
                                                   tblBudgetDetailProjectArea.Supply,tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus
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
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding_3.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding_3.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                     union all
                                     SELECT  tblCoding_3.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea, 0 as supply,0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus
                                     FROM            TblBudgets AS TblBudgets_2 INNER JOIN
                                                     TblBudgetDetails AS TblBudgetDetails_2 ON TblBudgets_2.Id = TblBudgetDetails_2.BudgetId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON TblBudgetDetails_2.tblCodingId = tblCoding_3.Id INNER JOIN
                                                     tblBudgetDetailProject AS tblBudgetDetailProject_2 ON TblBudgetDetails_2.Id = tblBudgetDetailProject_2.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                     WHERE  (TblBudgets_2.TblYearId = @YearId) AND (tblCoding_3.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding_3.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding_3.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                     UNION ALL
--سطح 7
                                     SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea,
                                                   tblBudgetDetailProjectArea.Supply,tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus
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
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding_1.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding_1.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                     union all

                                     SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus
                                     FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                     TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                     tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                     tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
                                     WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding_1.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                             (tblCoding_1.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                         )

                                 ) AS tbl1
                 GROUP BY CodingId) AS tbl2 INNER JOIN
                tblCoding AS tblCoding_4 ON tbl2.CodingId = tblCoding_4.Id
ORDER BY  tblCoding_4.Code,tblCoding_4.levelNumber
    return
end

END
go




