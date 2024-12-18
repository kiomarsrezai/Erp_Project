USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP00_Rezaei]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP00_Rezaei]
AS
BEGIN

SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 1) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 1 AND TypeCredit=120)

union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 2) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 2 AND TypeCredit=120)

union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 3) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 3 AND TypeCredit=120)

union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 4) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 4 AND TypeCredit=120)

union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 5) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 5 AND TypeCredit=120)
union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 6) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 6 AND TypeCredit=120)

union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 7) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 7 AND TypeCredit=120)


union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 8) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 8 AND TypeCredit=120)


union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 9) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 11 AND TypeCredit=120)

union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 11) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 102 AND TypeCredit=120)
union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 12) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 114 AND TypeCredit=120)

union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 13) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 105 AND TypeCredit=120)

union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 14) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 115 AND TypeCredit=120)

union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 15) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 112 AND TypeCredit=120)

union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 16) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 113 AND TypeCredit=120)

union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 17) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 107 AND TypeCredit=120)
union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 18) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 108 AND TypeCredit=120)

union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 19) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 106 AND TypeCredit=120)

union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 20) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 3034 AND TypeCredit=120)

union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 21) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 109 AND TypeCredit=120)

union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 22) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 101 AND TypeCredit=120)
union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 23) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 103 AND TypeCredit=120)

union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 104) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 24 AND TypeCredit=120)

union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 25) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 15 AND TypeCredit=120)

union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 26) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 110 AND TypeCredit=120)

union all
SELECT     tblBudgetDetailProjectArea.AreaId,   tblCoding.Id, tblCoding.Code, tblCoding.Description
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (TblBudgets.TblYearId = 33) AND
		(tblBudgetDetailProjectArea.AreaId = 29) AND
		(tblCoding.TblBudgetProcessId = 3) AND
		tblCoding.Code not in  (SELECT BodgetId FROM TAN.PortalTamin.dbo.Tbl_Bodgets 
		                          where SectionId = 16 AND TypeCredit=120)

order by  tblBudgetDetailProjectArea.AreaId, tblCoding.Code
END
GO
