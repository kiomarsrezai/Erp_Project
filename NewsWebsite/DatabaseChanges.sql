-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP500_BudgetBook]
    @YearId int,
	@AreaId int
AS

BEGIN


WITH CommonBudgetData AS (
    SELECT
        SUM(tblBudgetDetailProjectArea.Pishnahadi) AS Pishnahadi,
        SUM(tblBudgetDetailProjectArea.Mosavab) AS Mosavab,
        TblBudgetProcessId,
        TblAreas.Id AS AreaId

    FROM
        TblBudgets Inner Join
        TblBudgetDetails ON TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
        tblBudgetDetailProject ON tblBudgetDetailProject.BudgetDetailId = TblBudgetDetails.Id  INNER JOIN
        tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
        tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
        TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id

    WHERE
            TblBudgets.TblYearId = @YearId and
            TblAreas.ToGetherBudget='84'   AND (
            ( @AreaId IN (37)) OR
            (TblAreas.StructureId=1 AND @AreaId IN (10)) OR
            (TblAreas.StructureId=2 AND @AreaId IN (39)) OR
            (TblAreas.ToGetherBudget =10 AND @AreaId IN (40)) OR
            (TblAreas.ToGetherBudget =84 AND @AreaId IN (41)) OR
            (tblBudgetDetailProjectArea.AreaId = @AreaId AND  @AreaId in (11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
        )
    GROUP BY
        TblAreas.Id,
        tblCoding.TblBudgetProcessId
),
     NeyabatiData       AS ( SELECT AreaId,TblBudgetProcessId , Pishnahadi AS P_Neyabati, Mosavab AS M_Neyabati FROM CommonBudgetData WHERE TblBudgetProcessId = 9 ),
     DarKhazaneData     AS ( SELECT AreaId,TblBudgetProcessId , Pishnahadi AS P_Dar_Khazane, Mosavab AS M_Dar_Khazane FROM CommonBudgetData WHERE TblBudgetProcessId = 10 ),
     HagholamalData     AS ( SELECT AreaId,TblBudgetProcessId , Pishnahadi AS P_Hagholamal, Mosavab AS M_Hagholamal FROM CommonBudgetData WHERE TblBudgetProcessId = 11 ),
     MotomarkezData     AS ( SELECT AreaId,TblBudgetProcessId , Pishnahadi AS P_PayMotomarkez, Mosavab AS M_PayMotomarkez FROM CommonBudgetData WHERE TblBudgetProcessId = 8 ),
     DoyonSanavatiData  AS ( SELECT AreaId,TblBudgetProcessId , Pishnahadi AS P_Sanavati, Mosavab AS M_Sanavati FROM CommonBudgetData WHERE TblBudgetProcessId = 5 ),
     FinancialData      AS ( SELECT AreaId,TblBudgetProcessId , Pishnahadi AS P_Financial, Mosavab AS M_Financial FROM CommonBudgetData WHERE TblBudgetProcessId = 4 ),
     CivilData          AS ( SELECT AreaId,TblBudgetProcessId , Pishnahadi AS P_Civil, Mosavab AS M_Civil FROM CommonBudgetData WHERE TblBudgetProcessId = 3 ),
     CurrentData        AS ( SELECT AreaId,TblBudgetProcessId , Pishnahadi AS P_Current, Mosavab AS M_Current FROM CommonBudgetData WHERE TblBudgetProcessId = 2 ),
     RevenueData        AS ( SELECT AreaId,TblBudgetProcessId , Pishnahadi AS P_Revenue, Mosavab AS M_Revenue FROM CommonBudgetData WHERE TblBudgetProcessId = 1 ),



     CommonData AS (
         SELECT
             sum(ISNULL(RevenueData.M_Revenue, 0) - ISNULL(MotomarkezData.M_PayMotomarkez, 0)+ ISNULL(DarKhazaneData.M_Dar_Khazane, 0) + ISNULL(NeyabatiData.M_Neyabati,0)  + ISNULL(HagholamalData.M_Hagholamal,0))  AS M_Resources,
             sum(ISNULL(DarKhazaneData.M_Dar_Khazane, 0) + ISNULL(NeyabatiData.M_Neyabati,0)  + ISNULL(HagholamalData.M_Hagholamal,0) ) AS M_Khazane,
             sum(ISNULL(CurrentData.M_Current, 0) + ISNULL(CivilData.M_Civil, 0) +  ISNULL(DoyonSanavatiData.M_Sanavati, 0) +ISNULL(FinancialData.M_Financial, 0)) AS M_Costs,
             sum(ISNULL(RevenueData.P_Revenue, 0) - ISNULL(MotomarkezData.P_PayMotomarkez, 0)+ ISNULL(DarKhazaneData.P_Dar_Khazane, 0) + ISNULL(NeyabatiData.P_Neyabati,0)  + ISNULL(HagholamalData.P_Hagholamal,0))  AS P_Resources,
             sum(ISNULL(DarKhazaneData.P_Dar_Khazane, 0) + ISNULL(NeyabatiData.P_Neyabati,0)  + ISNULL(HagholamalData.P_Hagholamal,0) ) AS P_Khazane,
             sum(ISNULL(CurrentData.P_Current, 0) + ISNULL(CivilData.P_Civil, 0) +  ISNULL(DoyonSanavatiData.P_Sanavati, 0) +ISNULL(FinancialData.P_Financial, 0)) AS P_Costs

         FROM TblAreas
                  LEFT JOIN NeyabatiData ON TblAreas.Id = NeyabatiData.AreaId
                  LEFT JOIN DarKhazaneData ON TblAreas.Id = DarKhazaneData.AreaId
                  LEFT JOIN HagholamalData ON TblAreas.Id = HagholamalData.AreaId
                  LEFT JOIN MotomarkezData ON TblAreas.Id = MotomarkezData.AreaId
                  LEFT JOIN DoyonSanavatiData ON TblAreas.Id = DoyonSanavatiData.AreaId
                  LEFT JOIN FinancialData ON TblAreas.Id = FinancialData.AreaId
                  LEFT JOIN CivilData ON TblAreas.Id = CivilData.AreaId
                  LEFT JOIN CurrentData ON TblAreas.Id = CurrentData.AreaId
                  LEFT JOIN RevenueData ON TblAreas.Id = RevenueData.AreaId



     )



SELECT * FROM CommonData


END
go













-- auto-generated definition
ALTER PROCEDURE SP500_BudgetBook_Codings
    @YearId INT,
    @AreaId INT,
    @BudgetProcessId INT,
    @Codings NVARCHAR(MAX)
AS
BEGIN
    -- Temporary table to store the results
CREATE TABLE #Results (
                          Code NVARCHAR(50),
                          Pishnahadi BIGINT,
                          Mosavab BIGINT
);

-- Split the @Codings string into individual codes
DECLARE @Code NVARCHAR(50);
    DECLARE @Pos INT;
    SET @Codings = LTRIM(RTRIM(@Codings)) + ','; -- Ensure trailing comma for processing
    SET @Pos = CHARINDEX(',', @Codings);

    WHILE @Pos > 0
BEGIN
            SET @Code = LTRIM(RTRIM(LEFT(@Codings, @Pos - 1)));
            SET @Codings = SUBSTRING(@Codings, @Pos + 1, LEN(@Codings));
            SET @Pos = CHARINDEX(',', @Codings);

            -- Perform the calculation for the current code
INSERT INTO #Results (Code, Pishnahadi, Mosavab)
SELECT
    @Code AS Code,
    isnull(SUM(tblBudgetDetailProjectArea.Pishnahadi),0) AS Pishnahadi,
    isnull(SUM(tblBudgetDetailProjectArea.Mosavab),0) AS Mosavab
FROM
    TblBudgets
        INNER JOIN TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId
        INNER JOIN tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId
        INNER JOIN tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
        INNER JOIN TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
        INNER JOIN tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
        LEFT JOIN tblCoding AS tblCoding_2 ON tblCoding.MotherId = tblCoding_2.Id
        LEFT JOIN tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id
        LEFT JOIN tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id
        LEFT JOIN tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id
        LEFT JOIN tblCoding AS tblCoding_5 ON tblCoding_4.MotherId = tblCoding_5.Id
WHERE
        TblBudgets.TblYearId = @YearId
  AND tblCoding.TblBudgetProcessId = @BudgetProcessId
  AND (@Code IN (tblCoding.Code, tblCoding_2.Code, tblCoding_3.Code, tblCoding_1.Code, tblCoding_4.Code, tblCoding_5.Code))
  AND (
        ( @AreaId IN (37)) OR
        (TblAreas.StructureId=1 AND @AreaId IN (10)) OR
        (TblAreas.StructureId=2 AND @AreaId IN (39)) OR
        (TblAreas.ToGetherBudget =10 AND @AreaId IN (40)) OR
        (TblAreas.ToGetherBudget =84 AND @AreaId IN (41)) OR
        (tblBudgetDetailProjectArea.AreaId = @AreaId AND  @AreaId in (11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
    );
END;

    -- Return the results
SELECT * FROM #Results;

-- Clean up
DROP TABLE #Results;
END;
go





ALTER PROCEDURE [dbo].[SP500_BudgetBook_List]
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
                  TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
              WHERE        (tblCoding_1.TblBudgetProcessId = @BudgetProcessId)     AND (
                      ( @areaId IN (37)) OR
                      (TblAreas.StructureId=1 AND @areaId IN (10)) OR
                      (TblAreas.StructureId=2 AND @areaId IN (39)) OR
                      (TblAreas.ToGetherBudget =10 AND @areaId IN (40)) OR
                      (TblAreas.ToGetherBudget =84 AND @areaId IN (41)) OR
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

