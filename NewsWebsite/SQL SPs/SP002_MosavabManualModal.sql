USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_MosavabManualModal]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_MosavabManualModal]
@yearId int,
@areaId int,
@budgetProcessId tinyint--,
--@CodingId int,
--@Mosavab bigint
AS
BEGIN
SELECT        tblCoding.Code, tblCoding.Description, TblBudgetDetails.Id as BudgetDetailId, TblBudgetDetails.MosavabPublic, tblBudgetDetailProject.Id AS BudgetDetailProjectId, tblBudgetDetailProject.Mosavab as MosavabProject, tblBudgetDetailProjectArea.id AS BudgetDetailProjectAreaId, 
                         tblBudgetDetailProjectArea.Mosavab AS MosavabArea
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
WHERE  (TblBudgets.TblYearId = @yearId) AND
       (tblBudgetDetailProjectArea.AreaId = @areaId) AND
	   (tblCoding.TblBudgetProcessId = @budgetProcessId)
ORDER BY tblCoding.Code
 --  declare @BudgetDetailProjectAreaId int = (SELECT tblBudgetDetailProjectArea.id
	--											FROM            TblBudgets INNER JOIN
	--																	 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
	--																	 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
	--																	 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
	--																	 tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
	--											WHERE  (TblBudgets.TblYearId = @yearId) AND
	--												   (TblBudgets.TblAreaId = @areaId) AND
	--												   (TblBudgetDetails.tblCodingId = @CodingId))
	--if(@BudgetDetailProjectAreaId is null or 
	--   @BudgetDetailProjectAreaId = ''    or
	--   @BudgetDetailProjectAreaId =0)
	--   begin
	--    select 'کد انتخاب شده قابل تغییر نمی باشد' as Message_DB
	--   return
	--   end

	--   update tblBudgetDetailProjectArea
	--   set Mosavab = @Mosavab
	--   where id = @BudgetDetailProjectAreaId

END
GO
