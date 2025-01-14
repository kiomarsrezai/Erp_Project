USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP500_Abstract_Performance_Detail]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP500_Abstract_Performance_Detail]
@columnName nvarchar(200),
@areaId int,
@yearId int
AS
BEGIN
   if (@ColumnName in ('MosavabRevenue'       , 'ExpenseMonthRevenue'       , 'PercentRevenue' ))
   begin
		SELECT tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.Expense
		FROM            TblBudgets INNER JOIN
								 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
								 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
								 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
								 tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
		WHERE  (TblBudgets.TblYearId = @yearId) AND
		       (tblBudgetDetailProjectArea.AreaId = @areaId) AND
			   (tblCoding.TblBudgetProcessId = 1)
        order by tblCoding.Code
   return
   end
   if (@ColumnName in ('MosavabCurrent'       , 'ExpenseCurrent'       , 'PercentCurrent' ))
	begin
		   SELECT        tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.Expense
		     FROM            TblBudgets INNER JOIN
								 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
								 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
								 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
								 tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
		   WHERE     (TblBudgets.TblYearId = @yearId) AND
		             (tblBudgetDetailProjectArea.AreaId = @areaId) AND
					 (tblCoding.TblBudgetProcessId = 2)
    order by tblCoding.Code
	return
   end
   if (@ColumnName in ('MosavabCivil'         , 'ExpenseCivil'         , 'PercentCivil' ,'CreditAmountCivil'))
	begin
	   SELECT   tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.Expense
		FROM    TblBudgets INNER JOIN
								 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
								 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
								 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
								 tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
		WHERE (TblBudgets.TblYearId = @yearId) AND
			  (tblBudgetDetailProjectArea.AreaId = @areaId) AND
			  (tblCoding.TblBudgetProcessId = 3)
   order by tblCoding.Code
   return
   end
   if (@ColumnName in ('MosavabFinancial'     , 'ExpenseFinancial'     , 'PercentFinancial' ))
	begin
	     SELECT        tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.Expense
			FROM            TblBudgets INNER JOIN
									 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
									 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
									 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
									 tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
			WHERE        (TblBudgets.TblYearId = @yearId) AND
						 (tblBudgetDetailProjectArea.AreaId = @areaId) AND
						 (tblCoding.TblBudgetProcessId = 4)
    order by tblCoding.Code
	return
    end
   if (@ColumnName in ('MosavabSanavati'      , 'ExpenseSanavati'      , 'PercentSanavati' ))
	begin
	   	   SELECT  tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.Expense
        FROM       TblBudgets INNER JOIN
                   TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                   tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                   tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                   tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
         WHERE   (TblBudgets.TblYearId = @yearId) AND
		         (tblBudgetDetailProjectArea.AreaId = @areaId) AND
				 (tblCoding.TblBudgetProcessId = 5)
    order by tblCoding.Code
	return
   end
   if (@ColumnName in ('MosavabPayMotomarkez' , 'ExpensePayMotomarkez' , 'PercentPayMotomarkez' ))
	begin
	   	   SELECT        tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.Expense
               FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
               WHERE  (TblBudgets.TblYearId = @yearId) AND
		              (tblBudgetDetailProjectArea.AreaId = @areaId) AND
				      (tblCoding.TblBudgetProcessId = 8)
    order by tblCoding.Code
	return
   end
   if (@ColumnName in ('MosavabDar_Khazane'   , 'ExpenseMonthDarAzKhazane'   , 'PercentDar_Khazane' ))
	 begin
	   	   SELECT        tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.Expense
              FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
            WHERE   (TblBudgets.TblYearId = @yearId) AND
			        (tblBudgetDetailProjectArea.AreaId = @areaId) AND
					(tblCoding.TblBudgetProcessId = 10)
   order by tblCoding.Code
   return
   end
   if (@ColumnName in ('MosavabNeyabati'   , 'ExpenseMonthNeyabati'   , 'PercentNeyabati' ))
	 begin
	   	   SELECT        tblCoding.Code, tblCoding.Description, tblBudgetDetailProjectArea.Mosavab, tblBudgetDetailProjectArea.Expense
              FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
            WHERE   (TblBudgets.TblYearId = @yearId) AND
			        (tblBudgetDetailProjectArea.AreaId = @areaId) AND
					(tblCoding.TblBudgetProcessId = 9)
   order by tblCoding.Code
   return
   end
END
GO
