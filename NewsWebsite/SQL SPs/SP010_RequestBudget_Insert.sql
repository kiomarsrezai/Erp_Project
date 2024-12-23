USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP010_RequestBudget_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP010_RequestBudget_Insert]
@RequestId int,
@BudgetDetailProjectAreaId int
AS
BEGIN
declare @Count int = (select count(*) from tblRequestBudget 
                                   where RequestId = @RequestId and
								         BudgetDetailProjectAreaId =@BudgetDetailProjectAreaId )
if(@Count>0)
begin
  select 'ردیف بودجه مورد نظر قبلا منتقل شده است' as Message_DB
  return
end
    insert into tblRequestBudget( RequestId ,  BudgetDetailProjectAreaId)
	                      values(@RequestId , @BudgetDetailProjectAreaId)
END
GO
