USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP000_Coding_Delete]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP000_Coding_Delete]
@id int
AS
BEGIN
 declare @Count int = (select count(*) from TblBudgetDetails where tblCodingId = @id )
 if(@Count > 0)
  begin
     select 'امکان حذف وجود ندارد در بودجه استفاده شده است' as Message
	 return
  end
   if(@Count = 0)
    begin
	  delete tblCoding
	  where id = @id
	end
END
GO
