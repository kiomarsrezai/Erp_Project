USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP500_ProctorAutomation]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP500_ProctorAutomation]
@YearId int,
@AreaId int,
@ProctorId int 

AS
BEGIN
SELECT   tblRequest.Number, tblRequest.Date, tblRequest.Description, tblRequest.EstimateAmount,
        tblCoding.Code, tblCoding.Description AS title
FROM            TblBudgetDetails INNER JOIN
                         TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblRequestBudget ON tblBudgetDetailProjectArea.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblRequest ON tblRequestBudget.RequestId = tblRequest.Id
WHERE  (TblBudgets.TblYearId = @YearId) AND
       (tblRequest.AreaId = @AreaId)AND
	   (tblCoding.ProctorId = @ProctorId)
END
GO
