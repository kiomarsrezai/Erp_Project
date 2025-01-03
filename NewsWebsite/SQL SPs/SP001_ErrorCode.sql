USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_ErrorCode]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_ErrorCode]
@yearId int
AS
BEGIN
SELECT        tbl1.Code, tblCoding_1.Description,  TblAreas.AreaName
FROM            (SELECT        tblCoding.Code, tblBudgetDetailProjectArea.AreaId, COUNT(*) AS CountRepet
                          FROM            TblBudgets INNER JOIN
                                                    TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                                                    tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                                                    tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                                                    tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
                          WHERE   (TblBudgets.TblYearId = @yearId) AND
						          (tblCoding.TblBudgetProcessId = 3)
                          GROUP BY tblCoding.Code, tblBudgetDetailProjectArea.AreaId) AS tbl1 INNER JOIN
                         tblCoding AS tblCoding_1 ON tbl1.Code = tblCoding_1.Code LEFT OUTER JOIN
                         TblAreas ON tbl1.AreaId = TblAreas.Id
WHERE        (tbl1.CountRepet > 1)
END
GO
