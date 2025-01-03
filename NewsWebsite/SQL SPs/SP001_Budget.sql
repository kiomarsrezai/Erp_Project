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

