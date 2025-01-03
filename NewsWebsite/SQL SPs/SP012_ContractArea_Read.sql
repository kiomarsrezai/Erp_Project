USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_ContractArea_Read]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_ContractArea_Read]
@Id int
AS
BEGIN
SELECT        tblContractArea.Id, tblContractArea.AreaId, tblContractArea.ShareAmount, TblAreas.AreaName
FROM            tblContractArea LEFT OUTER JOIN
                         TblAreas ON tblContractArea.AreaId = TblAreas.Id
WHERE        (tblContractArea.ContractId = @Id)
END
GO
