USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP007_EditDetail_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP007_EditDetail_Read]
@Id int
AS
BEGIN
SELECT        tblBudgetDetailProjectAreaEdit.id, tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.EditArea , tblBudgetDetailProjectAreaEdit.Decrease, 
                         tblBudgetDetailProjectAreaEdit.Increase
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProjectAreaEdit ON tblBudgetDetailProjectArea.id = tblBudgetDetailProjectAreaEdit.BudgetDetailProjectAreaId
WHERE        (tblBudgetDetailProjectAreaEdit.BudgetDetailProjectAreaEditMasterId = @Id)

END
GO
