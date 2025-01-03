USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP010_RequestTable_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP010_RequestTable_Update]
@Id int,
@Description nvarchar(500),
@Quantity float ,
@Price bigint,
@OthersDescription nvarchar(500),
@Scale nvarchar(50)
AS
BEGIN
   update tblRequestTable
   set Description = @Description,
          Quantity = @Quantity,
		     scale = @Scale ,
             Price = @Price,
 OthersDescription = @OthersDescription
          where id = @Id
END
GO
