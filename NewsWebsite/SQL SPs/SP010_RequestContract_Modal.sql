USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP010_RequestContract_Modal]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP010_RequestContract_Modal]
@areaId int
AS
BEGIN
SELECT  tblContract.id, tblContract.Number, tblContract.Date, tblContract.Description,
        tblContractArea.ShareAmount, tblSuppliers.SuppliersName
FROM            tblContract INNER JOIN
                         tblContractArea ON tblContract.id = tblContractArea.ContractId LEFT OUTER JOIN
                         tblSuppliers ON tblContract.SuppliersId = tblSuppliers.id
WHERE        (tblContractArea.AreaId = @areaId)
END
GO
