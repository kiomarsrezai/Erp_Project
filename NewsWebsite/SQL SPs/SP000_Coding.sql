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
SELECT        tblCoding.Id, tblCoding.MotherId, tblCoding.Code, tblCoding.Description, tblCoding.levelNumber, tblCoding.Crud, tblCoding.Show, tblCoding.CodingKindId,isnull(tblCoding.Scope,0) as Scope,isnull(tblCoding.Stability,0) as Stability,isnull(tblCoding.PublicConsumptionPercent,0) as PublicConsumptionPercent,isnull(tblCoding.PrivateConsumptionPercent,0) as PrivateConsumptionPercent, tblCodingKind.CodingKindName
FROM            tblCoding LEFT OUTER JOIN
                tblCodingKind ON tblCoding.CodingKindId = tblCodingKind.Id
WHERE        (tblCoding.TblBudgetProcessId = @BudgetProcessId)
  and (tblCoding.Code not like '0%') -- old budget codings
ORDER BY tblCoding.Code
    return
end

if (@MotherId IS NOT NULL)
begin
SELECT        Id, MotherId, Code, Description, levelNumber, Crud, Show, CodingKindId,isnull(Scope,0) as Scope,isnull(Stability,0) as Stability,isnull(PublicConsumptionPercent,0) as PublicConsumptionPercent,isnull(PrivateConsumptionPercent,0) as PrivateConsumptionPercent
FROM            tblCoding
WHERE        MotherId = @MotherId
ORDER BY Code
    return
end

END
go

