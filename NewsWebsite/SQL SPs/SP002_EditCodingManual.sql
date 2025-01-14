USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_EditCodingManual]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_EditCodingManual]
@yearId int,
@areaId int,
@budgetProcessId tinyint,
@CodingId int,
@Code nvarchar(50),
@Description  nvarchar(2000)
AS
BEGIN
--select 'امروز در حال مطابقت بین بودجه سازمانها و بودجه تلفیقی شهرداری هستیم امکان تغییر وجود ندارد' as Message_DB
--	return
--     if(@budgetProcessId <>3)
--	 begin
--	    select 'تغییرات کدینگ فقط برای سرمایه ای مجاز است' as Message_DB
--		return
--	 end

declare @LevelNumber int = (select levelNumber from tblCoding where id = @CodingId)

 if(@budgetProcessId =3 and @LevelNumber in (1,2,3))
	 begin
      select 'تغییرات برای سطوح ماموریت ، برنامه و طرح مجاز نمی باشد' as Message_DB
	 return
	 end

   if(@budgetProcessId =3 and @LevelNumber in (4,5,6))
	 begin
	    update tblCoding
	       set code = @Code,
	    Description = @Description
	       where Id = @CodingId
	 return
	 end

END
GO
