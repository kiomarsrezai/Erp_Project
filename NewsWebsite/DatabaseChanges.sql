USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_Edit]    Script Date: 11/19/2024 5:16:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP002_Edit]
@yearId int , 
@areaId int,
@budgetProcessId int
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

SELECT        tbl2.CodingId, tblCoding_4.Code , tblCoding_4.Description,tbl2.Mosavab,tbl2.Edit,tbl2.Supply ,tbl2.Expense ,
              tbl2.NeedEditYearNow, tblCoding_4.levelNumber ,tblCoding_4.Crud,tbl2.ProctorId,tbl2.ExecutionId, proctors.ProctorName AS proctorName,executors.ProctorName AS executorName, CreditAmount AS CreditAmount
FROM            (SELECT        CodingId, isnull(SUM(Mosavab),0) AS Mosavab, isnull(SUM(EditArea),0) AS Edit , isnull(sum(Supply),0) as Supply, isnull(SUM(Expense),0) AS Expense ,
                     isnull(sum(NeedEditYearNow),0) as NeedEditYearNow
                      ,CASE WHEN COUNT(DISTINCT ProctorId) = 0 THEN 0  WHEN COUNT(DISTINCT ProctorId) = 1 THEN MAX(ProctorId) ELSE -1 END AS ProctorId ,CASE WHEN COUNT(DISTINCT ExecutionId) = 0 THEN 0 WHEN COUNT(DISTINCT ExecutionId) = 1 THEN MAX(ExecutionId) ELSE -1 END AS ExecutionId
                      ,ISNULL(sum(CreditAmount),0) as CreditAmount


                 FROM            (

--سطح اول
                                     SELECT        tblCoding_5.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.NeedEditYearNow AS NeedEditYearNow
                                          ,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,der_Supply.CreditAmount AS CreditAmount
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
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT OUTER JOIN
                                                     (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                                                      FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                                      TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                                      tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                                      tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                                      tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                                      tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                                      TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                                                      WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                                                      GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
                                     WHERE   (TblBudgets.TblYearId = @YearId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
                                         (
                                                 ( @areaId IN (37)) OR
                                                 (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                 (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                 (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                 (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                             )
                                     union all
----------سطح 2	

                                     SELECT        tblCoding_4.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.NeedEditYearNow AS NeesEditYearNow
                                          ,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,der_Supply.CreditAmount AS CreditAmount
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                                                     tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
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
                                                      WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                                                      GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
                                     WHERE    (TblBudgets.TblYearId = @YearId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
                                         (
                                                 ( @areaId IN (37)) OR
                                                 (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                 (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                 (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                 (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                             )
                                     UNION ALL

----سطح 3
                                     SELECT        tblCoding_1.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.NeedEditYearNow AS NeesEditYearNow
                                          ,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,der_Supply.CreditAmount AS CreditAmount
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                                                     tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
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
                                                      WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                                                      GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
                                     WHERE     (TblBudgets.TblYearId = @YearId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
                                         (
                                                 ( @areaId IN (37)) OR
                                                 (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                 (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                 (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                 (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                             )

--سطح 4
                                     union all
                                     SELECT        tblCoding_3.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.NeedEditYearNow AS NeesEditYearNow
                                          ,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,der_Supply.CreditAmount AS CreditAmount
                                     FROM            tblCoding AS tblCoding_2 INNER JOIN
                                                     TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
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
                                                      WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                                                      GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
                                     WHERE    (TblBudgets.TblYearId = @YearId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
                                         (
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
                                     SELECT        tblCoding_2.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.NeedEditYearNow AS NeesEditYearNow
                                          ,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,der_Supply.CreditAmount AS CreditAmount
                                     FROM            TblBudgets INNER JOIN
                                                     TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                     tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                     tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                     tblCoding AS tblCoding_2 ON tblCoding.MotherId = tblCoding_2.Id INNER JOIN
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
                                                      WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                                                      GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
                                     WHERE    (TblBudgets.TblYearId = @YearId) AND
                                         (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
                                         (
                                                 ( @areaId IN (37)) OR
                                                 (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                 (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                 (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                 (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                                             )
                                     union all
--سطح 6
                                     SELECT        tblCoding_3.MotherId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.NeedEditYearNow AS NeesEditYearNow
                                          ,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,der_Supply.CreditAmount AS CreditAmount
                                     FROM            TblBudgets AS TblBudgets_2 INNER JOIN
                                                     TblBudgetDetails AS TblBudgetDetails_2 ON TblBudgets_2.Id = TblBudgetDetails_2.BudgetId INNER JOIN
                                                     tblCoding AS tblCoding_3 ON TblBudgetDetails_2.tblCodingId = tblCoding_3.Id INNER JOIN
                                                     tblBudgetDetailProject AS tblBudgetDetailProject_2 ON TblBudgetDetails_2.Id = tblBudgetDetailProject_2.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT OUTER JOIN
                                                     (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                                                      FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                                      TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                                      tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                                      tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                                      tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                                      tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                                      TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                                                      WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                                                      GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
                                     WHERE   (TblBudgets_2.TblYearId = @YearId) AND
                                         (tblCoding_3.TblBudgetProcessId = @BudgetProcessId) AND
                                         (
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
                                     SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.NeedEditYearNow AS NeesEditYearNow
                                          ,tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,der_Supply.CreditAmount AS CreditAmount
                                     FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                     TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                     tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                     tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                     tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                     TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT OUTER JOIN
                                                     (SELECT        tblRequestBudget.BudgetDetailProjectAreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                                                      FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                                      TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                                      tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                                      tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                                      tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                                      tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                                                                      TblAreas AS TblAreas_3 ON tblBudgetDetailProjectArea_1.AreaId = TblAreas_3.Id
                                                      WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId) AND (TblAreas_3.StructureId = 1)
                                                      GROUP BY tblRequestBudget.BudgetDetailProjectAreaId) AS der_Supply ON tblBudgetDetailProjectArea.id = der_Supply.BudgetDetailProjectAreaId
                                     WHERE    (TblBudgets_1.TblYearId = @YearId) AND
                                         (tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND
                                         (
                                                 ( @areaId IN (37)) OR
                                                 (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                                                 (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                                                 (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                                                 (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
                                                 (tblBudgetDetailProjectArea.AreaId = 9 AND tblCoding_1.ExecuteId = @ExecuteId AND  @areaId in (30,31,32,33,34,35,36,42,43,44)) OR
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