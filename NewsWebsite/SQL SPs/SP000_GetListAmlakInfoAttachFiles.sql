USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP000_GetListAmlakInfoAttachFiles]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP000_GetListAmlakInfoAttachFiles] 
	-- Add the parameters for the stored procedure here
@AmlakInfoId int
AS
BEGIN

SELECT        TblAmlakInfoAttachs.AttachID, TblAmlakInfoAttachs.FileName, TblAmlakInfoAttachs.AmlakInfoId, TblAmlakInfoAttachs.FileTitle, TblAmlakInfoAttachs.Type
FROM            TblAmlakInfoAttachs INNER JOIN
                         tblAmlakInfo ON TblAmlakInfoAttachs.AmlakInfoId = tblAmlakInfo.id
WHERE        (tblAmlakInfo.id = @AmlakInfoId)

END
GO
