USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP005_ProjectOrg_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP005_ProjectOrg_Read]
@id int
AS
BEGIN
--declare @temp1 table(Id int) 
--declare @temp2 table(Id int) 
--declare @temp3 table(Id int) 
--declare @temp4 table(Id int) 
--declare @temp5 table(Id int) 
--declare @temp6 table(Id int) 

--declare @MainId int =dbo.FindMotherID(@id)

--insert into @temp1 (Id)
--select Id from TblProjects
--where MotherId= @MainId

--insert into @temp2 (Id)
--select Id from TblProjects
--where MotherId in (select Id from @temp1)

--insert into @temp3 (Id)
--select Id from TblProjects
--where MotherId in (select Id from @temp2)

--insert into @temp4 (Id)
--select Id from TblProjects
--where MotherId in (select Id from @temp3)

--insert into @temp5 (Id)
--select Id from TblProjects
--where MotherId in (select Id from @temp4)

--insert into @temp6 (Id)
--select Id from TblProjects
--where MotherId in (select Id from @temp5)


--SELECT        Id, MotherId, ProjectCode, ProjectName, AreaId, Weight
--FROM            TblProjects
--				  where id in (select @MainId 
--								union all 
--							   select Id from @temp1
--								union all 
--							   select Id from @temp2
--								union all 
--							   select Id from @temp3
--								union all 
--							   select Id from @temp4
--			  					union all 
--							   select Id from @temp5
--								union all 
--							   select Id from @temp6 )

declare @temp table(Id int) 
declare @MainId int =dbo.FindMotherID(@id)
declare @i tinyint = 1


insert into @temp (   Id  )
            select @MainId

while @i<=20
begin
	insert into @temp (Id)
	select Id from TblProjects
	where MotherId in (select Id from @temp)
set @i = @i + 1
end

SELECT        Id, MotherId, ProjectCode, ProjectName, AreaId, Weight, DateFrom, DateEnd, AreaArray
FROM            TblProjects
				  where id in (select id from @temp)


END
GO
