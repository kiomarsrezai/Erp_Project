USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP500_Abstract_Performance_Sazman]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP500_Abstract_Performance_Sazman]
@yearId int ,
@structureId tinyint ,
@MonthId tinyint
AS
BEGIN

declare @YearName nvarchar(10) =cast((select YearName from TblYears where id = @YearId)as nvarchar(10))
declare @MonthName nvarchar(10)

if(@MonthId = 1)  begin set @MonthName='01' end
if(@MonthId = 2)  begin set @MonthName='02' end
if(@MonthId = 3)  begin set @MonthName='03' end
if(@MonthId = 4)  begin set @MonthName='04' end
if(@MonthId = 5)  begin set @MonthName='05' end
if(@MonthId = 6)  begin set @MonthName='06' end
if(@MonthId = 7)  begin set @MonthName='07' end
if(@MonthId = 8)  begin set @MonthName='08' end
if(@MonthId = 9)  begin set @MonthName='09' end
if(@MonthId =10)  begin set @MonthName='10' end
if(@MonthId =11)  begin set @MonthName='11' end
if(@MonthId =12)  begin set @MonthName='12' end

declare @Datestart nvarchar(10)=@YearName+'/'+'01/01'
declare @DateEnd nvarchar(10)
if(@MonthId<=6)	                begin  set @DateEnd = @YearName+'/'+@MonthName+'/31' end
if(@MonthId in (7,8,9,10,11))	begin  set @DateEnd = @YearName+'/'+@MonthName+'/31' end
if(@MonthId =12)	            begin  set @DateEnd = @YearName+'/'+@MonthName+'/29' end

SELECT        tbl1.Id, tbl1.AreaName, tbl1.MosavabRevenue, ISNULL(derivedtbl_1.ExpenseMonthRevenue, 0) AS ExpenseMonthRevenue, tbl1.MosavabPayMotomarkez, tbl1.MosavabDar_Khazane, 
                         ISNULL(der_DarAzKhazane.ExpenseMonthDarAzKhazane, 0) AS ExpenseMonthDarAzKhazane, tbl1.Resoures, tbl1.MosavabCurrent, ISNULL(der_SupplyCurrent.CreditCurrent, 0) AS CreditCurrent, 
                         ISNULL(der_MonthCurrent.ExpenseMonthCurrent, 0) AS ExpenseMonthCurrent, 
						 tbl1.MosavabCivil, ISNULL(der_CreditCivil.CreditAmountCivil, 0) AS CreditAmountCivil,
						 ISNULL(der_ExpenseCivil.ExpenseCivil, 0) 
                         AS ExpenseCivil, tbl1.MosavabFinancial, ISNULL(der_SupplyFinancial.CreditFinancial, 0) AS CreditFinancial, tbl1.MosavabSanavati, ISNULL(der_SupplySanavati.CreditDoyonSanavati, 0) AS CreditDoyonSanavati, 
                         tbl1.balance, tbl1.MosavabNeyabati, ISNULL(der_ExpenseNeyabati.ExpenseMonthNeyabati, 0) AS ExpenseMonthNeyabati, 0 AS ExpenseCivil, 0 AS ExpenseFinancial, 0 AS ExpenseSanavati, 
                         0 AS ExpensePayMotomarkez
