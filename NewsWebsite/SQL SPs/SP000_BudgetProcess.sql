USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP000_BudgetProcess]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP000_BudgetProcess]
AS
BEGIN

	SELECT        Id, ProcessName
	FROM            tblBudgetProcess
return

END
GO
