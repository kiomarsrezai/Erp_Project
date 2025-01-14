USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal1CodingSearch]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetModal1CodingSearch]
@BudgetProcessId tinyint,
@MotherId int ,
@yearId int ,
@areaId  int
AS
BEGIN
SELECT        Id, Code, Description, levelNumber, Crud, Show
FROM            tblCoding
WHERE        (TblBudgetProcessId = @BudgetProcessId) AND 
             MotherId=@MotherId
       -- Id not in (select MotherId from tblCoding where MotherId is not null)  --and 

--		id not in (SELECT        TblBudgetDetails.tblCodingId
--FROM            TblBudgets INNER JOIN
--                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId
--WHERE  (TblBudgets.TblYearId = @yearId) AND
--       (TblBudgets.TblAreaId = @areaId))

END
GO
