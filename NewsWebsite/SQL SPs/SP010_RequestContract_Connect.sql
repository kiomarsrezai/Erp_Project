USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP010_RequestContract_Connect]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP010_RequestContract_Connect] 
@ContractId int,
@RequestId int
AS
BEGIN
 declare @Count tinyint = (SELECT count(*) FROM tblContractRequest WHERE RequestId = @RequestId and ContractId = @ContractId)
if(@Count=0)
begin
   insert into tblContractRequest ( ContractId ,  RequestId)
                            values(@ContractId , @RequestId)
end
END
GO