FROM            (SELECT        TblAreas.Id, TblAreas.AreaNameShort AS AreaName, ISNULL(der_Revenue.MosavabRevenue, 0) AS MosavabRevenue, ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0) AS MosavabPayMotomarkez, 
                                                    ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) AS MosavabDar_Khazane, ISNULL(der_Revenue.MosavabRevenue, 0) - ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0) 
                                                    + ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) + ISNULL(der_Neyabati.MosavabNeyabati, 0) AS Resoures, ISNULL(der_Current.MosavabCurrent, 0) AS MosavabCurrent, ISNULL(der_Civil.MosavabCivil, 0) 
                                                    AS MosavabCivil, ISNULL(der_Financial.MosavabFinancial, 0) AS MosavabFinancial, ISNULL(der_Doyon.MosavabSanavati, 0) AS MosavabSanavati, ISNULL(der_Revenue.MosavabRevenue, 0) 
                                                    - ISNULL(der_Current.MosavabCurrent, 0) - ISNULL(der_Civil.MosavabCivil, 0) - ISNULL(der_Doyon.MosavabSanavati, 0) - ISNULL(der_Financial.MosavabFinancial, 0) 
                                                    - ISNULL(der_Motomarkez.MosavabPayMotomarkez, 0) + ISNULL(der_Neyabati.MosavabNeyabati, 0) + ISNULL(der_Mahromeyat.MosavabDar_Khazane, 0) AS balance, ISNULL(der_Neyabati.MosavabNeyabati, 0) 
                                                    AS MosavabNeyabati
                          FROM            TblAreas LEFT OUTER JOIN
                                                        (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Mosavab) AS MosavabNeyabati
                                                          FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                                                    tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                                                    TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                                                    tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                                                    TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                                          WHERE        (tblCoding_4.TblBudgetProcessId = 9) AND (TblBudgets_4.TblYearId = @YearId)
                                                          GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Neyabati ON TblAreas.Id = der_Neyabati.AreaId LEFT OUTER JOIN
                                                        (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Mosavab) AS MosavabDar_Khazane
                                                          FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                                                    tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                                                    TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                                                    tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                                                    TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                                          WHERE        (tblCoding_4.TblBudgetProcessId = 10) AND (TblBudgets_4.TblYearId = @YearId)
                                                          GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Mahromeyat ON TblAreas.Id = der_Mahromeyat.AreaId LEFT OUTER JOIN
                                                        (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Mosavab) AS MosavabPayMotomarkez
                                                          FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                                                    tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                                                    TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                                                    tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                                                    TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                                          WHERE        (tblCoding_4.TblBudgetProcessId = 8) AND (TblBudgets_4.TblYearId = @YearId)
                                                          GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Motomarkez ON TblAreas.Id = der_Motomarkez.AreaId LEFT OUTER JOIN
                                                        (SELECT        tblBudgetDetailProjectArea_4.AreaId, SUM(tblBudgetDetailProjectArea_4.Mosavab) AS MosavabSanavati
                                                          FROM            tblBudgetDetailProject AS tblBudgetDetailProject_4 INNER JOIN
                                                                                    tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_4 ON tblBudgetDetailProject_4.Id = tblBudgetDetailProjectArea_4.BudgetDetailProjectId INNER JOIN
                                                                                    TblBudgetDetails AS TblBudgetDetails_4 ON tblBudgetDetailProject_4.BudgetDetailId = TblBudgetDetails_4.Id INNER JOIN
                                                                                    tblCoding AS tblCoding_4 ON TblBudgetDetails_4.tblCodingId = tblCoding_4.Id INNER JOIN
                                                                                    TblBudgets AS TblBudgets_4 ON TblBudgetDetails_4.BudgetId = TblBudgets_4.Id
                                                          WHERE        (tblCoding_4.TblBudgetProcessId = 5) AND (TblBudgets_4.TblYearId = @YearId)
                                                          GROUP BY tblBudgetDetailProjectArea_4.AreaId) AS der_Doyon ON TblAreas.Id = der_Doyon.AreaId LEFT OUTER JOIN
                                                        (SELECT        tblBudgetDetailProjectArea_3.AreaId, SUM(tblBudgetDetailProjectArea_3.Mosavab) AS MosavabFinancial
                                                          FROM            tblBudgetDetailProject AS tblBudgetDetailProject_3 INNER JOIN
                                                                                    tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_3 ON tblBudgetDetailProject_3.Id = tblBudgetDetailProjectArea_3.BudgetDetailProjectId INNER JOIN
                                                                                    TblBudgetDetails AS TblBudgetDetails_3 ON tblBudgetDetailProject_3.BudgetDetailId = TblBudgetDetails_3.Id INNER JOIN
                                                                                    tblCoding AS tblCoding_3 ON TblBudgetDetails_3.tblCodingId = tblCoding_3.Id INNER JOIN
                                                                                    TblBudgets AS TblBudgets_3 ON TblBudgetDetails_3.BudgetId = TblBudgets_3.Id
                                                          WHERE        (tblCoding_3.TblBudgetProcessId = 4) AND (TblBudgets_3.TblYearId = @YearId)
                                                          GROUP BY tblBudgetDetailProjectArea_3.AreaId) AS der_Financial ON TblAreas.Id = der_Financial.AreaId LEFT OUTER JOIN
                                                        (SELECT        tblBudgetDetailProjectArea_2.AreaId, SUM(tblBudgetDetailProjectArea_2.Mosavab) AS MosavabCivil
                                                          FROM            tblBudgetDetailProject AS tblBudgetDetailProject_2 INNER JOIN
                                                                                    tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_2 ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea_2.BudgetDetailProjectId INNER JOIN
                                                                                    TblBudgetDetails AS TblBudgetDetails_2 ON tblBudgetDetailProject_2.BudgetDetailId = TblBudgetDetails_2.Id INNER JOIN
                                                                                    tblCoding AS tblCoding_2 ON TblBudgetDetails_2.tblCodingId = tblCoding_2.Id INNER JOIN
                                                                                    TblBudgets AS TblBudgets_2 ON TblBudgetDetails_2.BudgetId = TblBudgets_2.Id
                                                          WHERE        (tblCoding_2.TblBudgetProcessId = 3) AND (TblBudgets_2.TblYearId = @YearId)
                                                          GROUP BY tblBudgetDetailProjectArea_2.AreaId) AS der_Civil ON TblAreas.Id = der_Civil.AreaId LEFT OUTER JOIN
                                                        (SELECT        tblBudgetDetailProjectArea_1.AreaId, SUM(tblBudgetDetailProjectArea_1.Mosavab) AS MosavabCurrent
                                                          FROM            tblBudgetDetailProject AS tblBudgetDetailProject_1 INNER JOIN
                                                                                    tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                                                    TblBudgetDetails AS TblBudgetDetails_1 ON tblBudgetDetailProject_1.BudgetDetailId = TblBudgetDetails_1.Id INNER JOIN
                                                                                    tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                                                    TblBudgets AS TblBudgets_1 ON TblBudgetDetails_1.BudgetId = TblBudgets_1.Id
                                                          WHERE        (tblCoding_1.TblBudgetProcessId = 2) AND (TblBudgets_1.TblYearId = @YearId)
                                                          GROUP BY tblBudgetDetailProjectArea_1.AreaId) AS der_Current ON TblAreas.Id = der_Current.AreaId LEFT OUTER JOIN
                                                        (SELECT        tblBudgetDetailProjectArea.AreaId, SUM(tblBudgetDetailProjectArea.Mosavab) AS MosavabRevenue
                                                          FROM            tblBudgetDetailProject INNER JOIN
                                                                                    tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                                                    TblBudgetDetails ON tblBudgetDetailProject.BudgetDetailId = TblBudgetDetails.Id INNER JOIN
                                                                                    tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                                                    TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
                                                                                    TblAreas AS TblAreas_1 ON tblBudgetDetailProjectArea.AreaId = TblAreas_1.Id
                                                          WHERE        (tblCoding.TblBudgetProcessId = 1) AND (TblBudgets.TblYearId = @YearId) AND (TblAreas_1.StructureId = 2)
                                                          GROUP BY tblBudgetDetailProjectArea.AreaId) AS der_Revenue ON TblAreas.Id = der_Revenue.AreaId
                          WHERE        (TblAreas.StructureId = 2)) AS tbl1 LEFT OUTER JOIN
                             (SELECT        AreaId, SUM(ExpenseCivil) AS ExpenseCivil
                               FROM            (SELECT        tblBudgetDetailProjectArea_5.AreaId, tblSanadDetail_MD_2.Bedehkar - tblSanadDetail_MD_2.Bestankar AS ExpenseCivil, TblCodingsMapSazman_2.CodeAcc
                                                         FROM            olden.tblSanad_MD AS tblSanad_MD_2 INNER JOIN
                                                                                   olden.tblSanadDetail_MD AS tblSanadDetail_MD_2 ON tblSanad_MD_2.Id = tblSanadDetail_MD_2.IdSanad_MD AND tblSanad_MD_2.AreaId = tblSanadDetail_MD_2.AreaId AND 
                                                                                   tblSanad_MD_2.YearName = tblSanadDetail_MD_2.YearName INNER JOIN
                                                                                   TblBudgetDetails AS TblBudgetDetails_5 INNER JOIN
                                                                                   TblBudgets AS TblBudgets_5 ON TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND 
                                                                                   TblBudgetDetails_5.BudgetId = TblBudgets_5.Id INNER JOIN
                                                                                   tblBudgetDetailProject AS tblBudgetDetailProject_5 ON TblBudgetDetails_5.Id = tblBudgetDetailProject_5.BudgetDetailId INNER JOIN
                                                                                   tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_5 ON tblBudgetDetailProject_5.Id = tblBudgetDetailProjectArea_5.BudgetDetailProjectId INNER JOIN
                                                                                   tblCoding AS tblCoding_5 ON TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id INNER JOIN
                                                                                   TblCodingsMapSazman AS TblCodingsMapSazman_2 ON tblCoding_5.Id = TblCodingsMapSazman_2.CodingId AND tblBudgetDetailProjectArea_5.AreaId = TblCodingsMapSazman_2.AreaId ON 
                                                                                   tblSanadDetail_MD_2.AreaId = TblCodingsMapSazman_2.AreaId AND tblSanadDetail_MD_2.CodeVasetSazman = TblCodingsMapSazman_2.CodeAcc
                                                         WHERE        (TblBudgets_5.TblYearId = @yearId) AND (tblCoding_5.TblBudgetProcessId = 3) AND (TblCodingsMapSazman_2.YearId = @yearId) AND (tblSanadDetail_MD_2.YearName = @YearName) AND 
                                                                                   (tblSanad_MD_2.SanadDateS BETWEEN @Datestart AND @DateEnd) AND (tblSanad_MD_2.YearName = @YearName) AND (TblCodingsMapSazman_2.CodeAcc IS NOT NULL)) AS tbl1_1_2
                               GROUP BY AreaId) AS der_ExpenseCivil ON tbl1.Id = der_ExpenseCivil.AreaId LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea_6.AreaId, SUM(tblRequestBudget_3.RequestBudgetAmount) AS CreditCurrent
                               FROM            tblRequest AS tblRequest_3 INNER JOIN
                                                         tblRequestBudget AS tblRequestBudget_3 ON tblRequest_3.Id = tblRequestBudget_3.RequestId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_6 ON tblRequestBudget_3.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea_6.id INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_6 ON tblBudgetDetailProjectArea_6.BudgetDetailProjectId = tblBudgetDetailProject_6.Id AND 
                                                         tblBudgetDetailProjectArea_6.BudgetDetailProjectId = tblBudgetDetailProject_6.Id AND tblBudgetDetailProjectArea_6.BudgetDetailProjectId = tblBudgetDetailProject_6.Id AND 
                                                         tblBudgetDetailProjectArea_6.BudgetDetailProjectId = tblBudgetDetailProject_6.Id INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_6 ON tblBudgetDetailProject_6.BudgetDetailId = TblBudgetDetails_6.Id AND tblBudgetDetailProject_6.BudgetDetailId = TblBudgetDetails_6.Id AND 
                                                         tblBudgetDetailProject_6.BudgetDetailId = TblBudgetDetails_6.Id AND tblBudgetDetailProject_6.BudgetDetailId = TblBudgetDetails_6.Id INNER JOIN
                                                         TblBudgets AS TblBudgets_6 ON TblBudgetDetails_6.BudgetId = TblBudgets_6.Id AND TblBudgetDetails_6.BudgetId = TblBudgets_6.Id AND TblBudgetDetails_6.BudgetId = TblBudgets_6.Id INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_6.tblCodingId = tblCoding_6.Id AND TblBudgetDetails_6.tblCodingId = tblCoding_6.Id AND TblBudgetDetails_6.tblCodingId = tblCoding_6.Id INNER JOIN
                                                         TblAreas AS TblAreas_2 ON tblBudgetDetailProjectArea_6.AreaId = TblAreas_2.Id
                               WHERE        (TblBudgets_6.TblYearId = @yearId) AND (tblCoding_6.TblBudgetProcessId = 2) AND (tblRequest_3.DateS BETWEEN @Datestart AND @DateEnd) AND (TblAreas_2.StructureId = 2)
                               GROUP BY tblBudgetDetailProjectArea_6.AreaId) AS der_SupplyCurrent ON tbl1.Id = der_SupplyCurrent.AreaId LEFT OUTER JOIN
                             (SELECT        AreaId, SUM(ExpenseMonthDarAzKhazane) AS ExpenseMonthDarAzKhazane
                               FROM            (SELECT        tblBudgetDetailProjectArea_5.AreaId, tblSanadDetail_MD_1.Bestankar - tblSanadDetail_MD_1.Bedehkar AS ExpenseMonthDarAzKhazane, TblCodingsMapSazman_1.CodeAcc
                                                         FROM            olden.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                                                                                   olden.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.AreaId = tblSanadDetail_MD_1.AreaId AND 
                                                                                   tblSanad_MD_1.YearName = tblSanadDetail_MD_1.YearName INNER JOIN
                                                                                   TblBudgetDetails AS TblBudgetDetails_5 INNER JOIN
                                                                                   TblBudgets AS TblBudgets_5 ON TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND 
                                                                                   TblBudgetDetails_5.BudgetId = TblBudgets_5.Id INNER JOIN
                                                                                   tblBudgetDetailProject AS tblBudgetDetailProject_5 ON TblBudgetDetails_5.Id = tblBudgetDetailProject_5.BudgetDetailId INNER JOIN
                                                                                   tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_5 ON tblBudgetDetailProject_5.Id = tblBudgetDetailProjectArea_5.BudgetDetailProjectId INNER JOIN
                                                                                   tblCoding AS tblCoding_5 ON TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id INNER JOIN
                                                                                   TblCodingsMapSazman AS TblCodingsMapSazman_1 ON tblCoding_5.Id = TblCodingsMapSazman_1.CodingId AND tblBudgetDetailProjectArea_5.AreaId = TblCodingsMapSazman_1.AreaId ON 
                                                                                   tblSanadDetail_MD_1.CodeVasetSazman = TblCodingsMapSazman_1.CodeAcc
                                                         WHERE        (TblBudgets_5.TblYearId = @yearId) AND (tblCoding_5.TblBudgetProcessId = 10) AND (TblCodingsMapSazman_1.YearId = @yearId) AND (tblSanadDetail_MD_1.YearName = @YearName) AND 
                                                                                   (tblSanad_MD_1.SanadDateS BETWEEN @Datestart AND @DateEnd) AND (TblCodingsMapSazman_1.CodeAcc IS NOT NULL)) AS tbl1_3
                               GROUP BY AreaId) AS der_DarAzKhazane ON tbl1.Id = der_DarAzKhazane.AreaId LEFT OUTER JOIN
                             (SELECT        AreaId, SUM(ExpenseMonthNeyabati) AS ExpenseMonthNeyabati
                               FROM            (SELECT        tblBudgetDetailProjectArea_5.AreaId, tblSanadDetail_MD_1.Bestankar - tblSanadDetail_MD_1.Bedehkar AS ExpenseMonthNeyabati, TblCodingsMapSazman_1.CodeAcc
                                                         FROM            olden.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                                                                                   olden.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.AreaId = tblSanadDetail_MD_1.AreaId AND 
                                                                                   tblSanad_MD_1.YearName = tblSanadDetail_MD_1.YearName INNER JOIN
                                                                                   TblBudgetDetails AS TblBudgetDetails_5 INNER JOIN
                                                                                   TblBudgets AS TblBudgets_5 ON TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND 
                                                                                   TblBudgetDetails_5.BudgetId = TblBudgets_5.Id INNER JOIN
                                                                                   tblBudgetDetailProject AS tblBudgetDetailProject_5 ON TblBudgetDetails_5.Id = tblBudgetDetailProject_5.BudgetDetailId INNER JOIN
                                                                                   tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_5 ON tblBudgetDetailProject_5.Id = tblBudgetDetailProjectArea_5.BudgetDetailProjectId INNER JOIN
                                                                                   tblCoding AS tblCoding_5 ON TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id INNER JOIN
                                                                                   TblCodingsMapSazman AS TblCodingsMapSazman_1 ON tblCoding_5.Id = TblCodingsMapSazman_1.CodingId AND tblBudgetDetailProjectArea_5.AreaId = TblCodingsMapSazman_1.AreaId ON 
                                                                                   tblSanadDetail_MD_1.CodeVasetSazman = TblCodingsMapSazman_1.CodeAcc
                                                         WHERE        (TblBudgets_5.TblYearId = @yearId) AND (tblCoding_5.TblBudgetProcessId = 9) AND (TblCodingsMapSazman_1.YearId = @yearId) AND (tblSanadDetail_MD_1.YearName = @YearName) AND 
                                                                                   (tblSanad_MD_1.SanadDateS BETWEEN @Datestart AND @DateEnd) AND (TblCodingsMapSazman_1.CodeAcc IS NOT NULL)) AS tbl1_2
                               GROUP BY AreaId) AS der_ExpenseNeyabati ON tbl1.Id = der_ExpenseNeyabati.AreaId LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea_6.AreaId, SUM(tblRequestBudget_2.RequestBudgetAmount) AS CreditDoyonSanavati
                               FROM            tblRequest AS tblRequest_2 INNER JOIN
                                                         tblRequestBudget AS tblRequestBudget_2 ON tblRequest_2.Id = tblRequestBudget_2.RequestId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_6 ON tblRequestBudget_2.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea_6.id INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_6 ON tblBudgetDetailProjectArea_6.BudgetDetailProjectId = tblBudgetDetailProject_6.Id AND 
                                                         tblBudgetDetailProjectArea_6.BudgetDetailProjectId = tblBudgetDetailProject_6.Id AND tblBudgetDetailProjectArea_6.BudgetDetailProjectId = tblBudgetDetailProject_6.Id AND 
                                                         tblBudgetDetailProjectArea_6.BudgetDetailProjectId = tblBudgetDetailProject_6.Id INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_6 ON tblBudgetDetailProject_6.BudgetDetailId = TblBudgetDetails_6.Id AND tblBudgetDetailProject_6.BudgetDetailId = TblBudgetDetails_6.Id AND 
                                                         tblBudgetDetailProject_6.BudgetDetailId = TblBudgetDetails_6.Id AND tblBudgetDetailProject_6.BudgetDetailId = TblBudgetDetails_6.Id INNER JOIN
                                                         TblBudgets AS TblBudgets_6 ON TblBudgetDetails_6.BudgetId = TblBudgets_6.Id AND TblBudgetDetails_6.BudgetId = TblBudgets_6.Id AND TblBudgetDetails_6.BudgetId = TblBudgets_6.Id INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_6.tblCodingId = tblCoding_6.Id AND TblBudgetDetails_6.tblCodingId = tblCoding_6.Id AND TblBudgetDetails_6.tblCodingId = tblCoding_6.Id
                               WHERE        (TblBudgets_6.TblYearId = @yearId) AND (tblCoding_6.TblBudgetProcessId = 5) AND (tblRequest_2.DateS BETWEEN @Datestart AND @DateEnd)
                               GROUP BY tblBudgetDetailProjectArea_6.AreaId) AS der_SupplySanavati ON tbl1.Id = der_SupplySanavati.AreaId LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea_6.AreaId, SUM(tblRequestBudget_1.RequestBudgetAmount) AS CreditFinancial
                               FROM            tblRequest AS tblRequest_1 INNER JOIN
                                                         tblRequestBudget AS tblRequestBudget_1 ON tblRequest_1.Id = tblRequestBudget_1.RequestId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_6 ON tblRequestBudget_1.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea_6.id INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_6 ON tblBudgetDetailProjectArea_6.BudgetDetailProjectId = tblBudgetDetailProject_6.Id AND 
                                                         tblBudgetDetailProjectArea_6.BudgetDetailProjectId = tblBudgetDetailProject_6.Id AND tblBudgetDetailProjectArea_6.BudgetDetailProjectId = tblBudgetDetailProject_6.Id AND 
                                                         tblBudgetDetailProjectArea_6.BudgetDetailProjectId = tblBudgetDetailProject_6.Id INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_6 ON tblBudgetDetailProject_6.BudgetDetailId = TblBudgetDetails_6.Id AND tblBudgetDetailProject_6.BudgetDetailId = TblBudgetDetails_6.Id AND 
                                                         tblBudgetDetailProject_6.BudgetDetailId = TblBudgetDetails_6.Id AND tblBudgetDetailProject_6.BudgetDetailId = TblBudgetDetails_6.Id INNER JOIN
                                                         TblBudgets AS TblBudgets_6 ON TblBudgetDetails_6.BudgetId = TblBudgets_6.Id AND TblBudgetDetails_6.BudgetId = TblBudgets_6.Id AND TblBudgetDetails_6.BudgetId = TblBudgets_6.Id INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_6.tblCodingId = tblCoding_6.Id AND TblBudgetDetails_6.tblCodingId = tblCoding_6.Id AND TblBudgetDetails_6.tblCodingId = tblCoding_6.Id
                               WHERE        (TblBudgets_6.TblYearId = @yearId) AND (tblCoding_6.TblBudgetProcessId = 4) AND (tblRequest_1.DateS BETWEEN @Datestart AND @DateEnd)
                               GROUP BY tblBudgetDetailProjectArea_6.AreaId) AS der_SupplyFinancial ON tbl1.Id = der_SupplyFinancial.AreaId LEFT OUTER JOIN
                             (SELECT        tblBudgetDetailProjectArea_6.AreaId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmountCivil
                               FROM            tblRequest INNER JOIN
                                                         tblRequestBudget ON tblRequest.Id = tblRequestBudget.RequestId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_6 ON tblRequestBudget.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea_6.id INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_6 ON tblBudgetDetailProjectArea_6.BudgetDetailProjectId = tblBudgetDetailProject_6.Id AND 
                                                         tblBudgetDetailProjectArea_6.BudgetDetailProjectId = tblBudgetDetailProject_6.Id AND tblBudgetDetailProjectArea_6.BudgetDetailProjectId = tblBudgetDetailProject_6.Id AND 
                                                         tblBudgetDetailProjectArea_6.BudgetDetailProjectId = tblBudgetDetailProject_6.Id INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_6 ON tblBudgetDetailProject_6.BudgetDetailId = TblBudgetDetails_6.Id AND tblBudgetDetailProject_6.BudgetDetailId = TblBudgetDetails_6.Id AND 
                                                         tblBudgetDetailProject_6.BudgetDetailId = TblBudgetDetails_6.Id AND tblBudgetDetailProject_6.BudgetDetailId = TblBudgetDetails_6.Id INNER JOIN
                                                         TblBudgets AS TblBudgets_6 ON TblBudgetDetails_6.BudgetId = TblBudgets_6.Id AND TblBudgetDetails_6.BudgetId = TblBudgets_6.Id AND TblBudgetDetails_6.BudgetId = TblBudgets_6.Id INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_6.tblCodingId = tblCoding_6.Id AND TblBudgetDetails_6.tblCodingId = tblCoding_6.Id AND TblBudgetDetails_6.tblCodingId = tblCoding_6.Id
                               WHERE        (TblBudgets_6.TblYearId = @yearId) AND (tblCoding_6.TblBudgetProcessId = 3) AND (tblRequest.DateS BETWEEN @Datestart AND @DateEnd)
                               GROUP BY tblBudgetDetailProjectArea_6.AreaId) AS der_CreditCivil ON tbl1.Id = der_CreditCivil.AreaId LEFT OUTER JOIN
                             (SELECT        AreaId, SUM(ExpenseMonthRevenue) AS ExpenseMonthRevenue
                               FROM            (SELECT        tblBudgetDetailProjectArea_5.AreaId, tblSanadDetail_MD_1.Bestankar - tblSanadDetail_MD_1.Bedehkar AS ExpenseMonthRevenue, TblCodingsMapSazman_1.CodeAcc
                                                         FROM            olden.tblSanad_MD AS tblSanad_MD_1 INNER JOIN
                                                                                   olden.tblSanadDetail_MD AS tblSanadDetail_MD_1 ON tblSanad_MD_1.Id = tblSanadDetail_MD_1.IdSanad_MD AND tblSanad_MD_1.AreaId = tblSanadDetail_MD_1.AreaId AND 
                                                                                   tblSanad_MD_1.YearName = tblSanadDetail_MD_1.YearName INNER JOIN
                                                                                   TblBudgetDetails AS TblBudgetDetails_5 INNER JOIN
                                                                                   TblBudgets AS TblBudgets_5 ON TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND 
                                                                                   TblBudgetDetails_5.BudgetId = TblBudgets_5.Id INNER JOIN
                                                                                   tblBudgetDetailProject AS tblBudgetDetailProject_5 ON TblBudgetDetails_5.Id = tblBudgetDetailProject_5.BudgetDetailId INNER JOIN
                                                                                   tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_5 ON tblBudgetDetailProject_5.Id = tblBudgetDetailProjectArea_5.BudgetDetailProjectId INNER JOIN
                                                                                   tblCoding AS tblCoding_5 ON TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id INNER JOIN
                                                                                   TblCodingsMapSazman AS TblCodingsMapSazman_1 ON tblCoding_5.Id = TblCodingsMapSazman_1.CodingId AND tblBudgetDetailProjectArea_5.AreaId = TblCodingsMapSazman_1.AreaId ON 
                                                                                   tblSanadDetail_MD_1.CodeVasetSazman = TblCodingsMapSazman_1.CodeAcc AND tblSanadDetail_MD_1.AreaId = TblCodingsMapSazman_1.AreaId
                                                         WHERE        (TblBudgets_5.TblYearId = @yearId) AND (tblCoding_5.TblBudgetProcessId = 1) AND (TblCodingsMapSazman_1.YearId = @yearId) AND (tblSanadDetail_MD_1.YearName = @YearName) AND 
                                                                                   (tblSanad_MD_1.SanadDateS BETWEEN @Datestart AND @DateEnd) AND (TblCodingsMapSazman_1.CodeAcc IS NOT NULL)) AS tbl1_1_1
                               GROUP BY AreaId) AS derivedtbl_1 ON tbl1.Id = derivedtbl_1.AreaId LEFT OUTER JOIN
                             (SELECT        AreaId, SUM(ExpenseMonthCurrent) AS ExpenseMonthCurrent
                               FROM            (SELECT        tblBudgetDetailProjectArea_5.AreaId, olden.tblSanadDetail_MD.Bedehkar - olden.tblSanadDetail_MD.Bestankar AS ExpenseMonthCurrent, TblCodingsMapSazman.CodeAcc
                                                         FROM            olden.tblSanad_MD INNER JOIN
                                                                                   olden.tblSanadDetail_MD ON olden.tblSanad_MD.Id = olden.tblSanadDetail_MD.IdSanad_MD AND olden.tblSanad_MD.AreaId = olden.tblSanadDetail_MD.AreaId AND 
                                                                                   olden.tblSanad_MD.YearName = olden.tblSanadDetail_MD.YearName INNER JOIN
                                                                                   TblBudgetDetails AS TblBudgetDetails_5 INNER JOIN
                                                                                   TblBudgets AS TblBudgets_5 ON TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND TblBudgetDetails_5.BudgetId = TblBudgets_5.Id AND 
                                                                                   TblBudgetDetails_5.BudgetId = TblBudgets_5.Id INNER JOIN
                                                                                   tblBudgetDetailProject AS tblBudgetDetailProject_5 ON TblBudgetDetails_5.Id = tblBudgetDetailProject_5.BudgetDetailId INNER JOIN
                                                                                   tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_5 ON tblBudgetDetailProject_5.Id = tblBudgetDetailProjectArea_5.BudgetDetailProjectId INNER JOIN
                                                                                   tblCoding AS tblCoding_5 ON TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id AND TblBudgetDetails_5.tblCodingId = tblCoding_5.Id INNER JOIN
                                                                                   TblCodingsMapSazman ON tblCoding_5.Id = TblCodingsMapSazman.CodingId AND tblBudgetDetailProjectArea_5.AreaId = TblCodingsMapSazman.AreaId ON 
                                                                                   olden.tblSanadDetail_MD.AreaId = TblCodingsMapSazman.AreaId AND olden.tblSanadDetail_MD.CodeVasetSazman = TblCodingsMapSazman.CodeAcc
                                                         WHERE        (TblBudgets_5.TblYearId = @yearId) AND (tblCoding_5.TblBudgetProcessId = 2) AND (TblCodingsMapSazman.YearId = @yearId) AND (olden.tblSanadDetail_MD.YearName = @YearName) AND 
                                                                                   (olden.tblSanad_MD.SanadDateS BETWEEN @Datestart AND @DateEnd) AND (olden.tblSanad_MD.YearName = @YearName) AND (TblCodingsMapSazman.CodeAcc IS NOT NULL)) AS tbl1_1
                               GROUP BY AreaId) AS der_MonthCurrent ON tbl1.Id = der_MonthCurrent.AreaId
ORDER BY tbl1.AreaName
END
GO
