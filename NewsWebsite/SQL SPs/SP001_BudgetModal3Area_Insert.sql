USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal3Area_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetModal3Area_Insert]
@areaPublicId int,
@yearId int,
@codingId int,
@projectId int,
@areaId int
AS
BEGIN

declare @Count int=(SELECT  count(*)
						FROM   tblBudgetDetailProjectArea
						WHERE (BudgetDetailProjectId = @areaPublicId) AND
						      (AreaId = @areaId)
)

if(@Count>0)
  begin
    select 'تکراری است' as Message_DB
	return
  end

if(@Count=0)
  begin
insert into tblBudgetDetailProjectArea ( BudgetDetailProjectId ,  AreaId , Mosavab)
                                 values(     @areaPublicId     , @areaId ,  1000  )
  end


END
GO
