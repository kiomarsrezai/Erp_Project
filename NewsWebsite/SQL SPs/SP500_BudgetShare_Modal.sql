USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP500_BudgetShare_Modal]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP500_BudgetShare_Modal]
@YearId int ,
@AreaId int ,
@CodingId int
AS
BEGIN
SELECT        tblRequest.Number, tblRequest.Date, tblRequest.Description,
tblRequestBudget.RequestBudgetAmount 
FROM            tblRequestBudget INNER JOIN
                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblRequestBudget.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea_1.id INNER JOIN
                         tblBudgetDetailProject AS tblBudgetDetailProject_1 ON tblBudgetDetailProjectArea_1.BudgetDetailProjectId = tblBudgetDetailProject_1.Id INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_1 ON tblBudgetDetailProject_1.BudgetDetailId = TblBudgetDetails_1.Id INNER JOIN
                         TblBudgets AS TblBudgets_1 ON TblBudgetDetails_1.BudgetId = TblBudgets_1.Id INNER JOIN
                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                         tblRequest ON tblRequestBudget.RequestId = tblRequest.Id
WHERE  (TblBudgets_1.TblYearId = @YearId) AND
       (tblBudgetDetailProjectArea_1.AreaId = @AreaId) AND
	   (TblBudgetDetails_1.tblCodingId = @CodingId)
END
GO
