USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP010_RequestContract_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP010_RequestContract_Read]
@Id int
AS
BEGIN
SELECT        tblContractRequest.id, tblContract.Number, tblContract.Date, tblContract.Description, tblSuppliers.SuppliersName
FROM            tblContractRequest INNER JOIN
                         tblContract ON tblContractRequest.ContractId = tblContract.id LEFT OUTER JOIN
                         tblSuppliers ON tblContract.SuppliersId = tblSuppliers.id
WHERE        (tblContractRequest.RequestId = @Id)
END
GO
