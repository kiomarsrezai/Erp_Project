USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP010_RequestBudget_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP010_RequestBudget_Update]
@Id int ,
@RequestBudgetAmount bigint
AS
BEGIN

declare @Mosavab bigint = (SELECT tblBudgetDetailProjectArea.Mosavab
								FROM   tblRequestBudget INNER JOIN
									   tblBudgetDetailProjectArea ON tblRequestBudget.BudgetDetailProjectAreaId = tblBudgetDetailProjectArea.id
								WHERE  tblRequestBudget.Id = @Id)

declare @BudgetDetailProjectAreaId int =(SELECT        BudgetDetailProjectAreaId
									          FROM     tblRequestBudget
									          WHERE    Id = @Id)

declare @SupplyAmount bigint =(SELECT sum(RequestBudgetAmount)
									FROM   tblRequestBudget
									WHERE  BudgetDetailProjectAreaId = @BudgetDetailProjectAreaId)
							
 

   update tblRequestBudget
   set RequestBudgetAmount = @RequestBudgetAmount
                  where id = @Id
END
GO
