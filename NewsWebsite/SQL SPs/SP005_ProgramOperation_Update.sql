USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP005_ProgramOperation_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP005_ProgramOperation_Update]
@ProjectId int ,
@ScaleId tinyint,
@ProjectName nvarchar(2000)
AS
BEGIN

declare @TblProjectId int = (select TblProjectId from TblProgramOperationDetails where id = @ProjectId)
    update TblProjects
	set ProjectScaleId = @ScaleId,
	       ProjectName = @ProjectName
	          where id = @TblProjectId 
END
GO
