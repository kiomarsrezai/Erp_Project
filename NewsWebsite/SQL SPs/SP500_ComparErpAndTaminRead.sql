USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP500_ComparErpAndTaminRead]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP500_ComparErpAndTaminRead]
@YearId int,
@AreaId int,
@BudgetProcessId tinyint,
@Number int
AS
BEGIN
if(@AreaId in (1,2,3,4,5,6,7,8,9))
begin
SELECT tblBudgetDetailProjectArea.AreaId ,  tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea as Edit,
         tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, 
         aa1402_compar_Rezaei_ERP.Total_Res, tblBudgetDetailProjectArea.Mosavab - aa1402_compar_Rezaei_ERP.Total_Res AS Diff
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         aa1402_compar_Rezaei_ERP ON tblBudgetDetailProjectArea.AreaId = aa1402_compar_Rezaei_ERP.SectionId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id AND aa1402_compar_Rezaei_ERP.BodgetId = tblCoding.Code COLLATE Arabic_CI_AS
WHERE  (TblBudgets.TblYearId = @YearId) AND
       (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
       (tblBudgetDetailProjectArea.AreaId = @AreaId)
ORDER BY tblCoding.Code
return
end

if(@AreaId=10)
begin
SELECT tblBudgetDetailProjectArea.AreaId ,  tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea as Edit,
         tblBudgetDetailProjectArea.Supply, tblBudgetDetailProjectArea.Expense, 
         aa1402_compar_Rezaei_ERP.Total_Res, tblBudgetDetailProjectArea.Mosavab - aa1402_compar_Rezaei_ERP.Total_Res AS Diff
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         aa1402_compar_Rezaei_ERP ON tblBudgetDetailProjectArea.AreaId = aa1402_compar_Rezaei_ERP.SectionId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id AND aa1402_compar_Rezaei_ERP.BodgetId = tblCoding.Code COLLATE Arabic_CI_AS
WHERE   (TblBudgets.TblYearId = @YearId) AND
        (tblCoding.TblBudgetProcessId = @BudgetProcessId) AND
     (tblBudgetDetailProjectArea.AreaId in (1,2,3,4,5,6,7,8,9))AND
	tblBudgetDetailProjectArea.Mosavab - aa1402_compar_Rezaei_ERP.Total_Res<>0
ORDER BY tblCoding.Code,tblBudgetDetailProjectArea.AreaId
return
end


END
GO
