USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_ContractInstallments_Insert]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_ContractInstallments_Insert]
@ContractId int ,
@Date       date,
@Amount     bigint,
@Month      tinyint,
@YearName   int
AS
BEGIN
declare @YearId int = (select Id from TblYears where YearName = @YearName)
     insert into tblContractInstallments( ContractId ,  YearId , MonthId ,InstallmentsDate , MonthlyAmount)
	                              values(@ContractId , @YearId ,  @Month ,     @Date       ,     @Amount  )
END
GO
