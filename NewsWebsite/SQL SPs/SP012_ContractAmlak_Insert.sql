USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_ContractAmlak_Insert]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_ContractAmlak_Insert]
@AreaId int,
@Number nvarchar(50),
@Date nvarchar(10),
@Description nvarchar(300),
@SuppliersId int,
@DateFrom   nvarchar(10),
@DateEnd  nvarchar(10),
@Amount bigint,
@AmountMonth bigint,
@AmlakId int,
@DoingMethodId tinyint,
@Zemanat_Price bigint,
@ModatValue int,
@Masahat float,
@CurrentStatus nvarchar(30),
@Structure nvarchar(30),
@Owner nvarchar(30),
@TenderNumber nvarchar(20),
@TenderDate nvarchar(10),
@Sarparast nvarchar(200),
@Modir nvarchar(200),
@Nemayande nvarchar(200),
@TypeUsing nvarchar(200)
AS
BEGIN
   insert into tblContract(AreaId, Number ,  Date ,  Description ,  SuppliersId ,  DateFrom ,  DateEnd ,  Amount , DoingMethodId,ModatValue,Zemanat_Price,AmountMonth,Masahat,AmlakId, TenderNumber,TenderDate,Sarparast,Modir,Nemayande,Type)
                    values(@AreaId,@Number , @Date , @Description , @SuppliersId , @DateFrom , @DateEnd , @Amount ,@DoingMethodId,@ModatValue,@Zemanat_Price,@AmountMonth,@Masahat,@AmlakId,@TenderNumber,@TenderDate,@Sarparast,@Modir,@Nemayande,1)
  declare @Id int = SCOPE_IDENTITY()


update tblAmlakInfo set IsContracted=1 , Masahat=@Masahat,TypeUsing=@TypeUsing,CurrentStatus=@CurrentStatus,Structure=@Structure,Owner=@Owner where Id=@AmlakId

SELECT        tblContract.Number, tblContract.Date, tblContract.Description, TblAreas.AreaName, tblAmlakInfo.EstateInfoName, tblAmlakInfo.EstateInfoAddress, tblAmlakInfo.TypeUsing, tblContract.TenderNumber, tblContract.TenderDate, 
                         tblContract.Sarparast, tblContract.Modir, tblContract.Nemayande, tblContract.ModatType, tblContract.ModatValue, tblContract.Type AS ContractType, tblContract.Amount, tblContract.DateFrom, tblContract.DateEnd, 
                         tblContract.AreaId, tblContract.Surplus, tblContract.Final, tblAmlakInfo.AmlakInfoId, tblContract.Masahat, tblContract.id, tblContract.DoingMethodId, tblDoingMethod.MethodName, 
                         tblSuppliers.FirstName + ' ' + tblSuppliers.LastName AS SupplierFullName, tblContract.AmlakId, tblAmlakInfo.IsSubmited, tblContract.SuppliersId, tblContract.Zemanat_Price, tblContract.AmountMonth
FROM            tblContract INNER JOIN
                         TblAreas INNER JOIN
                         tblAmlakInfo ON TblAreas.Id = tblAmlakInfo.AreaId ON tblContract.AmlakId = tblAmlakInfo.Id LEFT OUTER JOIN
                         tblDoingMethod ON tblContract.DoingMethodId = tblDoingMethod.id LEFT OUTER JOIN
                         tblSuppliers ON tblContract.SuppliersId = tblSuppliers.id
WHERE        (tblContract.id = @Id)

END
GO
