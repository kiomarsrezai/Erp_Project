USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_AmlakInfo_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_AmlakInfo_Read]
@id int=0
AS
BEGIN
if (ISNULL(@Id,0)=0)
begin
SELECT        tblAmlakInfo.Id, tblAmlakInfo.AreaId, tblAmlakInfo.AmlakInfoKindId, tblAmlakInfoKind.AmlakInfoKindName, tblAmlakInfo.EstateInfoName, tblAmlakInfo.EstateInfoAddress, TblAreas.AreaName, tblAmlakInfo.AmlakInfolate, 
                         tblAmlakInfo.AmlakInfolong, tblAmlakInfo.AmlakInfoId,tblAmlakInfo.CurrentStatus,tblAmlakInfo.Structure,tblAmlakInfo.Owner, ISNULL
                             ((SELECT        COUNT(AmlakId) AS total
                                 FROM            tblAmlakContract
                                 WHERE        (AmlakId = tblAmlakInfo.Id)
                                 GROUP BY AmlakId), 0) AS TotalContract, ISNULL(tblAmlakInfo.IsSubmited, 0) AS IsSubmited, ISNULL(tblAmlakInfo.Masahat, 0) AS Masahat, ISNULL(tblAmlakInfo.IsContracted, 0) AS IsContracted, tblAmlakInfo.TypeUsing, 
                         tblAmlakInfo.CodeUsing
FROM            tblAmlakInfo LEFT OUTER JOIN
                         tblAmlakInfoKind ON tblAmlakInfo.AmlakInfoKindId = tblAmlakInfoKind.Id LEFT OUTER JOIN
                         TblAreas ON tblAmlakInfo.AreaId = TblAreas.Id
return
end
else
if (ISNULL(@id,0)>0)
begin
SELECT        tblAmlakInfo.Id, tblAmlakInfo.AreaId, tblAmlakInfo.AmlakInfoKindId, tblAmlakInfoKind.AmlakInfoKindName, tblAmlakInfo.EstateInfoName, tblAmlakInfo.EstateInfoAddress, TblAreas.AreaName, tblAmlakInfo.AmlakInfolate, 
                         tblAmlakInfo.AmlakInfolong, tblAmlakInfo.AmlakInfoId,tblAmlakInfo.CurrentStatus,tblAmlakInfo.Structure,tblAmlakInfo.Owner, ISNULL
                             ((SELECT COUNT(AmlakId) AS total
                                 FROM tblAmlakContract
                                 WHERE        (AmlakId = tblAmlakInfo.Id)
                                 GROUP BY AmlakId), 0) AS TotalContract, ISNULL(tblAmlakInfo.IsSubmited,0)As IsSubmited, ISNULL(tblAmlakInfo.Masahat,0)As Masahat,ISNULL(IsContracted,0)As IsContracted, tblAmlakInfo.TypeUsing, 
                         tblAmlakInfo.CodeUsing
FROM            tblAmlakInfo LEFT OUTER JOIN
                         tblAmlakInfoKind ON tblAmlakInfo.AmlakInfoKindId = tblAmlakInfoKind.Id LEFT OUTER JOIN
                         TblAreas ON tblAmlakInfo.AreaId = TblAreas.Id
Where 	tblAmlakInfo.Id=@id
return
end

END
GO
