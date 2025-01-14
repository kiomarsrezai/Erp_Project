USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP010_RequestTable_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP010_RequestTable_Insert]
@RequestId int,
@Description nvarchar(500),
@Quantity float ,
@Scale nvarchar(50),
@Price bigint,
@OthersDescription nvarchar(500)
AS
BEGIN
insert into tblRequestTable ( RequestId , Description ,  Quantity , scale , Price ,  OthersDescription)
                      values(@RequestId ,@Description , @Quantity ,@Scale ,@Price , @OthersDescription)
END
GO
