USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_AmlakInfo_Delete]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_AmlakInfo_Delete]
@Id int
AS
BEGIN
   declare @Count int = (select count(*) from tblAmlakPrivate where AmlakInfoId = @Id)
    if(@Count>0)
	begin
	 select 'ابتدا نسبت به حذف اطلاعات  غرف اقدام نمائید' as Message_DB
	 return
	end

    if(@Count=0)
	begin
	 delete tblAmlakInfo 
	 where Id = @Id
	 return
	end
	
END
GO
