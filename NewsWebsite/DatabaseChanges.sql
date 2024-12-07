USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP005_Report_ProjectScale]    Script Date: 12/7/2024 5:24:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP005_Report_ProjectScale]
@yearId int ,
@areaId int ,
@scaleId tinyint
AS
BEGIN
if(@areaId<>10)
begin
SELECT        tbl2.TblProjectId AS ProjectId, tbl2.AreaId, TblAreas.AreaNameShort AS AreaName, TblProjects.ProjectCode, TblProjects.ProjectName, tbl2.Mosavab, tbl2.Edit, tbl2.Supply, tbl2.Expense, tbl2.BudgetNext
FROM            (SELECT        TblProjectId, AreaId, SUM(Mosavab) AS Mosavab, SUM(EditArea) AS Edit, SUM(Supply) AS Supply, SUM(Expense) AS Expense, SUM(BudgetNext) AS BudgetNext
                 FROM            (SELECT        TblProgramOperationDetails.TblProjectId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense, 0 AS BudgetNext
                                  FROM            TblBudgets INNER JOIN
                                                  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id INNER JOIN
                                                  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                  TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id
                                  WHERE  (TblBudgets.TblYearId = @yearId - 1) AND
                                      (tblBudgetDetailProjectArea.AreaId = @areaId) AND
                                      (tblCoding.TblBudgetProcessId = 3) AND
                                      (TblProjects.ProjectScaleId = @scaleId)
                                  UNION ALL
                                  SELECT        TblProgramOperationDetails_1.TblProjectId, tblBudgetDetailProjectArea_1.AreaId, 0 AS Mosavab, 0 AS EditArea, 0 AS Supply, 0 AS Expense, tblBudgetDetailProjectArea_1.Pishnahadi AS Expr1
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                  TblProgramOperationDetails AS TblProgramOperationDetails_1 ON tblBudgetDetailProject_1.ProgramOperationDetailsId = TblProgramOperationDetails_1.Id INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  TblProjects ON TblProgramOperationDetails_1.TblProjectId = TblProjects.Id
                                  WHERE   (TblBudgets_1.TblYearId = @yearId) AND
                                      (tblBudgetDetailProjectArea_1.AreaId = @areaId) AND
                                      (tblCoding_1.TblBudgetProcessId = 3) AND
                                      (TblProjects.ProjectScaleId = @scaleId)
                                 ) AS tbl1
                 GROUP BY TblProjectId, AreaId) AS tbl2 INNER JOIN
                TblProjects ON tbl2.TblProjectId = TblProjects.Id INNER JOIN
                TblAreas ON tbl2.AreaId = TblAreas.Id
    return
end

if(@areaId=10)
begin
SELECT        tbl2.TblProjectId AS ProjectId, tbl2.AreaId, TblAreas_1.AreaNameShort AS AreaName, TblProjects.ProjectCode, TblProjects.ProjectName, tbl2.Mosavab, tbl2.Edit, tbl2.Supply, tbl2.Expense, tbl2.BudgetNext
FROM            (SELECT        TblProjectId, AreaId, SUM(Mosavab) AS Mosavab, SUM(EditArea) AS Edit, SUM(Supply) AS Supply, SUM(Expense) AS Expense, SUM(BudgetNext) AS BudgetNext
                 FROM            (SELECT        TblProgramOperationDetails.TblProjectId, tblBudgetDetailProjectArea.AreaId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,
                                                tblBudgetDetailProjectArea.Expense, 0 AS BudgetNext
                                  FROM            TblBudgets INNER JOIN
                                                  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id INNER JOIN
                                                  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id INNER JOIN
                                                  TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id
                                  WHERE   (TblBudgets.TblYearId = @yearId - 1) AND
                                      (tblCoding.TblBudgetProcessId = 3) AND
                                      (TblAreas.StructureId = 1) AND
                                      (TblProjects.ProjectScaleId = @scaleId)
                                  UNION ALL
                                  SELECT        TblProgramOperationDetails_1.TblProjectId, tblBudgetDetailProjectArea_1.AreaId, 0 AS Mosavab, 0 AS EditArea, 0 AS Supply, 0 AS Expense, tblBudgetDetailProjectArea_1.Mosavab AS Expr1
                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                  TblProgramOperationDetails AS TblProgramOperationDetails_1 ON tblBudgetDetailProject_1.ProgramOperationDetailsId = TblProgramOperationDetails_1.Id INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  TblAreas AS TblAreas_2 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_2.Id INNER JOIN
                                                  TblProjects ON TblProgramOperationDetails_1.TblProjectId = TblProjects.Id
                                  WHERE   (TblBudgets_1.TblYearId = @yearId) AND
                                      (tblCoding_1.TblBudgetProcessId = 3) AND
                                      (TblAreas_2.StructureId = 1) AND
                                      (TblProjects.ProjectScaleId = @scaleId)
                                 ) AS tbl1
                 GROUP BY TblProjectId, AreaId) AS tbl2 INNER JOIN
                TblProjects ON tbl2.TblProjectId = TblProjects.Id INNER JOIN
                TblAreas AS TblAreas_1 ON tbl2.AreaId = TblAreas_1.Id
    return
end

END



















-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetModal2Project_Update]
--@areaGlobalId int,
--@yearId int ,
--@codingId int,
--@projectId int,
--@areaId int,
@Mosavab bigint,
@EditProject bigint,
@Id int,
@areaId int,
@ProjectCode int

