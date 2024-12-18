USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP000_Coding]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP000_Coding]
@BudgetProcessId tinyint,
@MotherId int=NULL
AS
BEGIN
if (@MotherId IS NULL)
 begin
	SELECT        tblCoding.Id, tblCoding.MotherId, tblCoding.Code, tblCoding.Description, tblCoding.levelNumber, tblCoding.Crud, tblCoding.Show, tblCoding.CodingKindId, tblCodingKind.CodingKindName
FROM            tblCoding LEFT OUTER JOIN
                         tblCodingKind ON tblCoding.CodingKindId = tblCodingKind.Id
WHERE        (tblCoding.TblBudgetProcessId = @BudgetProcessId) and (tblCoding.Code not like '0%')
ORDER BY tblCoding.Code
return
end

if (@MotherId IS NOT NULL)
 begin
	 SELECT        Id, MotherId, Code, Description, levelNumber, Crud, Show, CodingKindId
	FROM            tblCoding
	WHERE        MotherId = @MotherId
	ORDER BY Code
return
end

END
GO
