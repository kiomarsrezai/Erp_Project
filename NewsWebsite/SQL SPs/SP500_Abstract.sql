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
    
    if (@type='mosavab')
BEGIN
SELECT       Id, AreaName, MosavabRevenue, MosavabPayMotomarkez, MosavabDar_Khazane,MosavabNeyabati ,MosavabHagholamal , Resoures, MosavabCurrent, MosavabCivil, MosavabFinancial, MosavabSanavati, balanceMosavab
FROM            (SELECT        TblAreas.Id, TblAreas.AreaNameShort AS AreaName,
                               ISNULL(der_Revenue.MosavabRevenue, 0) AS MosavabRevenue,
                               ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0) AS MosavabPayMotomarkez,
                               ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) AS MosavabDar_Khazane,
                               ISNULL(der_Neyabati.MosavabNeyabati,0) AS MosavabNeyabati ,
                               ISNULL(der_Hagholamal.MosavabHagholamal,0) AS MosavabHagholamal ,
                               ISNULL(der_Revenue.MosavabRevenue, 0) -
                               ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0)+
                               ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) +
                               ISNULL(der_Neyabati.MosavabNeyabati,0)  +
                               ISNULL(der_Hagholamal.MosavabHagholamal,0)  AS Resoures,
                               ISNULL(der_Current.MosavabCurrent, 0) AS MosavabCurrent,
                               ISNULL(der_Civil.MosavabCivil, 0) AS MosavabCivil,
                               ISNULL(der_Financial.MosavabFinancial,0) AS MosavabFinancial,
                               ISNULL(der_Doyon.MosavabSanavati, 0) AS MosavabSanavati,
                               ISNULL(der_Revenue.MosavabRevenue, 0) -
                               ISNULL(der_Current.MosavabCurrent, 0) -
                               ISNULL(der_Civil.MosavabCivil, 0) -
                               ISNULL(der_Doyon.MosavabSanavati, 0) -
                               ISNULL(der_Financial.MosavabFinancial, 0) -
                               ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0) +
                               ISNULL(der_Neyabati.MosavabNeyabati,0) +
                               ISNULL(der_Hagholamal.MosavabHagholamal,0) +
                               ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) AS balanceMosavab

                 FROM            TblAreas LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Mosavab) AS MosavabNeyabati, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseNeyabati
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 9) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Neyabati ON TblAreas.Id = der_Neyabati.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Mosavab) AS MosavabDar_Khazane, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseDar_Khazane
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId=10) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Mahromeyat ON TblAreas.Id = der_Mahromeyat.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Mosavab) AS MosavabHagholamal, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseHagholamal
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 11) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Hagholamal ON TblAreas.Id = der_Hagholamal.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Mosavab) AS MosavabPayMotomarkez, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpensePayMotomarkez
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 8) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Motomarkez ON TblAreas.Id = der_Motomarkez.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Mosavab) AS MosavabSanavati, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseDoyonSanavatiGhatei
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 5) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Doyon ON TblAreas.Id = der_Doyon.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_3.AreaId, SUM(tblBudgetDetailProjectArea_3.Mosavab) AS MosavabFinancial, SUM(tblBudgetDetailProjectArea_3.Expense) AS ExpenseFinancial
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_3 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_3 ON tblBudgetDetailProject_3.Id = tblBudgetDetailProjectArea_3.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_3 ON tblBudgetDetailProject_3.BudgetDetailId = TblBudgetDetails_3.Id INNER JOIN
                                                  tblCoding AS tblCoding_3 ON TblBudgetDetails_3.tblCodingId = tblCoding_3.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_3 ON TblBudgetDetails_3.BudgetId = TblBudgets_3.Id
                                  WHERE   (tblCoding_3.TblBudgetProcessId = 4) AND
                                      (TblBudgets_3.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_3.AreaId) AS der_Financial ON TblAreas.Id = der_Financial.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_2.AreaId, SUM(tblBudgetDetailProjectArea_2.Mosavab) AS MosavabCivil, SUM(tblBudgetDetailProjectArea_2.Expense) AS ExpenseCivil
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_2 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_2 ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea_2.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_2 ON tblBudgetDetailProject_2.BudgetDetailId = TblBudgetDetails_2.Id INNER JOIN
                                                  tblCoding AS tblCoding_2 ON TblBudgetDetails_2.tblCodingId = tblCoding_2.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_2 ON TblBudgetDetails_2.BudgetId = TblBudgets_2.Id
                                  WHERE   (tblCoding_2.TblBudgetProcessId = 3) AND
                                      (TblBudgets_2.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_2.AreaId) AS der_Civil ON TblAreas.Id = der_Civil.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_1.AreaId, SUM(tblBudgetDetailProjectArea_1.Mosavab) AS MosavabCurrent, SUM(tblBudgetDetailProjectArea_1.Expense) AS ExpenseCurrent
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_1 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON tblBudgetDetailProject_1.BudgetDetailId = TblBudgetDetails_1.Id INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_1 ON TblBudgetDetails_1.BudgetId = TblBudgets_1.Id
                                  WHERE   (tblCoding_1.TblBudgetProcessId = 2) AND
                                      (TblBudgets_1.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_1.AreaId) AS der_Current ON TblAreas.Id = der_Current.AreaId LEFT OUTER JOIN
                                 (SELECT   tblBudgetDetailProjectArea.AreaId, SUM(tblBudgetDetailProjectArea.Mosavab) AS MosavabRevenue, SUM(tblBudgetDetailProjectArea.Expense) AS ExpenseRevenue
                                  FROM            tblBudgetDetailProject INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails ON tblBudgetDetailProject.BudgetDetailId = TblBudgetDetails.Id INNER JOIN
                                                  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                  TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id
                                  WHERE   (tblCoding.TblBudgetProcessId = 1) AND
                                      (TblBudgets.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea.AreaId) AS der_Revenue ON TblAreas.Id = der_Revenue.AreaId
                ) AS tbl1

