USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP007_Edit_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP007_Edit_Read]
@yearId int ,
@areaId int 
AS
BEGIN

SELECT        id, Number, Date
FROM            tblBudgetDetailProjectAreaEditMaster
WHERE        (YearId = @yearId) AND (AreaId = @areaId)

END
GO
