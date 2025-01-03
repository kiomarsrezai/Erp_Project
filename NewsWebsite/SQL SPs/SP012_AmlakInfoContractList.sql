USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_AmlakInfoContractList]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_AmlakInfoContractList]
@AmlakInfoId int=0
AS
BEGIN
if (ISNULL(@AmlakInfoId,0)=0)
begin
SELECT        tblContract.Number, tblContract.Date, tblContract.Description, TblAreas.AreaName, tblAmlakInfo.EstateInfoName, tblAmlakInfo.EstateInfoAddress, tblAmlakInfo.IsSubmited, tblAmlakInfo.TypeUsing, tblContract.TenderNumber, 
                         tblContract.TenderDate, tblContract.Sarparast, tblContract.Modir, tblContract.Nemayande, tblContract.ModatType, tblContract.ModatValue, tblContract.Type AS ContractType, tblContract.Amount, tblContract.DateFrom, 
                         tblContract.DateEnd, tblContract.AreaId, tblContract.Surplus, tblContract.Final, tblAmlakInfo.AmlakInfoId, tblContract.Masahat, tblContract.id, tblContract.AmlakId, tblDoingMethod.MethodName AS DoingMethodId, 
                         tblSuppliers.FirstName + ' ' + tblSuppliers.LastName AS SupplierFullName
FROM            tblContract LEFT OUTER JOIN
                         TblAreas INNER JOIN
                         tblAmlakInfo ON TblAreas.Id = tblAmlakInfo.AreaId ON tblContract.AmlakId = tblAmlakInfo.Id LEFT OUTER JOIN
                         tblDoingMethod ON tblContract.DoingMethodId = tblDoingMethod.id LEFT OUTER JOIN
                         tblSuppliers ON tblContract.SuppliersId = tblSuppliers.id

return
end
else
if (ISNULL(@AmlakInfoId,0)>0)
begin
SELECT        tblContract.Number, tblContract.Date, tblContract.Description, TblAreas.AreaName, tblAmlakInfo.EstateInfoName, tblAmlakInfo.EstateInfoAddress, tblAmlakInfo.IsSubmited, tblAmlakInfo.TypeUsing, tblContract.TenderNumber, 
                         tblContract.TenderDate, tblContract.Sarparast, tblContract.Modir, tblContract.Nemayande, tblContract.ModatType, tblContract.ModatValue, tblContract.Type AS ContractType, tblContract.Amount, tblContract.DateFrom, 
                         tblContract.DateEnd, tblContract.AreaId, tblContract.Surplus, tblContract.Final, tblAmlakInfo.AmlakInfoId, tblContract.Masahat, tblContract.id, tblContract.AmlakId, tblDoingMethod.MethodName AS DoingMethodId, 
                         tblSuppliers.FirstName + ' ' + tblSuppliers.LastName AS SupplierFullName
FROM            tblContract LEFT OUTER JOIN
                         TblAreas INNER JOIN
                         tblAmlakInfo ON TblAreas.Id = tblAmlakInfo.AreaId ON tblContract.AmlakId = tblAmlakInfo.Id LEFT OUTER JOIN
                         tblDoingMethod ON tblContract.DoingMethodId = tblDoingMethod.id LEFT OUTER JOIN
                         tblSuppliers ON tblContract.SuppliersId = tblSuppliers.id
WHERE        (tblAmlakInfo.Id = @AmlakInfoId)
return
end
END
GO
