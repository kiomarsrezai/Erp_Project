USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_Contract_Delete]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_Contract_Delete]
@Id int
AS
BEGIN
    delete tblContractArea
	where ContractId = @Id

    delete tblContract
	where id = @Id
END
GO
