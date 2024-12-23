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
