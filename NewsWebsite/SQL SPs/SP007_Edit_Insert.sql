USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP007_Edit_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP007_Edit_Insert]
@BudgetDetailId int
AS
BEGIN
    insert into tblbudgetdetailEdit( BudgetDetailId ,Decrease , Increase , StatusId)
	                         values(@BudgetDetailId ,    0    ,    0     ,    20    )
END
GO
