USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal1Coding]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetModal1Coding]
@YearId int,
@CodingId int,
@AreaId int
AS
BEGIN
if(@AreaId in (10,37))
begin
declare @temp table(Id int) 
declare @i tinyint = 1
insert into @temp (   Id  )
            select @CodingId
while @i<=2
begin
	insert into @temp (Id)
	select Id from tblCoding
	where MotherId in (select Id from @temp)
set @i = @i + 1
end
SELECT        TblBudgetDetails.Id, TblBudgetDetails.tblCodingId AS CodingId, tblCoding.Code, tblCoding.Description, TblBudgetDetails.MosavabPublic AS Mosavab, 999 AS Expense, 
                         TblBudgetDetails.MosavabPublic + ISNULL(der_Edit.Change, 0) AS EditPublic , 1 as CreditAmount , '100' as AreaName
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id LEFT OUTER JOIN
                             (SELECT        BudgetDetailId, SUM(Increase) - SUM(Decrease) AS Change
                               FROM            TblBudgetDetailEdit
                               WHERE        (StatusId = 20)
                               GROUP BY BudgetDetailId) AS der_Edit ON TblBudgetDetails.Id = der_Edit.BudgetDetailId
WHERE  (TblBudgets.TblYearId = @YearId) AND
       (TblBudgetDetails.tblCodingId IN (select id from @temp)) 
ORDER BY tblCoding.Code
return
end

if(@AreaId not in (10,30,31,32,33,34,35,36,37,42,43,44,53))
begin
SELECT        TblBudgetDetails.Id, TblBudgetDetails.tblCodingId AS CodingId, tblCoding.Code, tblCoding.Description, TblBudgetDetails.MosavabPublic AS Mosavab, 999 AS Expense, 
                         TblBudgetDetails.MosavabPublic + ISNULL(der_Edit.Change, 0) AS EditPublic, 1 AS CreditAmount, '100' AS AreaName
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId LEFT OUTER JOIN
                             (SELECT        BudgetDetailId, SUM(Increase) - SUM(Decrease) AS Change
                               FROM            TblBudgetDetailEdit
                               WHERE        (StatusId = 20)
                               GROUP BY BudgetDetailId) AS der_Edit ON TblBudgetDetails.Id = der_Edit.BudgetDetailId
WHERE        (TblBudgets.TblYearId = @YearId) AND (TblBudgetDetails.tblCodingId = @CodingId) AND (tblBudgetDetailProjectArea.AreaId = @AreaId)
ORDER BY tblCoding.Code

end

if(@AreaId in (10,30,31,32,33,34,35,36,37,42,43,44,53))
begin
declare @Execute tinyint 
if(@AreaId=30) begin set @Execute = 4  end -- معاونت شهر سازی
if(@AreaId=31) begin set @Execute = 10 end -- معاونت فنی عمرانی
if(@AreaId=32) begin set @Execute = 2  end --معاونت حمل و نقل 
if(@AreaId=33) begin set @Execute = 1  end --معاونت خدمات شهری
if(@AreaId=34) begin set @Execute = 3  end --معاونت فرهنگی
if(@AreaId=35) begin set @Execute =  7 end --معاونت مالی اقتصادی
if(@AreaId=36) begin set @Execute = 6  end --معاونت برنامه ریزی
if(@areaId=42) begin set @Execute = 12 end
if(@areaId=43) begin set @Execute = 11 end
if(@areaId=44) begin set @Execute = 13 end
if(@areaId=53) begin set @Execute = 14 end

SELECT        TblBudgetDetails.Id, TblBudgetDetails.tblCodingId AS CodingId, tblCoding.Code, tblCoding.Description, TblBudgetDetails.MosavabPublic AS Mosavab, 999 AS Expense, 
                         TblBudgetDetails.MosavabPublic + ISNULL(der_Edit.Change, 0) AS EditPublic, 1 AS CreditAmount, '100' AS AreaName
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId LEFT OUTER JOIN
                             (SELECT        BudgetDetailId, SUM(Increase) - SUM(Decrease) AS Change
                               FROM            TblBudgetDetailEdit
                               WHERE        (StatusId = 20)
                               GROUP BY BudgetDetailId) AS der_Edit ON TblBudgetDetails.Id = der_Edit.BudgetDetailId
WHERE        (TblBudgets.TblYearId = @YearId) AND
(TblBudgetDetails.tblCodingId = @CodingId) AND
(tblBudgetDetailProjectArea.AreaId = 9) AND
(tblCoding.ExecuteId = @Execute)
ORDER BY tblCoding.Code

end

END
GO