END

ELSE IF (@type='eslahi')
BEGIN

SELECT       Id, AreaName, MosavabRevenue, MosavabPayMotomarkez, MosavabDar_Khazane,MosavabNeyabati ,MosavabHagholamal, Resoures, MosavabCurrent, MosavabCivil, MosavabFinancial, MosavabSanavati, balanceMosavab
FROM            (SELECT        TblAreas.Id, TblAreas.AreaNameShort AS AreaName,
                               ISNULL(der_Revenue.MosavabRevenue, 0) AS MosavabRevenue,
                               ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0) AS MosavabPayMotomarkez,
                               ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) AS MosavabDar_Khazane,
                               ISNULL(der_Neyabati.MosavabNeyabati,0) AS MosavabNeyabati ,
                               ISNULL(der_Hagholamal.MosavabHagholamal,0) AS MosavabHagholamal ,
                               ISNULL(der_Revenue.MosavabRevenue, 0) -
                               ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0)+
                               ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) +
                               ISNULL(der_Neyabati.MosavabNeyabati,0)+
                               ISNULL(der_Hagholamal.MosavabHagholamal,0)  AS Resoures,
                               ISNULL(der_Current.MosavabCurrent, 0) AS MosavabCurrent,
                               ISNULL(der_Civil.MosavabCivil, 0) AS MosavabCivil,
                               ISNULL(der_Financial.MosavabFinancial,0) AS MosavabFinancial,
                               ISNULL(der_Doyon.MosavabSanavati, 0) AS MosavabSanavati,
                               ISNULL(der_Revenue.MosavabRevenue, 0) -
                               ISNULL(der_Current.MosavabCurrent, 0) -
                               ISNULL(der_Civil.MosavabCivil, 0) -
                               ISNULL(der_Doyon.MosavabSanavati, 0) -
                               ISNULL(der_Financial.MosavabFinancial, 0) -
                               ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0) +
                               ISNULL(der_Neyabati.MosavabNeyabati,0) +
                               ISNULL(der_Hagholamal.MosavabHagholamal,0) +
                               ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) AS balanceMosavab

                 FROM            TblAreas LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.EditArea) AS MosavabNeyabati, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseNeyabati
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 9) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Neyabati ON TblAreas.Id = der_Neyabati.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.EditArea) AS MosavabDar_Khazane, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseDar_Khazane
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId=10) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Mahromeyat ON TblAreas.Id = der_Mahromeyat.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.EditArea) AS MosavabHagholamal, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseHagholamal
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 11) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Hagholamal ON TblAreas.Id = der_Hagholamal.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.EditArea) AS MosavabPayMotomarkez, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpensePayMotomarkez
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 8) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Motomarkez ON TblAreas.Id = der_Motomarkez.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.EditArea) AS MosavabSanavati, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseDoyonSanavatiGhatei
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 5) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Doyon ON TblAreas.Id = der_Doyon.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_3.AreaId, SUM(tblBudgetDetailProjectArea_3.EditArea) AS MosavabFinancial, SUM(tblBudgetDetailProjectArea_3.Expense) AS ExpenseFinancial
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_3 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_3 ON tblBudgetDetailProject_3.Id = tblBudgetDetailProjectArea_3.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_3 ON tblBudgetDetailProject_3.BudgetDetailId = TblBudgetDetails_3.Id INNER JOIN
                                                  tblCoding AS tblCoding_3 ON TblBudgetDetails_3.tblCodingId = tblCoding_3.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_3 ON TblBudgetDetails_3.BudgetId = TblBudgets_3.Id
                                  WHERE   (tblCoding_3.TblBudgetProcessId = 4) AND
                                      (TblBudgets_3.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_3.AreaId) AS der_Financial ON TblAreas.Id = der_Financial.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_2.AreaId, SUM(tblBudgetDetailProjectArea_2.EditArea) AS MosavabCivil, SUM(tblBudgetDetailProjectArea_2.Expense) AS ExpenseCivil
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_2 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_2 ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea_2.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_2 ON tblBudgetDetailProject_2.BudgetDetailId = TblBudgetDetails_2.Id INNER JOIN
                                                  tblCoding AS tblCoding_2 ON TblBudgetDetails_2.tblCodingId = tblCoding_2.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_2 ON TblBudgetDetails_2.BudgetId = TblBudgets_2.Id
                                  WHERE   (tblCoding_2.TblBudgetProcessId = 3) AND
                                      (TblBudgets_2.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_2.AreaId) AS der_Civil ON TblAreas.Id = der_Civil.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_1.AreaId, SUM(tblBudgetDetailProjectArea_1.EditArea) AS MosavabCurrent, SUM(tblBudgetDetailProjectArea_1.Expense) AS ExpenseCurrent
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_1 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON tblBudgetDetailProject_1.BudgetDetailId = TblBudgetDetails_1.Id INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_1 ON TblBudgetDetails_1.BudgetId = TblBudgets_1.Id
                                  WHERE   (tblCoding_1.TblBudgetProcessId = 2) AND
                                      (TblBudgets_1.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_1.AreaId) AS der_Current ON TblAreas.Id = der_Current.AreaId LEFT OUTER JOIN
                                 (SELECT   tblBudgetDetailProjectArea.AreaId, SUM(tblBudgetDetailProjectArea.EditArea) AS MosavabRevenue, SUM(tblBudgetDetailProjectArea.Expense) AS ExpenseRevenue
                                  FROM            tblBudgetDetailProject INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails ON tblBudgetDetailProject.BudgetDetailId = TblBudgetDetails.Id INNER JOIN
                                                  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                  TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id
                                  WHERE   (tblCoding.TblBudgetProcessId = 1) AND
                                      (TblBudgets.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea.AreaId) AS der_Revenue ON TblAreas.Id = der_Revenue.AreaId
                ) AS tbl1


