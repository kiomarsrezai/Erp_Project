USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP007_Edit_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP007_Edit_Update]
@Id int ,
@Decrease bigint,
@Increase bigint
AS
BEGIN
    update TblBudgetDetailEdit
	set Decrease = @Decrease,
	    Increase = @Increase
		where Id = @Id
END
GO
