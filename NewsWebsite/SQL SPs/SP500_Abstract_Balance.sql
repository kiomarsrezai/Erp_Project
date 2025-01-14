-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP500_Abstract_Balance]
    @YearId int,
    @type NVARCHAR(50)
AS
BEGIN

WITH CommonBudgetData AS (
    SELECT
        (CASE
             WHEN tblBudgetDetailProjectArea.AreaId != 9 OR (tblBudgetDetailProjectArea.AreaId = 9 and (tblCoding.ExecuteId is null or tblCoding.ExecuteId in (5,8,9))) THEN tblBudgetDetailProjectArea.AreaId
                 WHEN tblBudgetDetailProjectArea.AreaId = 9 and (tblCoding.ExecuteId is not null or tblCoding.ExecuteId not in (5,8,9)) THEN TblAreas.Id
                 ELSE 0
                END) AS AreaId,
        tblCoding.TblBudgetProcessId,
        SUM(CASE WHEN @type = 'mosavab' THEN tblBudgetDetailProjectArea.Mosavab
                 WHEN @type = 'eslahi' THEN tblBudgetDetailProjectArea.EditArea
                 WHEN @type = 'pishnahadi' THEN tblBudgetDetailProjectArea.Pishnahadi
                 ELSE 0
            END) AS amount,
        SUM(CASE WHEN @type = 'mosavab' THEN 0
                 WHEN @type = 'eslahi' THEN 0
                 WHEN @type = 'pishnahadi' THEN tblBudgetDetailProjectArea.PishnahadiNonCash
                 ELSE 0
            END) AS amountNonCash,
        SUM(tblBudgetDetailProjectArea.Expense) AS Expense

    FROM
        tblBudgetDetailProject INNER JOIN
        tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
        TblBudgetDetails ON tblBudgetDetailProject.BudgetDetailId = TblBudgetDetails.Id INNER JOIN
        tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
        TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id
                               LEFT JOIN TblAreas ON tblCoding.ExecuteId = TblAreas.ExecuteId


    WHERE
            TblBudgets.TblYearId = @YearId
    GROUP BY
        (CASE
             WHEN tblBudgetDetailProjectArea.AreaId != 9 OR (tblBudgetDetailProjectArea.AreaId = 9 and (tblCoding.ExecuteId is null or tblCoding.ExecuteId in (5,8,9))) THEN tblBudgetDetailProjectArea.AreaId
                 WHEN tblBudgetDetailProjectArea.AreaId = 9 and (tblCoding.ExecuteId is not null or tblCoding.ExecuteId not in (5,8,9)) THEN TblAreas.Id
                 ELSE 0
                END),
        tblCoding.TblBudgetProcessId
),
     NeyabatiData           AS ( SELECT AreaId, amount AS MosavabNeyabati, Expense AS ExpenseNeyabati FROM CommonBudgetData WHERE TblBudgetProcessId = 9 ),
     DarKhazaneData         AS ( SELECT AreaId, amount AS MosavabDar_Khazane, Expense AS ExpenseDar_Khazane FROM CommonBudgetData WHERE TblBudgetProcessId = 10 ),
     HagholamalData         AS ( SELECT AreaId, amount AS MosavabHagholamal, Expense AS ExpenseHagholamal FROM CommonBudgetData WHERE TblBudgetProcessId = 11 ),
     MotomarkezData         AS ( SELECT AreaId, amount AS MosavabPayMotomarkez, Expense AS ExpensePayMotomarkez FROM CommonBudgetData WHERE TblBudgetProcessId = 8 ),
     DoyonSanavatiData      AS ( SELECT AreaId, amount AS MosavabSanavati, Expense AS ExpenseDoyonSanavatiGhatei FROM CommonBudgetData WHERE TblBudgetProcessId = 5 ),
     FinancialData          AS ( SELECT AreaId, amount AS MosavabFinancial, Expense AS ExpenseFinancial FROM CommonBudgetData WHERE TblBudgetProcessId = 4 ),
     CivilDataCash          AS ( SELECT AreaId, amount-amountNonCash AS MosavabCivil, Expense AS ExpenseCivil FROM CommonBudgetData WHERE TblBudgetProcessId = 3 ),
     CivilDataNonCash       AS ( SELECT AreaId, amountNonCash AS MosavabCivil, Expense AS ExpenseCivil FROM CommonBudgetData WHERE TblBudgetProcessId = 3 ),
     CurrentDataCash        AS ( SELECT AreaId, amount-amountNonCash AS MosavabCurrent, Expense AS ExpenseCurrent FROM CommonBudgetData WHERE TblBudgetProcessId = 2 ),
     CurrentDataNonCash     AS ( SELECT AreaId, amountNonCash AS MosavabCurrent, Expense AS ExpenseCurrent FROM CommonBudgetData WHERE TblBudgetProcessId = 2 ),
     RevenueData            AS ( SELECT AreaId, amount AS MosavabRevenue, Expense AS ExpenseRevenue FROM CommonBudgetData WHERE TblBudgetProcessId = 1 ),



     CommonData AS (
         SELECT tttt.*,TblAreasTogether.ToGetherBudget from (select TblAreas.Id,

                                                                    0                                                                                                                                   as isSummary,
                                                                    TblAreas.AreaNameShort                                                                                                              AS AreaName,
                                                                    ISNULL(RevenueData.MosavabRevenue, 0)                                                                                               AS MosavabRevenue,
                                                                    ISNULL(MotomarkezData.MosavabPayMotomarkez, 0)                                                                                      AS MosavabPayMotomarkez,
                                                                    ISNULL(DarKhazaneData.MosavabDar_Khazane, 0)                                                                                        AS MosavabDar_Khazane,
                                                                    ISNULL(NeyabatiData.MosavabNeyabati, 0)                                                                                             AS MosavabNeyabati,
                                                                    ISNULL(HagholamalData.MosavabHagholamal, 0)                                                                                         AS MosavabHagholamal,
                                                                    ISNULL(RevenueData.MosavabRevenue, 0) - ISNULL(MotomarkezData.MosavabPayMotomarkez, 0) + ISNULL(DarKhazaneData.MosavabDar_Khazane, 0) +
                                                                    ISNULL(NeyabatiData.MosavabNeyabati, 0) + ISNULL(HagholamalData.MosavabHagholamal, 0)                                               AS Resoures,
                                                                    ISNULL(CurrentDataCash.MosavabCurrent, 0)                                                                                           AS MosavabCurrentCash,
                                                                    ISNULL(CurrentDataNonCash.MosavabCurrent, 0)                                                                                        AS MosavabCurrentNonCash,
                                                                    ISNULL(CivilDataCash.MosavabCivil, 0)                                                                                               AS MosavabCivilCash,
                                                                    ISNULL(CivilDataNonCash.MosavabCivil, 0)                                                                                            AS MosavabCivilNonCash,
                                                                    ISNULL(FinancialData.MosavabFinancial, 0)                                                                                           AS MosavabFinancial,
                                                                    ISNULL(DoyonSanavatiData.MosavabSanavati, 0)                                                                                        AS MosavabSanavati,
                                                                    ISNULL(CurrentDataCash.MosavabCurrent, 0) + ISNULL(CurrentDataNonCash.MosavabCurrent, 0) + ISNULL(CivilDataCash.MosavabCivil, 0) +
                                                                    ISNULL(CivilDataNonCash.MosavabCivil, 0) + ISNULL(DoyonSanavatiData.MosavabSanavati, 0) + ISNULL(FinancialData.MosavabFinancial, 0) AS Costs

                                                             FROM TblAreas

                                                                      LEFT JOIN NeyabatiData ON TblAreas.Id = NeyabatiData.AreaId
                                                                      LEFT JOIN DarKhazaneData ON TblAreas.Id = DarKhazaneData.AreaId
                                                                      LEFT JOIN HagholamalData ON TblAreas.Id = HagholamalData.AreaId
                                                                      LEFT JOIN MotomarkezData ON TblAreas.Id = MotomarkezData.AreaId
                                                                      LEFT JOIN DoyonSanavatiData ON TblAreas.Id = DoyonSanavatiData.AreaId
                                                                      LEFT JOIN FinancialData ON TblAreas.Id = FinancialData.AreaId
                                                                      LEFT JOIN CivilDataCash ON TblAreas.Id = CivilDataCash.AreaId
                                                                      LEFT JOIN CivilDataNonCash ON TblAreas.Id = CivilDataNonCash.AreaId
                                                                      LEFT JOIN CurrentDataCash ON TblAreas.Id = CurrentDataCash.AreaId
                                                                      LEFT JOIN CurrentDataNonCash ON TblAreas.Id = CurrentDataNonCash.AreaId
                                                                      LEFT JOIN RevenueData ON TblAreas.Id = RevenueData.AreaId) as tttt
                                                                LEFT JOIN TblAreasTogether ON tttt.Id = TblAreasTogether.AreaId AND TblAreasTogether.YearId = @YearId
     )

