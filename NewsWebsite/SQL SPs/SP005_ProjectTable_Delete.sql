USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP005_ProjectTable_Delete]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP005_ProjectTable_Delete]
@id int
AS
BEGIN
declare @count int = (select count(*) from TblProgramOperationDetails where TblProjectId = @id)

if(@count>0)
begin
    select cast(@count as nvarchar(10)) as Message_DB
	return
end

    delete TblProjects
	where id = @id
END
GO
