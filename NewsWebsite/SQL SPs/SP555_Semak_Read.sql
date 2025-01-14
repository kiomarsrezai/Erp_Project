USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP555_Semak_Read]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP555_Semak_Read]
@yearId int ,
@areaid int ,
@Semak_CodingId int
AS
BEGIN

if(@areaid = 10)
begin
SELECT        Semak_CodingId, Semak_CodingName, Amount
FROM            (SELECT        olden.tblIncomeDetail.Semak_CodingId, olden.tblIncomeDetail.Semak_CodingName, SUM(olden.tblIncomeDetail.Amount) AS Amount
                          FROM            olden.tblIncome INNER JOIN
                                                    olden.tblIncomeDetail ON olden.tblIncome.Id = olden.tblIncomeDetail.IncomeId
                          WHERE (olden.tblIncome.YearId = @yearId) AND
								(olden.tblIncomeDetail.YearId = @yearId) 
                          GROUP BY olden.tblIncomeDetail.Semak_CodingId, olden.tblIncomeDetail.Semak_CodingName) AS tbl1
ORDER BY Semak_CodingId 
return

end

if(@Semak_CodingId is null)
begin
SELECT        Semak_CodingId, Semak_CodingName, Amount
FROM            (SELECT        olden.tblIncomeDetail.Semak_CodingId, olden.tblIncomeDetail.Semak_CodingName, SUM(olden.tblIncomeDetail.Amount) AS Amount
                          FROM            olden.tblIncome INNER JOIN
                                                    olden.tblIncomeDetail ON olden.tblIncome.Id = olden.tblIncomeDetail.IncomeId
                          WHERE (olden.tblIncome.YearId = @yearId) AND
						        (olden.tblIncome.AreaId = @areaid) AND
								(olden.tblIncomeDetail.YearId = @yearId) AND
								(olden.tblIncomeDetail.AreaId = @areaid)
                          GROUP BY olden.tblIncomeDetail.Semak_CodingId, olden.tblIncomeDetail.Semak_CodingName) AS tbl1
ORDER BY Semak_CodingId 
return
end

if(@Semak_CodingId is not null)
begin
SELECT        olden.tblIncome.ShSerialFish, olden.tblIncome.ShenaseGhabz, olden.tblIncome.SDateSodoor, olden.tblIncome.Simak_MalekName, olden.tblIncomeDetail.Amount
FROM            olden.tblIncome INNER JOIN
                         olden.tblIncomeDetail ON olden.tblIncome.Id = olden.tblIncomeDetail.IncomeId
WHERE        (olden.tblIncome.YearId = @yearId) AND (olden.tblIncome.AreaId = @areaid) AND (olden.tblIncomeDetail.YearId = @yearId) AND (olden.tblIncomeDetail.AreaId = @areaid) AND 
                         (olden.tblIncomeDetail.Semak_CodingId = @Semak_CodingId)
ORDER BY olden.tblIncomeDetail.Semak_CodingId
return
end


END
GO
