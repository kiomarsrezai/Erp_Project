USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP000_Coding_Update123456789]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP000_Coding_Update123456789]
@CodingId int,
@CodeAcc nvarchar(50)
AS
BEGIN
declare @LevelNumber tinyint = (select levelNumber from TblCodings where id = @CodingId)

--کنترل اول===================================================================================
if(@CodeAcc is null  or  @CodeAcc='') 
   begin 
       return 
   end
--=============================================================================================

--کنترل دوم===================================================================================
if(@LevelNumber<>5) 
   begin 
       select 'امکان تغییر وجود ندارد' as Message 
       return 
   end
--============================================================================================

--کنترل سوم===================================================================================
 declare @CountCodeAccExsis int = (select count(*) from TblCodings where CodeVaset=@CodeAcc)
 if(@CountCodeAccExsis>0)
   begin
      select 'کد  حسابداری قبلا به یک ردیف دیگر اختصاص داده شده است' as Message 
       return 
   end
--=============================================================================================

update TblCodings
   set CodeVaset = @CodeAcc
      where id = @CodingId
END
GO
