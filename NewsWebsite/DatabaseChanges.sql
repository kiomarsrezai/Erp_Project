-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_Budget]
    @YearId int ,
    @AreaId int ,
    @BudgetProcessId int
AS
BEGIN



    if(@areaId  in (10,37,39,40,41 ,
                    30,31,32,33,34,35,36,42,43,44,53,
                    1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
begin

            declare @ExecuteId int
            if(@areaId=30) begin set @ExecuteId = 4  end
            if(@areaId=31) begin set @ExecuteId = 10 end
            if(@areaId=32) begin set @ExecuteId = 2  end
            if(@areaId=33) begin set @ExecuteId = 1  end
            if(@areaId=34) begin set @ExecuteId = 3  end
            if(@areaId=35) begin set @ExecuteId = 7  end
            if(@areaId=36) begin set @ExecuteId = 6  end
            if(@areaId=42) begin set @ExecuteId = 12 end
            if(@areaId=43) begin set @ExecuteId = 11 end
            if(@areaId=44) begin set @ExecuteId = 13 end
            if(@areaId=53) begin set @ExecuteId = 14 end

SELECT        tbl2.CodingId, tblCoding_4.Code, tblCoding_4.Description,tbl2.Pishnahadi,tbl2.Mosavab,tbl2.Edit,tblCoding_4.levelNumber , tbl2.Expense ,
              tblCoding_4.Show,tblCoding_4.Crud,tblCoding_4.MotherId,isnull(tbl2.CreditAmount,0) as CreditAmount,isnull(tbl2.ConfirmStatus,0) AS ConfirmStatus
FROM            (SELECT        CodingId, SUM(Pishnahadi) AS Pishnahadi, SUM(Mosavab) AS Mosavab ,Sum(Edit) as Edit, sum(Expense) as Expense , sum(CreditAmount) as CreditAmount,MIN(ConfirmStatus) AS ConfirmStatus
                 FROM            (
-------------------------------------------------------------------------------------------------------

--سطح اول
                                     SELECT        tblCoding_5.MotherId AS CodingId, ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
                                                   ISNULL(tblBudgetDetailProjectArea.Supply, 0) AS CreditAmount,ConfirmStatus
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                     tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                                                     tblCoding AS tblCoding_5 ON tblCoding_4.MotherId = tblCoding_5.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                     TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblBudgets.TblYearId=TblAreasTogether.YearId
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreasTogether.ToGetherBudget =10 AND  @areaId IN (40)) OR
                                             (TblAreasTogether.ToGetherBudget =84 AND  @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                         )
                                     UNION ALL


--	--سطح 2					   
                                     SELECT        tblCoding_4.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
                                                   ISNULL(tblBudgetDetailProjectArea.Supply, 0) as CreditAmount,ConfirmStatus
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                     tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                     TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblBudgets.TblYearId=TblAreasTogether.YearId
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreasTogether.ToGetherBudget =10 AND  @areaId IN (40)) OR
                                             (TblAreasTogether.ToGetherBudget =84 AND  @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                         )

                                     UNION ALL

--سطح 3
                                     SELECT        tblCoding_1.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
                                                   ISNULL(tblBudgetDetailProjectArea.Supply, 0) as CreditAmount,ConfirmStatus
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                     TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblBudgets.TblYearId=TblAreasTogether.YearId
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreasTogether.ToGetherBudget =10 AND  @areaId IN (40)) OR
                                             (TblAreasTogether.ToGetherBudget =84 AND  @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                         )
                                     UNION ALL

--		 --سطح 4
                                     SELECT        tblCoding_3.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
                                                   ISNULL(tblBudgetDetailProjectArea.Supply, 0) as CreditAmount,ConfirmStatus
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                     TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblBudgets.TblYearId=TblAreasTogether.YearId
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreasTogether.ToGetherBudget =10 AND  @areaId IN (40)) OR
                                             (TblAreasTogether.ToGetherBudget =84 AND  @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                         )
                                     UNION ALL
--سطح 5
                                     SELECT        tblCoding_2.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
                                                   ISNULL(tblBudgetDetailProjectArea.Supply, 0) as CreditAmount,ConfirmStatus
                                     FROM            TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblCoding AS tblCoding_2 ON tblCoding.MotherId = tblCoding_2.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                     TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblBudgets.TblYearId=TblAreasTogether.YearId
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreasTogether.ToGetherBudget =10 AND  @areaId IN (40)) OR
                                             (TblAreasTogether.ToGetherBudget =84 AND  @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                         )
                                     UNION ALL

