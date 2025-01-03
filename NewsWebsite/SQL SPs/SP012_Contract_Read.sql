USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_Contract_Read]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_Contract_Read]
@Id int
AS
BEGIN
SELECT        tblContract.id, tblContract.Number, tblContract.Date, tblContract.Description, tblSuppliers.SuppliersName, tblContract.SuppliersId, tblContract.DateFrom, tblContract.DateEnd, tblContract.DoingMethodId, tblContract.Amount, 
                         tblContract.Surplus, tblContract.Final, tblContract.Zemanat_Number, ISNULL(tblContract.Zemanat_Price,0)AS Zemanat_Price, tblContract.Zemanat_Date, tblContract.Zemanat_Bank, tblContract.Zemanat_Shobe, tblContract.Zemanat_ModatType, 
                         tblContract.Zemanat_ModatValue, tblContract.Zemanat_EndDate, tblContract.Zemanat_Type, tblContract.Type, tblContract.CodeBaygani, tblContract.RequestID, tblContract.ModatType, tblContract.ModatValue, 
                         tblContract.AmountMonth, tblContract.AreaId, tblContract.Masahat, tblContract.Nemayande, tblContract.Modir, tblContract.Sarparast, tblContract.TenderNumber, tblContract.TenderDate, tblContract.AmlakId
FROM            tblContract INNER JOIN
                         tblContractArea ON tblContract.id = tblContractArea.ContractId LEFT OUTER JOIN
                         tblSuppliers ON tblContract.SuppliersId = tblSuppliers.id
WHERE        (tblContract.id = @Id)
END
GO
