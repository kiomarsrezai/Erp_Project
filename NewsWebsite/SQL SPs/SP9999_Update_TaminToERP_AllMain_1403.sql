USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9999_Update_TaminToERP_AllMain_1403]    Script Date: 08/10/1403 04:33:01 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9999_Update_TaminToERP_AllMain_1403]
@BodgetId      nvarchar(50),
@BodgetDesc    nvarchar(2000),
@BudgetPrice  bigint,
@YearId       int,
@SectionId int,
@TypeCredit int

AS
BEGIN



--declare @id int=(select min(id) from a)
--declare @t int=1
--declare @Count int = (select count(*) from a)
--while @t<=@Count
--begin
--declare @BodgetId      nvarchar(50)   = (select BodgetId      from a where id = @id+@t)
--declare @BodgetDesc    nvarchar(2000) = (select BodgetDesc    from a where id = @id+@t)
--declare @RequestDate   nvarchar(50)   = (select RequestDate   from a where id = @id+@t)
--declare @RequestPrice  bigint         = (select RequestPrice  from a where id = @id+@t)
--declare @ReqDesc       nvarchar(2000) = (select ReqDesc       from a where id = @id+@t)
--declare @RequestRefStr nvarchar(2000) = (select RequestRefStr from a where id = @id+@t)
--declare @SectionId       int          = (select SectionId     from a where id = @id+@t)

declare @udgetProcess int
if(@TypeCredit = 119)    begin set @udgetProcess = 1  end
if(@TypeCredit = 120)    begin set @udgetProcess = 2  end
if(@TypeCredit = 122)    begin set @udgetProcess = 1  end
if(@TypeCredit = 123)    begin set @udgetProcess = 2  end

declare @AreaId int
if(@SectionId = 1)    begin set @areaId = 1  end
if(@SectionId = 2)    begin set @areaId = 2  end
if(@SectionId = 3)    begin set @areaId = 3  end
if(@SectionId = 4)    begin set @areaId = 4  end
if(@SectionId = 5)    begin set @areaId = 5  end
if(@SectionId = 6)    begin set @areaId = 6  end
if(@SectionId = 7)    begin set @areaId = 7  end
if(@SectionId = 8)    begin set @areaId = 8  end
if(@SectionId = 11)   begin set @areaId = 9  end
if(@SectionId = 102)  begin set @areaId = 11 end
if(@SectionId = 114)  begin set @areaId = 12 end
if(@SectionId = 105)  begin set @areaId = 13 end
if(@SectionId = 115)  begin set @areaId = 14 end
if(@SectionId = 112)  begin set @areaId = 15 end
if(@SectionId = 113)  begin set @areaId = 16 end
if(@SectionId = 107)  begin set @areaId = 17 end
if(@SectionId = 108)  begin set @areaId = 18 end
if(@SectionId = 106)  begin set @areaId = 19 end
if(@SectionId = 3034) begin set @areaId = 20 end
if(@SectionId = 109)  begin set @areaId = 21 end
if(@SectionId = 101)  begin set @areaId = 22 end
if(@SectionId = 103)  begin set @areaId = 23 end
if(@SectionId = 104)  begin set @areaId = 24 end
if(@SectionId = 15 )  begin set @areaId = 25 end
if(@SectionId = 110)  begin set @areaId = 26 end
if(@SectionId = 16 )  begin set @areaId = 29 end


declare @codingId int=(Select Id from tblCoding Where Code=@BodgetId)
declare @budgetId int=(Select Id from TblBudgets Where TblAreaId=@SectionId and TblYearId=@YearId)

declare @budgetdetailId int=(Select Id from TblBudgetDetails Where (tblCodingId=@codingId) and (BudgetId=@budgetId))

--declare @countCodeingpid int=(




if @budgetdetailId>0
begin
INSERT INTO tblBudgetDetailProject
( BudgetDetailId, ProgramOperationDetailsId, Mosavab, EditProject, Supply, Takhsis, Expense)
VALUES        (@BudgetDetailId,2,@BudgetPrice,0,0,0,0)

declare @BudgetDetailProjectID int=(select Id from tblBudgetDetailProject where Id=@@identity)

INSERT INTO tblBudgetDetailProjectArea
				(AreaId,BudgetDetailProjectId,Mosavab) Values (@AreaId,@BudgetDetailProjectID,@BudgetPrice)

end

--insert into tblBudgetDetailProject 
--declare @count1 int = (SELECT     count(*)
--FROM            TblBudgets INNER JOIN
--                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
--                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
--WHERE  (TblBudgets.TblYearId = 33) AND
--       (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
--	   (tblCoding.Code = @BodgetId) AND
--	   (tblCoding.TblBudgetProcessId = 2))
--if((@count1>1 or @count1=0) and @AreaId<=9)
--begin
--   select @BodgetId +'   '+@BodgetDesc ,'   '+cast(@count1 as nvarchar(10))+'  '+cast(@AreaId  as nvarchar(10))
--   return
--end

--declare @BudgetDetailProjectAreaId int = (SELECT        tblBudgetDetailProjectArea.id
--FROM            TblBudgets INNER JOIN
--                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
--                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
--WHERE  (TblBudgets.TblYearId = 34) AND
--       (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
--	   (tblCoding.Code = @BodgetId) AND
--	   (tblCoding.TblBudgetProcessId in (2,3)))

--insert into tblRequest (YearId ,  AreaId  ,    Number    , Description,EstimateAmount ,   DateS     , sal )
--                 values(   34  , @AreaId  ,@RequestRefStr,  @ReqDesc  , @RequestPrice ,@RequestDate ,  403   )
--declare @RequestId int = SCOPE_IDENTITY()

--insert into tblRequestBudget( RequestId  ,  BudgetDetailProjectAreaId , RequestBudgetAmount,  BodgetId , BodgetDesc , sal ,AreaId)
--                      values(  @RequestId , @BudgetDetailProjectAreaId ,     @RequestPrice  , @BodgetId , @BodgetDesc, 403  ,@AreaId)
--set @t = @t+1
--end
END
