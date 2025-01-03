USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_SepratorAreaDepartmant_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_SepratorAreaDepartmant_Insert]
@yearId int ,
@areaId int,
@codingId int ,	
@projectId int ,
@departmanId int
AS
BEGIN
declare @Count int = (SELECT count(*)
											FROM  TblBudgets INNER JOIN
												  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
												  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
												  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
												  TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id
												   WHERE (TblBudgets.TblYearId = @yearId) AND
												         (tblBudgetDetailProjectArea.AreaId = @areaId) AND
												         (TblBudgetDetails.tblCodingId = @CodingId) AND
												         (TblProgramOperationDetails.TblProjectId = @ProjectId))

if(@Count=0) begin select 'کد بودجه موجود نمی باشد'                  as Message_DB return end
if(@Count>1) begin select 'تعداد ردیف بودجه بیش از یک ردیف می باشد' as Message_DB return end

--تعداددپارتمان در کوئری زیر چند تاست 
declare @Count_DepartmenId int = (SELECT     count(*)
									FROM TblBudgets INNER JOIN
										 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
										 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
										 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
										 TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id INNER JOIN
										 tblBudgetDetailProjectAreaDepartment ON tblBudgetDetailProjectArea.id = tblBudgetDetailProjectAreaDepartment.BudgetDetailProjectAreaId
									WHERE (TblBudgets.TblYearId = @yearId) AND
									      (tblBudgetDetailProjectArea.AreaId = @areaId) AND
									      (TblBudgetDetails.tblCodingId = @CodingId) AND
									      (TblProgramOperationDetails.TblProjectId = @ProjectId) AND 
									      (tblBudgetDetailProjectAreaDepartment.DepartmenId = @departmanId))

if(@Count_DepartmenId>1)
begin
   select 'دپارتمان قبلا به این ردیف بودجه متصل شده است' as Message_DB
   return
end

declare @BudgetDetailProjectAreaId int =(SELECT tblBudgetDetailProjectArea.id
											FROM  TblBudgets INNER JOIN
												  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
												  tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
												  tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
												  TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id
												   WHERE (TblBudgets.TblYearId = @yearId) AND
												         (tblBudgetDetailProjectArea.AreaId = @areaId) AND
												         (TblBudgetDetails.tblCodingId = @CodingId) AND
												         (TblProgramOperationDetails.TblProjectId = @ProjectId))


     insert into tblBudgetDetailProjectAreaDepartment( BudgetDetailProjectAreaId ,  DepartmenId)
	                                           values(@BudgetDetailProjectAreaId , @DepartmanId)
END
GO
