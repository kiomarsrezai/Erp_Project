USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal2Project_Delete]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetModal2Project_Delete]
@Id int
AS
BEGIN
declare @Count int = (select count(*) from tblBudgetDetailProjectArea where BudgetDetailProjectId = @Id)
if(@Count>0)
 begin
 select 'ابتدا نسبت به حذف اطلاعات در جدول مناطق اقدام نمائید' as Message_DB
 return
 end
    delete tblBudgetDetailProject
	where id = @Id
END
GO
