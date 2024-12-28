USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9999_CompareAndUpdateBudgets_TaminToERP_1403]    Script Date: 08/10/1403 04:32:40 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9999_CompareAndUpdateBudgets_TaminToERP_1403]
--@BodgetDesc    nvarchar(2000),--@RequestDate   nvarchar(50),--@RequestPrice  bigint,--@ReqDesc       nvarchar(2000),--@RequestRefStr nvarchar(2000),--@SectionId int
AS
BEGIN

declare @AreaId int

declare @NotCounterBudget bigint=0;

declare @BudgetCounter int=(select min(Id) from TAN.PortalTamin.dbo.Tbl_Bodgets Where (Year_mosavab = 1403) AND (TakhsisNumber IS NULL)) 
while @BudgetCounter IS NOT NULL
begin

declare @BodgetId nvarchar(50)=(select BodgetId from TAN.PortalTamin.dbo.Tbl_Bodgets Where (id = @BudgetCounter))
--declare @SectionId int=(select SectionId from TAN.PortalTamin.dbo.Tbl_Bodgets Where (id = @BudgetCounter))

--if(@SectionId = 1)    begin set @areaId = 1  end
--if(@SectionId = 2)    begin set @areaId = 2  end
--if(@SectionId = 3)    begin set @areaId = 3  end
--if(@SectionId = 4)    begin set @areaId = 4  end
--if(@SectionId = 5)    begin set @areaId = 5  end
--if(@SectionId = 6)    begin set @areaId = 6  end
--if(@SectionId = 7)    begin set @areaId = 7  end
--if(@SectionId = 8)    begin set @areaId = 8  end
--if(@SectionId = 11)   begin set @areaId = 9  end
--if(@SectionId = 102)  begin set @areaId = 11 end
--if(@SectionId = 114)  begin set @areaId = 12 end
--if(@SectionId = 105)  begin set @areaId = 13 end
--if(@SectionId = 115)  begin set @areaId = 14 end
--if(@SectionId = 112)  begin set @areaId = 15 end
--if(@SectionId = 113)  begin set @areaId = 16 end
--if(@SectionId = 107)  begin set @areaId = 17 end
--if(@SectionId = 108)  begin set @areaId = 18 end
--if(@SectionId = 106)  begin set @areaId = 19 end
--if(@SectionId = 3034) begin set @areaId = 20 end
--if(@SectionId = 109)  begin set @areaId = 21 end
--if(@SectionId = 101)  begin set @areaId = 22 end
--if(@SectionId = 103)  begin set @areaId = 23 end
--if(@SectionId = 104)  begin set @areaId = 24 end
--if(@SectionId = 15 )  begin set @areaId = 25 end
--if(@SectionId = 110)  begin set @areaId = 26 end
--if(@SectionId = 16 )  begin set @areaId = 29 end


declare @butIDnOT int= (select count(Code) from tblCoding where Code = @BodgetId)
declare @bodid nvarchar(50)= (select Code from tblCoding where Code = @BodgetId)

if @butIDnOT=0 begin print @BodgetId; set @NotCounterBudget=@BodgetId;  end



select @BudgetCounter= min(Id) from TAN.PortalTamin.dbo.Tbl_Bodgets Where (Id>@BudgetCounter)
end
























END
--declare @BodgetDesc    nvarchar(2000) = (select BodgetDesc    from a where id = @id+@t)
--declare @RequestDate   nvarchar(50)   = (select RequestDate   from a where id = @id+@t)
--declare @RequestPrice  bigint         = (select RequestPrice  from a where id = @id+@t)
--declare @ReqDesc       nvarchar(2000) = (select ReqDesc       from a where id = @id+@t)
--declare @RequestRefStr nvarchar(2000) = (select RequestRefStr from a where id = @id+@t)
--declare @SectionId       int          = (select SectionId     from a where id = @id+@t)



--declare @BudgetDetailProjectAreaId int = (SELECT        tblBudgetDetailProjectArea.id
--FROM TblBudgets INNER JOIN
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


