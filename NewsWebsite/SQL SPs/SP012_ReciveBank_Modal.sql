USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_ReciveBank_Modal]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_ReciveBank_Modal]
@SuppliersId int,
@ReciveBankId int
AS
BEGIN
SELECT        tblContractInstallments.Id, TblYears.YearName, tblContractInstallments.MonthId, tblContractInstallments.MonthlyAmount, tblContract.Number, tblContract.Date, tblContract.Description
FROM            tblContract INNER JOIN
                         tblContractInstallments ON tblContract.id = tblContractInstallments.ContractId INNER JOIN
                         TblYears ON tblContractInstallments.YearId = TblYears.Id
WHERE        (tblContract.SuppliersId = @SuppliersId)
END
GO
