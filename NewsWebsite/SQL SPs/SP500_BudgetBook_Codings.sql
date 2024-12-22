-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP500_BudgetBook_Codings]    Script Date: 12/22/2024 2:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP500_BudgetBook_Codings]
    @YearId INT,
    @AreaId INT,
    @BudgetProcessId INT,
    @Codings NVARCHAR(MAX)
AS
BEGIN
    -- Temporary table to store the results
CREATE TABLE #Results (
                          Code NVARCHAR(50),
                          Pishnahadi BIGINT,
                          Mosavab BIGINT
);

-- Split the @Codings string into individual codes
DECLARE @Code NVARCHAR(50);
    DECLARE @Pos INT;
    SET @Codings = LTRIM(RTRIM(@Codings)) + ','; -- Ensure trailing comma for processing
    SET @Pos = CHARINDEX(',', @Codings);

    WHILE @Pos > 0
BEGIN
            SET @Code = LTRIM(RTRIM(LEFT(@Codings, @Pos - 1)));
            SET @Codings = SUBSTRING(@Codings, @Pos + 1, LEN(@Codings));
            SET @Pos = CHARINDEX(',', @Codings);

            -- Perform the calculation for the current code
INSERT INTO #Results (Code, Pishnahadi, Mosavab)
SELECT
    @Code AS Code,
    isnull(SUM(tblBudgetDetailProjectArea.Pishnahadi),0) AS Pishnahadi,
    isnull(SUM(tblBudgetDetailProjectArea.Mosavab),0) AS Mosavab
FROM
    TblBudgets
        INNER JOIN TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId
        INNER JOIN tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId
        INNER JOIN tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId
        INNER JOIN TblAreas ON tblBudgetDetailProjectArea.AreaId = TblAreas.Id
        INNER JOIN tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
        LEFT JOIN tblCoding AS tblCoding_2 ON tblCoding.MotherId = tblCoding_2.Id
        LEFT JOIN tblCoding AS tblCoding_3 ON tblCoding_2.MotherId = tblCoding_3.Id
        LEFT JOIN tblCoding AS tblCoding_1 ON tblCoding_3.MotherId = tblCoding_1.Id
        LEFT JOIN tblCoding AS tblCoding_4 ON tblCoding_1.MotherId = tblCoding_4.Id
        LEFT JOIN tblCoding AS tblCoding_5 ON tblCoding_4.MotherId = tblCoding_5.Id
WHERE
        TblBudgets.TblYearId = @YearId
  AND tblCoding.TblBudgetProcessId = @BudgetProcessId
  AND (@Code IN (tblCoding.Code, tblCoding_2.Code, tblCoding_3.Code, tblCoding_1.Code, tblCoding_4.Code, tblCoding_5.Code));
END;

    -- Return the results
SELECT * FROM #Results;

-- Clean up
DROP TABLE #Results;
END;go

