update sp001_budget
add [SP001_BudgetConfirmStatus_Update]
update SP001_Budget_Inline_Insert
update SP005_ProjectTable_Update
update SP005_ProjectTable_Insert
    SP001_BudgetModal3Area_Update



    USE [ProgramBudDB]
    GO
/****** Object:  StoredProcedure [dbo].[SP001_Budget]    Script Date: 11/25/2024 1:11:51 PM ******/
SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP001_Budget]
    @YearId int ,
    @AreaId int ,
    @BudgetProcessId int
AS
BEGIN



    if(@areaId  in (10,37,39,40,41 ,
                    30,31,32,33,34,35,36,42,43,44,
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

SELECT        tbl2.CodingId, tblCoding_4.Code, tblCoding_4.Description,tbl2.Pishnahadi,tbl2.Mosavab,tbl2.Edit,tblCoding_4.levelNumber , tbl2.Expense ,
              tblCoding_4.Show,tblCoding_4.Crud,tblCoding_4.MotherId,isnull(tbl2.CreditAmount,0) as CreditAmount,isnull(tbl2.ConfirmStatus,0) AS ConfirmStatus
FROM            (SELECT        CodingId, SUM(Pishnahadi) AS Pishnahadi, SUM(Mosavab) AS Mosavab ,Sum(Edit) as Edit, sum(Expense) as Expense , sum(CreditAmount) as CreditAmount,MIN(ConfirmStatus) AS ConfirmStatus
                 FROM            (
-------------------------------------------------------------------------------------------------------

--سطح اول
                                     SELECT        tblCoding_5.MotherId AS CodingId, ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
                                                   ISNULL(der_Supply.CreditAmount, 0) AS CreditAmount,ConfirmStatus
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
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT OUTER JOIN
                                                     (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                                                      FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                                      TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                                      tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                                      tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                                      tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                                      tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                                      TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                                                      WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId)  AND (
                                                              ( @areaId IN (37)) OR
                                                              (TblAreas_3.StructureId=1 AND @areaId IN (10)) OR
                                                              (TblAreas_3.StructureId=2 AND @areaId IN (39)) OR
                                                              (TblAreas_3.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                              (TblAreas_3.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                              (tblBudgetDetailProjectArea_1.AreaId = 9 AND tblCoding_6.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                                              (tblBudgetDetailProjectArea_1.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                                          )
                                                      GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                         )
                                     UNION ALL


--	--سطح 2					   
                                     SELECT        tblCoding_4.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
                                                   ISNULL(der_Supply.CreditAmount,0) as CreditAmount,ConfirmStatus
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                     tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT OUTER JOIN
                                                     (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                                                      FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                                      TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                                      tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                                      tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                                      tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                                      tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                                      TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                                                      WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (
                                                              ( @areaId IN (37)) OR
                                                              (TblAreas_3.StructureId=1 AND @areaId IN (10)) OR
                                                              (TblAreas_3.StructureId=2 AND @areaId IN (39)) OR
                                                              (TblAreas_3.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                              (TblAreas_3.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                              (tblBudgetDetailProjectArea_1.AreaId = 9 AND tblCoding_6.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                                              (tblBudgetDetailProjectArea_1.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                                          )
                                                      GROUP BY  tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                         )

                                     UNION ALL

--سطح 3
                                     SELECT        tblCoding_1.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
                                                   der_Supply.CreditAmount,ConfirmStatus
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT OUTER JOIN
                                                     (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                                                      FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                                      TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                                      tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                                      tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                                      tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                                      tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                                      TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                                                      WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId)  AND (
                                                              ( @areaId IN (37)) OR
                                                              (TblAreas_3.StructureId=1 AND @areaId IN (10)) OR
                                                              (TblAreas_3.StructureId=2 AND @areaId IN (39)) OR
                                                              (TblAreas_3.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                              (TblAreas_3.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                              (tblBudgetDetailProjectArea_1.AreaId = 9 AND tblCoding_6.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                                              (tblBudgetDetailProjectArea_1.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                                          )
                                                      GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                         )
                                     UNION ALL

--		 --سطح 4
                                     SELECT        tblCoding_3.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
                                                   der_Supply.CreditAmount,ConfirmStatus
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT OUTER JOIN
                                                     (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                                                      FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                                      TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                                      tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                                      tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                                      tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                                      tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                                      TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                                                      WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId)  AND (
                                                              ( @areaId IN (37)) OR
                                                              (TblAreas_3.StructureId=1 AND @areaId IN (10)) OR
                                                              (TblAreas_3.StructureId=2 AND @areaId IN (39)) OR
                                                              (TblAreas_3.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                              (TblAreas_3.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                              (tblBudgetDetailProjectArea_1.AreaId = 9 AND tblCoding_6.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                                              (tblBudgetDetailProjectArea_1.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                                          )
                                                      GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                         )
                                     UNION ALL
--سطح 5
                                     SELECT        tblCoding_2.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
                                                   der_Supply.CreditAmount,ConfirmStatus
                                     FROM            TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblCoding AS tblCoding_2 ON tblCoding.MotherId = tblCoding_2.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT OUTER JOIN
                                                     (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                                                      FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                                      TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                                      tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                                      tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                                      tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                                      tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                                      TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                                                      WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId)  AND (
                                                              ( @areaId IN (37)) OR
                                                              (TblAreas_3.StructureId=1 AND @areaId IN (10)) OR
                                                              (TblAreas_3.StructureId=2 AND @areaId IN (39)) OR
                                                              (TblAreas_3.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                              (TblAreas_3.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                              (tblBudgetDetailProjectArea_1.AreaId = 9 AND tblCoding_6.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                                              (tblBudgetDetailProjectArea_1.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                                          )
                                                      GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
                                     WHERE        (TblBudgets.TblYearId = @YearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                         )
                                     UNION ALL

--سطح 6
                                     SELECT        tblCoding_3.MotherId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
                                                   der_Supply.CreditAmount,ConfirmStatus
                                     FROM            TblBudgets AS TblBudgets_2 INNER JOIN
                                                     TblBudgetDetails AS TblBudgetDetails_2 ON TblBudgets_2.Id = TblBudgetDetails_2.BudgetId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON TblBudgetDetails_2.tblCodingId = tblCoding_3.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails_2.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT OUTER JOIN
                                                     (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                                                      FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                                      TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                                      tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                                      tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                                      tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                                      tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                                      TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                                                      WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (
                                                              ( @areaId IN (37)) OR
                                                              (TblAreas_3.StructureId=1 AND @areaId IN (10)) OR
                                                              (TblAreas_3.StructureId=2 AND @areaId IN (39)) OR
                                                              (TblAreas_3.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                              (TblAreas_3.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                              (tblBudgetDetailProjectArea_1.AreaId = 9 AND tblCoding_6.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                                              (tblBudgetDetailProjectArea_1.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                                          )
                                                      GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
                                     WHERE        (TblBudgets_2.TblYearId = @YearId) AND (tblCoding_3.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding_3.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                             (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                         )
                                     UNION ALL

--سطح 7
                                     SELECT        TblBudgetDetails_1.tblCodingId AS CodingId,ISNULL(tblBudgetDetailProjectArea.Pishnahadi, 0) AS Pishnahadi, ISNULL(tblBudgetDetailProjectArea.Mosavab, 0) AS Mosavab, ISNULL(tblBudgetDetailProjectArea.EditArea, 0) AS Edit, ISNULL(tblBudgetDetailProjectArea.Expense, 0) AS Expense,
                                                   der_Supply.CreditAmount,ConfirmStatus
                                     FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                     TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                     tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails_1.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT OUTER JOIN
                                                     (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                                                      FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                                      TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                                      tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                                      tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                                      tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                                      tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                                      TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                                                      WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId)  AND (
                                                              ( @areaId IN (37)) OR
                                                              (TblAreas_3.StructureId=1 AND @areaId IN (10)) OR
                                                              (TblAreas_3.StructureId=2 AND @areaId IN (39)) OR
                                                              (TblAreas_3.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                              (TblAreas_3.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                              (tblBudgetDetailProjectArea_1.AreaId = 9 AND tblCoding_6.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                                              (tblBudgetDetailProjectArea_1.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                                          )
                                                      GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
                                     WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND (
                                             ( @areaId IN (37)) OR
                                             (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                             (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                             (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                             (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                             (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding_1.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
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




--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------




USE [ProgramBudDB]
GO

/****** Object:  StoredProcedure [dbo].[SP001_BudgetConfirmStatus_Update]    Script Date: 11/25/2024 1:12:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetConfirmStatus_Update]
    @YearId int ,
    @AreaId int ,
    @codingId int,
	@status int
AS
BEGIN
	if(@areaId  in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
begin

		declare @Count_BudgetDetailProjectAreaId int =(SELECT count(*)
												FROM            TblBudgets INNER JOIN
																		 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
																		 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
																		 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
												WHERE       (TblBudgets.TblYearId = @yearId) AND
															(tblBudgetDetailProjectArea.AreaId = @areaId) AND
															(TblBudgetDetails.tblCodingId = @CodingId))

			if(@Count_BudgetDetailProjectAreaId>=2)
begin
select ' تعداد رکورد بیشتر از یک مورد است ' as Message_DB
    return
end



			declare @BudgetDetailProjectAreaId int =(SELECT tblBudgetDetailProjectArea.id
												FROM            TblBudgets INNER JOIN
																		 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
																		 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
																		 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
												WHERE       (TblBudgets.TblYearId = @yearId) AND
															(tblBudgetDetailProjectArea.AreaId = @areaId) AND
															(TblBudgetDetails.tblCodingId = @CodingId))
                  
				  if(@BudgetDetailProjectAreaId is null or @BudgetDetailProjectAreaId='')
begin
select 'خطا در BudgetDetailProjectAreaId' as Message_DB
    return
end



update tblBudgetDetailProjectArea
set ConfirmStatus = @status

where id = @BudgetDetailProjectAreaId

end


END
GO


------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------



USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_Budget_Inline_Insert]    Script Date: 11/25/2024 1:13:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP001_Budget_Inline_Insert]
@Code nvarchar(50),
@Description nvarchar(2000),
@CodingId int,
@YearId int,
@AreaId int,
@Mosavab bigint,
@ProgramOperationDetailsId int
 
AS
BEGIN
--if(@yearId<>34) begin  select 'برای سال 1403 مجاز هستید' as Message_DB  return end

declare @ExecuteId int
if(@areaId not in (30,31,32,33,34,35,36)) begin  set @ExecuteId = 8  end
if(@areaId = 30) begin set @areaId=9  set @ExecuteId = 4  end
if(@areaId = 31) begin set @areaId=9  set @ExecuteId = 10 end
if(@areaId = 32) begin set @areaId=9  set @ExecuteId = 2  end
if(@areaId = 33) begin set @areaId=9  set @ExecuteId = 1  end
if(@areaId = 34) begin set @areaId=9  set @ExecuteId = 3  end
if(@areaId = 35) begin set @areaId=9  set @ExecuteId = 7  end
if(@areaId = 36) begin set @areaId=9  set @ExecuteId = 6  end




    declare @budgetId        int      = (select Id from TblBudgets where TblYearId = @yearId and TblAreaId = @areaId)
    declare @LevelNumber   tinyint    = (select levelNumber from tblCoding where id = @CodingId) +1
	declare @MotherId        int      = @CodingId -- (select MotherId from tblCoding where id = @CodingId)
	declare @budgetProcessId int      = (select TblBudgetProcessId from tblCoding where id = @CodingId)

	declare @MaxCode   nvarchar(20) = (SELECT max(tblCoding.Code)
												FROM            TblBudgets INNER JOIN
																		 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
																		 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
																		 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
																		 tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
																WHERE   (TblBudgets.TblYearId in (@yearId , @yearId-1)) AND
																	    (tblCoding.MotherId = @MotherId) AND
																	    (tblCoding.TblBudgetProcessId = @budgetProcessId) )
	if(@MaxCode is null or @MaxCode='')
begin
	    --select CONCAT('خطا:',@MaxCode) as Message_DB
        declare @currentCode    nvarchar(20)   =  (select Code from tblCoding where id = @CodingId)

            SET @MaxCode= @currentCode+'00'
	 --return
end
	declare @MaxCode2 nvarchar(20)= cast(@MaxCode as bigint)+1 

	
	declare @ProjectId int 
	if(@BudgetProcessId = 1)         begin set @ProjectId = 1 end
	if(@BudgetProcessId = 2)         begin set @ProjectId = 2 end
	if(@BudgetProcessId in (3,4,5))  begin set @ProjectId = 3 end
	
	
	declare  @ProgramOperationDetailId int = (SELECT TblProgramOperationDetails.Id
													FROM    TblProgramOperations INNER JOIN
															TblProgramOperationDetails ON TblProgramOperations.Id = TblProgramOperationDetails.TblProgramOperationId INNER JOIN
															TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id
													WHERE  (TblProgramOperations.TblAreaId = @areaId) AND
													       (TblProgramOperations.TblProgramId = 10) AND
													       (TblProgramOperationDetails.TblProjectId = @ProjectId))


-- if(@LevelNumber<>5 or @budgetProcessId<>3)
-- begin
--    select 'فعلا فقط برای سطح 5 و تملک سرمایه ای وارد شود' as Message_DB
-- return
-- end

--=========تست مانده


declare @Revenue bigint = (SELECT    sum(tblBudgetDetailProjectArea.Mosavab)
								FROM  TblBudgets INNER JOIN
									  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
								WHERE  (TblBudgets.TblYearId = @yearId) AND
								       (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
									   (tblCoding.TblBudgetProcessId = 1))
   
 --  declare @Revenue bigint 
 --if(@AreaId = 1) begin set @Revenue =  4600000000000  end
 --if(@AreaId = 2) begin set @Revenue =  12000000000000 end
 --if(@AreaId = 3) begin set @Revenue =  7300000000000  end
 --if(@AreaId = 4) begin set @Revenue =  5750000000000  end
 --if(@AreaId = 5) begin set @Revenue =  3000000000000  end
 --if(@AreaId = 6) begin set @Revenue =  1842000000000  end
 --if(@AreaId = 7) begin set @Revenue =  3900000000000  end
 --if(@AreaId = 8) begin set @Revenue =  5200000000000  end
 
declare @Current bigint = (SELECT   sum(tblBudgetDetailProjectArea.Mosavab)
								FROM  TblBudgets INNER JOIN
									  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
							   WHERE (TblBudgets.TblYearId = @yearId) AND
							         (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
									 (tblCoding.TblBudgetProcessId = 2))  
   
   
declare @Civil bigint = (SELECT    sum(tblBudgetDetailProjectArea.Mosavab)
							FROM   TblBudgets INNER JOIN
								   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
								   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
								   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
								   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
					       WHERE  (TblBudgets.TblYearId = @yearId) AND
						          (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
								  (tblCoding.TblBudgetProcessId = 3))   
   
declare @Motomarkez bigint = (SELECT   sum(tblBudgetDetailProjectArea.Mosavab)
								FROM   TblBudgets INNER JOIN
									   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
								WHERE (TblBudgets.TblYearId = @yearId) AND
									  (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
									  (tblCoding.TblBudgetProcessId = 8))     
   
   
declare @Komak bigint = (SELECT  sum(tblBudgetDetailProjectArea.Mosavab)
								FROM   TblBudgets INNER JOIN
									   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
								WHERE (TblBudgets.TblYearId = @yearId) AND
									  (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
									  (tblCoding.TblBudgetProcessId = 10))     
   
   


declare @Balance bigint = isnull(@Revenue,0) - isnull(@Current,0) - isnull(@Civil,0) - isnull(@Motomarkez,0) + isnull(@Komak,0) - isnull(@Mosavab,0)
--select dbo.seprator(cast(@Balance as nvarchar(100))) as Message_DB
--return

--if(@AreaId <=8 and @Balance<0)
--begin
--    select 'مانده منفی می شود' as Message_DB
--	return
--end
--============================================
--===============کنترل بودجه معاونت ها

if(@areaId not in (30,31,32,33,34,35,36))
begin  
	declare @CivilExecute bigint
	if(@ExecuteId = 4 ) begin set @CivilExecute = 6500000000000  end-- شهر سازی
	if(@ExecuteId = 10) begin set @CivilExecute = 15000000000000 end-- معاونت فنی عمرانی
	if(@ExecuteId = 2)  begin set @CivilExecute = 6800000000000  end -- حمل و نقل و ترافیک
	if(@ExecuteId = 1)  begin set @CivilExecute = 3200000000000  end--خدمات شهری
	if(@ExecuteId = 3)  begin set @CivilExecute = 1190000000000  end -- فرهنگی
	if(@ExecuteId = 7)  begin set @CivilExecute =       0        end -- مالی اقتصادی
	if(@ExecuteId = 6)  begin set @CivilExecute =       0        end--برنامه ریزی


select @Civil = (SELECT  SUM(tblBudgetDetailProjectArea.Mosavab) AS Expr1
                 FROM TblBudgets INNER JOIN
                      TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                      tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                      tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                      tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                 WHERE (TblBudgets.TblYearId = @yearId) AND
                     (tblBudgetDetailProjectArea.AreaId = 9) AND
                     (tblCoding.TblBudgetProcessId = 3) AND
                     (tblCoding.ExecuteId = @ExecuteId))

declare  @Balance2 bigint  = @CivilExecute - isnull(@Civil,0) + isnull(@Mosavab,0)
--if(@Balance2<0 and @ExecuteId<>10)
--begin
-- select ' به مبلغ '+dbo.seprator(cast(@Balance2 as nvarchar(100)))+' منفی می شود ' as Message_DB
--return
--end
end
--==============================================================================================================================

insert into tblCoding ( MotherId ,   Code    ,  Description ,levelNumber  ,TblBudgetProcessId ,Show,Crud , ExecuteId )
values(@MotherId ,@MaxCode2  , @Description ,@LevelNumber , @budgetProcessId  ,  1 ,  1  ,@ExecuteId)
declare @Codeing_NewId int = SCOPE_IDENTITY()


insert into TblBudgetDetails ( BudgetId ,  tblCodingId   ,MosavabPublic)
                       values(@BudgetId , @Codeing_NewId ,   @Mosavab  )
declare @BudgetDetailId int = SCOPE_IDENTITY()

insert into tblBudgetDetailProject ( BudgetDetailId ,  ProgramOperationDetailsId , Mosavab )
						     values(@BudgetDetailId , @ProgramOperationDetailId  ,@Mosavab )
declare @BudgetDetailProjectId int = SCOPE_IDENTITY()

insert into tblBudgetDetailProjectArea( BudgetDetailProjectId ,  AreaId ,  Mosavab )
							    values(@BudgetDetailProjectId , @areaId , @Mosavab )

return






END


------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------


USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP005_ProjectTable_Update]    Script Date: 11/25/2024 1:13:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP005_ProjectTable_Update]
@Id int,
@ProjectName nvarchar(500), 
@DateFrom date,
@DateEnd  date,
@AreaArray nvarchar(50),
@ProjectScaleId tinyint
AS
BEGIN
update TblProjects
set  ProjectName = @ProjectName ,
     DateFrom = @DateFrom,
     DateEnd = @DateEnd ,
     AreaArray = @AreaArray,
     ProjectScaleId = @ProjectScaleId
where id = @Id
END


----------------------------------------
----------------------------------------
----------------------------------------
----------------------------------------
----------------------------------------
----------------------------------------


USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP005_ProjectTable_Insert]    Script Date: 11/25/2024 1:13:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP005_ProjectTable_Insert]
@ProjectName nvarchar(500) =NULL, 
@DateFrom date =NULL,
@DateEnd  date=NULL,
@AreaArray nvarchar(50),
@ProjectScaleId tinyint

AS
BEGIN
     if(@ProjectName is null or @ProjectName='')
begin
select 'نسبت به تکمیل اطلاعات نام پروژه اقدام فرمائید' as Message_DB
    return
end
insert into TblProjects( ProjectName , ProjectScaleId , AreaArray,DateFrom,DateEnd )
values(@ProjectName , @ProjectScaleId ,@AreaArray,@DateFrom,@DateEnd )
declare @ProjectId int = SCOPE_IDENTITY()

update TblProjects
set ProjectCode = cast(@ProjectId as nvarchar(50))
where id = @ProjectId

declare @AreaId int =  (select REPLACE(@AreaArray,'-',''))

declare @programOperationId int = (select Id from TblProgramOperations where TblProgramId = 10 and TblAreaId = @AreaId)

insert into TblProgramOperationDetails(TblProgramOperationId , TblProjectId)
								values(  @programOperationId , @ProjectId  )

END


---------------------------------
---------------------------------
---------------------------------
---------------------------------
---------------------------------



USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal3Area_Update]    Script Date: 11/25/2024 1:14:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP001_BudgetModal3Area_Update]
@Id int,
@Pishnahadi bigint,
@Mosavab bigint,
@EditArea bigint
AS
BEGIN
 declare @BudgetNext bigint = @Mosavab
 declare @YearId int =(SELECT   top(1)     TblBudgets.TblYearId
								FROM            TblBudgets INNER JOIN
														 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
														 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
														 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
								WHERE        (tblBudgetDetailProjectArea.id = @Id))



declare @AreaId int =(SELECT   top(1)   tblBudgetDetailProjectArea.AreaId
								FROM    TblBudgets INNER JOIN
									   	TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
										tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
										tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
								WHERE  (tblBudgetDetailProjectArea.id = @Id))

declare @CodingId int =(SELECT   top(1)   TblBudgetDetails.tblCodingId
								FROM    TblBudgets INNER JOIN
									   	TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
										tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
										tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
								WHERE  (tblBudgetDetailProjectArea.id = @Id))


declare @BudgetProcessId int = (select TblBudgetProcessId from tblCoding where id = @CodingId)



 declare @MosavabAgo bigint =(SELECT   Mosavab
								FROM      tblBudgetDetailProjectArea
								WHERE     (id = @Id))

declare @Revenue bigint = (SELECT    sum(tblBudgetDetailProjectArea.Mosavab)
								FROM  TblBudgets INNER JOIN
									  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
								WHERE  (TblBudgets.TblYearId = @yearId) AND
								       (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
									   (tblCoding.TblBudgetProcessId = 1))
 --declare @Revenue bigint 
 --if(@AreaId = 1) begin set @Revenue =  4600000000000  end
 --if(@AreaId = 2) begin set @Revenue =  12000000000000 end
 --if(@AreaId = 3) begin set @Revenue =  7300000000000  end
 --if(@AreaId = 4) begin set @Revenue =  6000000000000  end
 --if(@AreaId = 5) begin set @Revenue =  3000000000000  end
 --if(@AreaId = 6) begin set @Revenue =  1842000000000  end
 --if(@AreaId = 7) begin set @Revenue =  4000000000000  end
 --if(@AreaId = 8) begin set @Revenue =  5200000000000  end
   

declare @Current bigint = (SELECT   sum(tblBudgetDetailProjectArea.Mosavab)
								FROM  TblBudgets INNER JOIN
									  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
							   WHERE (TblBudgets.TblYearId = @yearId) AND
							         (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
									 (tblCoding.TblBudgetProcessId = 2))  
   
 

 --if(@AreaId = 1) begin set @Current =  4600000000000  end
 --if(@AreaId = 2) begin set @Current =  4250000000000  end
 --if(@AreaId = 3) begin set @Current =  3740000000000  end
 --if(@AreaId = 4) begin set @Current =  3015000000000  end
 --if(@AreaId = 5) begin set @Current =  2420000000000  end
 --if(@AreaId = 6) begin set @Current =  2680000000000  end
 --if(@AreaId = 7) begin set @Current =  2750000000000  end
 --if(@AreaId = 8) begin set @Current =  2750000000000  end 
  

 

declare @Civil bigint = (SELECT    sum(tblBudgetDetailProjectArea.Mosavab)
							FROM   TblBudgets INNER JOIN
								   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
								   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
								   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
								   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
					       WHERE  (TblBudgets.TblYearId = @yearId) AND
						          (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
								  (tblCoding.TblBudgetProcessId = 3))   
   
declare @Motomarkez bigint = (SELECT   sum(tblBudgetDetailProjectArea.Mosavab)
								FROM   TblBudgets INNER JOIN
									   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
								WHERE (TblBudgets.TblYearId = @yearId) AND
									  (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
									  (tblCoding.TblBudgetProcessId = 8))     
   
   
declare @Komak bigint = (SELECT  sum(tblBudgetDetailProjectArea.Mosavab)
								FROM   TblBudgets INNER JOIN
									   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
								WHERE (TblBudgets.TblYearId = @yearId) AND
									  (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
									  (tblCoding.TblBudgetProcessId = 10))     
   
   


declare @Balance bigint = isnull(@Revenue,0) - isnull(@Current,0) - isnull(@Civil,0) - isnull(@Motomarkez,0) + isnull(@Komak,0) + isnull(@MosavabAgo,0)-isnull(@BudgetNext,0)

--if(@AreaId <=8 AND @Balance<0 AND @BudgetProcessId=3 and @Mosavab>@MosavabAgo and @YearId=34)
--begin
--   select ' به مبلغ '+dbo.seprator(cast(@Balance as nvarchar(100)))+' منفی می شود ' as Message_DB
--	return
--end

--===============کنترل بودجه معاونت ها
 	declare @ExecuteId int =(SELECT     tblCoding.ExecuteId
									FROM   TblBudgets INNER JOIN
										   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
										   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
										   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
										   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
									WHERE (tblBudgetDetailProjectArea.id = @Id))
if(@AreaId = 9)
begin  
	declare @CivilExecute bigint
	if(@ExecuteId = 4 ) begin set @CivilExecute = 650000000000   end-- شهر سازی
	if(@ExecuteId = 10) begin set @CivilExecute = 15000000000000 end-- معاونت فنی عمرانی
	if(@ExecuteId = 2)  begin set @CivilExecute = 6800000000000  end -- حمل و نقل و ترافیک
	if(@ExecuteId = 1)  begin set @CivilExecute = 3200000000000  end--خدمات شهری
	if(@ExecuteId = 3)  begin set @CivilExecute = 1190000000000  end -- فرهنگی
	if(@ExecuteId = 7)  begin set @CivilExecute =       0        end -- مالی اقتصادی
	if(@ExecuteId = 6)  begin set @CivilExecute =       0        end--برنامه ریزی


select @Civil = (SELECT  SUM(tblBudgetDetailProjectArea.Mosavab) AS Expr1
                 FROM TblBudgets INNER JOIN
                      TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                      tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                      tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                      tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                 WHERE (TblBudgets.TblYearId = @yearId) AND
                     (tblBudgetDetailProjectArea.AreaId = 9) AND
                     (tblCoding.TblBudgetProcessId = 3) AND
                     (tblCoding.ExecuteId = @ExecuteId))

declare  @Balance2 bigint  = @CivilExecute - isnull(@Civil,0) + isnull(@MosavabAgo,0)-isnull(@BudgetNext,0)
--if(@Balance2<0 AND @Mosavab>@MosavabAgo and @YearId = 34)
--begin
-- select ' به مبلغ '+dbo.seprator(cast(@Balance2 as nvarchar(100)))+' منفی می شود ' as Message_DB
--return
--end

end




 DECLARE @areaShare Bigint;
 DECLARE @currentPishnahadi Bigint;
 DECLARE @currentMosavab Bigint;
 DECLARE @currentEdit Bigint;
 DECLARE @sql NVARCHAR(MAX);

 SET @sql = N'SELECT TOP(1) @areaShare = ShareProcessId' + CAST(@budgetProcessId AS NVARCHAR(10)) + ' FROM tblBudgetAreaShare WHERE AreaId = '+CAST(@areaId AS NVARCHAR(10))+' AND YearId = '+CAST(@yearId AS NVARCHAR(10))+';';

-- Execute dynamic SQL and retrieve the value into @areaShare
EXEC sp_executesql @sql, N'@areaShare BIGINT OUTPUT', @areaShare OUTPUT;



 SET @currentPishnahadi= (select Pishnahadi from tblBudgetDetailProjectArea where id = @Id)
--  SET @currentMosavab= (select Mosavab from tblBudgetDetailProjectArea where id = @Id)
--  SET @currentEdit= (select EditArea from tblBudgetDetailProjectArea where id = @Id)

 declare @currentSumPishnahadi Bigint =(SELECT  sum(tblBudgetDetailProjectArea.Pishnahadi)
                           FROM     TblBudgets INNER JOIN
                                    TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                    tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                    tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                    tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                           WHERE   (tblCoding.TblBudgetProcessId = @budgetProcessId) AND
                               (TblBudgets.TblYearId =@yearId) AND
                               (tblBudgetDetailProjectArea.AreaId =@AreaId))

--  declare @currentSumMosavab Bigint =(SELECT  sum(tblBudgetDetailProjectArea.Mosavab)
--                            FROM     TblBudgets INNER JOIN
--                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
--                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
--                            WHERE   (tblCoding.TblBudgetProcessId = @budgetProcessId) AND
--                                (TblBudgets.TblYearId =@yearId) AND
--                                (tblBudgetDetailProjectArea.AreaId =@AreaId))
-- 
--  declare @currentSumEdit Bigint =(SELECT  sum(tblBudgetDetailProjectArea.EditArea)
--                            FROM     TblBudgets INNER JOIN
--                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
--                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
--                            WHERE   (tblCoding.TblBudgetProcessId = @budgetProcessId) AND
--                                (TblBudgets.TblYearId =@yearId) AND
--                                (tblBudgetDetailProjectArea.AreaId =@AreaId))

 if(@areaShare is not null and @areaShare<@currentSumPishnahadi-@currentPishnahadi+@Pishnahadi)
begin
select CONCAT('خطا بودجه پیشنهادی - سهم منطقه ',@areaShare,' ریال می باشد و تنها',(@areaShare-@currentSumPishnahadi),'ریال آزاد می باشد') as Message_DB
    return
end
     
--  if(@areaShare is not null and @areaShare<@currentSumMosavab-@currentMosavab+@Mosavab)
--      begin
--          select CONCAT('خطا بودجه مصوب - سهم منطقه ',@areaShare,' ریال می باشد و تنها',(@areaShare-@currentSumMosavab),'ریال آزاد می باشد') as Message_DB
--          return
--      end
--      
--      

--  if(@areaShare is not null and @areaShare<@currentSumEdit-@currentEdit+@EditArea)
--      begin
--          select CONCAT('خطا بودجه پیشنهادی - سهم منطقه ',@areaShare,' ریال می باشد و تنها',(@areaShare-@currentSumEdit),'ریال آزاد می باشد') as Message_DB
--          return
--      end
     
     
--if(@YearId in (33,34))
--begin
update tblBudgetDetailProjectArea
set Pishnahadi = @Pishnahadi,
    Mosavab = @Mosavab,
    EditArea = @EditArea,
    ConfirmStatus=0
where id = @Id
--return
--end



--if(@YearId Not in (33,34))
--begin
--      update tblBudgetDetailProjectArea
--	   set --Mosavab = @Mosavab,
--		  --EditArea = @EditArea,
--		  Expense = @Mosavab
--		  where id = @Id
--END



END