--سطح 6
                                     SELECT        tblCoding_3.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
                                                   ISNULL(tblBudgetDetailProjectArea.Supply, 0) as CreditAmount,ConfirmStatus
                                     FROM            TblBudgets AS TblBudgets_2 INNER JOIN
                                                     TblBudgetDetails AS TblBudgetDetails_2 ON TblBudgets_2.Id = TblBudgetDetails_2.BudgetId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON TblBudgetDetails_2.tblCodingId = tblCoding_3.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails_2.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                     TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblBudgets_2.TblYearId=TblAreasTogether.YearId
                                     WHERE        (TblBudgets_2.TblYearId = @YearId) AND (tblCoding_3.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreasTogether.ToGetherBudget =10 AND  @areaId IN (40)) OR
                                             (TblAreasTogether.ToGetherBudget =84 AND  @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding_3.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                         )
                                     UNION ALL

--سطح 7
                                     SELECT        TblBudgetDetails_1.tblCodingId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
                                                   ISNULL(tblBudgetDetailProjectArea.Supply, 0) as CreditAmount,ConfirmStatus
                                     FROM            TblBudgets AS TblBudgets_0 INNER JOIN
                                                     TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_0.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                     tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails_1.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                     TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblBudgets_0.TblYearId=TblAreasTogether.YearId
                                     WHERE        (TblBudgets_0.TblYearId = @YearId) AND (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreasTogether.ToGetherBudget =10 AND  @areaId IN (40)) OR
                                             (TblAreasTogether.ToGetherBudget =84 AND  @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding_1.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                         )

                                 ) AS tbl1
                 GROUP BY CodingId
                 having CodingId is not null
                ) AS tbl2 INNER JOIN
                tblCoding AS tblCoding_4 ON tbl2.CodingId = tblCoding_4.Id
--where  tblCoding_4.Show = 1

ORDER BY tblCoding_4.Code
    return
end

END
go







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








-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_Edit]
    @yearId int ,
    @areaId int,
    @budgetProcessId int
