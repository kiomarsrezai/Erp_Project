USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9999_Tamin_To_ERP_1402_Before_Ins_Up_Del123456789]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9999_Tamin_To_ERP_1402_Before_Ins_Up_Del123456789]
@BodgetId      nvarchar(50),
@BodgetDesc    nvarchar(2000),
@RequestDate   nvarchar(50),
@RequestPrice  bigint,
@ReqDesc       nvarchar(2000),
@RequestRefStr nvarchar(50),
@SectionId int
AS
BEGIN
declare @AreaId int
if(@SectionId = 1)    begin set @areaId = 1  end
if(@SectionId = 2)    begin set @areaId = 2  end
if(@SectionId = 3)    begin set @areaId = 3  end
if(@SectionId = 4)    begin set @areaId = 4  end
if(@SectionId = 5)    begin set @areaId = 5  end
if(@SectionId = 6)    begin set @areaId = 6  end
if(@SectionId = 7)    begin set @areaId = 7  end
if(@SectionId = 8)    begin set @areaId = 8  end
if(@SectionId = 11)   begin set @areaId = 9  end
if(@SectionId = 102)  begin set @areaId = 11 end
if(@SectionId = 114)  begin set @areaId = 12 end
if(@SectionId = 105)  begin set @areaId = 13 end
if(@SectionId = 115)  begin set @areaId = 14 end
if(@SectionId = 112)  begin set @areaId = 15 end
if(@SectionId = 113)  begin set @areaId = 16 end
if(@SectionId = 107)  begin set @areaId = 17 end
if(@SectionId = 108)  begin set @areaId = 18 end
if(@SectionId = 106)  begin set @areaId = 19 end
if(@SectionId = 3034) begin set @areaId = 20 end
if(@SectionId = 109)  begin set @areaId = 21 end
if(@SectionId = 101)  begin set @areaId = 22 end
if(@SectionId = 103)  begin set @areaId = 23 end
if(@SectionId = 104)  begin set @areaId = 24 end
if(@SectionId = 15 )  begin set @areaId = 25 end
if(@SectionId = 110)  begin set @areaId = 26 end
if(@SectionId = 16 )  begin set @areaId = 29 end

declare @count int = (SELECT  COUNT(*) 
FROM            TblBudgets INNER JOIN
                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
                         tblCoding ON TblBudgetDetails.tblCodingId = tblCoding.Id
WHERE   (TblBudgets.TblYearId = 33) AND
        (tblBudgetDetailProjectArea.AreaId = @AreaId) AND
		(tblCoding.Code = @BodgetId) AND
		(tblCoding.TblBudgetProcessId IN (2, 3, 4, 5)) )


   select @count 


END
GO
