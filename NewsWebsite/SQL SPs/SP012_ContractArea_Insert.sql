USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_ContractArea_Insert]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_ContractArea_Insert]
@ContractId int,
@AreaId  int
AS
BEGIN
   insert into tblContractArea( ContractId ,  AreaId ,ShareAmount)
                        values(@ContractId , @AreaId ,     0     )
END
GO