AS
BEGIN

    if(@areaId  in (10,37,39,40,41 ,
                    30,31,32,33,34,35,36,42,43,44,53,
                    1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
begin

            declare @ExecuteId int
            if(@areaId=30) begin set @ExecuteId = 4  end
            if(@areaId=31) begin set @ExecuteId = 10 end
            if(@areaId=32) begin set @ExecuteId = 2  end
            if(@areaId=33) begin set @ExecuteId = 1  end
            if(@areaId=34) begin set @ExecuteId = 3  end
            if(@areaId=35) begin set @ExecuteId = 7  end
            if(@areaId=36) begin set @ExecuteId = 6  end
            if(@areaId=42) begin set @ExecuteId = 12 end
            if(@areaId=43) begin set @ExecuteId = 11 end
            if(@areaId=44) begin set @ExecuteId = 13 end
            if(@areaId=53) begin set @ExecuteId = 14 end

SELECT        tbl2.CodingId, tblCoding_4.Code , tblCoding_4.Description,tbl2.Mosavab,tbl2.Edit,tbl2.Supply ,tbl2.Expense ,
              tbl2.NeedEditYearNow, tblCoding_4.levelNumber ,tblCoding_4.Crud,tbl2.ProctorId,tbl2.ExecutionId, proctors.ProctorName AS proctorName,executors.ProctorName AS executorName,tbl2.Supply AS  CreditAmount
FROM            (SELECT        CodingId, isnull(SUM(Mosavab),0) AS Mosavab, isnull(SUM(EditArea),0) AS Edit , isnull(sum(Supply),0) as Supply, isnull(SUM(Expense),0) AS Expense ,
                               isnull(sum(NeedEditYearNow),0) as NeedEditYearNow
                         ,CASE WHEN COUNT(DISTINCT ProctorId) = 0 THEN 0  WHEN COUNT(DISTINCT ProctorId) = 1 THEN MAX(ProctorId) ELSE -1 END AS ProctorId ,CASE WHEN COUNT(DISTINCT ExecutionId) = 0 THEN 0 WHEN COUNT(DISTINCT ExecutionId) = 1 THEN MAX(ExecutionId) ELSE -1 END AS ExecutionId



                 FROM            (

--سطح اول
                                     SELECT        tblCoding_5.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.NeedEditYearNow AS NeedEditYearNow
                                          ,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                     tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                                                     tblCoding AS tblCoding_5 ON tblCoding_4.MotherId = tblCoding_5.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                     TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblBudgets.TblYearId=TblAreasTogether.YearId
                                     WHERE   (TblBudgets.TblYearId = @YearId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
                                         (
                                                 ( @areaId IN (37)) OR
                                                 (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                 (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                 (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                 (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                             )
                                     union all
----------سطح 2	

                                     SELECT        tblCoding_4.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.NeedEditYearNow AS NeesEditYearNow
                                          ,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                     tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                     TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblBudgets.TblYearId=TblAreasTogether.YearId
                                     WHERE    (TblBudgets.TblYearId = @YearId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
                                         (
                                                 ( @areaId IN (37)) OR
                                                 (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                 (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                 (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                 (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                             )
                                     UNION ALL

----سطح 3
                                     SELECT        tblCoding_1.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.NeedEditYearNow AS NeesEditYearNow
                                          ,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id  LEFT JOIN
                                                     TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblBudgets.TblYearId=TblAreasTogether.YearId
                                     WHERE     (TblBudgets.TblYearId = @YearId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
                                         (
                                                 ( @areaId IN (37)) OR
                                                 (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                 (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                 (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                 (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                             )

--سطح 4
                                     union all
                                     SELECT        tblCoding_3.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.NeedEditYearNow AS NeesEditYearNow
                                          ,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id  LEFT JOIN
                                                     TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblBudgets.TblYearId=TblAreasTogether.YearId
                                     WHERE    (TblBudgets.TblYearId = @YearId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
                                         (
                                                 ( @areaId IN (37)) OR
                                                 (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                 (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                 (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                 (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                             )

                                     UNION ALL
--سطح 5
                                     SELECT        tblCoding_2.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.NeedEditYearNow AS NeesEditYearNow
                                          ,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId
                                     FROM            TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                     tblCoding AS tblCoding_2 ON tblCoding.MotherId = tblCoding_2.Id INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id  LEFT JOIN
                                                     TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblBudgets.TblYearId=TblAreasTogether.YearId
                                     WHERE    (TblBudgets.TblYearId = @YearId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
                                         (
                                                 ( @areaId IN (37)) OR
                                                 (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                 (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                 (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                 (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                             )
                                     union all
--سطح 6
                                     SELECT        tblCoding_3.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.NeedEditYearNow AS NeesEditYearNow
                                          ,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId
                                     FROM            TblBudgets AS TblBudgets_2 INNER JOIN
                                                     TblBudgetDetails AS TblBudgetDetails_2 ON TblBudgets_2.Id = TblBudgetDetails_2.BudgetId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON TblBudgetDetails_2.tblCodingId = tblCoding_3.Id INNER JOIN
                                                     tblBudgetDetailProject AS tblBudgetDetailProject_2 ON TblBudgetDetails_2.Id = tblBudgetDetailProject_2.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id  LEFT JOIN
                                                     TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblBudgets_2.TblYearId=TblAreasTogether.YearId
                                     WHERE   (TblBudgets_2.TblYearId = @YearId) AND
                                         (tblCoding_3.TblBudgetProcessId = @BudgetProcessId) AND
                                         (
                                                 ( @areaId IN (37)) OR
                                                 (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                 (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                 (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                 (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding_3.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                             )

                                     UNION ALL
--سطح 7
                                     SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.NeedEditYearNow AS NeesEditYearNow
                                          ,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId
                                     FROM            TblBudgets AS TblBudgets_0 INNER JOIN
                                                     TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_0.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                     tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                     tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id  LEFT JOIN
                                                     TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblBudgets_0.TblYearId=TblAreasTogether.YearId
                                     WHERE    (TblBudgets_0.TblYearId = @YearId) AND
                                         (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND
                                         (
                                                 ( @areaId IN (37)) OR
                                                 (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                 (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                 (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                 (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding_1.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                             )

                                 ) AS tbl1
                 GROUP BY CodingId) AS tbl2 INNER JOIN
                tblCoding AS tblCoding_4 ON tbl2.CodingId = tblCoding_4.Id  LEFT JOIN
                tblProctor AS proctors On tbl2.ProctorId= proctors.Id LEFT JOIN
                tblProctor AS executors On tbl2.ExecutionId= executors.Id
ORDER BY  tblCoding_4.Code,tblCoding_4.levelNumber
    return
end
END
go








-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP004_BudgetProposal_Read]
    @yearId int,
    @areaId int,
    @budgetProcessId int
AS
BEGIN

    if(@areaId  in (10,37,39,40,41 ,
                    30,31,32,33,34,35,36,42,43,44,53,
                    1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29,
                    45,46,47,48,49,50,51,52)) --گزارشات اداره کل منابع انسانی-- اداره کل پشتیبانی
begin

            declare @ExecuteId int
            if(@areaId=30) begin set @ExecuteId = 4  end
            if(@areaId=31) begin set @ExecuteId = 10 end
            if(@areaId=32) begin set @ExecuteId = 2  end
            if(@areaId=33) begin set @ExecuteId = 1  end
            if(@areaId=34) begin set @ExecuteId = 3  end
            if(@areaId=35) begin set @ExecuteId = 7  end
            if(@areaId=36) begin set @ExecuteId = 6  end
            if(@areaId=42) begin set @ExecuteId = 12 end
            if(@areaId=43) begin set @ExecuteId = 11 end
            if(@areaId=44) begin set @ExecuteId = 13 end
            if(@areaId=53) begin set @ExecuteId = 14 end

            declare @OnlyReport int
            if(@areaId = 45) begin set @OnlyReport = 1   end -- منابع انسانی
            if(@areaId = 46) begin set @OnlyReport = 2   end --اداره پشتیبانی
            if(@areaId = 47) begin set @OnlyReport = 3   end -- فرهنگی
            if(@areaId = 48) begin set @OnlyReport = 4   end -- خدمات شهری
            if(@areaId = 49) begin set @OnlyReport = 5   end --  روابط عمومی
            if(@areaId = 52) begin set @OnlyReport = 6   end -- سایر
            if(@areaId = 50) begin set @OnlyReport = 7   end -- بسیج
            if(@areaId = 51) begin set @OnlyReport = 8   end -- حقوقی

            
            ;WITH supplyQuery as (
    SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
    FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                    TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                    tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                    tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                    tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                    tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                    TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id LEFT JOIN
                    TblAreasTogether AS TblAreasTogether_3 ON TblAreasTogether_3.AreaId = TblAreas_3.Id AND TblBudgets_1.TblYearId=TblAreasTogether_3.YearId
    WHERE        (TblBudgets_1.TblYearId = @YearId-1) AND
        (tblCoding_6.TblBudgetProcessId = @BudgetProcessId)  AND
        (
                ( @areaId IN (37)) OR
                (TblAreas_3.StructureId=1 AND @areaId IN (10)) OR
                (TblAreas_3.StructureId=2 AND @areaId IN (39)) OR
                (TblAreasTogether_3.ToGetherBudget =10 AND @areaId IN (40)) OR
                (TblAreasTogether_3.ToGetherBudget =84 AND @areaId IN (41)) OR
                (tblBudgetDetailProjectArea_1.AreaId = 9 AND tblCoding_6.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                (tblBudgetDetailProjectArea_1.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
            )
    GROUP BY tblRequestBudget.BudgetDetailProjectAreaId
)

             SELECT        tbl2.CodingId, tblCoding_4.Code , tblCoding_4.Description,tbl2.Mosavab,tbl2.Edit,tbl2.Supply as  CreditAmount,tbl2.Expense ,PishnahadiCash,PishnahadiNonCash,
                           tbl2.Pishnahadi, tblCoding_4.levelNumber ,tblCoding_4.Crud,ConfirmStatus AS ConfirmStatus,isNewYear AS isNewYear,delegateTo,delegateAmount,delegatePercentage,DelegateArea.AreaName as DelegateToName,tbl2.ProctorId,tbl2.ExecutionId,tbl2.Last3Month,tbl2.Last9Month
             FROM            (SELECT CodingId, isnull(SUM(Mosavab),0) AS Mosavab, isnull(SUM(EditArea),0) AS Edit , SUM(Supply) as Supply,isnull(SUM(Expense),0) AS Expense ,isnull(sum(PishnahadiCash),0) as PishnahadiCash,isnull(sum(PishnahadiNonCash),0) as PishnahadiNonCash,isnull(sum(Pishnahadi),0) as Pishnahadi,isnull(min(ConfirmStatus),0) AS ConfirmStatus ,
                                     max(isNewYear) AS isNewYear ,isnull(max(delegateTo),0) AS delegateTo ,isnull(max(delegateAmount),0) AS delegateAmount ,isnull(max(delegatePercentage),0) AS delegatePercentage,isnull(sum(Last3Month),0) AS Last3Month,isnull(sum(Last9Month),0) AS Last9Month
                                      ,CASE WHEN COUNT(DISTINCT ProctorId) = 0 THEN 0  WHEN COUNT(DISTINCT ProctorId) <=2 THEN MAX(ProctorId) ELSE -1 END AS ProctorId ,CASE WHEN COUNT(DISTINCT ExecutionId) = 0 THEN 0 WHEN COUNT(DISTINCT ExecutionId) <=2 THEN MAX(ExecutionId) ELSE -1 END AS ExecutionId
                              FROM            (

--سطح اول
                                                  SELECT        tblCoding_5.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea,  tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, 0 AS PishnahadiCash, 0 AS PishnahadiNonCash, 0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                                                  FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                                  TblBudgets INNER JOIN
                                                                  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                                  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                                  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                                  tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                                  tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                                  tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                                                                  tblCoding AS tblCoding_5 ON tblCoding_4.MotherId = tblCoding_5.Id INNER JOIN
                                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                                  TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblAreasTogether.YearId=TblBudgets.TblYearId
                                                  WHERE        (TblBudgets.TblYearId = @YearId - 1) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)  AND (
                                                          ( @areaId IN (37)) OR
                                                          (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                          (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                          (TblAreasTogether.ToGetherBudget =10 AND @AreaId IN (40)) OR
                                                          (TblAreasTogether.ToGetherBudget =84 AND @AreaId IN (41)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29)) OR
                                                          (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                                      )
                                                  UNION ALL
                                                  SELECT        tblCoding_5.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage ,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,tblBudgetDetailProjectArea.Last3Month AS Last3Month,tblBudgetDetailProjectArea.Last9Month AS Last9Month
                                                  FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                                  TblBudgets INNER JOIN
                                                                  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                                  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                                  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                                  tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                                  tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                                  tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                                                                  tblCoding AS tblCoding_5 ON tblCoding_4.MotherId = tblCoding_5.Id INNER JOIN
                                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                                  TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblAreasTogether.YearId=TblBudgets.TblYearId LEFT JOIN
                                                                  tblBudgetDetailProjectAreaDelegate ON tblBudgetDetailProjectAreaDelegate.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea.id
                                                  WHERE  (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)  AND (
                                                          ( @areaId IN (37)) OR
                                                          (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                          (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                          (TblAreasTogether.ToGetherBudget =10 AND @AreaId IN (40)) OR
                                                          (TblAreasTogether.ToGetherBudget =84 AND @AreaId IN (41)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                                          (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                                      )

                                                  union all
----------سطح 2	

                                                  SELECT        tblCoding_4.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear  , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                                                  FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                                  TblBudgets INNER JOIN
                                                                  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                                  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                                  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                                  tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                                  tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                                  tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                                  TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblAreasTogether.YearId=TblBudgets.TblYearId
                                                  WHERE        (TblBudgets.TblYearId = @YearId - 1) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)  AND (
                                                          ( @areaId IN (37)) OR
                                                          (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                          (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                          (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                          (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                                          (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                                      )

                                                  UNION ALL

                                                  SELECT        tblCoding_4.MotherId AS CodingId, 0 as Mosavab, 0 as EditArea,0 as supply, 0 as Expense , tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear ,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,tblBudgetDetailProjectArea.Last3Month AS Last3Month,tblBudgetDetailProjectArea.Last9Month AS Last9Month
                                                  FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                                  TblBudgets INNER JOIN
                                                                  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                                  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                                  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                                  tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                                  tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                                  tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                                  TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblAreasTogether.YearId=TblBudgets.TblYearId LEFT JOIN
                                                                  tblBudgetDetailProjectAreaDelegate ON tblBudgetDetailProjectAreaDelegate.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea.id
                                                  WHERE  (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                                          ( @areaId IN (37)) OR
                                                          (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                          (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                          (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                          (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                                          (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                                      )

                                                  union all

----سطح 3
                                                  SELECT        tblCoding_1.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear  , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                                                  FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                                  TblBudgets INNER JOIN
                                                                  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                                  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                                  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                                  tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                                  tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                                  TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblAreasTogether.YearId=TblBudgets.TblYearId
                                                  WHERE        (TblBudgets.TblYearId = @YearId - 1) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                                          ( @areaId IN (37)) OR
                                                          (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                          (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                          (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                          (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                                          (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                                      )

                                                  UNION ALL

                                                  SELECT tblCoding_1.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear ,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,tblBudgetDetailProjectArea.Last3Month AS Last3Month,tblBudgetDetailProjectArea.Last9Month AS Last9Month
                                                  FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                                  TblBudgets INNER JOIN
                                                                  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                                  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                                  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                                  tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                                  tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                                  TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblAreasTogether.YearId=TblBudgets.TblYearId LEFT JOIN
                                                                  tblBudgetDetailProjectAreaDelegate ON tblBudgetDetailProjectAreaDelegate.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea.id
                                                  WHERE  (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)AND (
                                                          ( @areaId IN (37)) OR
                                                          (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                          (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                          (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                          (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                                          (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                                      )


                                                  --سطح 4
                                                  union all
                                                  SELECT        tblCoding_3.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear  , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                                                  FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                                  TblBudgets INNER JOIN
                                                                  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                                  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                                  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                                  tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                                  TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblAreasTogether.YearId=TblBudgets.TblYearId
                                                  WHERE        (TblBudgets.TblYearId = @YearId - 1) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                                          ( @areaId IN (37)) OR
                                                          (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                          (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                          (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                          (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                                          (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                                      )

                                                  union all
                                                  SELECT        tblCoding_3.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,tblBudgetDetailProjectArea.Last3Month AS Last3Month,tblBudgetDetailProjectArea.Last9Month AS Last9Month
                                                  FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                                  TblBudgets INNER JOIN
                                                                  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                                  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                                  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                                  tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                                  TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblAreasTogether.YearId=TblBudgets.TblYearId LEFT JOIN
                                                                  tblBudgetDetailProjectAreaDelegate ON tblBudgetDetailProjectAreaDelegate.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea.id
                                                  WHERE  (TblBudgets.TblYearId = @YearId) AND(tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                                          ( @areaId IN (37)) OR
                                                          (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                          (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                          (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                          (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                                          (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                                      )

                                                  UNION ALL
                                                  --سطح 5
                                                  SELECT        tblCoding_2.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea,tblBudgetDetailProjectArea.Supply,tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear  , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                                                  FROM            TblBudgets INNER JOIN
                                                                  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                                  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                                  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                                  tblCoding AS tblCoding_2 ON tblCoding.MotherId = tblCoding_2.Id INNER JOIN
                                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                                  TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblAreasTogether.YearId=TblBudgets.TblYearId
                                                  WHERE        (TblBudgets.TblYearId = @YearId - 1) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                                          ( @areaId IN (37)) OR
                                                          (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                          (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                          (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                          (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                                          (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                                      )
                                                  UNION ALL
                                                  SELECT        tblCoding_2.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,tblBudgetDetailProjectArea.Last3Month AS Last3Month,tblBudgetDetailProjectArea.Last9Month AS Last9Month
                                                  FROM            TblBudgets INNER JOIN
                                                                  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                                  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                                  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                                  tblCoding AS tblCoding_2 ON tblCoding.MotherId = tblCoding_2.Id INNER JOIN
                                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                                  TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblAreasTogether.YearId=TblBudgets.TblYearId LEFT JOIN
                                                                  tblBudgetDetailProjectAreaDelegate ON tblBudgetDetailProjectAreaDelegate.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea.id
                                                  WHERE  (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                                          ( @areaId IN (37)) OR
                                                          (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                          (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                          (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                          (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                                          (tblCoding.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                                      )
                                                  union all
                                                  --سطح 6
                                                  SELECT        tblCoding_3.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply,tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                                                  FROM            TblBudgets AS TblBudgets_2 INNER JOIN
                                                                  TblBudgetDetails AS TblBudgetDetails_2 ON TblBudgets_2.Id = TblBudgetDetails_2.BudgetId INNER JOIN
                                                                  tblCoding AS tblCoding_3 ON TblBudgetDetails_2.tblCodingId = tblCoding_3.Id INNER JOIN
                                                                  tblBudgetDetailProject AS tblBudgetDetailProject_2 ON TblBudgetDetails_2.Id = tblBudgetDetailProject_2.BudgetDetailId INNER JOIN
                                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                                  TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblAreasTogether.YearId=TblBudgets_2.TblYearId
                                                  WHERE        (TblBudgets_2.TblYearId = @YearId - 1) AND (tblCoding_3.TblBudgetProcessId = @BudgetProcessId) AND (
                                                          ( @areaId IN (37)) OR
                                                          (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                          (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                          (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                          (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding_3.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                                          (tblCoding_3.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                                      )

                                                  union all
                                                  SELECT  tblCoding_3.MotherId AS CodingId, 0 AS Mosavab, 0 AS EditArea, 0 as supply,0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,tblBudgetDetailProjectArea.Last3Month AS Last3Month,tblBudgetDetailProjectArea.Last9Month AS Last9Month
                                                  FROM            TblBudgets AS TblBudgets_2 INNER JOIN
                                                                  TblBudgetDetails AS TblBudgetDetails_2 ON TblBudgets_2.Id = TblBudgetDetails_2.BudgetId INNER JOIN
                                                                  tblCoding AS tblCoding_3 ON TblBudgetDetails_2.tblCodingId = tblCoding_3.Id INNER JOIN
                                                                  tblBudgetDetailProject AS tblBudgetDetailProject_2 ON TblBudgetDetails_2.Id = tblBudgetDetailProject_2.BudgetDetailId INNER JOIN
                                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                                  TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblAreasTogether.YearId=TblBudgets_2.TblYearId LEFT JOIN
                                                                  tblBudgetDetailProjectAreaDelegate ON tblBudgetDetailProjectAreaDelegate.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea.id
                                                  WHERE  (TblBudgets_2.TblYearId = @YearId) AND (tblCoding_3.TblBudgetProcessId = @BudgetProcessId) AND (
                                                          ( @areaId IN (37)) OR
                                                          (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                          (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                          (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                          (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding_3.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                                          (tblCoding_3.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                                      )

                                                  UNION ALL
                                                  --سطح 7
                                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea,tblBudgetDetailProjectArea.Supply,tblBudgetDetailProjectArea.Expense,0 AS PishnahadiCash, 0 AS PishnahadiNonCash,  0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear  , 0 AS delegateTo, 0 AS delegateAmount, 0 AS delegatePercentage, 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId  INNER JOIN
                                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                                  TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblAreasTogether.YearId=TblBudgets_1.TblYearId
                                                  WHERE        (TblBudgets_1.TblYearId = @YearId - 1) AND (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND (
                                                          ( @areaId IN (37)) OR
                                                          (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                          (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                          (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                          (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding_1.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                                          (tblCoding_1.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                                      )

                                                  union all

                                                  SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, 0 AS Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   tblBudgetDetailProjectAreaDelegate.AreaId AS delegateTo, tblBudgetDetailProjectAreaDelegate.Pishnahadi AS delegateAmount, tblBudgetDetailProjectAreaDelegate.SupervisorPercent AS delegatePercentage,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,tblBudgetDetailProjectArea.Last3Month AS Last3Month,tblBudgetDetailProjectArea.Last9Month AS Last9Month
                                                  FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                                  TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                                  tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                                                                  TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblAreasTogether.YearId=TblBudgets_1.TblYearId LEFT JOIN
                                                                  tblBudgetDetailProjectAreaDelegate ON tblBudgetDetailProjectAreaDelegate.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea.id
                                                  WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND (
                                                          ( @areaId IN (37)) OR
                                                          (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                          (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                          (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                          (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding_1.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44,53)) OR
                                                          (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))OR
                                                          (tblCoding_1.OnlyReport = @OnlyReport AND  @areaId in (45,46,47,48,49,50,51,52))
                                                      )

                                              ) AS tbl1
                              GROUP BY CodingId) AS tbl2 INNER JOIN
                             tblCoding AS tblCoding_4 ON tbl2.CodingId = tblCoding_4.Id LEFT JOIN
                             TblAreas AS DelegateArea ON tbl2.delegateTo = DelegateArea.Id

             ORDER BY  tblCoding_4.Code,tblCoding_4.levelNumber
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          return
end

END
go

