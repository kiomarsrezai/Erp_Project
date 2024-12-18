USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_ContractInstallmentsRecive_Read]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_ContractInstallmentsRecive_Read]
@ReciveBankId int
AS
BEGIN
SELECT        tblContractInstallmentsRecive.Id, tblSuppliers.SuppliersName, tblContract.Number, TblYears.YearName, tblContractInstallments.MonthId, tblContractInstallmentsRecive.ReciveAmount
FROM            tblContractInstallmentsRecive INNER JOIN
                         tblContractInstallments ON tblContractInstallmentsRecive.ContractInstallmentsId = tblContractInstallments.Id INNER JOIN
                         tblContract ON tblContractInstallments.ContractId = tblContract.id INNER JOIN
                         tblSuppliers ON tblContract.SuppliersId = tblSuppliers.id INNER JOIN
                         TblYears ON tblContractInstallments.YearId = TblYears.Id
--WHERE        (tblContractInstallmentsRecive.ReciveBankId = @ReciveBankId)
END
GO
