USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[sp000_ghasemi]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp000_ghasemi]

AS
BEGIN
declare @codingId int =10795
--declare @areaid int=29
declare @areaId int=1
while @areaId<=29
begin
if(@areaId not in (27,28))
begin
declare @budgetId      int      = (select Id from TblBudgets where TblYearId = 34 and TblAreaId = @areaId)
declare  @ProgramOperationDetailId int = (SELECT TblProgramOperationDetails.Id
													FROM    TblProgramOperations INNER JOIN
															TblProgramOperationDetails ON TblProgramOperations.Id = TblProgramOperationDetails.TblProgramOperationId INNER JOIN
															TblProjects ON TblProgramOperationDetails.TblProjectId = TblProjects.Id
													WHERE  (TblProgramOperations.TblAreaId = @areaId) AND
													       (TblProgramOperations.TblProgramId = 10) AND
													       (TblProgramOperationDetails.TblProjectId = 2))

insert into TblBudgetDetails ( BudgetId , tblCodingId , MosavabPublic)
                       values(@BudgetId ,  @codingId  ,     1000     )
declare @BudgetDetailId int = SCOPE_IDENTITY()

insert into tblBudgetDetailProject ( BudgetDetailId ,  ProgramOperationDetailsId ,Mosavab)
						     values(@BudgetDetailId , @ProgramOperationDetailId  ,  1000 )
declare @BudgetDetailProjectId int = SCOPE_IDENTITY()

insert into tblBudgetDetailProjectArea( BudgetDetailProjectId ,  AreaId  ,Mosavab)
							    values(@BudgetDetailProjectId , @areaId  ,  1000 )
end
set @areaId = @areaId+1
END
end


SELECT        tblBudgetDetailProjectArea_1.Mosavab, tblCoding_1.Code, tblCoding_1.Description
FROM            tblBudgetDetailProject AS tblBudgetDetailProject_1 INNER JOIN
                         tblBudgetDetailProjectArea AS tblBudgetDetailProjectArea_1 ON tblBudgetDetailProject_1.Id = tblBudgetDetailProjectArea_1.BudgetDetailProjectId INNER JOIN
                         TblBudgetDetails AS TblBudgetDetails_1 ON tblBudgetDetailProject_1.BudgetDetailId = TblBudgetDetails_1.Id INNER JOIN
                         tblCoding AS tblCoding_1 ON TblBudgetDetails_1.tblCodingId = tblCoding_1.Id INNER JOIN
                         TblBudgets AS TblBudgets_1 ON TblBudgetDetails_1.BudgetId = TblBudgets_1.Id
WHERE        (tblCoding_1.TblBudgetProcessId = 2) AND
(TblBudgets_1.TblYearId = 34) AND
tblBudgetDetailProjectArea_1.Mosavab<>0 and 
(tblBudgetDetailProjectArea_1.AreaId in (1,2,3,4,5,6,7,8,9)) AND
(RIGHT(tblBudgetDetailProjectArea_1.Mosavab, 7) <> '0000000')
ORDER BY tblBudgetDetailProjectArea_1.Mosavab
GO
