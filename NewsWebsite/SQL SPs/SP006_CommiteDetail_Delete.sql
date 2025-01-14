USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP006_CommiteDetail_Delete]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP006_CommiteDetail_Delete]
@Id int
AS
BEGIN

declare @Count int = (SELECT count(*)   FROM tblCommiteDetailWbs WHERE CommiteDetailId = @Id)

if(@Count>0) begin  select 'ابتدا نسبت به حذف اطلاعات در فرم  wbs  اقدام نمائید.' as Message_DB return end

   delete tblCommiteDetail
   where Id = @Id
END
GO
