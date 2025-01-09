insert Scope  int into Scope
insert Stability  int into Stability
insert PublicConsumptionPercent  int into PublicConsumptionPercent
insert PrivateConsumptionPercent  int into PrivateConsumptionPercent

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP000_Coding_Update]
@id int,
@code nvarchar(50),
@description nvarchar(1000),
@show bit,
@crud bit,
@levelNumber tinyint,
@Scope int,
@Stability int,
@PublicConsumptionPercent int,
@PrivateConsumptionPercent int
AS
BEGIN
update tblCoding
set code = @code ,
    description = @description,
    show = @show,
    crud = @crud,
    levelNumber = @levelNumber,
    Scope = @Scope,
    Stability = @Stability,
    PublicConsumptionPercent = @PublicConsumptionPercent,
    PrivateConsumptionPercent = @PrivateConsumptionPercent
where      id = @id
END
go





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP000_Coding_Insert]
@MotherId int ,
@code nvarchar(50),
@description nvarchar(1000),
@show bit,
@crud bit,
@levelNumber tinyint,
@BudgetProcessId tinyint,
@Scope int,
@Stability int,
@PublicConsumptionPercent int,
@PrivateConsumptionPercent int
AS
BEGIN

insert into tblCoding( MotherId ,  code ,  description , show  ,  crud , levelNumber , TblBudgetProcessId ,CodingKindId,Scope,Stability,PublicConsumptionPercent,PrivateConsumptionPercent)
values(@MotherId , @code , @description , @show , @crud ,@levelNumber ,@BudgetProcessId    ,  20       ,@Scope,@Stability,@PublicConsumptionPercent,@PrivateConsumptionPercent )


END
go





USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP500_Abstract]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP500_Abstract]
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
     NeyabatiData       AS ( SELECT AreaId, amount AS MosavabNeyabati, Expense AS ExpenseNeyabati FROM CommonBudgetData WHERE TblBudgetProcessId = 9 ),
     DarKhazaneData     AS ( SELECT AreaId, amount AS MosavabDar_Khazane, Expense AS ExpenseDar_Khazane FROM CommonBudgetData WHERE TblBudgetProcessId = 10 ),
     HagholamalData     AS ( SELECT AreaId, amount AS MosavabHagholamal, Expense AS ExpenseHagholamal FROM CommonBudgetData WHERE TblBudgetProcessId = 11 ),
     MotomarkezData     AS ( SELECT AreaId, amount AS MosavabPayMotomarkez, Expense AS ExpensePayMotomarkez FROM CommonBudgetData WHERE TblBudgetProcessId = 8 ),
     DoyonSanavatiData  AS ( SELECT AreaId, amount AS MosavabSanavati, Expense AS ExpenseDoyonSanavatiGhatei FROM CommonBudgetData WHERE TblBudgetProcessId = 5 ),
     FinancialData      AS ( SELECT AreaId, amount AS MosavabFinancial, Expense AS ExpenseFinancial FROM CommonBudgetData WHERE TblBudgetProcessId = 4 ),
     CivilData          AS ( SELECT AreaId, amount AS MosavabCivil, Expense AS ExpenseCivil FROM CommonBudgetData WHERE TblBudgetProcessId = 3 ),
     CurrentData        AS ( SELECT AreaId, amount AS MosavabCurrent, Expense AS ExpenseCurrent FROM CommonBudgetData WHERE TblBudgetProcessId = 2 ),
     RevenueData        AS ( SELECT AreaId, amount AS MosavabRevenue, Expense AS ExpenseRevenue FROM CommonBudgetData WHERE TblBudgetProcessId = 1 ),



     CommonData AS (
         SELECT
             TblAreas.Id, TblAreas.AreaNameShort AS AreaName,
             ISNULL(RevenueData.MosavabRevenue, 0) AS MosavabRevenue,
             ISNULL(MotomarkezData.MosavabPayMotomarkez, 0) AS MosavabPayMotomarkez,
             ISNULL(DarKhazaneData.MosavabDar_Khazane, 0) AS MosavabDar_Khazane,
             ISNULL(NeyabatiData.MosavabNeyabati,0) AS MosavabNeyabati ,
             ISNULL(HagholamalData.MosavabHagholamal,0) AS MosavabHagholamal ,
             ISNULL(RevenueData.MosavabRevenue, 0) - ISNULL(MotomarkezData.MosavabPayMotomarkez, 0)+ ISNULL(DarKhazaneData.MosavabDar_Khazane, 0) + ISNULL(NeyabatiData.MosavabNeyabati,0)  + ISNULL(HagholamalData.MosavabHagholamal,0)  AS Resoures,
             ISNULL(CurrentData.MosavabCurrent, 0) AS MosavabCurrent,
             ISNULL(CivilData.MosavabCivil, 0) AS MosavabCivil,
             ISNULL(FinancialData.MosavabFinancial,0) AS MosavabFinancial,
             ISNULL(DoyonSanavatiData.MosavabSanavati, 0) AS MosavabSanavati,
             ISNULL(CurrentData.MosavabCurrent, 0) + ISNULL(CivilData.MosavabCivil, 0) +  ISNULL(DoyonSanavatiData.MosavabSanavati, 0) +ISNULL(FinancialData.MosavabFinancial, 0) AS Costs,
             ISNULL(RevenueData.MosavabRevenue, 0) - ISNULL(CurrentData.MosavabCurrent, 0) - ISNULL(CivilData.MosavabCivil, 0) - ISNULL(DoyonSanavatiData.MosavabSanavati, 0) - ISNULL(FinancialData.MosavabFinancial, 0) - ISNULL(MotomarkezData.MosavabPayMotomarkez, 0) + ISNULL(NeyabatiData.MosavabNeyabati,0) + ISNULL(HagholamalData.MosavabHagholamal,0) + ISNULL(DarKhazaneData.MosavabDar_Khazane, 0) AS balanceMosavab

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

UNION ALL

SELECT
    0 AS Id, 'ستاد' AS AreaName,SUM(MosavabRevenue) AS MosavabRevenue,SUM(MosavabPayMotomarkez) AS MosavabPayMotomarkez,SUM(MosavabDar_Khazane) AS MosavabDar_Khazane,SUM(MosavabNeyabati) AS MosavabNeyabati,SUM(MosavabHagholamal) AS MosavabHagholamal,SUM(Resoures) AS Resoures,SUM(MosavabCurrent) AS MosavabCurrent,SUM(MosavabCivil) AS MosavabCivil,SUM(MosavabFinancial) AS MosavabFinancial,SUM(MosavabSanavati) AS MosavabSanavati,SUM(Costs) AS Costs,SUM(balanceMosavab) AS balanceMosavab
FROM CommonData
WHERE Id IN (9,30,31,32,33,34,35,36,42,43,44,53)

UNION ALL

SELECT
    0 AS Id, 'ستاد و مناطق' AS AreaName,SUM(MosavabRevenue) AS MosavabRevenue,SUM(MosavabPayMotomarkez) AS MosavabPayMotomarkez,SUM(MosavabDar_Khazane) AS MosavabDar_Khazane,SUM(MosavabNeyabati) AS MosavabNeyabati,SUM(MosavabHagholamal) AS MosavabHagholamal,SUM(Resoures) AS Resoures,SUM(MosavabCurrent) AS MosavabCurrent,SUM(MosavabCivil) AS MosavabCivil,SUM(MosavabFinancial) AS MosavabFinancial,SUM(MosavabSanavati) AS MosavabSanavati,SUM(Costs) AS Costs,SUM(balanceMosavab) AS balanceMosavab
FROM CommonData
WHERE Id IN (1,2,3,4,5,6,7,8,9,30,31,32,33,34,35,36,42,43,44,53)

UNION ALL

SELECT
    0 AS Id, 'َشهرداری و فرهنگی و مشارکتها' AS AreaName,SUM(MosavabRevenue) AS MosavabRevenue,SUM(MosavabPayMotomarkez) AS MosavabPayMotomarkez,SUM(MosavabDar_Khazane) AS MosavabDar_Khazane,SUM(MosavabNeyabati) AS MosavabNeyabati,SUM(MosavabHagholamal) AS MosavabHagholamal,SUM(Resoures) AS Resoures,SUM(MosavabCurrent) AS MosavabCurrent,SUM(MosavabCivil) AS MosavabCivil,SUM(MosavabFinancial) AS MosavabFinancial,SUM(MosavabSanavati) AS MosavabSanavati,SUM(Costs) AS Costs,SUM(balanceMosavab) AS balanceMosavab
FROM CommonData
WHERE Id IN (1,2,3,4,5,6,7,8,9,30,31,32,33,34,35,36,42,43,44,53,25,29);

END
go



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP000_Coding]
@BudgetProcessId tinyint,
@MotherId int=NULL
AS
BEGIN
if (@MotherId IS NULL)
begin
SELECT        tblCoding.Id, tblCoding.MotherId, tblCoding.Code, tblCoding.Description, tblCoding.levelNumber, tblCoding.Crud, tblCoding.Show, tblCoding.CodingKindId,tblCoding.Scope,tblCoding.Stability,tblCoding.PublicConsumptionPercent,tblCoding.PrivateConsumptionPercent, tblCodingKind.CodingKindName
FROM            tblCoding LEFT OUTER JOIN
                tblCodingKind ON tblCoding.CodingKindId = tblCodingKind.Id
WHERE        (tblCoding.TblBudgetProcessId = @BudgetProcessId)
  and (tblCoding.Code not like '0%') -- old budget codings
ORDER BY tblCoding.Code
    return
end

if (@MotherId IS NOT NULL)
begin
SELECT        Id, MotherId, Code, Description, levelNumber, Crud, Show, CodingKindId,Scope,Stability,PublicConsumptionPercent,PrivateConsumptionPercent
FROM            tblCoding
WHERE        MotherId = @MotherId
ORDER BY Code
    return
end

END
go

