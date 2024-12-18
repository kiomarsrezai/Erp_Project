USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9000_Mapping_Shardari_TaminOmrani_Read]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9000_Mapping_Shardari_TaminOmrani_Read]
@yearId int,
@areaId int
AS
BEGIN
declare @year_System_Tamin int
declare @area_System_Tamin int
if(@yearId = 32) begin set @year_System_Tamin = 1401 end

if(@areaId = 1 ) begin set @area_System_Tamin = 1 end
if(@areaId = 2 ) begin set @area_System_Tamin = 2 end
if(@areaId = 3 ) begin set @area_System_Tamin = 3 end
if(@areaId = 4 ) begin set @area_System_Tamin = 4 end
if(@areaId = 5 ) begin set @area_System_Tamin = 5 end
if(@areaId = 6 ) begin set @area_System_Tamin = 6 end
if(@areaId = 7 ) begin set @area_System_Tamin = 7 end
if(@areaId = 8 ) begin set @area_System_Tamin = 8 end
if(@areaId = 9 ) begin set @area_System_Tamin = 11 end

SELECT        Tbl_Bodgets_1.BodgetId,  Tbl_Bodgets_1.BodgetDesc, Tbl_Requsts_1.RequestDate, Tbl_Requsts_1.RequestPrice, Tbl_Requsts_1.ReqDesc, 
                         Tbl_Requsts_1.RequestRefStr
FROM            TAN.PortalTamin.dbo.Tbl_Bodgets AS Tbl_Bodgets_1 INNER JOIN
                         TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 ON Tbl_Bodgets_1.id = Tbl_Requsts_1.BudgetIDKey INNER JOIN
                         TAN.PortalTamin.dbo.Tbl_Sections AS Tbl_Sections_1 ON Tbl_Requsts_1.SectionExecutive = Tbl_Sections_1.SectionId
WHERE     (Tbl_Bodgets_1.Year_mosavab = @year_System_Tamin) AND
          (Tbl_Bodgets_1.TakhsisNumber IS NULL) AND
		  (Tbl_Requsts_1.Confirmed = 1) AND
		  (Tbl_Bodgets_1.TypeCredit = 116) AND
		  (Tbl_Requsts_1.SectionExecutive = @area_System_Tamin)
end
GO
