ALTER TABLE tblContractAmlakInfoChecks ADD Issuer VARCHAR(255);
ALTER TABLE tblContractAmlakInfoChecks ADD IssuerBank VARCHAR(255);
ALTER TABLE tblContractAmlakInfoChecks ADD CheckType INT;
ALTER TABLE tblContractAmlakInfoChecks ADD IsSubmitted INT;
update tblContractAmlakInfoChecks set IsSubmitted=0 , Issuer=0,IssuerBank=0,CheckType=1
change ispassed to PassStatus
       
       
ALTER TABLE tblAmlakInfo ADD Code VARCHAR(50);


USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_ProgramBudget_Report]    Script Date: 11/6/2024 12:48:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP001_ProgramBudget_Report]
@yearId int ,
@areaId int,
@BudgetProcessId tinyint,
@programId int,
@programDetailsId1 int,
@programDetailsId2 int,
@programDetailsId3 int
AS
BEGIN


if(@areaId IN (1,2,3,4,5,6,7,8,9))
begin

SELECT        tblCoding.Id, tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab,  tblBudgetDetailProjectArea.ProgramDetailsId ,
              CONCAT(p1.Code,p2.Code,p3.Code) AS ProgramCode, p1.Color AS ProgramColor,p3.Name AS ProgramName,
              tblBudgetDetailProjectArea.Id AS BDPAId


FROM            TblBudgets INNER JOIN
                TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id

                           LEFT JOIN TblProgramDetails AS p3 ON p3.Id = tblBudgetDetailProjectArea.ProgramDetailsId
                           LEFT JOIN TblProgramDetails AS p2 ON p2.Id = p3.MotherId
                           LEFT JOIN TblProgramDetails AS p1 ON p1.Id = p2.MotherId



WHERE        (TblBudgets.TblYearId = @yearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)

  AND
    (
            ( tblBudgetDetailProjectArea.AreaId= @areaId AND @areaId IN (1,2,3,4,5,6,7,8,9)) OR
            (TblAreas.StructureId=1 AND @areaId IN (10)) OR
            (TblAreas.StructureId=2 AND @areaId IN (39)) OR
            (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
            (TblAreas.ToGetherBudget =84 AND @areaId IN (41))
        )

  AND (
        (@programId!=0 AND @programDetailsId1!=0 AND @programDetailsId2!=0 AND @programDetailsId3!=0 And p3.Id = @programDetailsId3) OR
        (@programId!=0 AND @programDetailsId1!=0 AND @programDetailsId2!=0 AND @programDetailsId3=0 And p2.Id = @programDetailsId2) OR
        (@programId!=0 AND @programDetailsId1!=0 AND @programDetailsId2=0 AND @programDetailsId3=0 And p1.Id = @programDetailsId1) OR
        (@programId!=0 AND @programDetailsId1=0 AND @programDetailsId2=0 AND @programDetailsId3=0 And p1.ProgramId = @programId)

    )

order by tblCoding.Code

END





if(@areaId IN (10,39,40,41))
begin

SELECT        tblCoding.Id, tblCoding.Code, tblCoding.Description, sum (tblBudgetDetailProjectArea.Mosavab) as Mosavab,
              0 as ProgramDetailsId ,'' AS ProgramCode, '' AS ProgramColor, '' AS ProgramName,0 AS BDPAId

FROM            TblBudgets INNER JOIN
                TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id

                           LEFT JOIN TblProgramDetails AS p3 ON p3.Id = tblBudgetDetailProjectArea.ProgramDetailsId
                           LEFT JOIN TblProgramDetails AS p2 ON p2.Id = p3.MotherId
                           LEFT JOIN TblProgramDetails AS p1 ON p1.Id = p2.MotherId



WHERE        (TblBudgets.TblYearId = @yearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)

  AND
    (
            ( tblBudgetDetailProjectArea.AreaId= @areaId AND @areaId IN (1,2,3,4,5,6,7,8,9)) OR
            (TblAreas.StructureId=1 AND @areaId IN (10)) OR
            (TblAreas.StructureId=2 AND @areaId IN (39)) OR
            (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
            (TblAreas.ToGetherBudget =84 AND @areaId IN (41))
        )

  AND (
        (@programId!=0 AND @programDetailsId1!=0 AND @programDetailsId2!=0 AND @programDetailsId3!=0 And p3.Id = @programDetailsId3) OR
        (@programId!=0 AND @programDetailsId1!=0 AND @programDetailsId2!=0 AND @programDetailsId3=0 And p2.Id = @programDetailsId2) OR
        (@programId!=0 AND @programDetailsId1!=0 AND @programDetailsId2=0 AND @programDetailsId3=0 And p1.Id = @programDetailsId1) OR
        (@programId!=0 AND @programDetailsId1=0 AND @programDetailsId2=0 AND @programDetailsId3=0 And p1.ProgramId = @programId)

    )

group by
    tblCoding.Id, tblCoding.Code, tblCoding.Description

order by tblCoding.Code


END




END




-----------------------------------------------------------------------


USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal1Coding_Insert]    Script Date: 11/6/2024 3:28:41 PM ******/
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
          SET @BudgetDetailId = (SELECT        TblBudgetDetails.Id
                                FROM     TblBudgetDetails INNER JOIN
                                         TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id
                                WHERE   (TblBudgets.TblYearId = @yearId) AND
                                  -- (tblBudgetDetailProjectArea.AreaId = @areaId) AND
                                    (TblBudgetDetails.tblCodingId = @codingId))
-- 	     select 'آی دی کد بودجه تکراری است' as Message_DB
-- 		 return
end


    declare @Hcode nvarchar(20)=(select Code from tblCoding where id = @codingId)
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




USE [ProgramBudDB]
GO

/****** Object:  Table [dbo].[tblContractAmlakInfoNotices]    Script Date: 11/7/2024 10:33:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblContractAmlakInfoNotices](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [AmlakInfoContractId] [int] NULL,
    [Title] [int] NULL,
    [Date] [datetime] NULL,
    [LetterNumber] [nvarchar](50) NULL,
    [Description] [nvarchar](500) NULL,
    [CreatedAt] [datetime] NULL,
    [UpdatedAt] [datetime] NULL,
    CONSTRAINT [PK_tblContractAmlakInfoNotices] PRIMARY KEY CLUSTERED
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO


-------------------------------------

add status int to tblContractAmlakInfo

update tblContractAmlakInfo set Status=1



