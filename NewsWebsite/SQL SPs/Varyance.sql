USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[Varyance]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Varyance]

AS
BEGIN
declare @BudgetDetailProjectId int

declare @BudgetDetailId int=3956
insert into  tblBudgetDetailProject(TblBudgetDetailId,ProgramOperationDetailsId)
                             values(@BudgetDetailId  ,          19             )
set  @BudgetDetailProjectId = SCOPE_IDENTITY()

insert into tblBudgetDetailProjectArea(BudgetDetailProjectId  ,AreaId )
                                values(@BudgetDetailProjectId ,   1   )

--====================================================================================
insert into  tblBudgetDetailProject(TblBudgetDetailId,ProgramOperationDetailsId)
                             values(@BudgetDetailId  ,          20             )
set  @BudgetDetailProjectId = SCOPE_IDENTITY()

insert into tblBudgetDetailProjectArea(BudgetDetailProjectId  ,AreaId )
                                values(@BudgetDetailProjectId ,   2   )
--====================================================================================
insert into  tblBudgetDetailProject(TblBudgetDetailId,ProgramOperationDetailsId)
                             values(@BudgetDetailId  ,          21             )
set  @BudgetDetailProjectId = SCOPE_IDENTITY()

insert into tblBudgetDetailProjectArea(BudgetDetailProjectId  ,AreaId )
                                values(@BudgetDetailProjectId ,   3   )
--====================================================================================
insert into  tblBudgetDetailProject(TblBudgetDetailId,ProgramOperationDetailsId)
                             values(@BudgetDetailId  ,          22             )
set  @BudgetDetailProjectId = SCOPE_IDENTITY()

insert into tblBudgetDetailProjectArea(BudgetDetailProjectId  ,AreaId )
                                values(@BudgetDetailProjectId ,   4   )
--=====================================================================================
insert into  tblBudgetDetailProject(TblBudgetDetailId,ProgramOperationDetailsId)
                             values(@BudgetDetailId  ,          23             )
set  @BudgetDetailProjectId = SCOPE_IDENTITY()

insert into tblBudgetDetailProjectArea(BudgetDetailProjectId  ,AreaId )
                                values(@BudgetDetailProjectId ,   5   )
--======================================================================================
insert into  tblBudgetDetailProject(TblBudgetDetailId,ProgramOperationDetailsId)
                             values(@BudgetDetailId  ,          24             )
set  @BudgetDetailProjectId = SCOPE_IDENTITY()

insert into tblBudgetDetailProjectArea(BudgetDetailProjectId  ,AreaId )
                                values(@BudgetDetailProjectId ,   6   )
--========================================================================================
insert into  tblBudgetDetailProject(TblBudgetDetailId,ProgramOperationDetailsId)
                             values(@BudgetDetailId  ,          25             )
set  @BudgetDetailProjectId = SCOPE_IDENTITY()

insert into tblBudgetDetailProjectArea(BudgetDetailProjectId  ,AreaId )
                                values(@BudgetDetailProjectId ,   7   )
--========================================================================================
insert into  tblBudgetDetailProject(TblBudgetDetailId,ProgramOperationDetailsId)
                             values(@BudgetDetailId  ,          26             )
set  @BudgetDetailProjectId = SCOPE_IDENTITY()

insert into tblBudgetDetailProjectArea(BudgetDetailProjectId  ,AreaId )
                                values(@BudgetDetailProjectId ,   8   )
--========================================================================================
insert into  tblBudgetDetailProject(TblBudgetDetailId,ProgramOperationDetailsId)
                             values(@BudgetDetailId  ,          27             )
set  @BudgetDetailProjectId = SCOPE_IDENTITY()

insert into tblBudgetDetailProjectArea(BudgetDetailProjectId  ,AreaId )
                                values(@BudgetDetailProjectId ,   9   )
--========================================================================================


declare @AreaId int =2
declare @CodingId int=4863



--declare @BudgetDetailProjectId int
--declare @BudgetDetailId int
--declare @ProgramOperationDetailsId int

--if (@AreaId=1) begin set @ProgramOperationDetailsId = 19 end
--if (@AreaId=2) begin set @ProgramOperationDetailsId = 20 end
--if (@AreaId=3) begin set @ProgramOperationDetailsId = 21 end
--if (@AreaId=4) begin set @ProgramOperationDetailsId = 22 end
--if (@AreaId=5) begin set @ProgramOperationDetailsId = 23 end
--if (@AreaId=6) begin set @ProgramOperationDetailsId = 24 end
--if (@AreaId=7) begin set @ProgramOperationDetailsId = 25 end
--if (@AreaId=8) begin set @ProgramOperationDetailsId = 26 end
--if (@AreaId=9) begin set @ProgramOperationDetailsId = 27 end

insert into  tblBudgetDetails(TblBudgetId , tblCodingId )
                       values(     1      ,  @CodingId  )
set  @BudgetDetailId = SCOPE_IDENTITY()


insert into  tblBudgetDetailProject(TblBudgetDetailId ,  ProgramOperationDetailsId)
                             --values( @BudgetDetailId  , @ProgramOperationDetailsId)
--set  @BudgetDetailProjectId = SCOPE_IDENTITY()

--insert into tblBudgetDetailProjectArea(BudgetDetailProjectId  , AreaId )
--                                values(@BudgetDetailProjectId ,@AreaId )

Exec SP9000_GetPerformanceFromAcc1401
END
GO
