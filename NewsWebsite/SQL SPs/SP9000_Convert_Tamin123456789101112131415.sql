USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9000_Convert_Tamin123456789101112131415]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9000_Convert_Tamin123456789101112131415]

AS
BEGIN
declare @a int=1
--delete tbl_Vaset_Tamin

--delete tblRequestBudget
--DBCC CHECKIDENT('tblRequestBudget',RESEED,0)

--delete tblRequest
--DBCC CHECKIDENT('tblRequest',RESEED,0)


--INSERT INTO tbl_Vaset_Tamin (       Code        ,          AreaIdTamin          ,        AreaName           ,   Description           ,        RequestDate       ,        RequestPrice       ,       ReqDesc        ,       RequestRefStr      )
--			SELECT        Tbl_Bodgets_1.BodgetId, Tbl_Requsts_1.SectionExecutive, Tbl_Sections_1.Description, Tbl_Bodgets_1.BodgetDesc, Tbl_Requsts_1.RequestDate, Tbl_Requsts_1.RequestPrice, Tbl_Requsts_1.ReqDesc, 
--									 Tbl_Requsts_1.RequestRefStr
--			FROM            TAN.PortalTamin.dbo.Tbl_Bodgets AS Tbl_Bodgets_1 INNER JOIN
--									 TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 ON Tbl_Bodgets_1.id = Tbl_Requsts_1.BudgetIDKey INNER JOIN
--									 TAN.PortalTamin.dbo.Tbl_Sections AS Tbl_Sections_1 ON Tbl_Requsts_1.SectionExecutive = Tbl_Sections_1.SectionId
--			WHERE        (Tbl_Bodgets_1.Year_mosavab = 1401) AND (Tbl_Bodgets_1.TakhsisNumber IS NULL) AND (Tbl_Requsts_1.Confirmed=1)

----منطقه 01
--update tbl_Vaset_Tamin set AreaId = 1 where AreaIdTamin=1 

----منطقه 02
--update tbl_Vaset_Tamin set AreaId = 2 where AreaIdTamin=2 

----منطقه 03
--update tbl_Vaset_Tamin set AreaId = 3 where AreaIdTamin=3 

----منطقه 04
--update tbl_Vaset_Tamin set AreaId = 4 where AreaIdTamin=4 

----منطقه 05
--update tbl_Vaset_Tamin set AreaId = 5 where AreaIdTamin=5 

----منطقه 06
--update tbl_Vaset_Tamin set AreaId = 6 where AreaIdTamin=6 

----منطقه 07
--update tbl_Vaset_Tamin set AreaId = 7 where AreaIdTamin=7 

----منطقه 08
--update tbl_Vaset_Tamin set AreaId = 8 where AreaIdTamin=8 

----مرکزی
--update tbl_Vaset_Tamin set AreaId = 9 where AreaIdTamin=11 

----سازمان فاوا 11
--update tbl_Vaset_Tamin set AreaId = 11 where AreaIdTamin=102

---- انش نشانی 12
--update tbl_Vaset_Tamin set AreaId = 12 where AreaIdTamin=114

----اتوبوسرانی 13
--update tbl_Vaset_Tamin set AreaId = 13 where AreaIdTamin=105

----نوسازی 14
--update tbl_Vaset_Tamin set AreaId = 14 where AreaIdTamin = 115

----فرهنگی 25
--update tbl_Vaset_Tamin set AreaId = 25 where AreaIdTamin = 15

----پارکها 15
--update tbl_Vaset_Tamin set AreaId = 15 where AreaIdTamin = 112

----پایانه ها 16
--update tbl_Vaset_Tamin set AreaId = 16 where AreaIdTamin = 113

----تاکسیرانی 17
--update tbl_Vaset_Tamin set AreaId = 17 where AreaIdTamin = 107

----موتوری 18
--update tbl_Vaset_Tamin set AreaId = 18 where AreaIdTamin = 108

----ارامستانها 19
--update tbl_Vaset_Tamin set AreaId = 19 where AreaIdTamin = 106

----بار 20
--update tbl_Vaset_Tamin set AreaId = 20 where AreaIdTamin = 3034

----زیبا سازی 21
--update tbl_Vaset_Tamin set AreaId = 21 where AreaIdTamin = 109

----عمران 22
--update tbl_Vaset_Tamin set AreaId = 22 where AreaIdTamin = 101

----پسماند 23
--update tbl_Vaset_Tamin set AreaId = 23 where AreaIdTamin = 103

----مشاغل 24
--update tbl_Vaset_Tamin set AreaId = 24 where AreaIdTamin = 104

----ریلی 26
--update tbl_Vaset_Tamin set AreaId = 26 where AreaIdTamin = 110

----مشارکتها 29
--update tbl_Vaset_Tamin set AreaId = 29 where AreaIdTamin = 16


--insert into tblRequest (YearId ,             AreaId     ,               Number          ,              DateS         ,        EstimateAmount        ,           Description   ,   BudgetDetailProjectAreaId )
--			SELECT        32   , tbl_Vaset_Tamin.AreaId , tbl_Vaset_Tamin.RequestRefStr , tbl_Vaset_Tamin.RequestDate, tbl_Vaset_Tamin.RequestPrice , tbl_Vaset_Tamin.ReqDesc , tblBudgetDetailProjectArea.id
--			FROM            TblBudgets INNER JOIN
--									 TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--									 tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--									 tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
--									 TblCodings ON TblBudgetDetails.tblCodingId = TblCodings.Id INNER JOIN
--									 tbl_Vaset_Tamin ON TblCodings.Code = tbl_Vaset_Tamin.Code AND tblBudgetDetailProjectArea.AreaId = tbl_Vaset_Tamin.AreaId
--			WHERE (TblBudgets.TblYearId = 32) AND
--			      (TblCodings.TblBudgetProcessId IN (2, 3, 4))


--insert into tblRequestBudget(RequestId , BudgetDetailProjectAreaId ,  BudgetAmount )
--					SELECT        Id   , BudgetDetailProjectAreaId , EstimateAmount
--					FROM            tblRequest


--DELETE FROM tbl_Vaset_Tamin
--FROM            TblBudgets INNER JOIN
--                         TblBudgetDetails ON TblBudgets.Id = TblBudgetDetails.BudgetId INNER JOIN
--                         tblBudgetDetailProject ON TblBudgetDetails.Id = tblBudgetDetailProject.BudgetDetailId INNER JOIN
--                         tblBudgetDetailProjectArea ON tblBudgetDetailProject.Id = tblBudgetDetailProjectArea.BudgetDetailProjectId INNER JOIN
--                         TblCodings ON TblBudgetDetails.tblCodingId = TblCodings.Id INNER JOIN
--                         tbl_Vaset_Tamin ON TblCodings.Code = tbl_Vaset_Tamin.Code AND tblBudgetDetailProjectArea.AreaId = tbl_Vaset_Tamin.AreaId
--WHERE  (TblBudgets.TblYearId = 32) AND
--       (TblCodings.TblBudgetProcessId IN (2, 3, 4))



END
GO
