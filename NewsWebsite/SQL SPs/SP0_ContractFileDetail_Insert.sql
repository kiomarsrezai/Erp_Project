USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP0_ContractFileDetail_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP0_ContractFileDetail_Insert]
@FileName nvarchar(500),
@Title nvarchar(100),
@ContractId int 
AS
BEGIN

 INSERT INTO TblContractAttachs
                         (FileName, ContractId,FileTitle)
VALUES        (@FileName,@ContractId,@Title)


END
GO
