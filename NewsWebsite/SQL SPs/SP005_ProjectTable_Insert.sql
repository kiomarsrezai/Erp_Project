USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP005_ProjectTable_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP005_ProjectTable_Insert]
@ProjectName nvarchar(500) =NULL, 
@DateFrom date =NULL,
@DateEnd  date=NULL,
@AreaArray nvarchar(50),
@ProjectScaleId tinyint

AS
BEGIN
     if(@ProjectName is null or @ProjectName='')
	  begin
	    select 'نسبت به تکمیل اطلاعات نام پروژه اقدام فرمائید' as Message_DB
	  return
	  end
      insert into TblProjects( ProjectName , ProjectScaleId , AreaArray,DateFrom,DateEnd )
	                   values(@ProjectName , @ProjectScaleId ,@AreaArray,@DateFrom,@DateEnd )
      declare @ProjectId int = SCOPE_IDENTITY()

	  update TblProjects
		set ProjectCode = cast(@ProjectId as nvarchar(50))
		       where id = @ProjectId 

declare @AreaId int =  (select REPLACE(@AreaArray,'-',''))

declare @programOperationId int = (select Id from TblProgramOperations where TblProgramId = 10 and TblAreaId = @AreaId)

insert into TblProgramOperationDetails(TblProgramOperationId , TblProjectId)
								values(  @programOperationId , @ProjectId  )

END
GO
