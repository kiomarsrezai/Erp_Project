USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP006_CommiteDetailEstimate_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP006_CommiteDetailEstimate_Insert]
@CommiteDetailId int,
@Description nvarchar(2000),
@Quantity float,
@Price bigint
AS
BEGIN
   insert into tblCommiteDetailEstimate( CommiteDetailId ,  Description ,  Quantity ,  Price)
                                 values(@CommiteDetailId , @Description , @Quantity , @Price)
END
GO
