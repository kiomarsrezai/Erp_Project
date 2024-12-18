USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP010_RequestSearch_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP010_RequestSearch_Read]
@yearId int,
@AreaId int,
@DepartmentId int
AS
BEGIN
    SELECT   Id, Employee, Number, Date, Description, EstimateAmount
		FROM      tblRequest
		WHERE       YearId = @yearId AND
		            AreaId = @AreaId AND
	          DepartmentId = @DepartmentId
END
GO
