USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal1Coding_Delete]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetModal1Coding_Delete]
@id int
AS
BEGIN

declare @Count int = (SELECT     count(*)   
							FROM   tblBudgetDetailProject
							WHERE   (BudgetDetailId = @id))
 
if(@Count<>0)
begin
   select 'لطفا نسبت به حذف اطلاعات پروژه اقدام فرمائید' as Message_DB
return
end


declare @CountEdit int = (SELECT     count(*)   
							FROM   TblBudgetDetailEdit
							WHERE   (BudgetDetailId = @id))
 
if(@CountEdit<>0)
begin
   select 'لطفا نسبت به حذف اطلاعات اصلاح بودجه اقدام فرمائید' as Message_DB
return
end


if(@Count = 0)
begin
 delete TblBudgetDetails
   where id = @id
return
end


END
GO
