USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9999_Transfer_Tamin_To_ERP_1402_Manual_VaryanceRezaei_ERP]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9999_Transfer_Tamin_To_ERP_1402_Manual_VaryanceRezaei_ERP]
@MosavabOrEditId int
AS
BEGIN
delete aa1402_compar_Rezaei_ERP
DBCC CHECKIDENT ('[aa1402_compar_Rezaei_ERP]', RESEED, 0)

INSERT INTO aa1402_compar_Rezaei_ERP(BodgetId,BodgetDesc,SectionId,AreaName,Total_Res)

SELECT        Tbl_Bodgets_1.BodgetId, Tbl_Bodgets_1.BodgetDesc, Tbl_Bodgets_1.SectionId, Tbl_Sections_1.Description, 
Tbl_Bodgets_1.Total_Res 

FROM            TAN.PortalTamin.dbo.Tbl_Bodgets AS Tbl_Bodgets_1 INNER JOIN
                         TAN.PortalTamin.dbo.Tbl_Sections AS Tbl_Sections_1 ON Tbl_Bodgets_1.SectionId = Tbl_Sections_1.SectionId
WHERE   (Tbl_Bodgets_1.Year_mosavab = 1402) and
        (Tbl_Bodgets_1.TakhsisNumber is null) and
		(Tbl_Bodgets_1.TypeCredit=120) and
        (Tbl_Bodgets_1.Total_ResUnused is not null or Tbl_Bodgets_1.Total_ResUnused>0)

declare @Id int=1
declare @AreaId int

declare @Count_Record int = (select count(*) from aa1402_compar_Rezaei_ERP)
declare @SectionId  int
while @Id <= @Count_Record
begin
 set @SectionId = (select SectionId from aa1402_compar_Rezaei_ERP where id = @id)
if(@SectionId = 1)    begin set @areaId = 1  end
if(@SectionId = 2)    begin set @areaId = 2  end
if(@SectionId = 3)    begin set @areaId = 3  end
if(@SectionId = 4)    begin set @areaId = 4  end
if(@SectionId = 5)    begin set @areaId = 5  end
if(@SectionId = 6)    begin set @areaId = 6  end
if(@SectionId = 7)    begin set @areaId = 7  end
if(@SectionId = 8)    begin set @areaId = 8  end
if(@SectionId = 11)   begin set @areaId = 9  end
if(@SectionId = 102)  begin set @areaId = 11 end
if(@SectionId = 114)  begin set @areaId = 12 end
if(@SectionId = 105)  begin set @areaId = 13 end
if(@SectionId = 115)  begin set @areaId = 14 end
if(@SectionId = 112)  begin set @areaId = 15 end
if(@SectionId = 113)  begin set @areaId = 16 end
if(@SectionId = 107)  begin set @areaId = 17 end
if(@SectionId = 108)  begin set @areaId = 18 end
if(@SectionId = 106)  begin set @areaId = 19 end
if(@SectionId = 3034) begin set @areaId = 20 end
if(@SectionId = 109)  begin set @areaId = 21 end
if(@SectionId = 101)  begin set @areaId = 22 end
if(@SectionId = 103)  begin set @areaId = 23 end
if(@SectionId = 104)  begin set @areaId = 24 end
if(@SectionId = 15 )  begin set @areaId = 25 end
if(@SectionId = 110)  begin set @areaId = 26 end
if(@SectionId = 16 )  begin set @areaId = 29 end

update aa1402_compar_Rezaei_ERP
set SectionId = @areaId
     where id = @Id

set @id = @id +1
end
return
if(@MosavabOrEditId=1)
begin
	DELETE FROM aa1402_compar_Rezaei_ERP
	FROM            TblBudgets INNER JOIN
							 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
							 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
							 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
							 aa1402_compar_Rezaei_ERP ON tblBudgetDetailProjectArea.AreaId = aa1402_compar_Rezaei_ERP.SectionId AND tblBudgetDetailProjectArea.Mosavab = aa1402_compar_Rezaei_ERP.Total_Res INNER JOIN
							 tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id AND aa1402_compar_Rezaei_ERP.BodgetId = tblCoding.Code COLLATE Arabic_CI_AS
	WHERE   (TblBudgets.TblYearId = 33) and
			(tblCoding.TblBudgetProcessId in (2,3))
end

if(@MosavabOrEditId=2)
begin
	DELETE FROM aa1402_compar_Rezaei_ERP
	FROM            TblBudgets INNER JOIN
							 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
							 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
							 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
							 aa1402_compar_Rezaei_ERP ON tblBudgetDetailProjectArea.AreaId = aa1402_compar_Rezaei_ERP.SectionId AND tblBudgetDetailProjectArea.EditArea = aa1402_compar_Rezaei_ERP.Total_Res INNER JOIN
							 tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id AND aa1402_compar_Rezaei_ERP.BodgetId = tblCoding.Code COLLATE Arabic_CI_AS
	WHERE (TblBudgets.TblYearId = 33) AND
	      (tblCoding.TblBudgetProcessId IN (2, 3))
end

--SELECT        tblCoding.TblBudgetProcessId, tblBudgetDetailProjectArea.AreaId, tblCoding.Code, tblCoding.Description,
--tblBudgetDetailProjectArea.Mosavab, aa1402_compar_Rezaei_ERP.Total_Res,
--tblBudgetDetailProjectArea.Mosavab- aa1402_compar_Rezaei_ERP.Total_Res
--FROM            TblBudgets INNER JOIN
--                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
--                         aa1402_compar_Rezaei_ERP ON tblBudgetDetailProjectArea.AreaId = aa1402_compar_Rezaei_ERP.SectionId INNER JOIN
--                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id AND aa1402_compar_Rezaei_ERP.BodgetId = tblCoding.Code COLLATE Arabic_CI_AS
--WHERE        (TblBudgets.TblYearId = 33) AND
--(tblCoding.TblBudgetProcessId IN ( 2)) and 
--tblBudgetDetailProjectArea.Mosavab- aa1402_compar_Rezaei_ERP.Total_Res>2000
--ORDER BY tblBudgetDetailProjectArea.AreaId, tblCoding.Code


--SELECT        tblCoding.TblBudgetProcessId, tblBudgetDetailProjectArea.AreaId, tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, aa1402_compar_Rezaei_ERP.Total_Res
--FROM            TblBudgets INNER JOIN
--                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
--                         aa1402_compar_Rezaei_ERP ON tblBudgetDetailProjectArea.AreaId = aa1402_compar_Rezaei_ERP.SectionId INNER JOIN
--                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id AND aa1402_compar_Rezaei_ERP.BodgetId = tblCoding.Code COLLATE Arabic_CI_AS INNER JOIN
--                         tblCoding AS tblCoding_1 ON tblCoding.MotherId = tblCoding_1.Id
--WHERE        (TblBudgets.TblYearId = 33) AND (tblCoding.TblBudgetProcessId IN (3)) AND (tblCoding_1.Code = N'50301000010000')
--ORDER BY tblBudgetDetailProjectArea.AreaId, tblCoding.Code


END
GO