SELECT * FROM (
                  SELECT * FROM CommonData

                  UNION ALL

                  SELECT
                      60 AS Id,1 as IsSummary, 'جمع مناطق' AS AreaName,SUM(MosavabRevenue) AS MosavabRevenue,SUM(MosavabPayMotomarkez) AS MosavabPayMotomarkez,SUM(MosavabDar_Khazane) AS MosavabDar_Khazane,SUM(MosavabNeyabati) AS MosavabNeyabati,SUM(MosavabHagholamal) AS MosavabHagholamal,SUM(Resoures) AS Resoures,SUM(MosavabCurrentCash) AS MosavabCurrentCash,SUM(MosavabCurrentNonCash) AS MosavabCurrentNonCash,SUM(MosavabCivilCash) AS MosavabCivilCash,SUM(MosavabCivilNonCash) AS MosavabCivilNonCash,SUM(MosavabFinancial) AS MosavabFinancial,SUM(MosavabSanavati) AS MosavabSanavati,SUM(Costs)AS Costs,0 as ToGetherBudget
                  FROM CommonData
                  WHERE Id IN (1,2,3,4,5,6,7,8)

                  UNION ALL

                  SELECT
                      61 AS Id,1 as IsSummary, 'ستاد' AS AreaName,SUM(MosavabRevenue) AS MosavabRevenue,SUM(MosavabPayMotomarkez) AS MosavabPayMotomarkez,SUM(MosavabDar_Khazane) AS MosavabDar_Khazane,SUM(MosavabNeyabati) AS MosavabNeyabati,SUM(MosavabHagholamal) AS MosavabHagholamal,SUM(Resoures) AS Resoures,SUM(MosavabCurrentCash) AS MosavabCurrentCash,SUM(MosavabCurrentNonCash) AS MosavabCurrentNonCash,SUM(MosavabCivilCash) AS MosavabCivilCash,SUM(MosavabCivilNonCash) AS MosavabCivilNonCash,SUM(MosavabFinancial) AS MosavabFinancial,SUM(MosavabSanavati) AS MosavabSanavati,SUM(Costs)AS Costs,0 as ToGetherBudget
                  FROM CommonData
                  WHERE Id IN (9,30,31,32,33,34,35,36,42,43,44,53)

                  UNION ALL

                  SELECT
                      62 AS Id,1 as IsSummary, 'ستاد و مناطق' AS AreaName,SUM(MosavabRevenue) AS MosavabRevenue,SUM(MosavabPayMotomarkez) AS MosavabPayMotomarkez,SUM(MosavabDar_Khazane) AS MosavabDar_Khazane,SUM(MosavabNeyabati) AS MosavabNeyabati,SUM(MosavabHagholamal) AS MosavabHagholamal,SUM(Resoures) AS Resoures,SUM(MosavabCurrentCash) AS MosavabCurrentCash,SUM(MosavabCurrentNonCash) AS MosavabCurrentNonCash,SUM(MosavabCivilCash) AS MosavabCivilCash,SUM(MosavabCivilNonCash) AS MosavabCivilNonCash,SUM(MosavabFinancial) AS MosavabFinancial,SUM(MosavabSanavati) AS MosavabSanavati,SUM(Costs)AS Costs,0 as ToGetherBudget
                  FROM CommonData
                  WHERE Id IN (1,2,3,4,5,6,7,8,9,30,31,32,33,34,35,36,42,43,44,53)

                  UNION ALL

                  SELECT
                      63 AS Id,1 as IsSummary, 'مجموع 54' AS AreaName,SUM(MosavabRevenue) AS MosavabRevenue,SUM(MosavabPayMotomarkez) AS MosavabPayMotomarkez,SUM(MosavabDar_Khazane) AS MosavabDar_Khazane,SUM(MosavabNeyabati) AS MosavabNeyabati,SUM(MosavabHagholamal) AS MosavabHagholamal,SUM(Resoures) AS Resoures,SUM(MosavabCurrentCash) AS MosavabCurrentCash,SUM(MosavabCurrentNonCash) AS MosavabCurrentNonCash,SUM(MosavabCivilCash) AS MosavabCivilCash,SUM(MosavabCivilNonCash) AS MosavabCivilNonCash,SUM(MosavabFinancial) AS MosavabFinancial,SUM(MosavabSanavati) AS MosavabSanavati,SUM(Costs)AS Costs,0 as ToGetherBudget
                  FROM CommonData
                  WHERE ToGetherBudget =10 AND Id NOT IN (1,2,3,4,5,6,7,8,9,30,31,32,33,34,35,36,42,43,44,53)

                  UNION ALL

                  SELECT
                      64 AS Id,1 as IsSummary, 'شهرداری و 54' AS AreaName,SUM(MosavabRevenue) AS MosavabRevenue,SUM(MosavabPayMotomarkez) AS MosavabPayMotomarkez,SUM(MosavabDar_Khazane) AS MosavabDar_Khazane,SUM(MosavabNeyabati) AS MosavabNeyabati,SUM(MosavabHagholamal) AS MosavabHagholamal,SUM(Resoures) AS Resoures,SUM(MosavabCurrentCash) AS MosavabCurrentCash,SUM(MosavabCurrentNonCash) AS MosavabCurrentNonCash,SUM(MosavabCivilCash) AS MosavabCivilCash,SUM(MosavabCivilNonCash) AS MosavabCivilNonCash,SUM(MosavabFinancial) AS MosavabFinancial,SUM(MosavabSanavati) AS MosavabSanavati,SUM(Costs)AS Costs,0 as ToGetherBudget
                  FROM CommonData
                  WHERE Id IN (1,2,3,4,5,6,7,8,9,30,31,32,33,34,35,36,42,43,44,53) OR  ToGetherBudget =10

                  UNION ALL

                  SELECT
                      65 AS Id,1 as IsSummary, 'مجموع 84' AS AreaName,SUM(MosavabRevenue) AS MosavabRevenue,SUM(MosavabPayMotomarkez) AS MosavabPayMotomarkez,SUM(MosavabDar_Khazane) AS MosavabDar_Khazane,SUM(MosavabNeyabati) AS MosavabNeyabati,SUM(MosavabHagholamal) AS MosavabHagholamal,SUM(Resoures) AS Resoures,SUM(MosavabCurrentCash) AS MosavabCurrentCash,SUM(MosavabCurrentNonCash) AS MosavabCurrentNonCash,SUM(MosavabCivilCash) AS MosavabCivilCash,SUM(MosavabCivilNonCash) AS MosavabCivilNonCash,SUM(MosavabFinancial) AS MosavabFinancial,SUM(MosavabSanavati) AS MosavabSanavati,SUM(Costs)AS Costs,0 as ToGetherBudget
                  FROM CommonData
                  WHERE ToGetherBudget =84

                  UNION ALL

                  SELECT
                      66 AS Id,1 as IsSummary, 'تلفیقی' AS AreaName,SUM(MosavabRevenue) AS MosavabRevenue,SUM(MosavabPayMotomarkez) AS MosavabPayMotomarkez,SUM(MosavabDar_Khazane) AS MosavabDar_Khazane,SUM(MosavabNeyabati) AS MosavabNeyabati,SUM(MosavabHagholamal) AS MosavabHagholamal,SUM(Resoures) AS Resoures,SUM(MosavabCurrentCash) AS MosavabCurrentCash,SUM(MosavabCurrentNonCash) AS MosavabCurrentNonCash,SUM(MosavabCivilCash) AS MosavabCivilCash,SUM(MosavabCivilNonCash) AS MosavabCivilNonCash,SUM(MosavabFinancial) AS MosavabFinancial,SUM(MosavabSanavati) AS MosavabSanavati,SUM(Costs)AS Costs,0 as ToGetherBudget
                  FROM CommonData

              ) AS final
