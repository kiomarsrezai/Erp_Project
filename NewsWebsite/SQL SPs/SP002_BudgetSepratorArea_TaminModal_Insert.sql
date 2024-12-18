USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_BudgetSepratorArea_TaminModal_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_BudgetSepratorArea_TaminModal_Insert]
@yearId int,
@areaId int,
@budgetProcessId tinyint,
@codingId int ,

@RequestRefStr nvarchar(200),
@RequestDate   nvarchar(20),
@RequestPrice  bigint,
@ReqDesc       nvarchar(200) 

AS
BEGIN

declare @Count_BudgetDetailProjectAreaId int = (SELECT  Count(*)
												FROM            TblBudgets INNER JOIN
																		 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
																		 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
																		 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
																		 tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
												WHERE  (TblBudgets.TblYearId = @yearId) AND
													  (tblBudgetDetailProjectArea.AreaId = @areaId) AND
													  (TblBudgetDetails.tblCodingId = @codingId) AND
													  (tblCoding.TblBudgetProcessId = @budgetProcessId))
if(@Count_BudgetDetailProjectAreaId>1)
begin
   select 'خطا در ورود' as Message
return
end
declare @BudgetDetailProjectAreaId int = (SELECT        tblBudgetDetailProjectAreaDepartment.Id
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProjectAreaDepartment ON tblBudgetDetailProjectArea.id = tblBudgetDetailProjectAreaDepartment.BudgetDetailProjectAreaId
WHERE (TblBudgets.TblYearId = @yearId) AND
      (tblBudgetDetailProjectArea.AreaId = @areaId) AND
	  (TblBudgetDetails.tblCodingId = @codingId) AND
	  (tblCoding.TblBudgetProcessId = @budgetProcessId))

insert into tblRequest ( YearId ,  AreaId ,      Number    ,               Date              ,  EstimateAmount ,  Description )
			 	 values(@yearId , @areaId , @RequestRefStr , dbo.ShamsiToMilady(@RequestDate) ,   @RequestPrice ,    @ReqDesc  )
declare @RequestId int = SCOPE_IDENTITY()

insert into tblRequestBudget( RequestId ,  BudgetDetailProjectAreaDepartmentId ,  RequestBudgetAmount )
					  values(@RequestId ,          @BudgetDetailProjectAreaId  ,     @RequestPrice    )

END
GO
