USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP000_BudgetSection]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP000_BudgetSection]

AS
BEGIN
 SELECT        Id, ProcessName
FROM            tblBudgetProcess
END
GO
