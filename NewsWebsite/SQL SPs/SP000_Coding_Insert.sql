USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP000_Coding_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP000_Coding_Insert]
@MotherId int ,
@code nvarchar(50),
@description nvarchar(1000),
@show bit,
@crud bit,
@levelNumber tinyint,
@BudgetProcessId tinyint
AS
BEGIN

     insert into tblCoding( MotherId ,  code ,  description , show  ,  crud , levelNumber , TblBudgetProcessId ,CodingKindId)
	                values(@MotherId , @code , @description , @show , @crud ,@levelNumber ,@BudgetProcessId    ,  20        )


END
GO
