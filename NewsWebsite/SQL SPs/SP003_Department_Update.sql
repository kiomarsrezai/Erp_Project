USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP003_Department_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP003_Department_Update]
@id int, 
@DepartmentCode nvarchar(100), 
@DepartmentName nvarchar(200),
@MotherId int=NULL
AS
BEGIN
   update tblDepartman
	  set DepartmentCode = @DepartmentCode,
	      DepartmentName = @DepartmentName ,
		        MotherId = @MotherId
		        where id = @id
END
GO
