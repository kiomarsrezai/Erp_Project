USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP000_BudgetProcess_Inert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP000_BudgetProcess_Inert]
@ProcessName nvarchar(500)
AS
BEGIN

	Insert into  tblBudgetProcess (ProcessName) values (@ProcessName)
	            
return

END
GO
