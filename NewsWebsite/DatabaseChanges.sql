
ALTER TABLE tblBudgetDetailProjectArea
    ADD ProgramDetailsId int;

-------------------------------------------
USE [ProgramBudDB]
GO

/****** Object:  StoredProcedure [dbo].[SP001_ProgramBudget_Read]    Script Date: 11/3/2024 5:07:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_ProgramBudget_Read]
@yearId int ,
@areaId int,
@BudgetProcessId tinyint
AS
BEGIN

SELECT        tblCoding.Id, tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab,  tblBudgetDetailProjectArea.ProgramDetailsId ,
              CONCAT(p1.Code,p2.Code,p3.Code) AS ProgramCode, p1.Color AS ProgramColor,p3.Name AS ProgramName,
              tblBudgetDetailProjectArea.Id AS BDPAId




FROM            TblBudgets INNER JOIN
                TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id

                           LEFT JOIN TblProgramDetails AS p3 ON p3.Id = tblBudgetDetailProjectArea.ProgramDetailsId
                           LEFT JOIN TblProgramDetails AS p2 ON p2.Id = p3.MotherId
                           LEFT JOIN TblProgramDetails AS p1 ON p1.Id = p2.MotherId



WHERE        (TblBudgets.TblYearId = @yearId) AND (tblBudgetDetailProjectArea.AreaId = @areaId) AND (tblCoding.TblBudgetProcessId = @BudgetProcessId)
order by tblCoding.Code


END
GO


-------------------------




USE [ProgramBudDB]
GO

/****** Object:  StoredProcedure [dbo].[SP001_ProgramBudget_Update]    Script Date: 11/3/2024 5:07:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_ProgramBudget_Update]
@Ids NVARCHAR(MAX),
@programDetailsId int
AS
BEGIN
Update tblBudgetDetailProjectArea set ProgramDetailsId=@programDetailsId
WHERE Id IN (SELECT Id FROM dbo.fn_SplitString(@Ids, ','))
END
GO


-----------------------------------


USE [ProgramBudDB]
GO

/****** Object:  StoredProcedure [dbo].[SP001_ProgramDetails_Read]    Script Date: 11/3/2024 5:07:36 PM ******/
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



------------------------------------------






