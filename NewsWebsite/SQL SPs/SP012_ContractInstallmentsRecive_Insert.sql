USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_ContractInstallmentsRecive_Insert]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_ContractInstallmentsRecive_Insert]
@ReciveBankId int,
@ContractInstallmentsId int
AS
BEGIN
    insert into tblContractInstallmentsRecive( ReciveBankId , ContractInstallmentsId , ReciveAmount)
	                                   values(@ReciveBankId ,@ContractInstallmentsId ,      0      )
END
GO
