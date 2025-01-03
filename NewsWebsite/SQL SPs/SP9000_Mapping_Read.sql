USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9000_Mapping_Read]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9000_Mapping_Read]
@yearId int ,
@areaId int ,
@budgetProcessId tinyint
AS
BEGIN
if(@areaId >=11)
  begin
SELECT        TblCodingsMapSazman.Id, tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, TblCodingsMapSazman.CodeAcc, TblCodingsMapSazman.TitleAcc, TblCodingsMapSazman.PercentBud
FROM            TblBudgetDetails INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId
WHERE  (TblBudgets.TblYearId = @yearId) AND
       (tblBudgetDetailProjectArea.AreaId = @areaId) AND
	   (tblCoding.TblBudgetProcessId = @budgetProcessId) AND
	   (TblCodingsMapSazman.YearId = @yearId) AND 
       (TblCodingsMapSazman.AreaId = @areaId)

ORDER BY tblCoding.Code
  return
  end

if(@areaId <= 9)
  begin
SELECT  TblCodingsMapSazman.Id, tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, 
TblCodingsMapSazman.CodeVasetShahrdari as  CodeAcc, TblCodingsMapSazman.TitleAcc, TblCodingsMapSazman.PercentBud
FROM            TblBudgetDetails INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         TblCodingsMapSazman ON TblBudgetDetails.tblCodingId = TblCodingsMapSazman.CodingId
WHERE    (TblBudgets.TblYearId = @yearId) AND
		 (tblCoding.TblBudgetProcessId = @budgetProcessId) AND
		 (tblBudgetDetailProjectArea.AreaId = @areaId) AND
		 (TblCodingsMapSazman.AreaId = @areaId) AND
		 (TblCodingsMapSazman.YearId = @yearId) --AND
		-- (tblCoding.CodingKindId not in (10,11))
		 order by tblCoding.Code
  return
  end

END
GO
