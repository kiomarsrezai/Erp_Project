USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_Budget_Inline_Delete]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_Budget_Inline_Delete]
@CodingId int,
@YearId int
AS
BEGIN

DELETE FROM tblBudgetDetailProjectAreaDepartment
FROM            TblBudgetDetails INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
                         tblBudgetDetailProjectAreaDepartment ON tblBudgetDetailProjectArea.id = tblBudgetDetailProjectAreaDepartment.BudgetDetailProjectAreaId
WHERE    (TblBudgets.TblYearId = @YearId) AND
         (TblBudgetDetails.tblCodingId = @CodingId)


DELETE FROM tblBudgetDetailProjectArea
FROM            TblBudgetDetails INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id
WHERE   (TblBudgets.TblYearId = @YearId) AND
        (TblBudgetDetails.tblCodingId = @CodingId)


DELETE FROM tblBudgetDetailProject
FROM            TblBudgetDetails INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id
WHERE   (TblBudgets.TblYearId = @YearId) AND
        (TblBudgetDetails.tblCodingId = @CodingId)


DELETE FROM TblBudgetDetails
FROM            TblBudgetDetails INNER JOIN
                         TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id
WHERE   (TblBudgets.TblYearId = @YearId) AND
        (TblBudgetDetails.tblCodingId = @CodingId)


END
GO
