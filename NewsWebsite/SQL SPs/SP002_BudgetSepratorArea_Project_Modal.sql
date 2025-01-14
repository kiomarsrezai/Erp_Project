USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_BudgetSepratorArea_Project_Modal]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_BudgetSepratorArea_Project_Modal]
@yearId int ,
@areaId int ,
@BudgetProcessId tinyint,
@codingId int
AS
BEGIN
--SELECT        tbl1.ProjectId,TblProjects.ProjectCode, TblProjects.ProjectName, tbl1.Mosavab, tbl1.Expense
--FROM            (SELECT        TblProgramOperationDetails.TblProjectId as ProjectId, SUM(tblBudgetDetailProjectArea.Mosavab) AS Mosavab, SUM(tblBudgetDetailProjectArea.Expense) AS Expense
--                          FROM            TblBudgets AS TblBudgets_1 INNER JOIN
--                                                    TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
--                                                    tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
--                                                    tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
--                                                    tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
--                                                    TblProgramOperationDetails ON tblBudgetDetailProject_1.ProgramOperationDetailsId = TblProgramOperationDetails.Id
--                          WHERE (TblBudgets_1.TblYearId = @yearId) AND
--						        (tblBudgetDetailProjectArea.AreaId = @areaId) AND
--								(tblCoding_1.TblBudgetProcessId = @BudgetProcessId) AND
--								(TblBudgetDetails_1.tblCodingId = @codingId)
--                          GROUP BY TblProgramOperationDetails.TblProjectId) AS tbl1 INNER JOIN
--                         TblProjects ON tbl1.ProjectId = TblProjects.Id
SELECT        tblBudgetDetailProject_1.Id  , TblProgramOperationDetails.TblProjectId AS ProjectId, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.Expense, TblProjects.ProjectCode, TblProjects.ProjectName
FROM            TblBudgets AS TblBudgets_1 INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_1 ON TblBudgets_1.Id = TblBudgetDetails_1.BudgetId INNER JOIN
                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON TblBudgetDetails_1.Id = tblBudgetDetailProject_1.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblProgramOperationDetails ON tblBudgetDetailProject_1.ProgramOperationDetailsId = TblProgramOperationDetails.Id INNER JOIN
                         TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id
WHERE   (TblBudgets_1.TblYearId = @yearId) AND
        (tblBudgetDetailProjectArea.AreaId = @areaId) AND
        (TblBudgetDetails_1.tblCodingId = @codingId)
END
GO
