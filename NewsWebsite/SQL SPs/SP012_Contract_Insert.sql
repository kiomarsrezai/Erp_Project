USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_Contract_Insert]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_Contract_Insert]
@areaId int,
@Number nvarchar(50),
@Date date,
@Description nvarchar(300),
@SuppliersId int,
@DateFrom   date,
@DateEnd  date,
@Amount bigint,
@DoingMethodId int,
@Type int,
@CodeBaygani nvarchar(50),
@ModatType nvarchar(50),
@ModatValue nvarchar(50),
@RequestID int,
@Zemanat_Number nvarchar(50),
@Zemanat_Price bigint,
@Zemanat_Date nvarchar(10),
@Zemanat_Bank nvarchar(50),
@Zemanat_Shobe nvarchar(50),
@Zemanat_ModatValue nvarchar(50),
@Zemanat_ModatType nvarchar(50),
@Zemanat_EndDate nvarchar(50),
@Zemanat_Type nvarchar(50)

AS
BEGIN
   insert into tblContract( Number ,  Date ,  Description ,  SuppliersId ,  DateFrom ,  DateEnd ,  Amount , DoingMethodId,Type,CodeBaygani,ModatType,ModatValue,RequestID,Zemanat_Number,Zemanat_Price,Zemanat_Date,Zemanat_Bank,Zemanat_Shobe,Zemanat_ModatType,Zemanat_ModatValue,Zemanat_EndDate,Zemanat_Type)
                    values(@Number , @Date , @Description , @SuppliersId , @DateFrom , @DateEnd , @Amount ,@DoingMethodId,2,@CodeBaygani,@ModatType,@ModatValue,@RequestID,@Zemanat_Number,@Zemanat_Price,@Zemanat_Date,@Zemanat_Bank,@Zemanat_Shobe,@Zemanat_ModatType,@Zemanat_ModatValue,@Zemanat_EndDate,@Zemanat_Type)
  declare @Id int = SCOPE_IDENTITY()

  --insert into tblAmlakContract(AmlakId, ContractId)
  --                     values(    @AmlakId    ,  @Id   )


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
