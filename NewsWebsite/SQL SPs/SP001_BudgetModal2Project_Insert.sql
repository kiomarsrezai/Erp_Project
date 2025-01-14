USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal2Project_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetModal2Project_Insert]
@ProgramOperationDetailsId int,
@areaId int,
@yearId int,
@BudgetDetailId int 
AS
BEGIN
 --declare @BudgetDetailId int = (SELECT        TblBudgetDetails.Id
	--									FROM  TblBudgets INNER JOIN
	--										  TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId
	--									WHERE  (TblBudgets.TblYearId = @yearId) AND
	--										   (TblBudgets.TblAreaId = @areaId) AND
	--										   (TblBudgetDetails.tblCodingId = @codingId))
declare @Count int=(SELECT  Count(*)
						FROM   tblBudgetDetailProject
						WHERE (BudgetDetailId = @BudgetDetailId) AND
						      (ProgramOperationDetailsId = @ProgramOperationDetailsId))

if(@Count>0)
  begin
    select 'تکراری است' as Message_DB
	return
  end

if(@Count=0)
  begin
     insert into tblBudgetDetailProject( BudgetDetailId ,  ProgramOperationDetailsId , Mosavab)
	                             values(@BudgetDetailId , @ProgramOperationDetailsId ,   1000 )
  end



END
GO
