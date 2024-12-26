-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP500_BudgetBook]
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
        TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
        TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblAreasTogether.YearId=TblBudgets.TblYearId

    WHERE
            TblBudgets.TblYearId = @YearId and
            TblAreas.ToGetherBudget='84'   AND (
            ( @AreaId IN (37)) OR
            (TblAreas.StructureId=1 AND @AreaId IN (10)) OR
            (TblAreas.StructureId=2 AND @AreaId IN (39)) OR
            (TblAreasTogether.ToGetherBudget =10 AND @AreaId IN (40)) OR
            (TblAreasTogether.ToGetherBudget =84 AND @AreaId IN (41)) OR
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

