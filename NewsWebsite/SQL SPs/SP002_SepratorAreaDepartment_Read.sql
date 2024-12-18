USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_SepratorAreaDepartment_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_SepratorAreaDepartment_Read]
@yearId int , 
@areaId int ,
@budgetProcessId int
AS
BEGIN

SELECT     CodingId,ProjectId, tblCoding_4.Code, tblCoding_4.Description,tbl2.Mosavab,tbl2.Expense ,tblCoding_4.levelNumber,TblProjects.ProjectCode + ' '+TblProjects.ProjectName as Project,tblCoding_4.Crud
FROM            (SELECT        CodingId,ProjectId, isnull(SUM(Mosavab),0) AS Mosavab, isnull(SUM(Edit),0) AS Edit , isnull(SUM(Expense),0) AS Expense ,isnull(sum(CreditAmount),0) as CreditAmount
                           FROM            (

--سطح اول
SELECT        tblCoding_5.MotherId AS CodingId, TblProgramOperationDetails.TblProjectId as ProjectId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.Edit, tblBudgetDetailProjectArea.Expense, der_Supply.CreditAmount
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
                         TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id LEFT OUTER JOIN
                             (SELECT        TblBudgetDetails_1.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_6 ON TblBudgetDetails_1.tblCodingId = tblCoding_6.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaDepartmentId
                               WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblBudgetDetailProjectArea_1.AreaId = @AreaId) AND (tblCoding_6.TblBudgetProcessId = @BudgetProcessId)
                               GROUP BY TblBudgetDetails_1.tblCodingId) AS der_Supply ON TblBudgetDetails.tblCodingId = der_Supply.tblCodingId
WHERE        (TblBudgets.TblYearId = @YearId) AND (tblBudgetDetailProjectArea.AreaId = @AreaId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)
UNION ALL

--	--سطح 2					   
SELECT        tblCoding_4.MotherId AS CodingId, TblProgramOperationDetails.TblProjectId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.Edit, tblBudgetDetailProjectArea.Expense, der_Supply.CreditAmount
FROM            tblCoding AS tblCoding_2 INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                         tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                         tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                         tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id LEFT OUTER JOIN
                             (SELECT        TblBudgetDetails_1.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_5 ON TblBudgetDetails_1.tblCodingId = tblCoding_5.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaDepartmentId
                               WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblBudgetDetailProjectArea_1.AreaId = @AreaId) AND (tblCoding_5.TblBudgetProcessId = @BudgetProcessId)
                               GROUP BY TblBudgetDetails_1.tblCodingId) AS der_Supply ON TblBudgetDetails.tblCodingId = der_Supply.tblCodingId
WHERE        (TblBudgets.TblYearId = @YearId) AND (tblBudgetDetailProjectArea.AreaId = @AreaId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)

UNION ALL

----سطح 3
SELECT        tblCoding_1.MotherId AS CodingId, TblProgramOperationDetails.TblProjectId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.Edit, tblBudgetDetailProjectArea.Expense, der_Supply.CreditAmount
FROM            tblCoding AS tblCoding_2 INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                         tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                         tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id LEFT OUTER JOIN
                             (SELECT        TblBudgetDetails_1.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_4 ON TblBudgetDetails_1.tblCodingId = tblCoding_4.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaDepartmentId
                               WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblBudgetDetailProjectArea_1.AreaId = @AreaId) AND (tblCoding_4.TblBudgetProcessId = @BudgetProcessId)
                               GROUP BY TblBudgetDetails_1.tblCodingId) AS der_Supply ON TblBudgetDetails.tblCodingId = der_Supply.tblCodingId
WHERE        (TblBudgets.TblYearId = @YearId) AND (tblBudgetDetailProjectArea.AreaId = @AreaId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)

UNION ALL
--سطح 4
SELECT        tblCoding_3.MotherId AS CodingId, TblProgramOperationDetails.TblProjectId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.Edit, tblBudgetDetailProjectArea.Expense, der_Supply.CreditAmount
FROM            tblCoding AS tblCoding_2 INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId ON tblCoding_2.Id = tblCoding.MotherId INNER JOIN
                         tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id LEFT OUTER JOIN
                             (SELECT        TblBudgetDetails_1.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaDepartmentId
                               WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblBudgetDetailProjectArea_1.AreaId = @AreaId) AND (tblCoding_1.TblBudgetProcessId = @BudgetProcessId)
                               GROUP BY TblBudgetDetails_1.tblCodingId) AS der_Supply ON TblBudgetDetails.tblCodingId = der_Supply.tblCodingId
