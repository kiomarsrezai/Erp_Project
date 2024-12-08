USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal3Area_Delete]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetModal3Area_Delete]
@Id int
AS
BEGIN
--declare @Count int = (select count(*) from tblBudgetDetailProjectAreaDepartment where BudgetDetailProjectAreaId =@Id )
--if(@Count>0)
--  begin
--    select 'ابتدا نسبت به حذف ردیف در دپارتمان اقدام نمائید' as Message_DB
--	return
--  end

declare @YearId int = (SELECT        TblBudgets.TblYearId
							FROM     TblBudgets INNER JOIN
									 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
							WHERE  (tblBudgetDetailProjectArea.id = @Id))
--if(@YearId in (33))
--begin
--select 'امکان حذف وجود ندارد' as Message_DB
--return
--end
declare  @Count1 int = (select count(*) from tblRequestBudget where BudgetDetailProjectAreaId =@Id)
if(@Count1>0)
  begin
    select 'از ردیف فوق در درخواستها استفاده شده است' as Message_DB
	return
  end

    delete tblBudgetDetailProjectAreaDepartment
	where BudgetDetailProjectAreaId = @Id

    delete tblBudgetDetailProjectArea
	where id = @Id
END
GO
