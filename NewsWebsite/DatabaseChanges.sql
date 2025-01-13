USE [ProgramBudDB]
GO

/****** Object:  Table [dbo].[tblBudgetLogs]    Script Date: 1/13/2025 6:08:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblBudgetLogs](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [TargetId] [int] NULL,
    [TargetType] [int] NULL,
    [Date] [datetime] NULL,
    [AdminId] [int] NULL,
    [Description] [nvarchar](500) NULL,
    [Coding] [nvarchar](50) NULL,
    [Url] [nvarchar](100) NULL,
    [Ip] [nvarchar](50) NULL,
    [Device] [nvarchar](500) NULL,
    CONSTRAINT [PK_tblLogs] PRIMARY KEY CLUSTERED
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
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

select @MaxCode2 as NewCode;
return
END
go




