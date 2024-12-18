USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_ContractRequest_Read]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_ContractRequest_Read]
@Id int
AS
BEGIN
SELECT        tblContractRequest.Id, TblYears.YearName, TblAreas.AreaNameShort AS AreaName, tblRequest.Number, tblRequest.Date, tblRequest.Description
FROM            tblRequest INNER JOIN
                         tblContractRequest ON tblRequest.Id = tblContractRequest.RequestId INNER JOIN
                         TblAreas ON tblRequest.AreaId = TblAreas.Id INNER JOIN
                         TblYears ON tblRequest.YearId = TblYears.Id
WHERE        (tblContractRequest.ContractId = @Id)
END
GO
