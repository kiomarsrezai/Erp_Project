USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_BudgetSepratorArea_TaminModal_2]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_BudgetSepratorArea_TaminModal_2]
@yearId int ,
@areaId int ,
@budgetprocessId tinyint
AS
BEGIN
declare @Year_Tamin int
if(@yearId = 32) begin set @Year_Tamin = 1401  end
if(@yearId = 33) begin set @Year_Tamin = 1402  end

if(@areaId = 1)  begin set @areaId = 1    end
if(@areaId = 2)  begin set @areaId = 2    end
if(@areaId = 3)  begin set @areaId = 3    end
if(@areaId = 4)  begin set @areaId = 4    end
if(@areaId = 5)  begin set @areaId = 5    end
if(@areaId = 6)  begin set @areaId = 6    end
if(@areaId = 7)  begin set @areaId = 7    end
if(@areaId = 8)  begin set @areaId = 8    end
if(@areaId = 9)  begin set @areaId = 11   end
if(@areaId = 11) begin set @areaId = 102  end
if(@areaId = 12) begin set @areaId = 114  end
if(@areaId = 13) begin set @areaId = 105  end
if(@areaId = 14) begin set @areaId = 115  end
if(@areaId = 15) begin set @areaId = 112  end
if(@areaId = 16) begin set @areaId = 113  end
if(@areaId = 17) begin set @areaId = 107  end
if(@areaId = 18) begin set @areaId = 108  end
if(@areaId = 19) begin set @areaId = 106  end
if(@areaId = 20) begin set @areaId = 3034 end
if(@areaId = 21) begin set @areaId = 109  end
if(@areaId = 22) begin set @areaId = 101  end
if(@areaId = 23) begin set @areaId = 103  end
if(@areaId = 24) begin set @areaId = 104  end
if(@areaId = 25) begin set @areaId = 15   end
if(@areaId = 26) begin set @areaId = 110  end
if(@areaId = 29) begin set @areaId = 16   end

declare @TypeCredit int
if(@budgetprocessId = 2) begin set @TypeCredit = 115  end
if(@budgetprocessId = 3) begin set @TypeCredit = 116  end


SELECT        Tbl_Bodgets_1.BodgetId,  Tbl_Bodgets_1.BodgetDesc, Tbl_Requsts_1.RequestDate, Tbl_Requsts_1.RequestPrice, Tbl_Requsts_1.ReqDesc, 
                         Tbl_Requsts_1.RequestRefStr
FROM            TAN.PortalTamin.dbo.Tbl_Bodgets AS Tbl_Bodgets_1 INNER JOIN
                         TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 ON Tbl_Bodgets_1.id = Tbl_Requsts_1.BudgetIDKey INNER JOIN
                         TAN.PortalTamin.dbo.Tbl_Sections AS Tbl_Sections_1 ON Tbl_Requsts_1.SectionExecutive = Tbl_Sections_1.SectionId
WHERE     (Tbl_Bodgets_1.Year_mosavab = @Year_Tamin) AND
          (Tbl_Bodgets_1.TakhsisNumber IS NULL) AND
		  --(Tbl_Requsts_1.Confirmed = 1) AND
		  (Tbl_Bodgets_1.TypeCredit = @TypeCredit) AND
		  (Tbl_Requsts_1.SectionExecutive = @areaId) AND
		   Tbl_Requsts_1.RequestRefStr not in (select Number from tblRequest where YearId = @yearId and AreaId = @areaId )

order by Tbl_Requsts_1.RequestDate


END
GO
