USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_ContractInstallments_Update]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_ContractInstallments_Update]
@Id     int ,
@Date   date,
@Amount bigint,
@Month  tinyint,
@YearName int
AS
BEGIN
declare @YearId int = (select Id from TblYears where YearName = @YearName)

   update tblContractInstallments
            set YearId = @YearId ,
               MonthId = @Month,
      InstallmentsDate = @Date,
         MonthlyAmount = @Amount
              where Id = @Id
END
GO