WHERE        (TblBudgets.TblYearId = @YearId) AND (tblBudgetDetailProjectArea.AreaId = @AreaId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)
UNION ALL
--سطح 5
SELECT        tblCoding_2.MotherId AS CodingId, TblProgramOperationDetails.TblProjectId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.Edit, tblBudgetDetailProjectArea.Expense, der_Supply.CreditAmount
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblCoding AS tblCoding_2 ON tblCoding.MotherId = tblCoding_2.Id INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id LEFT OUTER JOIN
                             (SELECT        TblBudgetDetails_1.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaDepartmentId
                               WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblBudgetDetailProjectArea_1.AreaId = @AreaId) AND (tblCoding_1.TblBudgetProcessId = @BudgetProcessId)
                               GROUP BY TblBudgetDetails_1.tblCodingId) AS der_Supply ON TblBudgetDetails.tblCodingId = der_Supply.tblCodingId
WHERE        (TblBudgets.TblYearId = @YearId) AND (tblBudgetDetailProjectArea.AreaId = @AreaId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)

UNION ALL
--سطح 6
SELECT        tblCoding_3.MotherId AS CodingId, TblProgramOperationDetails.TblProjectId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.Edit, tblBudgetDetailProjectArea.Expense, der_Supply.CreditAmount
FROM            TblBudgets AS TblBudgets_2 INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_2 ON TblBudgets_2.Id = TblBudgetDetails_2.BudgetId INNER JOIN
                         tblCoding AS tblCoding_3 ON TblBudgetDetails_2.tblCodingId = tblCoding_3.Id INNER JOIN
                         tblBudgetDetailProject AS tblBudgetDetailProject_2 ON TblBudgetDetails_2.Id = tblBudgetDetailProject_2.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject_2.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblProgramOperationDetails ON tblBudgetDetailProject_2.ProgramOperationDetailsId = TblProgramOperationDetails.Id LEFT OUTER JOIN
                             (SELECT        TblBudgetDetails.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaDepartmentId
                               WHERE        (TblBudgets.TblYearId = @YearId) AND (tblBudgetDetailProjectArea_1.AreaId = @AreaId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)
                               GROUP BY TblBudgetDetails.tblCodingId) AS der_Supply ON TblBudgetDetails_2.tblCodingId = der_Supply.tblCodingId
WHERE        (TblBudgets_2.TblYearId = @YearId) AND (tblBudgetDetailProjectArea.AreaId = @AreaId) AND (tblCoding_3.TblBudgetProcessId = @BudgetProcessId)

UNION ALL
--سطح 7
SELECT        TblBudgetDetails_1.tblCodingId AS CodingId, TblProgramOperationDetails.TblProjectId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.Edit, tblBudgetDetailProjectArea.Expense, 
                         der_Supply.CreditAmount
FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblProgramOperationDetails ON tblBudgetDetailProject_1.ProgramOperationDetailsId = TblProgramOperationDetails.Id LEFT OUTER JOIN
                             (SELECT        TblBudgetDetails.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets INNER JOIN
                                                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaDepartmentId
                               WHERE        (TblBudgets.TblYearId = @YearId) AND (tblBudgetDetailProjectArea_1.AreaId = @AreaId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)
                               GROUP BY TblBudgetDetails.tblCodingId) AS der_Supply ON TblBudgetDetails_1.tblCodingId = der_Supply.tblCodingId
WHERE        (TblBudgets_1.TblYearId = @YearId) AND (tblBudgetDetailProjectArea.AreaId = @AreaId) AND (tblCoding_1.TblBudgetProcessId = @BudgetProcessId)
													  ) AS tbl1
                           GROUP BY CodingId,ProjectId) AS tbl2 INNER JOIN
                         tblCoding AS tblCoding_4 ON tbl2.CodingId = tblCoding_4.Id
						 LEFT OUTER JOIN
                         TblProjects ON tbl2.ProjectId = TblProjects.Id

ORDER BY tblCoding_4.Code



END
GO
