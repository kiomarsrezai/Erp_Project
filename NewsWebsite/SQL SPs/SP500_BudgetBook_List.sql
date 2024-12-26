-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP500_BudgetBook_List]
@yearId int, 
@areaId int,
@budgetProcessId int
AS
BEGIN

WITH CCC AS ( SELECT
                  tblCoding_1.Id AS CodingId0,
                  tblCoding_1.MotherId AS CodingId1,
                  tblCoding_2.MotherId AS CodingId2,
                  tblCoding_3.MotherId AS CodingId3,
                  tblCoding_4.MotherId AS CodingId4,
                  tblCoding_5.MotherId AS CodingId5,
                  tblCoding_6.MotherId AS CodingId6,
                  TblBudgets.TblYearId AS yearId,
                  tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea, tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, tblBudgetDetailProjectArea.PishnahadiCash AS PishnahadiCash, tblBudgetDetailProjectArea.PishnahadiNonCash AS PishnahadiNonCash, tblBudgetDetailProjectArea.Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   tblBudgetDetailProjectArea.ProctorId AS ProctorId ,tblBudgetDetailProjectArea.ExecutionId AS ExecutionId,tblBudgetDetailProjectArea.Last3Month AS Last3Month,tblBudgetDetailProjectArea.Last9Month AS Last9Month
              FROM
                  TblBudgets INNER JOIN
                  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId  INNER JOIN
                  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                  tblCoding AS tblCoding_1 ON TblBudgetDetails.tblCodingId = tblCoding_1.Id LEFT JOIN
                  tblCoding AS tblCoding_2 ON tblCoding_1.MotherId = tblCoding_2.Id  LEFT JOIN
                  tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id LEFT JOIN
                  tblCoding AS tblCoding_4 ON tblCoding_3.MotherId = tblCoding_4.Id LEFT JOIN
                  tblCoding AS tblCoding_5 ON tblCoding_4.MotherId = tblCoding_5.Id LEFT JOIN
                  tblCoding AS tblCoding_6 ON tblCoding_5.MotherId = tblCoding_6.Id LEFT JOIN
                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                  TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblAreasTogether.YearId =TblBudgets.TblYearId

              WHERE        (tblCoding_1.TblBudgetProcessId = @BudgetProcessId)     AND (
                      ( @areaId IN (37)) OR
                      (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                      (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                      (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
                      (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41)) OR
                      (tblBudgetDetailProjectArea.AreaId = @areaId AND  @areaId in (11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
                  )
)


SELECT        tbl2.CodingId, tblCoding_4.Code , tblCoding_4.Description,tbl2.MosavabLastYear,tbl2.Mosavab,tbl2.Edit,tbl2.Supply as  CreditAmount,tbl2.Expense ,PishnahadiCash,PishnahadiNonCash,
              tbl2.Pishnahadi, tblCoding_4.levelNumber ,tblCoding_4.Crud,ConfirmStatus AS ConfirmStatus,isNewYear AS isNewYear,tbl2.ProctorId,tbl2.ExecutionId,tbl2.Last3Month,tbl2.Last9Month, proctors.ProctorName AS proctorName,executors.ProctorName AS executorName
FROM            (SELECT CodingId, isnull(SUM(MosavabLastYear),0) AS MosavabLastYear, isnull(SUM(Mosavab),0) AS Mosavab, isnull(SUM(EditArea),0) AS Edit , SUM(Supply) as Supply,isnull(SUM(Expense),0) AS Expense ,isnull(sum(PishnahadiCash),0) as PishnahadiCash,isnull(sum(PishnahadiNonCash),0) as PishnahadiNonCash,isnull(sum(Pishnahadi),0) as Pishnahadi,isnull(min(ConfirmStatus),0) AS ConfirmStatus ,
                        max(isNewYear) AS isNewYear ,isnull(sum(Last3Month),0) AS Last3Month,isnull(sum(Last9Month),0) AS Last9Month
                         ,CASE WHEN COUNT(DISTINCT ProctorId) = 0 THEN 0  WHEN COUNT(DISTINCT ProctorId) <=2 THEN MAX(ProctorId) ELSE -1 END AS ProctorId ,CASE WHEN COUNT(DISTINCT ExecutionId) = 0 THEN 0 WHEN COUNT(DISTINCT ExecutionId) <=2 THEN MAX(ExecutionId) ELSE -1 END AS ExecutionId
                 FROM(


                         select  CodingId6 AS CodingId, Mosavab AS MosavabLastYear , 0 AS Mosavab, EditArea, Supply, Expense, 0 AS PishnahadiCash, 0 AS PishnahadiNonCash, 0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear , 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                         from CCC
                         where yearId = @YearId - 1
                         UNION ALL
                         select  CodingId6 AS CodingId, 0 AS MosavabLastYear,Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, PishnahadiCash AS PishnahadiCash, PishnahadiNonCash AS PishnahadiNonCash, Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   ProctorId AS ProctorId ,ExecutionId AS ExecutionId,Last3Month AS Last3Month,Last9Month AS Last9Month
                         from CCC
                         where yearId = @YearId

                         UNION ALL

                         select  CodingId5 AS CodingId,  Mosavab AS MosavabLastYear , 0 AS Mosavab, EditArea, Supply, Expense, 0 AS PishnahadiCash, 0 AS PishnahadiNonCash, 0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear , 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                         from CCC
                         where yearId = @YearId - 1
                         UNION ALL
                         select  CodingId5 AS CodingId,0 AS MosavabLastYear,Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, PishnahadiCash AS PishnahadiCash, PishnahadiNonCash AS PishnahadiNonCash, Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   ProctorId AS ProctorId ,ExecutionId AS ExecutionId,Last3Month AS Last3Month,Last9Month AS Last9Month
                         from CCC
                         where yearId = @YearId


                         UNION ALL

                         select  CodingId4 AS CodingId,  Mosavab AS MosavabLastYear , 0 AS Mosavab, EditArea, Supply, Expense, 0 AS PishnahadiCash, 0 AS PishnahadiNonCash, 0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear , 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                         from CCC
                         where yearId = @YearId - 1
                         UNION ALL
                         select  CodingId4 AS CodingId, 0 AS MosavabLastYear,Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, PishnahadiCash AS PishnahadiCash, PishnahadiNonCash AS PishnahadiNonCash, Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   ProctorId AS ProctorId ,ExecutionId AS ExecutionId,Last3Month AS Last3Month,Last9Month AS Last9Month
                         from CCC
                         where yearId = @YearId


                         UNION ALL

                         select  CodingId3 AS CodingId,  Mosavab AS MosavabLastYear , 0 AS Mosavab, EditArea, Supply, Expense, 0 AS PishnahadiCash, 0 AS PishnahadiNonCash, 0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear , 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                         from CCC
                         where yearId = @YearId - 1
                         UNION ALL
                         select  CodingId3 AS CodingId, 0 AS MosavabLastYear,Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, PishnahadiCash AS PishnahadiCash, PishnahadiNonCash AS PishnahadiNonCash, Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   ProctorId AS ProctorId ,ExecutionId AS ExecutionId,Last3Month AS Last3Month,Last9Month AS Last9Month
                         from CCC
                         where yearId = @YearId


                         UNION ALL

                         select  CodingId2 AS CodingId,  Mosavab AS MosavabLastYear , 0 AS Mosavab, EditArea, Supply, Expense, 0 AS PishnahadiCash, 0 AS PishnahadiNonCash, 0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear , 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                         from CCC
                         where yearId = @YearId - 1
                         UNION ALL
                         select  CodingId2 AS CodingId,0 AS MosavabLastYear,Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, PishnahadiCash AS PishnahadiCash, PishnahadiNonCash AS PishnahadiNonCash, Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   ProctorId AS ProctorId ,ExecutionId AS ExecutionId,Last3Month AS Last3Month,Last9Month AS Last9Month
                         from CCC
                         where yearId = @YearId


                         UNION ALL

                         select  CodingId1 AS CodingId,  Mosavab AS MosavabLastYear , 0 AS Mosavab, EditArea, Supply, Expense, 0 AS PishnahadiCash, 0 AS PishnahadiNonCash, 0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear , 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                         from CCC
                         where yearId = @YearId - 1
                         UNION ALL
                         select  CodingId1 AS CodingId, 0 AS MosavabLastYear,Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, PishnahadiCash AS PishnahadiCash, PishnahadiNonCash AS PishnahadiNonCash, Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   ProctorId AS ProctorId ,ExecutionId AS ExecutionId,Last3Month AS Last3Month,Last9Month AS Last9Month
                         from CCC
                         where yearId = @YearId

                         UNION ALL

                         select  CodingId0 AS CodingId,  Mosavab AS MosavabLastYear , 0 AS Mosavab, EditArea, Supply, Expense, 0 AS PishnahadiCash, 0 AS PishnahadiNonCash, 0 AS Pishnahadi,1 AS ConfirmStatus, 0 AS isNewYear , 0 AS ProctorId, 0 AS ExecutionId, 0 AS Last3Month, 0 AS Last9Month
                         from CCC
                         where yearId = @YearId - 1
                         UNION ALL
                         select  CodingId0 AS CodingId, 0 AS MosavabLastYear,Mosavab, 0 AS EditArea,0 as supply, 0 AS Expense, PishnahadiCash AS PishnahadiCash, PishnahadiNonCash AS PishnahadiNonCash, Pishnahadi AS Pishnahadi,ConfirmStatus, 1 AS isNewYear,   ProctorId AS ProctorId ,ExecutionId AS ExecutionId,Last3Month AS Last3Month,Last9Month AS Last9Month
                         from CCC
                         where yearId = @YearId
                     ) AS tbl1
                 GROUP BY CodingId) AS tbl2 INNER JOIN
                tblCoding AS tblCoding_4 ON tbl2.CodingId = tblCoding_4.Id LEFT JOIN
                tblProctor AS proctors On tbl2.ProctorId= proctors.Id LEFT JOIN
                tblProctor AS executors On tbl2.ExecutionId= executors.Id

ORDER BY  tblCoding_4.Code,tblCoding_4.levelNumber



    return

end
go

