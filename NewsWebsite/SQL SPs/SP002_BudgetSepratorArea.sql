-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_BudgetSepratorArea] 
@yearId int, 
@areaId int,
@budgetProcessId int
AS
BEGIN

SELECT        tbl2.CodingId, tblCoding_4.Code , tblCoding_4.Description,tbl2.Mosavab,tbl2.Edit,tbl2.Supply AS CreditAmount,tbl2.Expense ,tblCoding_4.levelNumber ,tblCoding_4.Crud
FROM            (SELECT        CodingId, isnull(SUM(Mosavab),0) AS Mosavab, isnull(SUM(EditArea),0) AS Edit , isnull(SUM(Expense),0) AS Expense ,isnull(sum(Supply),0) as Supply
                 FROM            (

--سطح اول
                                     SELECT        tblCoding_5.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab,tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.Supply
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                     tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                                                     tblCoding AS tblCoding_5 ON tblCoding_4.MotherId = tblCoding_5.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
                                     WHERE (TblBudgets.TblYearId = @YearId) AND
                                         (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId)
                                     UNION ALL

--	--سطح 2					   
                                     SELECT        tblCoding_4.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab,tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.Supply
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                     tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
                                     WHERE  (TblBudgets.TblYearId = @YearId) AND
                                         (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId)

                                     UNION ALL

----سطح 3
                                     SELECT        tblCoding_1.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab,tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.Supply
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
                                     WHERE  (TblBudgets.TblYearId = @YearId) AND
                                         (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId)

                                     UNION ALL
--سطح 4
                                     SELECT        tblCoding_3.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab,tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.Supply
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
                                     WHERE (TblBudgets.TblYearId = @YearId) AND
                                         (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId)
                                     UNION ALL
--سطح 5
                                     SELECT        tblCoding_2.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab,tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.Supply
                                     FROM            TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                     tblCoding AS tblCoding_2 ON tblCoding.MotherId = tblCoding_2.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
                                     WHERE (TblBudgets.TblYearId = @YearId) AND
                                         (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId)

                                     UNION ALL
--سطح 6
                                     SELECT        tblCoding_3.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab,tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Expense,tblBudgetDetailProjectArea.Supply
                                     FROM            TblBudgets AS TblBudgets_2 INNER JOIN
                                                     TblBudgetDetails AS TblBudgetDetails_2 ON TblBudgets_2.Id = TblBudgetDetails_2.BudgetId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON TblBudgetDetails_2.tblCodingId = tblCoding_3.Id INNER JOIN
                                                     tblBudgetDetailProject AS tblBudgetDetailProject_2 ON TblBudgetDetails_2.Id = tblBudgetDetailProject_2.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
                                     WHERE  (TblBudgets_2.TblYearId = @YearId) AND
                                         (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
                                         (tblCoding_3.TblBudgetProcessId = @BudgetProcessId)

                                     UNION ALL
--سطح 7
                                     SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.Mosavab,tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.Supply
                                     FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                     TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                     tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                     tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
                                     WHERE (TblBudgets_1.TblYearId = @YearId) AND
                                         (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
                                         (tblCoding_1.TblBudgetProcessId = @BudgetProcessId)
                                 ) AS tbl1
                 GROUP BY CodingId) AS tbl2 INNER JOIN
                tblCoding AS tblCoding_4 ON tbl2.CodingId = tblCoding_4.Id
ORDER BY  tblCoding_4.Code,tblCoding_4.levelNumber

END
go

