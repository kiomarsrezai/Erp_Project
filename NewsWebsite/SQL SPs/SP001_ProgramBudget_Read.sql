USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_ProgramBudget_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_ProgramBudget_Read]
@yearId int ,
@areaId int,
@BudgetProcessId tinyint
AS
BEGIN

--SELECT tblCoding.Id, tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab,
--tblCoding.ProctorId,
--tblProctor_1.ProctorNameShort AS ProctorName, 
--tblBudgetDetailProject.BudgetDetailId, tblCoding.Show, 
--tblCoding.ExecuteId as CodingNatureId,tblProctor_1.ProctorNameShort as     CodingNatureName, 
--tblCoding.ExecuteId,
--tblProctor.ProctorNameShort AS ExecuteName 
--FROM            TblBudgets INNER JOIN
--                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
--                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id LEFT OUTER JOIN
--                         tblProctor ON tblCoding.ExecuteId = tblProctor.Id LEFT OUTER JOIN
--                         tblCodingNature ON tblCoding.CodingNatureId = tblCodingNature.Id LEFT OUTER JOIN
--                         tblProctor AS tblProctor_1 ON tblCoding.ProctorId = tblProctor_1.Id
--WHERE        (TblBudgets.TblYearId = @yearId) AND (tblBudgetDetailProjectArea.AreaId = @areaId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)

SELECT        tblCoding.Id, tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab,  tblBudgetDetailProjectArea.ProgramDetailsId ,
CONCAT(p1.Code,p2.Code,p3.Code) AS ProgramCode, p1.Color AS ProgramColor,p3.Name AS ProgramName,
tblBudgetDetailProjectArea.Id AS BDPAId



 
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id 

						 LEFT JOIN TblProgramDetails AS p3 ON p3.Id = tblBudgetDetailProjectArea.ProgramDetailsId
						 LEFT JOIN TblProgramDetails AS p2 ON p2.Id = p3.MotherId
						 LEFT JOIN TblProgramDetails AS p1 ON p1.Id = p2.MotherId

						

WHERE        (TblBudgets.TblYearId = @yearId) AND (tblBudgetDetailProjectArea.AreaId = @areaId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)
order by tblCoding.Code


END
GO
