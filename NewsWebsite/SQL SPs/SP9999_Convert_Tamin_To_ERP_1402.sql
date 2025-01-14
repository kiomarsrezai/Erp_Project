USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9999_Convert_Tamin_To_ERP_1402]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9999_Convert_Tamin_To_ERP_1402]
--@BodgetId      nvarchar(50),
--@BodgetDesc    nvarchar(2000),
--@RequestDate   nvarchar(50),
--@RequestPrice  bigint,
--@ReqDesc       nvarchar(2000),
--@RequestRefStr nvarchar(2000),
--@SectionId int
AS
BEGIN
delete a 
--DBCC CHECKIDENT ('[a]', RESEED, 0)

delete tblRequestBudget where sal=402
--DBCC CHECKIDENT ('[tblRequestBudget]', RESEED, 0)

delete tblRequest where sal=402
--DBCC CHECKIDENT ('[tblRequest]', RESEED, 0)

--انتقال تامین اعتبارات جاری شهرداری
insert into a(      BodgetId    ,        BodgetDesc        ,      RequestDate       ,          RequestPrice      ,           ReqDesc        ,    RequestRefStr           ,          SectionId     )
SELECT        Tbl_Bodgets_1.BodgetId, Tbl_Bodgets_1.BodgetDesc, Tbl_Requsts_1.RequestDate, Tbl_Requsts_1.RequestPrice, Tbl_Requsts_1.ReqDesc, Tbl_Requsts_1.RequestRefStr, Tbl_Bodgets_1.SectionId
FROM            TAN.PortalTamin.dbo.Tbl_Bodgets AS Tbl_Bodgets_1 INNER JOIN
                         TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 ON Tbl_Bodgets_1.id = Tbl_Requsts_1.BudgetIDKey INNER JOIN
                         TAN.PortalTamin.dbo.Tbl_Sections AS Tbl_Sections_1 ON Tbl_Requsts_1.SectionExecutive = Tbl_Sections_1.SectionId
WHERE  (Tbl_Bodgets_1.Year_mosavab = 1402) AND
       (Tbl_Bodgets_1.TakhsisNumber IS NULL) AND
	   (Tbl_Bodgets_1.TypeCredit = 119) AND
	   (Tbl_Bodgets_1.SectionId in (1,2,3,4,5,6,7,8,11))

--انتقال تامین اعتبارات جاری و عمرانی سازمانها
insert into a(      BodgetId    ,        BodgetDesc        ,      RequestDate       ,          RequestPrice      ,           ReqDesc        ,    RequestRefStr           ,          SectionId     )
SELECT        Tbl_Bodgets_1.BodgetId, Tbl_Bodgets_1.BodgetDesc, Tbl_Requsts_1.RequestDate, Tbl_Requsts_1.RequestPrice, Tbl_Requsts_1.ReqDesc, Tbl_Requsts_1.RequestRefStr, Tbl_Bodgets_1.SectionId
FROM            TAN.PortalTamin.dbo.Tbl_Bodgets AS Tbl_Bodgets_1 INNER JOIN
                         TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 ON Tbl_Bodgets_1.id = Tbl_Requsts_1.BudgetIDKey INNER JOIN
                         TAN.PortalTamin.dbo.Tbl_Sections AS Tbl_Sections_1 ON Tbl_Requsts_1.SectionExecutive = Tbl_Sections_1.SectionId
WHERE  (Tbl_Bodgets_1.Year_mosavab = 1402) AND
       (Tbl_Bodgets_1.TakhsisNumber IS NULL) AND
	   (Tbl_Bodgets_1.SectionId >11)


declare @id int=(select min(id) from a)
declare @t int=1
declare @Count int = (select count(*) from a)
while @t<=@Count
begin
declare @BodgetId      nvarchar(50)   = (select BodgetId      from a where id = @id+@t)
declare @BodgetDesc    nvarchar(2000) = (select BodgetDesc    from a where id = @id+@t)
declare @RequestDate   nvarchar(50)   = (select RequestDate   from a where id = @id+@t)
declare @RequestPrice  bigint         = (select RequestPrice  from a where id = @id+@t)
declare @ReqDesc       nvarchar(2000) = (select ReqDesc       from a where id = @id+@t)
declare @RequestRefStr nvarchar(2000) = (select RequestRefStr from a where id = @id+@t)
declare @SectionId       int          = (select SectionId     from a where id = @id+@t)

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

declare @BudgetDetailProjectAreaId int = (SELECT   TOP(1)     tblBudgetDetailProjectArea.id
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
WHERE  (TblBudgets.TblYearId = 33) AND
       (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
	   (tblCoding.Code = @BodgetId) AND
	   (tblCoding.TblBudgetProcessId in (2,3)))

insert into tblRequest (YearId ,  AreaId  ,    Number    , Description,EstimateAmount ,   DateS     , sal )
                 values(   33  , @AreaId  ,@RequestRefStr,  @ReqDesc  , @RequestPrice ,@RequestDate ,  402   )
declare @RequestId int = SCOPE_IDENTITY()

insert into tblRequestBudget( RequestId  ,  BudgetDetailProjectAreaId , RequestBudgetAmount,  BodgetId , BodgetDesc , sal ,AreaId)
                      values(  @RequestId , @BudgetDetailProjectAreaId ,     @RequestPrice  , @BodgetId , @BodgetDesc, 402  ,@AreaId)
set @t = @t+1
end

UPDATE       tblBudgetDetailProjectArea
SET     Supply = der_Supply.RequestBudgetAmount
    FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
    tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
    tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
    (SELECT        BudgetDetailProjectAreaId, SUM(RequestBudgetAmount) AS RequestBudgetAmount , sum(TotalPriceRequestEditYearNow) AS TotalPriceRequestEditYearNow
    FROM            tblRequestBudget
    GROUP BY BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
WHERE        (TblBudgets.TblYearId = 33)

END
GO
