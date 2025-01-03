USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP010_Request_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP010_Request_Read]
@RequestId int
AS
BEGIN
SELECT  tblRequest.Id, tblRequest.YearId, tblRequest.AreaId, tblRequest.DepartmentId, tblRequest.Employee, 
        tblRequest.DoingMethodId, tblRequest.Number, tblRequest.Date,  tblRequest.Description, 
        tblRequest.EstimateAmount, tblRequest.ResonDoingMethod, tblRequest.SuppliersId, 
		tblSuppliers.SuppliersName
FROM            tblRequest LEFT OUTER JOIN
                tblSuppliers ON tblRequest.SuppliersId = tblSuppliers.id
WHERE   (tblRequest.Id = @RequestId)
END
GO
