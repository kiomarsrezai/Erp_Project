USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP005_ProgramOperation_Delete]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP005_ProgramOperation_Delete]
@Id int
AS
BEGIN
declare @ProjectId int = (select TblProjectId from TblProgramOperationDetails where id = @Id)
declare @count int = (SELECT  count(*)
							FROM   tblBudgetDetailProject INNER JOIN
								   TblProgramOperationDetails ON tblBudgetDetailProject.ProgramOperationDetailsId = TblProgramOperationDetails.Id
						WHERE     (TblProgramOperationDetails.TblProjectId = @ProjectId))
if(@count>0)
begin
     select 'پروژه مورد نظر در  بودجه استفاده شده است' as Message_DB
return
end

    delete TblProgramOperationDetails
	where id = @Id 
END
GO
