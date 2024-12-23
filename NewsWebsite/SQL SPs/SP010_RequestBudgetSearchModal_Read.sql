USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP010_RequestBudgetSearchModal_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP010_RequestBudgetSearchModal_Read]
@yearId int,
@areaId int ,
@departmentId int
AS
BEGIN

SELECT        tblBudgetDetailProjectArea.id, TblYears.YearName, tblCoding.Code, tblCoding.Description, TblProjects.ProjectCode + '  ' + TblProjects.ProjectName AS Project, tblBudgetDetailProjectAreaDepartment.DepartmenId, 
                         tblBudgetDetailProjectAreaDepartment.MosavabDepartment, 
						 tblCoding.TblBudgetProcessId AS BudgetProcessId, isnull(der_Credit.CreditAmount,0) as CreditAmount,
 tblBudgetDetailProjectAreaDepartment.MosavabDepartment-isnull(der_Credit.CreditAmount,0) as Balance
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         TblYears ON TblBudgets.TblYearId = TblYears.Id INNER JOIN
                         TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id INNER JOIN
                         TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id INNER JOIN
                         tblBudgetDetailProjectAreaDepartment ON tblBudgetDetailProjectArea.id = tblBudgetDetailProjectAreaDepartment.BudgetDetailProjectAreaId LEFT OUTER JOIN
                             (SELECT        TblBudgetDetails_1.tblCodingId, SUM(tblRequestBudget.RequestBudgetAmount) AS CreditAmount
                               FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                                                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                                                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                                                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                                                         tblBudgetDetailProjectAreaDepartment AS tblBudgetDetailProjectAreaDepartment_1 ON tblBudgetDetailProjectArea_1.id = tblBudgetDetailProjectAreaDepartment_1.BudgetDetailProjectAreaId INNER JOIN
                                                         tblRequestBudget ON tblBudgetDetailProjectArea_1.id = tblRequestBudget.BudgetDetailProjectAreaId
                               WHERE (TblBudgets_1.TblYearId = @yearId) AND
							         (tblBudgetDetailProjectArea_1.AreaId = @areaId) AND
									 (tblBudgetDetailProjectAreaDepartment_1.DepartmenId = @departmentId)
                               GROUP BY TblBudgetDetails_1.tblCodingId) AS der_Credit ON TblBudgetDetails.tblCodingId = der_Credit.tblCodingId
								WHERE  (TblBudgets.TblYearId = @yearId) AND
								       (tblBudgetDetailProjectArea.AreaId = @areaId) AND
									   (tblBudgetDetailProjectAreaDepartment.DepartmenId = @DepartmentId)
								ORDER BY TblYears.YearName, tblCoding.Code
END
GO