END
ELSE IF (@type='pishnahadi')
BEGIN

SELECT       Id, AreaName, MosavabRevenue, MosavabPayMotomarkez, MosavabDar_Khazane,MosavabNeyabati ,MosavabHagholamal, Resoures, MosavabCurrent, MosavabCivil, MosavabFinancial, MosavabSanavati, balanceMosavab
FROM            (SELECT        TblAreas.Id, TblAreas.AreaNameShort AS AreaName,
                               ISNULL(der_Revenue.MosavabRevenue, 0) AS MosavabRevenue,
                               ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0) AS MosavabPayMotomarkez,
                               ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) AS MosavabDar_Khazane,
                               ISNULL(der_Neyabati.MosavabNeyabati,0) AS MosavabNeyabati ,
                               ISNULL(der_Hagholamal.MosavabHagholamal,0) AS MosavabHagholamal ,
                               ISNULL(der_Revenue.MosavabRevenue, 0) -
                               ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0)+
                               ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) +
                               ISNULL(der_Neyabati.MosavabNeyabati,0) +
                               ISNULL(der_Hagholamal.MosavabHagholamal,0)  AS Resoures,
                               ISNULL(der_Current.MosavabCurrent, 0) AS MosavabCurrent,
                               ISNULL(der_Civil.MosavabCivil, 0) AS MosavabCivil,
                               ISNULL(der_Financial.MosavabFinancial,0) AS MosavabFinancial,
                               ISNULL(der_Doyon.MosavabSanavati, 0) AS MosavabSanavati,
                               ISNULL(der_Revenue.MosavabRevenue, 0) -
                               ISNULL(der_Current.MosavabCurrent, 0) -
                               ISNULL(der_Civil.MosavabCivil, 0) -
                               ISNULL(der_Doyon.MosavabSanavati, 0) -
                               ISNULL(der_Financial.MosavabFinancial, 0) -
                               ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0) +
                               ISNULL(der_Neyabati.MosavabNeyabati,0) +
                               ISNULL(der_Hagholamal.MosavabHagholamal,0) +
                               ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) AS balanceMosavab

                 FROM            TblAreas LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Pishnahadi) AS MosavabNeyabati, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseNeyabati
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 9) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Neyabati ON TblAreas.Id = der_Neyabati.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Pishnahadi) AS MosavabDar_Khazane, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseDar_Khazane
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId=10) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Mahromeyat ON TblAreas.Id = der_Mahromeyat.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Pishnahadi) AS MosavabHagholamal, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseHagholamal
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 11) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Hagholamal ON TblAreas.Id = der_Hagholamal.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Pishnahadi) AS MosavabPayMotomarkez, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpensePayMotomarkez
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 8) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Motomarkez ON TblAreas.Id = der_Motomarkez.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Pishnahadi) AS MosavabSanavati, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseDoyonSanavatiGhatei
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                  tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                  WHERE   (tblCoding_4.TblBudgetProcessId = 5) AND
                                      (TblBudgets_4.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Doyon ON TblAreas.Id = der_Doyon.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_3.AreaId, SUM(tblBudgetDetailProjectArea_3.Pishnahadi) AS MosavabFinancial, SUM(tblBudgetDetailProjectArea_3.Expense) AS ExpenseFinancial
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_3 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_3 ON tblBudgetDetailProject_3.Id = tblBudgetDetailProjectArea_3.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_3 ON tblBudgetDetailProject_3.BudgetDetailId = TblBudgetDetails_3.Id INNER JOIN
                                                  tblCoding AS tblCoding_3 ON TblBudgetDetails_3.tblCodingId = tblCoding_3.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_3 ON TblBudgetDetails_3.BudgetId = TblBudgets_3.Id
                                  WHERE   (tblCoding_3.TblBudgetProcessId = 4) AND
                                      (TblBudgets_3.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_3.AreaId) AS der_Financial ON TblAreas.Id = der_Financial.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_2.AreaId, SUM(tblBudgetDetailProjectArea_2.Pishnahadi) AS MosavabCivil, SUM(tblBudgetDetailProjectArea_2.Expense) AS ExpenseCivil
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_2 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_2 ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea_2.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_2 ON tblBudgetDetailProject_2.BudgetDetailId = TblBudgetDetails_2.Id INNER JOIN
                                                  tblCoding AS tblCoding_2 ON TblBudgetDetails_2.tblCodingId = tblCoding_2.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_2 ON TblBudgetDetails_2.BudgetId = TblBudgets_2.Id
                                  WHERE   (tblCoding_2.TblBudgetProcessId = 3) AND
                                      (TblBudgets_2.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_2.AreaId) AS der_Civil ON TblAreas.Id = der_Civil.AreaId LEFT OUTER JOIN
                                 (SELECT        tblBudgetDetailProjectArea_1.AreaId, SUM(tblBudgetDetailProjectArea_1.Pishnahadi) AS MosavabCurrent, SUM(tblBudgetDetailProjectArea_1.Expense) AS ExpenseCurrent
                                  FROM            tblBudgetDetailProject AS tblBudgetDetailProject_1 INNER JOIN
                                                  tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails AS TblBudgetDetails_1 ON tblBudgetDetailProject_1.BudgetDetailId = TblBudgetDetails_1.Id INNER JOIN
                                                  tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                  TblBudgets AS TblBudgets_1 ON TblBudgetDetails_1.BudgetId = TblBudgets_1.Id
                                  WHERE   (tblCoding_1.TblBudgetProcessId = 2) AND
                                      (TblBudgets_1.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea_1.AreaId) AS der_Current ON TblAreas.Id = der_Current.AreaId LEFT OUTER JOIN
                                 (SELECT   tblBudgetDetailProjectArea.AreaId, SUM(tblBudgetDetailProjectArea.Pishnahadi) AS MosavabRevenue, SUM(tblBudgetDetailProjectArea.Expense) AS ExpenseRevenue
                                  FROM            tblBudgetDetailProject INNER JOIN
                                                  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                  TblBudgetDetails ON tblBudgetDetailProject.BudgetDetailId = TblBudgetDetails.Id INNER JOIN
                                                  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                  TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id
                                  WHERE   (tblCoding.TblBudgetProcessId = 1) AND
                                      (TblBudgets.TblYearId = @YearId)
                                  GROUP BY tblBudgetDetailProjectArea.AreaId) AS der_Revenue ON TblAreas.Id = der_Revenue.AreaId
                ) AS tbl1


END

    --INNER JOIN 
						--     TblAreas ON Tbl1.Id = TblAreas.Id
						--	 where TblAreas.StructureId = 1

--SELECT       Id, AreaName, MosavabRevenue, MosavabPayMotomarkez, MosavabDar_Khazane,MosavabNeyabati , Resoures, MosavabCurrent, MosavabCivil, MosavabFinancial, MosavabSanavati, balanceMosavab
--FROM            (SELECT        TblAreas.Id, TblAreas.AreaNameShort AS AreaName, 
--                          ISNULL(der_Revenue.MosavabRevenue, 0) AS MosavabRevenue, 
--						  ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0) AS MosavabPayMotomarkez, 
--                          ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) AS MosavabDar_Khazane, 
--                          ISNULL(der_Neyabati.MosavabNeyabati,0) AS MosavabNeyabati ,
--						   ISNULL(der_Revenue.MosavabRevenue, 0) - 
--						   ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0)+ 
--						   ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) + 
--						   ISNULL(der_Neyabati.MosavabNeyabati,0)  AS Resoures, 
--						  ISNULL(der_Current.MosavabCurrent, 0) AS MosavabCurrent, 
--						  ISNULL(der_Civil.MosavabCivil, 0) AS MosavabCivil, 
--						  ISNULL(der_Financial.MosavabFinancial,0) AS MosavabFinancial,
--						  ISNULL(der_Doyon.MosavabSanavati, 0) AS MosavabSanavati, 
--						   ISNULL(der_Revenue.MosavabRevenue, 0) -
--						   ISNULL(der_Current.MosavabCurrent, 0) - 
--						   ISNULL(der_Civil.MosavabCivil, 0) - 
--						   ISNULL(der_Doyon.MosavabSanavati, 0) - 
--						   ISNULL(der_Financial.MosavabFinancial, 0) - 
--						   ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0) +
--						   ISNULL(der_Neyabati.MosavabNeyabati,0) +
--						   ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) AS balanceMosavab 
                        
