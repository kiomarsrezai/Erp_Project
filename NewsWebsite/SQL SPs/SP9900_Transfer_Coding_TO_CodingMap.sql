USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9900_Transfer_Coding_TO_CodingMap]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9900_Transfer_Coding_TO_CodingMap]
@yearId int ,
@areaId int
AS
BEGIN
INSERT INTO TblCodingsMapSazman(          YearId       ,          AreaId      ,  CodingId    )
					SELECT        TblBudgets.TblYearId , TblBudgets.TblAreaId , tblCoding.Id
					FROM            TblBudgetDetails INNER JOIN
											 TblBudgets ON TblBudgetDetails.BudgetId = TblBudgets.Id INNER JOIN
											 tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
					WHERE        (TblBudgets.TblYearId = @yearId) AND (TblBudgets.TblAreaId = @areaId) AND (tblCoding.Id NOT IN
												 (SELECT        CodingId
													FROM            TblCodingsMapSazman
													WHERE        (AreaId = @areaId) AND (YearId = @yearId)))
END
GO
