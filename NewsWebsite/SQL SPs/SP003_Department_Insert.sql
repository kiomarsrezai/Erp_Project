USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP003_Department_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP003_Department_Insert]
@MotherId int=NULL,
@areaId int 
AS
BEGIN

      insert into tblDepartman( MotherId , AreaId , DepartmentCode  , DepartmentName)
	                    values(@MotherId ,@areaId ,'تکمیل کنید'    , 'تکمیل کنید' )
END
GO
