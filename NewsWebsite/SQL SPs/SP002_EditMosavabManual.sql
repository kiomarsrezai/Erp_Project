USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_EditMosavabManual]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_EditMosavabManual]
@Mosavab bigint   ,
@BudgetDetailId    int   ,             
@BudgetDetailProjectId  int  ,               
@BudgetDetailProjectAreaId  int               
AS
BEGIN
select 'امروز در حال مطابقت بین بودجه سازمانها و بودجه تلفیقی شهرداری هستیم امکان تغییر وجود ندارد' as Message_DB
	return

declare @BudgetProcessId tinyint = ( SELECT        tblCoding.TblBudgetProcessId
										FROM            TblBudgetDetails INNER JOIN
																 tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
										WHERE        (TblBudgetDetails.Id = @BudgetDetailId))
--if(@BudgetProcessId in (1,9,2))
--begin
--    select 'تغییرات بودجه درآمد و پرداخت از خزانه به صورت متمرکز در حال انجام می باشد در صورت نیاز با آقای رضایی تماس بگیرید' as Message_DB
--	return
--end
  update TblBudgetDetails
 set MosavabPublic = @Mosavab
          where id = @BudgetDetailId

   update tblBudgetDetailProject
       set Mosavab = @Mosavab,
       EditProject = @Mosavab
          where id = @BudgetDetailProjectId

   update tblBudgetDetailProjectArea
       set Mosavab = @Mosavab,
	      EditArea = @Mosavab
          where id = @BudgetDetailProjectAreaId


END
GO
