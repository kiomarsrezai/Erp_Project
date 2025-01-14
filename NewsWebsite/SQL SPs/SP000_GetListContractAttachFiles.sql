USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP000_GetListContractAttachFiles]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP000_GetListContractAttachFiles] 
	-- Add the parameters for the stored procedure here
@ContractId int
AS
BEGIN

SELECT        TblContractAttachs.AttachID, TblContractAttachs.FileName, TblContractAttachs.ContractId, TblContractAttachs.FileTitle
FROM            TblContractAttachs INNER JOIN
                         tblContract ON TblContractAttachs.ContractId = tblContract.id
WHERE        (tblContract.id = @ContractId)

END
GO
