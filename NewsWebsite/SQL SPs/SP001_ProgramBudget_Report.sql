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


if(@areaId IN (1,2,3,4,5,6,7,8,9))
begin




SELECT        tblCoding.Id, tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab,  tblBudgetDetailProjectArea.ProgramDetailsId ,
              CONCAT(p1.Code,p2.Code,p3.Code) AS ProgramCode, p1.Color AS ProgramColor,p3.Name AS ProgramName,
              tblBudgetDetailProjectArea.Id AS BDPAId




FROM            TblBudgets INNER JOIN
                TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblBudgets.TblYearId=TblAreasTogether.YearId

                           LEFT JOIN TblProgramDetails AS p3 ON p3.Id = tblBudgetDetailProjectArea.ProgramDetailsId
                           LEFT JOIN TblProgramDetails AS p2 ON p2.Id = p3.MotherId
                           LEFT JOIN TblProgramDetails AS p1 ON p1.Id = p2.MotherId



WHERE        (TblBudgets.TblYearId = @yearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)

  AND
    (
            ( tblBudgetDetailProjectArea.AreaId= @areaId AND @areaId IN (1,2,3,4,5,6,7,8,9)) OR
            (TblAreas.StructureId=1 AND @areaId IN (10)) OR
            (TblAreas.StructureId=2 AND @areaId IN (39)) OR
            (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
            (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41))
        )

  AND (
        (@programId!=0 AND @programDetailsId1!=0 AND @programDetailsId2!=0 AND @programDetailsId3!=0 And p3.Id = @programDetailsId3) OR
        (@programId!=0 AND @programDetailsId1!=0 AND @programDetailsId2!=0 AND @programDetailsId3=0 And p2.Id = @programDetailsId2) OR
        (@programId!=0 AND @programDetailsId1!=0 AND @programDetailsId2=0 AND @programDetailsId3=0 And p1.Id = @programDetailsId1) OR
        (@programId!=0 AND @programDetailsId1=0 AND @programDetailsId2=0 AND @programDetailsId3=0 And p1.ProgramId = @programId)

    )

order by tblCoding.Code



END





if(@areaId IN (10,39,40,41))
begin

SELECT        tblCoding.Id, tblCoding.Code, tblCoding.Description, sum (tblBudgetDetailProjectArea.Mosavab) as Mosavab,
              tblBudgetDetailProjectArea.ProgramDetailsId as ProgramDetailsId ,CONCAT(p1.Code, p2.Code, p3.Code) AS ProgramCode, p1.Color AS ProgramColor,p3.Name AS ProgramName,0 AS BDPAId




FROM            TblBudgets INNER JOIN
                TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id LEFT JOIN
                TblAreasTogether ON TblAreasTogether.AreaId = TblAreas.Id AND TblBudgets.TblYearId=TblAreasTogether.YearId

                           LEFT JOIN TblProgramDetails AS p3 ON p3.Id = tblBudgetDetailProjectArea.ProgramDetailsId
                           LEFT JOIN TblProgramDetails AS p2 ON p2.Id = p3.MotherId
                           LEFT JOIN TblProgramDetails AS p1 ON p1.Id = p2.MotherId



WHERE        (TblBudgets.TblYearId = @yearId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)

  AND
    (
            ( tblBudgetDetailProjectArea.AreaId= @areaId AND @areaId IN (1,2,3,4,5,6,7,8,9)) OR
            (TblAreas.StructureId=1 AND @areaId IN (10)) OR
            (TblAreas.StructureId=2 AND @areaId IN (39)) OR
            (TblAreasTogether.ToGetherBudget =10 AND @areaId IN (40)) OR
            (TblAreasTogether.ToGetherBudget =84 AND @areaId IN (41))
        )

  AND (
        (@programId!=0 AND @programDetailsId1!=0 AND @programDetailsId2!=0 AND @programDetailsId3!=0 And p3.Id = @programDetailsId3) OR
        (@programId!=0 AND @programDetailsId1!=0 AND @programDetailsId2!=0 AND @programDetailsId3=0 And p2.Id = @programDetailsId2) OR
        (@programId!=0 AND @programDetailsId1!=0 AND @programDetailsId2=0 AND @programDetailsId3=0 And p1.Id = @programDetailsId1) OR
        (@programId!=0 AND @programDetailsId1=0 AND @programDetailsId2=0 AND @programDetailsId3=0 And p1.ProgramId = @programId)

    )

group by
    tblCoding.Id,
    tblCoding.Code,
    tblCoding.Description,
    tblBudgetDetailProjectArea.ProgramDetailsId,
    p1.Code,
    p2.Code,
    p3.Code,
    p1.Color,
    p3.Name

order by tblCoding.Code


END




END
go

