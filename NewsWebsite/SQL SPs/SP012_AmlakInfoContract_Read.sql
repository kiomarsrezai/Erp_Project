USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_AmlakInfoContract_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_AmlakInfoContract_Read]
@ContractId int
AS
BEGIN
SELECT        tblContract.Number, tblContract.Date, tblContract.Description, TblAreas.AreaName, tblAmlakInfo.EstateInfoName, tblAmlakInfo.EstateInfoAddress, tblAmlakInfo.TypeUsing, tblContract.TenderNumber, tblContract.TenderDate, 
                         tblContract.Sarparast, tblContract.Modir, tblContract.Nemayande, tblContract.ModatType, tblContract.ModatValue, tblContract.Type AS ContractType, tblContract.Amount, tblContract.DateFrom, tblContract.DateEnd, 
                         tblContract.AreaId, tblContract.Surplus, tblContract.Final, tblAmlakInfo.AmlakInfoId, tblContract.Masahat, tblContract.id, tblContract.DoingMethodId, tblDoingMethod.MethodName, 
                         tblSuppliers.FirstName + ' ' + tblSuppliers.LastName AS SupplierFullName, tblContract.AmlakId, tblAmlakInfo.IsSubmited, tblContract.SuppliersId, tblContract.Zemanat_Price, tblContract.AmountMonth
FROM            tblContract INNER JOIN
                         TblAreas INNER JOIN
                         tblAmlakInfo ON TblAreas.Id = tblAmlakInfo.AreaId ON tblContract.AmlakId = tblAmlakInfo.Id LEFT OUTER JOIN
                         tblDoingMethod ON tblContract.DoingMethodId = tblDoingMethod.id LEFT OUTER JOIN
                         tblSuppliers ON tblContract.SuppliersId = tblSuppliers.id
WHERE        (tblContract.id = @ContractId)

END
GO
