USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_ContractInstallments_Read]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_ContractInstallments_Read]
@ContractId int
AS
BEGIN
SELECT        Id, InstallmentsDate, MonthlyAmount
FROM            tblContractInstallments
WHERE        (ContractId = @ContractId)
ORDER BY InstallmentsDate
END
GO
