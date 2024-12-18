USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_ShowBudgetDetail_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_ShowBudgetDetail_Update]
@id int,
@EditAmount bigint
AS
BEGIN

declare @MosavabPublic bigint = (SELECT TblBudgetDetails.MosavabPublic
									FROM            tblBudgetDetailProjectArea INNER JOIN
															 tblBudgetDetailProject ON tblBudgetDetailProjectArea.BudgetDetailProjectId = tblBudgetDetailProject.Id INNER JOIN
															 TblBudgetDetails ON tblBudgetDetailProject.BudgetDetailId = TblBudgetDetails.Id INNER JOIN
															 TblBudgetDetailEdit ON TblBudgetDetails.Id = TblBudgetDetailEdit.BudgetDetailId
									WHERE        (tblBudgetDetailProjectArea.id = @id))

declare @Change bigint = (SELECT sum( TblBudgetDetailEdit.Increase)-sum(TblBudgetDetailEdit.Decrease)
								FROM            tblBudgetDetailProjectArea INNER JOIN
														 tblBudgetDetailProject ON tblBudgetDetailProjectArea.BudgetDetailProjectId = tblBudgetDetailProject.Id INNER JOIN
														 TblBudgetDetails ON tblBudgetDetailProject.BudgetDetailId = TblBudgetDetails.Id INNER JOIN
														 TblBudgetDetailEdit ON TblBudgetDetails.Id = TblBudgetDetailEdit.BudgetDetailId
								WHERE        (tblBudgetDetailProjectArea.id = @id) AND (TblBudgetDetailEdit.StatusId = 20))

declare @BudgetDetailProjectId int = (select BudgetDetailProjectId from tblBudgetDetailProjectArea where id = @id)

declare @SumEditUse bigint = (select sum(Edit) from tblBudgetDetailProjectArea where BudgetDetailProjectId = @BudgetDetailProjectId)
declare @EditRow    bigint = (select Edit from tblBudgetDetailProjectArea where Id = @Id)

declare @Balance bigint = isnull(@MosavabPublic,0)+isnull(@Change,0)-isnull(@SumEditUse,0)+isnull(@EditRow,0)-isnull(@EditAmount,0)

if(@Balance<0)
begin
     select 'مبلغ اصلاح بودجه به مبلغ '+cast(@Balance as nvarchar(20))+' ریال منفی می شود ' as Message
return
end

if (@Balance>=0)
begin
   update tblBudgetDetailProjectArea
   set Edit = @EditAmount
   where id = @id
   return
end

END
GO
