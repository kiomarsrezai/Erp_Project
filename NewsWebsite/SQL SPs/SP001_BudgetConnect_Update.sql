USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetConnect_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetConnect_Update]
@id int,
@ProctorId int,
--@ExecuteId int,
@CodingNatureId int
AS
BEGIN
   update tblCoding
    set ProctorId = @ProctorId ,
	 --   ExecuteId = @ExecuteId ,
        ExecuteId = @CodingNatureId
         where id = @id
END
GO
