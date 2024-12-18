USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[Varyanve3]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Varyanve3]

AS
BEGIN
declare @CodingId int = 5601
declare @AreaId int = 21
declare @BudgetProcessId tinyint =2
declare @ProjectId int=2

declare @BudgetId int = (SELECT Id FROM  TblBudgets WHERE TblAreaId = 10 and TblYearId = 32)

declare @ProgramOperationDetailsId int= (SELECT        TblProgramOperationDetails.Id
												FROM            TblProgramOperations INNER JOIN
																		 TblProgramOperationDetails ON TblProgramOperations.Id = TblProgramOperationDetails.TblProgramOperationId
												WHERE (TblProgramOperationDetails.TblProjectId = @ProjectId) AND
												      (TblProgramOperations.TblAreaId = @AreaId))


insert into  tblBudgetDetails( BudgetId , tblCodingId )
                       values(@BudgetId ,  @CodingId  )
declare @BudgetDetailId int
set  @BudgetDetailId = SCOPE_IDENTITY()


insert into  tblBudgetDetailProject( BudgetDetailId  ,  ProgramOperationDetailsId)
                             values(@BudgetDetailId  , @ProgramOperationDetailsId)
declare @BudgetDetailProjectId int
set  @BudgetDetailProjectId = SCOPE_IDENTITY()

insert into tblBudgetDetailProjectArea(BudgetDetailProjectId  , AreaId )
                                values(@BudgetDetailProjectId ,@AreaId )


END
GO
