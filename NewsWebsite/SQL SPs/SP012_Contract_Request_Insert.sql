USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_Contract_Request_Insert]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_Contract_Request_Insert]
@RequestId int,
@ContractId int
AS
BEGIN
      insert into tblContractRequest( ContractId , RequestId ,ShareAmount)
	                          values(@ContractId ,@RequestId ,     0     )
END
GO
