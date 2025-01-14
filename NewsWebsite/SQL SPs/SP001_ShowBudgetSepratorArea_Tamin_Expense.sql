USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_ShowBudgetSepratorArea_Tamin_Expense]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_ShowBudgetSepratorArea_Tamin_Expense]
@yearId int ,
@areaId int

AS
BEGIN
declare @YearName int
if(@yearId = 32) begin set @YearName = 1401  end
if(@yearId = 33) begin set @YearName = 1402  end
if(@yearId = 34) begin set @YearName = 1403  end
if(@yearId = 35) begin set @YearName = 1404  end

SELECT        olden.tblSanad_MD.Id, olden.tblSanad_MD.SanadDateS, olden.tblSanadDetail_MD.Bedehkar - olden.tblSanadDetail_MD.Bestankar AS Expense, olden.tblSanadDetail_MD.IdKol, olden.tblSanadDetail_MD.IdMoien, 
                         olden.tblSanadDetail_MD.IdTafsily4, olden.tblSanadDetail_MD.Description
FROM            olden.tblKol INNER JOIN
                         olden.tblSanadDetail_MD INNER JOIN
                         olden.tblSanad_MD ON olden.tblSanadDetail_MD.IdSanad_MD = olden.tblSanad_MD.Id AND olden.tblSanadDetail_MD.AreaId = olden.tblSanad_MD.AreaId AND 
                         olden.tblSanadDetail_MD.YearName = olden.tblSanad_MD.YearName ON olden.tblKol.id = olden.tblSanadDetail_MD.IdKol
WHERE (olden.tblSanad_MD.AreaId = @areaId) AND
      (olden.tblSanad_MD.YearName = @YearName) AND
	  (olden.tblSanadDetail_MD.AreaId = @areaId) AND
	  (olden.tblSanadDetail_MD.YearName = @YearName) AND
	  (olden.tblKol.AreaId = @areaId) AND 
      (olden.tblKol.YearName = @YearName) AND
	  (olden.tblKol.IdGroup = 999) AND
	  (olden.tblSanadDetail_MD.IdKol BETWEEN N'8258' AND N'8288')
ORDER BY olden.tblSanad_MD.Id
END
GO
