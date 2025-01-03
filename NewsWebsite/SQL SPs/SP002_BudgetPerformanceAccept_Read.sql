USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_BudgetPerformanceAccept_Read]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_BudgetPerformanceAccept_Read]
@YearId int ,
@MonthId tinyint
AS
BEGIN
	 SELECT   tblBudgetPerformanceAcceptDetail.Id, TblAreas.AreaName, tblBudgetPerformanceAcceptDetail.UserId, 
			  tblBudgetPerformanceAcceptDetail.FirstName, tblBudgetPerformanceAcceptDetail.LastName, 
			  tblBudgetPerformanceAcceptDetail.Responsibility, tblBudgetPerformanceAcceptDetail.Date
	 FROM     tblBudgetPerformanceAccept INNER JOIN
			  tblBudgetPerformanceAcceptDetail ON tblBudgetPerformanceAccept.Id = tblBudgetPerformanceAcceptDetail.BudgetPerformanceAcceptId INNER JOIN
			  TblAreas ON tblBudgetPerformanceAcceptDetail.AreaId = TblAreas.Id
	 WHERE   (tblBudgetPerformanceAccept.YearId = @YearId) AND
			 (tblBudgetPerformanceAccept.MonthId = @MonthId)
END
GO
