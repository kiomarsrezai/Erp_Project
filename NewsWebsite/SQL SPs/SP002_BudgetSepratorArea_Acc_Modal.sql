USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_BudgetSepratorArea_Acc_Modal]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_BudgetSepratorArea_Acc_Modal]
@areaId int,
@yearId int,
@codingId int,
@KindId tinyint
AS
BEGIN
--kind = 1 نمایش تامین اعتبارات
--kind = 2 نمایش اسناد حسابداری
declare @YearName int =(SELECT YearName FROM TblYears WHERE Id = @yearId)
declare @StructureId tinyint = (SELECT StructureId FROM TblAreas where id = @areaId)

if(@KindId = 1)
begin
SELECT        tblRequest.Number as NumberSanad, tblRequest.DateS as DateSanad, tblRequest.Description, tblRequest.EstimateAmount as Expense , tblBudgetDetailProject.programOperationDetailsId as programOperationDetailsId
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblRequestBudget ON tblBudgetDetailProjectArea.id = tblRequestBudget.BudgetDetailProjectAreaId INNER JOIN
                         tblRequest ON tblRequestBudget.RequestId = tblRequest.Id
WHERE  (TblBudgets.TblYearId = @yearId) AND
       (TblBudgetDetails.tblCodingId = @codingId) AND
	   (tblBudgetDetailProjectArea.AreaId = @areaId)
return
end

if(@KindId = 2 and @StructureId = 1)
begin
SELECT        olden.tblSanad_MD.Id as NumberSanad, olden.tblSanad_MD.SanadDateS as DateSanad, olden.tblSanadDetail_MD.Description, olden.tblSanadDetail_MD.Bedehkar - olden.tblSanadDetail_MD.Bestankar AS Expense, tblBudgetDetailProject.programOperationDetailsId as programOperationDetailsId
FROM            TblBudgetDetails INNER JOIN
                         TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id AND TblBudgetDetails.BudgetId = TblBudgets.Id AND TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id AND TblBudgetDetails.tblCodingId = tblCoding.Id AND TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                         olden.tblSanadDetail_MD INNER JOIN
                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id ON TblCodingsMapSazman.CodeVasetShahrdari = olden.tblSanadDetail_MD.CodeVasetShahrdari INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId AND TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId AND 
                         TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId AND tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId AND 
                         tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
WHERE   (olden.tblSanad_MD.AreaId = @areaId) AND
        (olden.tblSanad_MD.YearName = @YearName) AND
		(olden.tblSanadDetail_MD.AreaId = @areaId) AND
		(olden.tblSanadDetail_MD.YearName = @YearName) AND 
        (TblBudgets.TblYearId = @yearId) AND
		(TblCodingsMapSazman.YearId = @yearId) AND
		(TblCodingsMapSazman.AreaId = @areaId) AND
		(TblBudgetDetails.tblCodingId = @codingId) AND 
        (tblBudgetDetailProjectArea.AreaId = @areaId)
ORDER BY olden.tblSanad_MD.Id, olden.tblSanad_MD.SanadDateS
return
end

if(@KindId = 2 and  @StructureId = 2)
begin
SELECT        olden.tblSanad_MD.Id AS NumberSanad, olden.tblSanad_MD.SanadDateS AS DateSanad, olden.tblSanadDetail_MD.Description, olden.tblSanadDetail_MD.Bedehkar - olden.tblSanadDetail_MD.Bestankar AS Expense, tblBudgetDetailProject.programOperationDetailsId as programOperationDetailsId
FROM            TblBudgetDetails INNER JOIN
                         TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id AND TblBudgetDetails.BudgetId = TblBudgets.Id AND TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id AND TblBudgetDetails.tblCodingId = tblCoding.Id AND TblBudgetDetails.tblCodingId = tblCoding.Id INNER JOIN
                         TblCodingsMapSazman ON tblCoding.Id = TblCodingsMapSazman.CodingId INNER JOIN
                         olden.tblSanadDetail_MD INNER JOIN
                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id ON TblCodingsMapSazman.CodeAcc = olden.tblSanadDetail_MD.CodeVasetSazman INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId AND tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId AND 
                         tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         olden.tblKol ON olden.tblSanadDetail_MD.IdKol = olden.tblKol.id INNER JOIN
                         olden.tblGroup ON olden.tblKol.IdGroup = olden.tblGroup.Id
WHERE    (olden.tblSanad_MD.AreaId = @areaId) AND
         (olden.tblSanad_MD.YearName = @YearName) AND
		 (olden.tblSanadDetail_MD.AreaId = @areaId) AND
		 (olden.tblSanadDetail_MD.YearName = @YearName) AND 
         (TblBudgets.TblYearId = @yearId) AND
		 (tblBudgetDetailProjectArea.AreaId = @areaId) AND
		 (TblCodingsMapSazman.YearId = @yearId) AND
		 (TblCodingsMapSazman.AreaId = @areaId) AND 
         (TblBudgetDetails.tblCodingId = @codingId) AND
		 (olden.tblKol.AreaId = @areaId) AND
		 (olden.tblKol.YearName = @YearName) AND
		 (olden.tblGroup.AreaId = @areaId) AND
		 (olden.tblGroup.YearName = @YearName)
ORDER BY NumberSanad, DateSanad
return
end




END
GO
