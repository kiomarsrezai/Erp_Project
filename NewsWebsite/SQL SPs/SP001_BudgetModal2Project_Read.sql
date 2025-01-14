USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal2Project_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetModal2Project_Read]
@codingId int ,
@yearId  int ,
@areaId  int
AS
BEGIN
declare @Area2 int 
if(@areaId in (30,31,32,33,34,35,36,42,43,44,53)) 
begin 
set  @areaId=9   
end

if(@AreaId in (10,37))
begin
SELECT        tblBudgetDetailProject.Id, TblProgramOperationDetails.TblProjectId AS ProjectId, TblProgramOperations.TblAreaId as AreaId, TblAreas.AreaNameShort as AreaName, TblProjects.ProjectCode, TblProjects.ProjectName, tblBudgetDetailProject.Mosavab, 
                         tblBudgetDetailProject.EditProject, tblBudgetDetailProject.Expense
FROM            TblProgramOperationDetails INNER JOIN
                         tblBudgetDetailProject ON TblProgramOperationDetails.Id = tblBudgetDetailProject.ProgramOperationDetailsId INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId ON tblBudgetDetailProject.BudgetDetailId = TblBudgetDetails.Id INNER JOIN
                         TblProgramOperations ON TblProgramOperationDetails.TblProgramOperationId = TblProgramOperations.Id INNER JOIN
                         TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id INNER JOIN
                         TblAreas ON TblProgramOperations.TblAreaId = TblAreas.Id
WHERE (TblBudgetDetails.tblCodingId = @codingId) AND
      (TblBudgets.TblYearId = @yearId) 
order by AreaId
return
end

if(@AreaId not in (10,37))
begin
SELECT        tblBudgetDetailProject.Id, TblProgramOperationDetails.TblProjectId AS ProjectId, TblProgramOperations.TblAreaId AS AreaId, TblAreas.AreaNameShort AS AreaName, TblProjects.ProjectCode, TblProjects.ProjectName, 
                         tblBudgetDetailProject.Mosavab, tblBudgetDetailProject.EditProject, tblBudgetDetailProject.Expense
FROM            TblProgramOperationDetails INNER JOIN
                         tblBudgetDetailProject ON TblProgramOperationDetails.Id = tblBudgetDetailProject.ProgramOperationDetailsId INNER JOIN
                         TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId ON tblBudgetDetailProject.BudgetDetailId = TblBudgetDetails.Id INNER JOIN
                         TblProgramOperations ON TblProgramOperationDetails.TblProgramOperationId = TblProgramOperations.Id INNER JOIN
                         TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
WHERE        (TblBudgetDetails.tblCodingId = @codingId) AND (TblBudgets.TblYearId = @yearId) AND (tblBudgetDetailProjectArea.AreaId = @areaId)
ORDER BY AreaId
return
end

--SELECT        TblAreas.AreaNameShort AS AreaName, tbl1.ProjectId, tbl1.Mosavab, tbl1.Edit, tbl1.Expense, TblProjects.ProjectCode, TblProjects.ProjectName, tbl1.TblAreaId
--FROM            (SELECT   TblProgramOperationDetails.TblProjectId AS ProjectId, TblProgramOperations.TblAreaId,
--                         tblBudgetDetailProject.Mosavab , tblBudgetDetailProject.Edit, 
--                          tblBudgetDetailProject.Expense
--                          FROM            TblProgramOperationDetails INNER JOIN
--                                                    tblBudgetDetailProject ON TblProgramOperationDetails.Id = tblBudgetDetailProject.ProgramOperationDetailsId INNER JOIN
--                                                    TblBudgets INNER JOIN
--                                                    TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId ON tblBudgetDetailProject.BudgetDetailId = TblBudgetDetails.Id INNER JOIN
--                                                    TblProgramOperations ON TblProgramOperationDetails.TblProgramOperationId = TblProgramOperations.Id
--                          WHERE (TblBudgetDetails.tblCodingId = @codingId) AND
--						        (TblBudgets.TblYearId = @yearId) AND
--								(TblBudgets.TblAreaId = @areaId)
--                         ) AS tbl1 INNER JOIN
--                         TblProjects ON tbl1.ProjectId = TblProjects.Id LEFT OUTER JOIN
--                         TblAreas ON tbl1.TblAreaId = TblAreas.Id



END
GO