AS
BEGIN
--declare @Count int = (SELECT count(*)
--							FROM TblBudgets INNER JOIN
--								 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--								 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--								 TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id
--							   WHERE (TblBudgets.TblYearId = @yearId) AND
--							         (TblBudgets.TblAreaId = @areaId) AND
--									 (TblBudgetDetails.tblCodingId = @codingId) AND
--									 (TblProgramOperationDetails.TblProjectId = @projectId))
--if (@Count = 0)
-- begin
--     select 'رکوردی موجود نیست' as Message
--	 return
-- end

--if (@Count > 1)
-- begin
--     select ' تعداد رکورد موجود مجاز نیست' as Message
--	 return
-- end

--if (@Count = 1)
-- begin
--declare @Id int = (SELECT  tblBudgetDetailProject.Id
--							FROM TblBudgets INNER JOIN
--								 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--								 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--								 TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id
--							   WHERE (TblBudgets.TblYearId = @yearId) AND
--							         (TblBudgets.TblAreaId = @areaId) AND
--									 (TblBudgetDetails.tblCodingId = @codingId) AND
--									 (TblProgramOperationDetails.TblProjectId = @projectId))
--end
--declare @BudgetDetailProjectId int= (SELECT        tblBudgetDetailProject.Id
--										FROM            TblBudgets INNER JOIN
--																 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--																 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--																 TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id INNER JOIN
--																 TblProgramOperations ON TblProgramOperationDetails.TblProgramOperationId = TblProgramOperations.Id
--                                    WHERE (TblBudgets.TblYearId = @yearId) AND
--									      (TblBudgets.TblAreaId = @areaGlobalId) AND
--										  (TblBudgetDetails.tblCodingId = @codingId) AND
--										  (TblProgramOperationDetails.TblProjectId = @projectId) AND
--										  (TblProgramOperations.TblAreaId = @areaId))



declare @ProgramOperationDetailsIdCount int= (SELECT        count(*)
										FROM            TblProgramOperationDetails INNER JOIN
                                                        TblProjects ON TblProjects.Id = TblProgramOperationDetails.TblProjectId INNER JOIN
                                                        TblProgramOperations ON TblProgramOperations.Id = TblProgramOperationDetails.TblProgramOperationId 
                                   WHERE (TblProjects.ProjectCode = @ProjectCode) AND
                                          (TblProgramOperations.TblAreaId = @areaId) AND
                                          (TblProgramOperations.TblProgramId = 10)
                                   )
if(@ProgramOperationDetailsIdCount!=1)
begin

select CONCAT('رکوردی با کد پروژه موجود نیست' ,@ProgramOperationDetailsIdCount) as Message_DB
    return
end
    
declare @ProgramOperationDetailsId int= (SELECT        TblProgramOperationDetails.Id
										FROM            TblProgramOperationDetails INNER JOIN
                                                        TblProjects ON TblProjects.Id = TblProgramOperationDetails.TblProjectId  INNER JOIN
                                                        TblProgramOperations ON TblProgramOperations.Id = TblProgramOperationDetails.TblProgramOperationId 
                                   WHERE (TblProjects.ProjectCode = @ProjectCode) AND
                                             (TblProgramOperations.TblAreaId = @areaId) AND
                                             (TblProgramOperations.TblProgramId = 10))

update tblBudgetDetailProject
set Mosavab = @Mosavab ,
    EditProject = @EditProject,
    ProgramOperationDetailsId=@ProgramOperationDetailsId
where id = @Id

END
go





---------------------------------
---------------------------------
---------------------------------
---------------------------------
---------------------------------
---------------------------------
---------------------------------


USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_Budget_Inline_Insert]    Script Date: 12/7/2024 1:37:29 PM ******/
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







--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------
--------------------------------------



USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP004_BudgetProposal_Inline_Delete]    Script Date: 12/1/2024 10:55:20 AM ******/
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


delete tblBudgetDetailProjectArea
where id in (SELECT  tblBudgetDetailProjectArea.id
											FROM     TblBudgets INNER JOIN
													 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
													 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
													 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
											WHERE   (TblBudgets.TblYearId = @yearId) AND
											        (tblBudgetDetailProjectArea.AreaId = @areaId) AND
													(TblBudgetDetails.tblCodingId = @CodingId))

    declare @remainAreaRowCount int = (SELECT  count(*) as c
                                       FROM     TblBudgets INNER JOIN
                                                TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
                                       WHERE   (TblBudgets.TblYearId = @yearId) AND
                                           (TblBudgetDetails.tblCodingId = @CodingId))
    
    if(@remainAreaRowCount=0)
begin
        
        delete tblBudgetDetailProject
        where id in (SELECT        tblBudgetDetailProject.Id
        FROM            TblBudgets INNER JOIN
                                TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId
        WHERE  (TblBudgets.TblYearId = @yearId) AND
              (TblBudgetDetails.tblCodingId = @CodingId))

end




END




-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-----------------------------------------------



USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_Budget_Inline_Insert]    Script Date: 12/1/2024 10:56:25 AM ******/
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

insert into tblBudgetDetailProjectArea( BudgetDetailProjectId ,  AreaId ,  Mosavab ,Pishnahadi)
							    values(@BudgetDetailProjectId , @areaId , @Mosavab ,@Pishnahadi)

return






END









