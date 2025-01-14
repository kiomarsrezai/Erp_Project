USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal1Coding_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetModal1Coding_Update]
@Id int ,
@CodeOld nvarchar(100),
@CodeNew nvarchar(100),
@Description nvarchar(1000),
@mosavabPublic bigint

AS
BEGIN
--declare @YearId int = (SELECT   TblBudgets.TblYearId
--							FROM    TblBudgetDetails INNER JOIN
--									TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id
--							WHERE   (TblBudgetDetails.Id = @Id))

--declare @Count tinyint = (SELECT count(*)       
--							FROM      TblBudgetDetails INNER JOIN
--									  TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
--									  tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
--							WHERE  (TblBudgets.TblYearId = @YearId) AND
--							       (tblCoding.Code = @CodeNew))

declare @CodingId int = (select tblCodingId from TblBudgetDetails where Id = @Id)

declare @Count_CodingId_in_Year1402 int = (SELECT    count(*)    
											FROM   TblBudgets INNER JOIN
												   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
												   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
												   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
											WHERE  (TblBudgets.TblYearId = 33) AND
											       (TblBudgetDetails.tblCodingId = @CodingId))



--if(@CodeOld = @CodeNew)
--begin
if(@Count_CodingId_in_Year1402=0)
begin
	update tblCoding
		set  Description = @Description
		        where id = @CodingId
end


    update TblBudgetDetails
		 set MosavabPublic = @mosavabPublic
				  where id = @id
--return
--end

--if(@CodeOld <> @CodeNew and @Count=0)
-- begin
-- 	update tblCoding
--		  set  code = @CodeNew,
--		Description = @Description
--		   where id = @CodingId

--    update TblBudgetDetails
--		 set MosavabPublic = @mosavabPublic
--				  where id = @id
--return
-- end

--if(@CodeOld <> @CodeNew and @Count>0)
--begin
--     select 'کد تکراری است' as Message_DB
--return
--end



END
GO
