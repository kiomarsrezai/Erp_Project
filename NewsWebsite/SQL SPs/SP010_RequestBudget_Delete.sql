USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP010_RequestBudget_Delete]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP010_RequestBudget_Delete] 
@Id int
AS
BEGIN
     delete tblRequestBudget
	 where id = @Id
END
GO