ORDER BY
    CASE
        WHEN Id = 1 THEN 1
        WHEN Id = 2 THEN 2
        WHEN Id = 3 THEN 3
        WHEN Id = 4 THEN 4
        WHEN Id = 5 THEN 5
        WHEN Id = 6 THEN 6
        WHEN Id = 7 THEN 7
        WHEN Id = 8 THEN 8
        WHEN Id = 60 THEN 9
        WHEN Id = 30 THEN 10
        WHEN Id = 31 THEN 11
        WHEN Id = 32 THEN 12
        WHEN Id = 33 THEN 13
        WHEN Id = 34 THEN 14
        WHEN Id = 35 THEN 15
        WHEN Id = 36 THEN 16
        WHEN Id = 42 THEN 17
        WHEN Id = 43 THEN 18
        WHEN Id = 44 THEN 19
        WHEN Id = 53 THEN 20
        WHEN Id = 9 THEN 21
        WHEN Id = 61 THEN 22
        WHEN Id = 62 THEN 23
        WHEN ToGetherBudget=10 THEN 24
        WHEN Id = 63 THEN 25
        WHEN Id = 64 THEN 26
        WHEN ToGetherBudget=84  THEN 27
        WHEN Id = 65 THEN 28
        WHEN Id = 66 THEN 29
        END;



END
go

