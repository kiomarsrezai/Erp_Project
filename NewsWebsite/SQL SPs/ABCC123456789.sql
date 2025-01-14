USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[ABCC123456789]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ABCC123456789]

AS
BEGIN
declare @Radif int=1
while @Radif<=1240
begin
	declare @AreaId int         = (select AreaId from ABC where radif = @Radif)  
	declare	@MotherId int       = (select MotherId from ABC where radif = @Radif)  
	declare	@Code nvarchar(500) = (select Code from ABC where radif = @Radif)  
	declare	@Description nvarchar(3000) = (select Description from ABC where radif = @Radif)  
	declare	@Mosaavb bigint     = (select Mosaavb from ABC where radif = @Radif)  


insert into tblCoding ( MotherId, Code , Description,levelNumber,TblBudgetProcessId,Show,Crud,CodingKindId)
                values(@MotherId,@Code ,@Description,    5      ,         3        ,  1 ,  1 ,     20     )
declare @CodingId int = SCOPE_IDENTITY()
--=====================
insert TblBudgetDetails (BudgetId,tblCodingId,MosavabPublic)
                  values(   19   , @CodingId ,   @Mosaavb  )
declare @BudgetDetailId int = SCOPE_IDENTITY()
--=====================
declare @ProgramOperationDetailsId int = (SELECT TblProgramOperationDetails.Id
												FROM  TblProgramOperations INNER JOIN
													  TblProgramOperationDetails ON TblProgramOperations.Id = TblProgramOperationDetails.TblProgramOperationId
												WHERE (TblProgramOperations.TblAreaId = @AreaId) AND
												      (TblProgramOperations.TblProgramId = 10) AND
												      (TblProgramOperationDetails.TblProjectId = 3))

insert tblBudgetDetailProject( BudgetDetailId , ProgramOperationDetailsId  , Mosavab)
                       values(@BudgetDetailId , @ProgramOperationDetailsId ,@Mosaavb)
declare @BudgetDetailProjectId int = SCOPE_IDENTITY()
--=====================
insert into tblBudgetDetailProjectArea( BudgetDetailProjectId , AreaId , Mosavab)
                                values(@BudgetDetailProjectId ,@AreaId , @Mosaavb)

set @Radif = @Radif+1
end
END
GO
