USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP500_BudgetShare]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP500_BudgetShare]
@yearId int,
@areaId int,
@BudgetProcessId tinyint
AS
BEGIN
if(@areaId =10)
begin
SELECT        TblBudgetDetails.tblCodingId AS CodingId, tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea AS Edit, tblBudgetDetailProjectArea.Expense, 
                         TblAreas.AreaNameShort AS AreaName, ISNULL(der_Supply.CreditAmount, 0) AS CreditAmount
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea_1.AreaId, TblBudgetDetails_1.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            tblRequestBudget INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblRequestBudget.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea_1.id INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject_1.Id INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON tblBudgetDetailProject_1.BudgetDetailId = TblBudgetDetails_1.Id INNER JOIN
                                                         TblBudgets AS TblBudgets_1 ON TblBudgetDetails_1.BudgetId = TblBudgets_1.Id INNER JOIN
                                                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id
                               WHERE        (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND
							   (TblBudgets_1.TblYearId = @yearId) AND
							   (tblBudgetDetailProjectArea_1.AreaId in (1,2,3,4,5,6,7,8,9))
                               GROUP BY tblBudgetDetailProjectArea_1.AreaId, TblBudgetDetails_1.tblCodingId) AS der_Supply ON tblBudgetDetailProjectArea.AreaId = der_Supply.AreaId AND 
                         TblBudgetDetails.tblCodingId = der_Supply.tblCodingId LEFT OUTER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
WHERE        (TblBudgets.TblYearId = @yearId) AND
(tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
(tblBudgetDetailProjectArea.AreaId in (1,2,3,4,5,6,7,8,9))
ORDER BY tblBudgetDetailProjectArea.Mosavab DESC
return
end

if(@areaId not in (10,30,31,32,33,34,35,36))
begin
SELECT   TblBudgetDetails.tblCodingId AS CodingId  ,   tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab,tblBudgetDetailProjectArea.EditArea as Edit, tblBudgetDetailProjectArea.Expense, 
TblAreas.AreaNameShort AS AreaName, ISNULL(der_Supply.CreditAmount,0) as CreditAmount
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id LEFT OUTER JOIN
                             (SELECT        TblBudgetDetails_1.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            tblRequestBudget INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblRequestBudget.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea_1.id INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject_1.Id INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON tblBudgetDetailProject_1.BudgetDetailId = TblBudgetDetails_1.Id INNER JOIN
                                                         TblBudgets AS TblBudgets_1 ON TblBudgetDetails_1.BudgetId = TblBudgets_1.Id INNER JOIN
                                                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id
                               WHERE  (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND
							          (TblBudgets_1.TblYearId = @yearId) AND
									  (tblBudgetDetailProjectArea_1.AreaId = @areaId)
                               GROUP BY TblBudgetDetails_1.tblCodingId) AS der_Supply ON TblBudgetDetails.tblCodingId = der_Supply.tblCodingId LEFT OUTER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
WHERE   (TblBudgets.TblYearId = @yearId) AND
        (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
        (tblBudgetDetailProjectArea.AreaId = @areaId)
	ORDER BY tblBudgetDetailProjectArea.Mosavab DESC
return
end

if(@areaId in (30,31,32,33,34,35,36))
begin
declare @ExecuteId int
if(@areaId = 30) begin set @ExecuteId = 4  end
if(@areaId = 31) begin set @ExecuteId = 10 end
if(@areaId = 32) begin set @ExecuteId = 2  end
if(@areaId = 33) begin set @ExecuteId = 1  end
if(@areaId = 34) begin set @ExecuteId = 3  end
if(@areaId = 35) begin set @ExecuteId = 7  end
if(@areaId = 36) begin set @ExecuteId = 6  end
SELECT        TblBudgetDetails.tblCodingId AS CodingId, tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea AS Edit, tblBudgetDetailProjectArea.Supply AS CreditAmount, 
                         tblBudgetDetailProjectArea.Expense, TblAreas.AreaNameShort AS AreaName
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id LEFT OUTER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
WHERE        (TblBudgets.TblYearId = @yearId) AND
(tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
(tblBudgetDetailProjectArea.AreaId = 9) AND
(tblCoding.ExecuteId = @ExecuteId)
ORDER BY tblBudgetDetailProjectArea.Mosavab DESC
return
end
END
GO
