USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_BudgetSepratorArea_Project_Modal_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_BudgetSepratorArea_Project_Modal_Update]
@BudgetDetailPrjectId int,
@ProgramOperationDetailId int
AS
BEGIN
	update tblBudgetDetailProject
	set ProgramOperationDetailsId = @ProgramOperationDetailId
	where id = @BudgetDetailPrjectId
END
GO