--FROM            TblAreas LEFT OUTER JOIN
--                             (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.EditArea) AS MosavabNeyabati, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseNeyabati
--                               FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
--                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
--                                                         TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
--                                                         tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
--                                                         TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
--                               WHERE   (tblCoding_4.TblBudgetProcessId = 9) AND
--							           (TblBudgets_4.TblYearId = @YearId)
--                               GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Neyabati ON TblAreas.Id = der_Neyabati.AreaId LEFT OUTER JOIN
--                             (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.EditArea) AS MosavabDar_Khazane, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseDar_Khazane
--                               FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
--                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
--                                                         TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
--                                                         tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
--                                                         TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
--                               WHERE   (tblCoding_4.TblBudgetProcessId=10) AND
--							           (TblBudgets_4.TblYearId = @YearId)
--                               GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Mahromeyat ON TblAreas.Id = der_Mahromeyat.AreaId LEFT OUTER JOIN
--                             (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.EditArea) AS MosavabPayMotomarkez, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpensePayMotomarkez
--                               FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
--                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
--                                                         TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
--                                                         tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
--                                                         TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
--                               WHERE   (tblCoding_4.TblBudgetProcessId = 8) AND
--							           (TblBudgets_4.TblYearId = @YearId)
--                               GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Motomarkez ON TblAreas.Id = der_Motomarkez.AreaId LEFT OUTER JOIN
--                             (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.EditArea) AS MosavabSanavati, SUM(tblBudgetDetailProjectArea_4.Expense) AS ExpenseDoyonSanavatiGhatei
--                               FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
--                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
--                                                         TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
--                                                         tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
--                                                         TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
--                               WHERE   (tblCoding_4.TblBudgetProcessId = 5) AND
--							           (TblBudgets_4.TblYearId = @YearId)
--                               GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Doyon ON TblAreas.Id = der_Doyon.AreaId LEFT OUTER JOIN
--                             (SELECT        tblBudgetDetailProjectArea_3.AreaId, SUM(tblBudgetDetailProjectArea_3.EditArea) AS MosavabFinancial, SUM(tblBudgetDetailProjectArea_3.Expense) AS ExpenseFinancial
--                               FROM            tblBudgetDetailProject AS tblBudgetDetailProject_3 INNER JOIN
--                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_3 ON tblBudgetDetailProject_3.Id = tblBudgetDetailProjectArea_3.BudgetDetailProjectId INNER JOIN
--                                                         TblBudgetDetails AS TblBudgetDetails_3 ON tblBudgetDetailProject_3.BudgetDetailId = TblBudgetDetails_3.Id INNER JOIN
--                                                         tblCoding AS tblCoding_3 ON TblBudgetDetails_3.tblCodingId = tblCoding_3.Id INNER JOIN
--                                                         TblBudgets AS TblBudgets_3 ON TblBudgetDetails_3.BudgetId = TblBudgets_3.Id
--                               WHERE   (tblCoding_3.TblBudgetProcessId = 4) AND
--							           (TblBudgets_3.TblYearId = @YearId)
--                               GROUP BY tblBudgetDetailProjectArea_3.AreaId) AS der_Financial ON TblAreas.Id = der_Financial.AreaId LEFT OUTER JOIN
--                             (SELECT        tblBudgetDetailProjectArea_2.AreaId, SUM(tblBudgetDetailProjectArea_2.EditArea) AS MosavabCivil, SUM(tblBudgetDetailProjectArea_2.Expense) AS ExpenseCivil
--                               FROM            tblBudgetDetailProject AS tblBudgetDetailProject_2 INNER JOIN
--                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_2 ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea_2.BudgetDetailProjectId INNER JOIN
--                                                         TblBudgetDetails AS TblBudgetDetails_2 ON tblBudgetDetailProject_2.BudgetDetailId = TblBudgetDetails_2.Id INNER JOIN
--                                                         tblCoding AS tblCoding_2 ON TblBudgetDetails_2.tblCodingId = tblCoding_2.Id INNER JOIN
--                                                         TblBudgets AS TblBudgets_2 ON TblBudgetDetails_2.BudgetId = TblBudgets_2.Id
--                               WHERE   (tblCoding_2.TblBudgetProcessId = 3) AND
--							           (TblBudgets_2.TblYearId = @YearId)
--                               GROUP BY tblBudgetDetailProjectArea_2.AreaId) AS der_Civil ON TblAreas.Id = der_Civil.AreaId LEFT OUTER JOIN
--                             (SELECT        tblBudgetDetailProjectArea_1.AreaId, SUM(tblBudgetDetailProjectArea_1.EditArea) AS MosavabCurrent, SUM(tblBudgetDetailProjectArea_1.Expense) AS ExpenseCurrent
--                               FROM            tblBudgetDetailProject AS tblBudgetDetailProject_1 INNER JOIN
--                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
--                                                         TblBudgetDetails AS TblBudgetDetails_1 ON tblBudgetDetailProject_1.BudgetDetailId = TblBudgetDetails_1.Id INNER JOIN
--                                                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
--                                                         TblBudgets AS TblBudgets_1 ON TblBudgetDetails_1.BudgetId = TblBudgets_1.Id
--                               WHERE   (tblCoding_1.TblBudgetProcessId = 2) AND
--							           (TblBudgets_1.TblYearId = @YearId)
--                               GROUP BY tblBudgetDetailProjectArea_1.AreaId) AS der_Current ON TblAreas.Id = der_Current.AreaId LEFT OUTER JOIN
--                             (SELECT   tblBudgetDetailProjectArea.AreaId, SUM(tblBudgetDetailProjectArea.EditArea) AS MosavabRevenue, SUM(tblBudgetDetailProjectArea.Expense) AS ExpenseRevenue
--                               FROM            tblBudgetDetailProject INNER JOIN
--                                                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
--                                                         TblBudgetDetails ON tblBudgetDetailProject.BudgetDetailId = TblBudgetDetails.Id INNER JOIN
--                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
--                                                         TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id
--                               WHERE   (tblCoding.TblBudgetProcessId = 1) AND
--							           (TblBudgets.TblYearId = @YearId)
--                               GROUP BY tblBudgetDetailProjectArea.AreaId) AS der_Revenue ON TblAreas.Id = der_Revenue.AreaId
--                        ) AS tbl1 
END
GO
