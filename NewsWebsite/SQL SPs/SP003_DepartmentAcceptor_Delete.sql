USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP003_DepartmentAcceptor_Delete]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP003_DepartmentAcceptor_Delete]
@Id int
AS
BEGIN
declare @Count int = (select count(*) from tblDepartmentAcceptorUser where DepartmanAcceptorId = @Id)
if(@Count>0)
 begin
     select 'ابتدا نسبت به حذف کاربران اقدام نمایید' as Message_DB
 return
 end
     delete tblDepartmentAcceptor
	 where Id = @Id
END
GO
