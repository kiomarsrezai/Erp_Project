USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_ContractInstallmentsRecive_Update]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_ContractInstallmentsRecive_Update]
@Id int ,
@ReciveAmount bigint
AS
BEGIN
     update tblContractInstallmentsRecive
	 set ReciveAmount = @ReciveAmount 
	         where Id = @Id
END
GO
