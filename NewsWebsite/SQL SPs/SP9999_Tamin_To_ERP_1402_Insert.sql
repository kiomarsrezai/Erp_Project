USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9999_Tamin_To_ERP_1402_Insert]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9999_Tamin_To_ERP_1402_Insert]
@BodgetId      nvarchar(50),
@BodgetDesc    nvarchar(2000),
@RequestDate   nvarchar(50),
@RequestPrice  bigint,
@ReqDesc       nvarchar(2000),
@RequestRefStr nvarchar(50),
@SectionId int

AS
BEGIN
---------------------------
declare @AreaId int
declare @DepartmentId int

if(@SectionId = 1)    begin set @areaId = 1  set @DepartmentId = 4  end
if(@SectionId = 2)    begin set @areaId = 2  set @DepartmentId = 5  end
if(@SectionId = 3)    begin set @areaId = 3  set @DepartmentId = 6  end
if(@SectionId = 4)    begin set @areaId = 4  set @DepartmentId = 7  end
if(@SectionId = 5)    begin set @areaId = 5  set @DepartmentId = 8  end
if(@SectionId = 6)    begin set @areaId = 6  set @DepartmentId = 9  end
if(@SectionId = 7)    begin set @areaId = 7  set @DepartmentId = 10 end
if(@SectionId = 8)    begin set @areaId = 8  set @DepartmentId = 11 end
if(@SectionId = 11)   begin set @areaId = 9  set @DepartmentId = 213 end
if(@SectionId = 102)  begin set @areaId = 11 set @DepartmentId = 214 end
if(@SectionId = 114)  begin set @areaId = 12 set @DepartmentId = 215 end
if(@SectionId = 105)  begin set @areaId = 13 set @DepartmentId = 216 end
if(@SectionId = 115)  begin set @areaId = 14 set @DepartmentId = 217 end
if(@SectionId = 112)  begin set @areaId = 15 set @DepartmentId = 218 end
if(@SectionId = 113)  begin set @areaId = 16 set @DepartmentId = 219 end
if(@SectionId = 107)  begin set @areaId = 17 set @DepartmentId = 220 end
if(@SectionId = 108)  begin set @areaId = 18 set @DepartmentId = 221 end
if(@SectionId = 106)  begin set @areaId = 19 set @DepartmentId = 222 end
if(@SectionId = 3034) begin set @areaId = 20 set @DepartmentId = 223 end
if(@SectionId = 109)  begin set @areaId = 21 set @DepartmentId = 224 end
if(@SectionId = 101)  begin set @areaId = 22 set @DepartmentId = 225 end
if(@SectionId = 103)  begin set @areaId = 23 set @DepartmentId = 226 end
if(@SectionId = 104)  begin set @areaId = 24 set @DepartmentId = 227 end
if(@SectionId = 15 )  begin set @areaId = 25 set @DepartmentId = 228 end
if(@SectionId = 110)  begin set @areaId = 26 set @DepartmentId = 229 end
if(@SectionId = 16 )  begin set @areaId = 29 set @DepartmentId = 230 end

declare @count int = (SELECT  COUNT(*) 
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
WHERE   (TblBudgets.TblYearId = 33) AND
        (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
		(tblCoding.Code = @BodgetId) AND
		(tblCoding.TblBudgetProcessId IN (2, 3, 4, 5)) )
if(@count>1 or @count=0)
begin
insert into aa1402 ( BodgetId , BodgetDesc , countt  ,AreaId  , RequestRefStr , RequestDate)
             values(@BodgetId ,@BodgetDesc , @count ,@AreaId ,@RequestRefStr ,@RequestDate)
return
end

if(@count=1)
begin
declare @BudgetDetailProjectAreaId int = (SELECT tblBudgetDetailProjectArea.id
											FROM   TblBudgets INNER JOIN
												   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
												   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
												   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
												   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
											WHERE  (TblBudgets.TblYearId = 33) AND
												   (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
												   (tblCoding.Code = @BodgetId) AND
												   (tblCoding.TblBudgetProcessId in (2,3,4,5)))

insert into tblRequest (YearId ,  AreaId  ,    Number    , Description,EstimateAmount ,   DateS     ,  sal , DepartmentId )
                 values(   33  , @AreaId  ,@RequestRefStr,  @ReqDesc  , @RequestPrice ,@RequestDate ,  402 ,@DepartmentId )
declare @RequestId int = SCOPE_IDENTITY()

insert into tblRequestBudget( RequestId  ,  BudgetDetailProjectAreaId , RequestBudgetAmount,  BodgetId , BodgetDesc , sal , AreaId)
                      values( @RequestId , @BudgetDetailProjectAreaId ,     @RequestPrice  , @BodgetId , @BodgetDesc, 402 ,@AreaId)
end

END






















GO
