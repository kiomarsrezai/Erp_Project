USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_ProgramDetails_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_ProgramDetails_Read]
@programId int 
AS
BEGIN

select 
p0.Name AS name1,p1.Name AS name2,p2.Name AS name3,
CONCAT(p0.Code ,p1.Code ,p2.Code ) AS Code, p0.Color 

from (
	select * from TblProgramDetails where MotherId=0
)AS p0 

INNER Join  TblProgramDetails AS p1 ON p0.id=p1.MotherId
INNER Join  TblProgramDetails AS p2 ON p1.id=p2.MotherId

order by p0.Code asc ,  p1.Code asc ,  p2.Code asc 

END



GO
