USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetConfirmStatus_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetConfirmStatus_Update]
    @YearId int ,
    @AreaId int ,
    @codingId int,
	@status int
AS
BEGIN
	if(@areaId  in (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29,30,31,32,33,34,35,36,42,43,44,53))
        begin

		declare @Count_BudgetDetailProjectAreaId int =(SELECT count(*)
												FROM            TblBudgets INNER JOIN
																		 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
																		 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
																		 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
												WHERE       (TblBudgets.TblYearId = @yearId) AND
															(tblBudgetDetailProjectArea.AreaId = @areaId) AND
															(TblBudgetDetails.tblCodingId = @CodingId))

			if(@Count_BudgetDetailProjectAreaId>=2)
			 begin
				select ' تعداد رکورد بیشتر از یک مورد است ' as Message_DB
				return
			 end



			declare @BudgetDetailProjectAreaId int =(SELECT tblBudgetDetailProjectArea.id
												FROM            TblBudgets INNER JOIN
																		 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
																		 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
																		 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
												WHERE       (TblBudgets.TblYearId = @yearId) AND
															(tblBudgetDetailProjectArea.AreaId = @areaId) AND
															(TblBudgetDetails.tblCodingId = @CodingId))
                  
				  if(@BudgetDetailProjectAreaId is null or @BudgetDetailProjectAreaId='')
				 begin
					select 'خطا در BudgetDetailProjectAreaId' as Message_DB
					return
				 end



				 update tblBudgetDetailProjectArea
						set ConfirmStatus = @status
						
						   where id = @BudgetDetailProjectAreaId

		end


END
GO
