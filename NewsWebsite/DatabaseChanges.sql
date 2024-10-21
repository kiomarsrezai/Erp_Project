
CREATE TABLE [dbo].[TblAmlakagreementAttachs](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [FileName] [nvarchar](3000) NULL,
    [AmlakInfoId] [int] NULL,
    [FileTitle] [nvarchar](250) NULL,
    [Type] [nvarchar](20) NULL
    ) ON [PRIMARY]
    GO



CREATE TABLE [dbo].[tblAmlakagreement](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [SdiId] [nvarchar](100) NULL,
    [IsSubmitted] [int] NULL,
    [Title] [nvarchar](50) NULL,
    [Date] [datetime] NULL,
    [ContractParty] [nvarchar](50) NULL,
    [AmountMunicipality] [nvarchar](50) NULL,
    [AmountContractParty] [nvarchar](50) NULL,
    [DateFrom] [datetime] NULL,
    [DateTo] [datetime] NULL,
    [Description] [nvarchar](500) NULL,
    [Coordinates] [varchar](500) NULL,
    [Address] [nvarchar](150) NULL,
    [CreatedAt] [datetime] NULL,
    [UpdatedAt] [datetime] NULL,
    CONSTRAINT [PK_tblAmlakagreement] PRIMARY KEY CLUSTERED
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO



add Title to amlakArchive nvarchar(250)
    
add OwnerId in tblAmlakInfo default 0
add Coordinates in tblAmlakInfo
remove lat , lng ,IsContracted in tblAmlakInfo
change owner to ownerType

change SajamCode to JamCode in tblAmlakPrivateNew




ALTER TABLE tblAmlakPrivateNew
    ADD
        MainPlateNumber NVARCHAR(50),
    SubPlateNumber NVARCHAR(50),
    Section NVARCHAR(50),
    Address NVARCHAR(50),
    UsageOnDocument NVARCHAR(50),
    PropertyType NVARCHAR(50),
    OwnershipType NVARCHAR(50),
    OwnershipPercentage NVARCHAR(50),
    TransferredFrom NVARCHAR(50),
    InPossessionOf NVARCHAR(50),
    UsageUrban NVARCHAR(50),
    BlockedStatusSimakUnitWindow NVARCHAR(50),
    Status NVARCHAR(50),
    Notes NVARCHAR(50),
    ArchiveLocation NVARCHAR(50),
    DocumentSerial NVARCHAR(50),
    DocumentSeries NVARCHAR(50),
    DocumentAlphabet NVARCHAR(50),
    PropertyCode NVARCHAR(50),
    Year NVARCHAR(50),
    EntryDate NVARCHAR(50),
    InternalDate NVARCHAR(50),
    ProductiveAssetStrategies NVARCHAR(50),
    SimakCode NVARCHAR(50);


add SdiPlateNumber to tblAmlakPrivateNew  NVARCHAR(50)
change type of  Masahat to float  NVARCHAR(50)

update tblAmlakPrivateNew
set SdiPlateNumber=SadaCode

update tblAmlakPrivateNew
set SadaCode=''




-----------------

CREATE FUNCTION [dbo].[fn_SplitString] 
(
    @String NVARCHAR(MAX), 
    @Delimiter CHAR(1)
)   
RETURNS @OutputTable TABLE (Id INT)
AS
BEGIN
    DECLARE @start INT, @end INT
    SET @start = 1
    SET @end = CHARINDEX(@Delimiter, @String)

    WHILE @start < LEN(@String) + 1 BEGIN
        IF @end = 0 
            SET @end = LEN(@String) + 1

        INSERT INTO @OutputTable (Id)
        VALUES (CAST(SUBSTRING(@String, @start, @end - @start) AS INT))

        SET @start = @end + 1
        SET @end = CHARINDEX(@Delimiter, @String, @start)
END

    RETURN
END





USE [ProgramBudDB]
GO

/****** Object:  StoredProcedure [dbo].[SP9000_Mapping_Rows_Delete]    Script Date: 10/20/2024 1:06:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9000_Mapping_Rows_Delete]
@Ids NVARCHAR(MAX)
AS
BEGIN
DELETE FROM TblCodingsMapSazman
WHERE Id IN (SELECT Id FROM dbo.fn_SplitString(@Ids, ','))
END
GO




USE [ProgramBudDB]
GO

/****** Object:  Table [dbo].[tblBudgetAreaShare]    Script Date: 10/20/2024 2:59:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblBudgetAreaShare](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [AreaId] [int] NULL,
    [YearId] [int] NULL,
    [ShareProcessId1] [bigint] NULL,
    [ShareProcessId2] [bigint] NULL,
    [ShareProcessId3] [bigint] NULL,
    [ShareProcessId4] [bigint] NULL,
    CONSTRAINT [PK_tblBudgetAreaShare] PRIMARY KEY CLUSTERED
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO





update SP002_BudgetSepratorArea_Acc_Modal   
            add (, tblBudgetDetailProject.programOperationDetailsId as programOperationDetailsId)  to selects
                                                                                                        

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_BudgetSepratorArea_Acc_Modal]
@areaId int,
@yearId int,
@codingId int,
@KindId tinyint
AS
BEGIN
--kind = 1 نمایش تامین اعتبارات
--kind = 2 نمایش اسناد حسابداری
declare @YearName int =(SELECT YearName FROM TblYears WHERE Id = @yearId)
declare @StructureId tinyint = (SELECT StructureId FROM TblAreas where id = @areaId)

if(@KindId = 1)
begin
SELECT        tblRequest.Number as NumberSanad, tblRequest.DateS as DateSanad, tblRequest.Description, tblRequest.EstimateAmount as Expense , tblBudgetDetailProject.programOperationDetailsId as programOperationDetailsId
FROM            TblBudgets INNER JOIN
                TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                tblRequestBudget ON tblBudgetDetailProjectArea.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                tblRequest ON tblRequestBudget.RequestId = tblRequest.Id
WHERE  (TblBudgets.TblYearId = @yearId) AND
    (TblBudgetDetails.tblCodingId = @codingId) AND
    (tblBudgetDetailProjectArea.AreaId = @areaId)
    return
end

if(@KindId = 2 and @StructureId = 1)
begin
SELECT        olden.tblSanad_MD.Id as NumberSanad, olden.tblSanad_MD.SanadDateS as DateSanad, olden.tblSanadDetail_MD.Description, olden.tblSanadDetail_MD.Bedehkar - olden.tblSanadDetail_MD.Bestankar AS Expense, tblBudgetDetailProject.programOperationDetailsId as programOperationDetailsId
FROM            TblBudgetDetails INNER JOIN
                TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id AND TblBudgetDetails.BudgetId = TblBudgets.Id AND TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
                tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id AND TblBudgetDetails.tblCodingId = tblCoding.Id AND TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                olden.tblSanadDetail_MD INNER JOIN
                olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id ON TblCodingsMapSazman.CodeVasetShahrdari = olden.tblSanadDetail_MD.CodeVasetShahrdari INNER JOIN
                tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId AND TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId AND
                                          TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId AND tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId AND
                                              tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (olden.tblSanad_MD.AreaId = @areaId) AND
    (olden.tblSanad_MD.YearName = @YearName) AND
    (olden.tblSanadDetail_MD.AreaId = @areaId) AND
    (olden.tblSanadDetail_MD.YearName = @YearName) AND
    (TblBudgets.TblYearId = @yearId) AND
    (TblCodingsMapSazman.YearId = @yearId) AND
    (TblCodingsMapSazman.AreaId = @areaId) AND
    (TblBudgetDetails.tblCodingId = @codingId) AND
    (tblBudgetDetailProjectArea.AreaId = @areaId)
ORDER BY olden.tblSanad_MD.Id, olden.tblSanad_MD.SanadDateS
    return
end

if(@KindId = 2 and  @StructureId = 2)
begin
SELECT        olden.tblSanad_MD.Id AS NumberSanad, olden.tblSanad_MD.SanadDateS AS DateSanad, olden.tblSanadDetail_MD.Description, olden.tblSanadDetail_MD.Bedehkar - olden.tblSanadDetail_MD.Bestankar AS Expense, tblBudgetDetailProject.programOperationDetailsId as programOperationDetailsId
FROM            TblBudgetDetails INNER JOIN
                TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id AND TblBudgetDetails.BudgetId = TblBudgets.Id AND TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
                tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id AND TblBudgetDetails.tblCodingId = tblCoding.Id AND TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                olden.tblSanadDetail_MD INNER JOIN
                olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id ON TblCodingsMapSazman.CodeAcc = olden.tblSanadDetail_MD.CodeVasetSazman INNER JOIN
                tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId AND tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId AND
                                              tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id INNER JOIN
                olden.tblGroup ON olden.tblKol.IdGroup = olden.tblGroup.Id
WHERE    (olden.tblSanad_MD.AreaId = @areaId) AND
    (olden.tblSanad_MD.YearName = @YearName) AND
    (olden.tblSanadDetail_MD.AreaId = @areaId) AND
    (olden.tblSanadDetail_MD.YearName = @YearName) AND
    (TblBudgets.TblYearId = @yearId) AND
    (tblBudgetDetailProjectArea.AreaId = @areaId) AND
    (TblCodingsMapSazman.YearId = @yearId) AND
    (TblCodingsMapSazman.AreaId = @areaId) AND
    (TblBudgetDetails.tblCodingId = @codingId) AND
    (olden.tblKol.AreaId = @areaId) AND
    (olden.tblKol.YearName = @YearName) AND
    (olden.tblGroup.AreaId = @areaId) AND
    (olden.tblGroup.YearName = @YearName)
ORDER BY NumberSanad, DateSanad
    return
end




END
go
















update SP001_Budget_Inline_Insert
        disable line 69 if


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
@ProgramOperationDetailsId int
 
AS
BEGIN
--if(@yearId<>34) begin  select 'برای سال 1403 مجاز هستید' as Message_DB  return end

declare @ExecuteId int
if(@areaId not in (30,31,32,33,34,35,36)) begin  set @ExecuteId = 8  end
if(@areaId = 30) begin set @areaId=9  set @ExecuteId = 4  end
if(@areaId = 31) begin set @areaId=9  set @ExecuteId = 10 end
if(@areaId = 32) begin set @areaId=9  set @ExecuteId = 2  end
if(@areaId = 33) begin set @areaId=9  set @ExecuteId = 1  end
if(@areaId = 34) begin set @areaId=9  set @ExecuteId = 3  end
if(@areaId = 35) begin set @areaId=9  set @ExecuteId = 7  end
if(@areaId = 36) begin set @areaId=9  set @ExecuteId = 6  end




    declare @budgetId        int      = (select Id from TblBudgets where TblYearId = @yearId and TblAreaId = @areaId)
    declare @LevelNumber   tinyint    = (select levelNumber from tblCoding where id = @CodingId)
	declare @MotherId        int      = (select MotherId from tblCoding where id = @CodingId)
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
select 'خطا' as Message_DB
    return
end
	declare @MaxCode2 nvarchar(20)= cast(@MaxCode as bigint)+1 

	
	declare @ProjectId int 
	if(@BudgetProcessId = 1)         begin set @ProjectId = 1 end
	if(@BudgetProcessId = 2)         begin set @ProjectId = 2 end
	if(@BudgetProcessId in (3,4,5))  begin set @ProjectId = 3 end
	
	
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

insert into tblBudgetDetailProjectArea( BudgetDetailProjectId ,  AreaId ,  Mosavab )
							    values(@BudgetDetailProjectId , @areaId , @Mosavab )

return






END
go







--------------------------------