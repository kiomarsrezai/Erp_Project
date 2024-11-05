USE [ProgramBudDB]
GO

/****** Object:  StoredProcedure [dbo].[SP001_ProgramBudget_Report]    Script Date: 11/5/2024 4:33:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_ProgramBudget_Report]
@yearId int ,
@areaId int,
@BudgetProcessId tinyint,
@programId int,
@programDetailsId1 int,
@programDetailsId2 int,
@programDetailsId3 int
AS
BEGIN


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

  AND (
        (@programId!=0 AND @programDetailsId1!=0 AND @programDetailsId2!=0 AND @programDetailsId3!=0 And p3.Id = @programDetailsId3) OR
        (@programId!=0 AND @programDetailsId1!=0 AND @programDetailsId2!=0 AND @programDetailsId3=0 And p2.Id = @programDetailsId2) OR
        (@programId!=0 AND @programDetailsId1!=0 AND @programDetailsId2=0 AND @programDetailsId3=0 And p1.Id = @programDetailsId1) OR
        (@programId!=0 AND @programDetailsId1=0 AND @programDetailsId2=0 AND @programDetailsId3=0 And p1.ProgramId = @programId)

    )

order by tblCoding.Code


END
GO


