USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal2Project_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetModal2Project_Update]
--@areaGlobalId int,
--@yearId int ,
--@codingId int,
--@projectId int,
--@areaId int,
@Mosavab bigint,
@EditProject bigint,
@Id int,
@areaId int,
@ProjectCode int

AS
BEGIN
--declare @Count int = (SELECT count(*)
--							FROM TblBudgets INNER JOIN
--								 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--								 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--								 TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id
--							   WHERE (TblBudgets.TblYearId = @yearId) AND
--							         (TblBudgets.TblAreaId = @areaId) AND
--									 (TblBudgetDetails.tblCodingId = @codingId) AND
--									 (TblProgramOperationDetails.TblProjectId = @projectId))
--if (@Count = 0)
-- begin
--     select 'رکوردی موجود نیست' as Message
--	 return
-- end

--if (@Count > 1)
-- begin
--     select ' تعداد رکورد موجود مجاز نیست' as Message
--	 return
-- end

--if (@Count = 1)
-- begin
--declare @Id int = (SELECT  tblBudgetDetailProject.Id
--							FROM TblBudgets INNER JOIN
--								 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--								 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--								 TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id
--							   WHERE (TblBudgets.TblYearId = @yearId) AND
--							         (TblBudgets.TblAreaId = @areaId) AND
--									 (TblBudgetDetails.tblCodingId = @codingId) AND
--									 (TblProgramOperationDetails.TblProjectId = @projectId))
--end
--declare @BudgetDetailProjectId int= (SELECT        tblBudgetDetailProject.Id
--										FROM            TblBudgets INNER JOIN
--																 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--																 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--																 TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id INNER JOIN
--																 TblProgramOperations ON TblProgramOperationDetails.TblProgramOperationId = TblProgramOperations.Id
--                                    WHERE (TblBudgets.TblYearId = @yearId) AND
--									      (TblBudgets.TblAreaId = @areaGlobalId) AND
--										  (TblBudgetDetails.tblCodingId = @codingId) AND
--										  (TblProgramOperationDetails.TblProjectId = @projectId) AND
--										  (TblProgramOperations.TblAreaId = @areaId))



declare @ProgramOperationDetailsIdCount int= (SELECT        count(*)
										FROM            TblProgramOperationDetails INNER JOIN
                                                        TblProjects ON TblProjects.Id = TblProgramOperationDetails.TblProjectId INNER JOIN
                                                        TblProgramOperations ON TblProgramOperations.Id = TblProgramOperationDetails.TblProgramOperationId 
                                   WHERE (TblProjects.ProjectCode = @ProjectCode) AND
                                          (TblProgramOperations.TblAreaId = @areaId) AND
                                          (TblProgramOperations.TblProgramId = 10)
                                   )
if(@ProgramOperationDetailsIdCount!=1)
    begin

        select CONCAT('رکوردی با کد پروژه موجود نیست' ,@ProgramOperationDetailsIdCount) as Message_DB
        return
    end
    
declare @ProgramOperationDetailsId int= (SELECT        TblProgramOperationDetails.Id
										FROM            TblProgramOperationDetails INNER JOIN
                                                        TblProjects ON TblProjects.Id = TblProgramOperationDetails.TblProjectId  INNER JOIN
                                                        TblProgramOperations ON TblProgramOperations.Id = TblProgramOperationDetails.TblProgramOperationId 
                                   WHERE (TblProjects.ProjectCode = @ProjectCode) AND
                                             (TblProgramOperations.TblAreaId = @areaId) AND
                                             (TblProgramOperations.TblProgramId = 10))

update tblBudgetDetailProject
 set Mosavab = @Mosavab ,
 EditProject = @EditProject,
 ProgramOperationDetailsId=@ProgramOperationDetailsId
    where id = @Id

END
GO
