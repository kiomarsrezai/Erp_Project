USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP500_Request_Analyze]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP500_Request_Analyze]
@AreaId int ,
@KindId int
AS
BEGIN
--@KindId = 1 راکد
--@KindId = 2 بدون ثبت هزینه
--@KindId = 3 در جریان
--@KindId = 4 ثبت هزینه بیش از ت اعتبار
if(@AreaId = 9) begin set @AreaId = 11  end

declare @ExecuteId table(id int)
if(@areaId=30) -- معاونت  شهر سازی
  begin 
   insert into @ExecuteId (id ) 
	           select sectionid from TAN.PortalTamin.dbo.Tbl_Sections 
				where sectionid in (13)   
  end 
if(@areaId=31)-- معاونت عمرانی فنی 
 begin 
   insert into @ExecuteId (id ) 
	           select sectionid from TAN.PortalTamin.dbo.Tbl_Sections 
				where sectionid in (9) 
 end 
if(@areaId=32)-- ترافیک 
 begin 
  insert into @ExecuteId (id ) 
	           select sectionid from TAN.PortalTamin.dbo.Tbl_Sections 
				where sectionid in (14)  
 end
if(@areaId=33) --خدمات شهری
begin  
  insert into @ExecuteId (id ) 
	           select sectionid from TAN.PortalTamin.dbo.Tbl_Sections 
				where sectionid in (12)   
end
if(@areaId=34) --معاونت فرهنگی
begin   
insert into @ExecuteId (id ) 
select sectionid from TAN.PortalTamin.dbo.Tbl_Sections 
where sectionid in (15) 
end
if(@areaId=35) -- مالی اقتصادی
  begin 
    insert into @ExecuteId (id ) 
	              select sectionid from TAN.PortalTamin.dbo.Tbl_Sections 
				   where sectionid in (10,34,3130,3204,3231) 
  end
if(@areaId=36) --برنامه ریزی
 begin 
    insert into @ExecuteId (id ) 
	              select sectionid from TAN.PortalTamin.dbo.Tbl_Sections 
				   where sectionid in (47,739,173,3179) 
 end
if(@areaId=38) --حوزه شهردار
 begin 
    insert into @ExecuteId (id ) 
	              select sectionid from TAN.PortalTamin.dbo.Tbl_Sections 
				   where sectionid in (48,31,32,33,49,3224,35,38,3225,3228,3229,3232,3302) 
 end

--لیست تامین اعتبارت بلاتکلیف
if(@KindId = 1 and @AreaId  in (1,2,3,4,5,6,7,8,11))
begin
SELECT        RequestRef, ConfirmDocNo, RequestRefStr, RequestDate, ReqDesc, RequestPrice, ISNULL(CnfirmedPrice, 0) AS CnfirmedPrice, RequestPrice - ISNULL(CnfirmedPrice, 0) AS Diff, Tbl_Requsts_1.SectionId, ConfirmDocDate
FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1
WHERE        (YearNow = 1402) AND (SectionId = @AreaId) AND (ConfirmDocNo IS NULL) AND (TypeCredit = 120)
ORDER BY SectionId, RequestPrice desc --RequestDate

return
end
if(@KindId = 1 and @AreaId = 10)
begin
	SELECT  RequestRef, ConfirmDocNo,RequestRefStr,RequestDate,   ReqDesc, RequestPrice,isnull(CnfirmedPrice,0) as CnfirmedPrice,
	RequestPrice - isnull(CnfirmedPrice,0) as Diff,	SectionId, ConfirmDocDate
	FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1
	WHERE   (YearNow = 1402) AND
			(SectionId IN (1,2,3,4,5,6,7,8, 11))  and
			 ConfirmDocNo is null  AND (TypeCredit = 120)
	order by SectionId,RequestPrice desc--RequestDate
return
end
if(@KindId = 1 and @AreaId  in (30,31,32,33,34,35,36,38))
begin
SELECT        RequestRef, ConfirmDocNo, RequestRefStr, RequestDate, ReqDesc, RequestPrice, 
ISNULL(CnfirmedPrice, 0) AS CnfirmedPrice, RequestPrice - ISNULL(CnfirmedPrice, 0) AS Diff, SectionId, ConfirmDocDate
FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1
WHERE  (YearNow = 1402) AND
       (SectionId = 11) AND
	   (ConfirmDocNo IS NULL) AND
	   (TypeCredit = 120)AND
	   (DeputyExecutive in (select id from @ExecuteId))
ORDER BY SectionId, RequestPrice desc--RequestDate
return
end
--تامین اعتباراتی که اقدامی صورت گرفته ولی هیچ تخصیصی صورت نگرفته است
if(@KindId = 2 and @AreaId in (1,2,3,4,5,6,7,8,11))
begin
SELECT        Tbl_Requsts_1.RequestRef, Tbl_Requsts_1.ConfirmDocNo, Tbl_Requsts_1.RequestRefStr, Tbl_Requsts_1.RequestDate, Tbl_Requsts_1.ReqDesc, Tbl_Requsts_1.RequestPrice, ISNULL(der_Performance.CnfirmedPrice, 0) 
                         AS CnfirmedPrice, Tbl_Requsts_1.RequestPrice - ISNULL(der_Performance.CnfirmedPrice, 0) AS Diff, Tbl_Requsts_1.SectionId, Tbl_Requsts_1.ConfirmDocDate
FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 LEFT OUTER JOIN
                             (SELECT        Tbl_Bodgets_1.TakhsisNumber, SUM(Tbl_Requsts_1.CnfirmedPrice) AS CnfirmedPrice
                               FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 INNER JOIN
                                                         TAN.PortalTamin.dbo.Tbl_Bodgets AS Tbl_Bodgets_1 ON Tbl_Requsts_1.BudgetIDKey = Tbl_Bodgets_1.id
                               WHERE  (Tbl_Bodgets_1.Year_mosavab = 1402) AND
							          (Tbl_Bodgets_1.TakhsisNumber IS NOT NULL) AND
									  (Tbl_Requsts_1.Request_WorkingStatus = 3)
                               GROUP BY Tbl_Bodgets_1.TakhsisNumber) AS der_Performance ON Tbl_Requsts_1.RequestRef = der_Performance.TakhsisNumber
WHERE  (Tbl_Requsts_1.SectionId = @AreaId) AND
       (Tbl_Requsts_1.ConfirmDocNo IS NOT NULL) AND
	   (Tbl_Requsts_1.YearNow = 1402) AND
	   (Tbl_Requsts_1.TypeCredit = 120)AND
	   (Tbl_Requsts_1.Request_WorkingStatus IN (1, 2)) AND 
       (ISNULL(der_Performance.CnfirmedPrice, 0) = 0)
ORDER BY Tbl_Requsts_1.SectionId, Tbl_Requsts_1.RequestPrice desc --Tbl_Requsts_1.RequestDate
return
end
if(@KindId = 2 and @AreaId = 10)
begin
SELECT        Tbl_Requsts_1.RequestRef,Tbl_Requsts_1.ConfirmDocNo, Tbl_Requsts_1.RequestRefStr,  Tbl_Requsts_1.RequestDate, Tbl_Requsts_1.ReqDesc, Tbl_Requsts_1.RequestPrice, isnull(der_Performance.CnfirmedPrice,0) as CnfirmedPrice, 
                         Tbl_Requsts_1.RequestPrice- isnull(der_Performance.CnfirmedPrice,0) as Diff,Tbl_Requsts_1.SectionId, Tbl_Requsts_1.ConfirmDocDate
FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 LEFT OUTER JOIN
                             (SELECT        Tbl_Bodgets_1.TakhsisNumber, SUM(Tbl_Requsts_1.CnfirmedPrice) AS CnfirmedPrice
                               FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 INNER JOIN
                                                         TAN.PortalTamin.dbo.Tbl_Bodgets AS Tbl_Bodgets_1 ON Tbl_Requsts_1.BudgetIDKey = Tbl_Bodgets_1.id
                               WHERE  (Tbl_Bodgets_1.Year_mosavab = 1402) AND
							          (Tbl_Bodgets_1.TakhsisNumber IS NOT NULL) AND
									  (Tbl_Requsts_1.Request_WorkingStatus = 3)
                               GROUP BY Tbl_Bodgets_1.TakhsisNumber) AS der_Performance ON Tbl_Requsts_1.RequestRef = der_Performance.TakhsisNumber
WHERE   (Tbl_Requsts_1.SectionId IN (1, 2, 3, 4, 5, 6, 7, 8, 11)) AND
        (Tbl_Requsts_1.ConfirmDocNo IS NOT NULL) AND
		(Tbl_Requsts_1.YearNow = 1402) AND
		 (Tbl_Requsts_1.TypeCredit = 120)AND
		(Tbl_Requsts_1.Request_WorkingStatus in (1,2)) AND 
        (isnull(der_Performance.CnfirmedPrice,0) = 0)
ORDER BY SectionId, Tbl_Requsts_1.RequestPrice desc--RequestDate
return
end
if(@KindId = 2 and @AreaId in (30,31,32,33,34,35,36,38))
begin
SELECT        Tbl_Requsts_1.RequestRef, Tbl_Requsts_1.ConfirmDocNo, Tbl_Requsts_1.RequestRefStr, Tbl_Requsts_1.RequestDate, Tbl_Requsts_1.ReqDesc, Tbl_Requsts_1.RequestPrice, ISNULL(der_Performance.CnfirmedPrice, 0) 
                         AS CnfirmedPrice, Tbl_Requsts_1.RequestPrice - ISNULL(der_Performance.CnfirmedPrice, 0) AS Diff, Tbl_Requsts_1.SectionId, Tbl_Requsts_1.ConfirmDocDate
FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 LEFT OUTER JOIN
                             (SELECT        Tbl_Bodgets_1.TakhsisNumber, SUM(Tbl_Requsts_1.CnfirmedPrice) AS CnfirmedPrice
                               FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 INNER JOIN
                                                         TAN.PortalTamin.dbo.Tbl_Bodgets AS Tbl_Bodgets_1 ON Tbl_Requsts_1.BudgetIDKey = Tbl_Bodgets_1.id
                               WHERE        (Tbl_Bodgets_1.Year_mosavab = 1402) AND (Tbl_Bodgets_1.TakhsisNumber IS NOT NULL) AND (Tbl_Requsts_1.Request_WorkingStatus = 3)
                               GROUP BY Tbl_Bodgets_1.TakhsisNumber) AS der_Performance ON Tbl_Requsts_1.RequestRef = der_Performance.TakhsisNumber
WHERE   (Tbl_Requsts_1.SectionId = 11) AND
        (Tbl_Requsts_1.ConfirmDocNo IS NOT NULL) AND
		(Tbl_Requsts_1.YearNow = 1402) AND
		(Tbl_Requsts_1.Request_WorkingStatus in (1,2)) AND
		(Tbl_Requsts_1.TypeCredit = 120) AND
		(ISNULL(der_Performance.CnfirmedPrice, 0) = 0) AND
		(Tbl_Requsts_1.DeputyExecutive in (select id from @ExecuteId))
ORDER BY Tbl_Requsts_1.SectionId, Tbl_Requsts_1.RequestPrice desc--Tbl_Requsts_1.RequestDate
return
end
--تامین اعتباراتی که اقدامی صورت گرفته ولی به اندازه تامین اعتبار پرداخت نشده است
if(@KindId = 3 and @AreaId  in (1,2,3,4,5,6,7,8))
begin
SELECT        Tbl_Requsts_1.RequestRef,Tbl_Requsts_1.ConfirmDocNo, Tbl_Requsts_1.RequestRefStr, Tbl_Requsts_1.RequestDate,  Tbl_Requsts_1.ReqDesc, Tbl_Requsts_1.RequestPrice, isnull(der_Performance.CnfirmedPrice,0) as CnfirmedPrice, 
                Tbl_Requsts_1.RequestPrice- isnull(der_Performance.CnfirmedPrice,0) as Diff , Tbl_Requsts_1.SectionId, Tbl_Requsts_1.ConfirmDocDate
FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 LEFT OUTER JOIN
                             (SELECT        Tbl_Bodgets_1.TakhsisNumber, SUM(Tbl_Requsts_1.CnfirmedPrice) AS CnfirmedPrice
                               FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 INNER JOIN
                                                         TAN.PortalTamin.dbo.Tbl_Bodgets AS Tbl_Bodgets_1 ON Tbl_Requsts_1.BudgetIDKey = Tbl_Bodgets_1.id
                               WHERE   (Tbl_Bodgets_1.Year_mosavab = 1402) AND
							           (Tbl_Bodgets_1.TakhsisNumber IS NOT NULL) AND
									   (Tbl_Requsts_1.Request_WorkingStatus = 3)
                               GROUP BY Tbl_Bodgets_1.TakhsisNumber) AS der_Performance ON Tbl_Requsts_1.RequestRef = der_Performance.TakhsisNumber
WHERE   (Tbl_Requsts_1.SectionId = @AreaId) AND
        (Tbl_Requsts_1.ConfirmDocNo IS NOT NULL) AND
		(Tbl_Requsts_1.YearNow = 1402) AND
		(Tbl_Requsts_1.TypeCredit = 120)AND
		(Tbl_Requsts_1.Request_WorkingStatus in (1,2)) AND 
		(isnull(der_Performance.CnfirmedPrice,0)<>0)AND
        (Tbl_Requsts_1.RequestPrice >isnull(der_Performance.CnfirmedPrice,0))
ORDER BY SectionId, Tbl_Requsts_1.RequestPrice desc--RequestDate
return
end
if(@KindId = 3 and @AreaId = 10)
begin
SELECT        Tbl_Requsts_1.RequestRef, Tbl_Requsts_1.ConfirmDocNo, Tbl_Requsts_1.RequestRefStr,Tbl_Requsts_1.RequestDate,  Tbl_Requsts_1.ReqDesc, Tbl_Requsts_1.RequestPrice, isnull(der_Performance.CnfirmedPrice,0) as CnfirmedPrice, 
               Tbl_Requsts_1.RequestPrice- isnull(der_Performance.CnfirmedPrice,0) as Diff, Tbl_Requsts_1.SectionId, Tbl_Requsts_1.ConfirmDocDate
FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 LEFT OUTER JOIN
                             (SELECT        Tbl_Bodgets_1.TakhsisNumber, SUM(Tbl_Requsts_1.CnfirmedPrice) AS CnfirmedPrice
                               FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 INNER JOIN
                                                         TAN.PortalTamin.dbo.Tbl_Bodgets AS Tbl_Bodgets_1 ON Tbl_Requsts_1.BudgetIDKey = Tbl_Bodgets_1.id
                               WHERE    (Tbl_Bodgets_1.Year_mosavab = 1402) AND
							            (Tbl_Bodgets_1.TakhsisNumber IS NOT NULL) AND
									    (Tbl_Requsts_1.Request_WorkingStatus = 3)
                               GROUP BY Tbl_Bodgets_1.TakhsisNumber) AS der_Performance ON Tbl_Requsts_1.RequestRef = der_Performance.TakhsisNumber
WHERE   (Tbl_Requsts_1.SectionId IN (1, 2, 3, 4, 5, 6, 7, 8, 11)) AND
        (Tbl_Requsts_1.ConfirmDocNo IS NOT NULL) AND
		(Tbl_Requsts_1.YearNow = 1402) AND
		(Tbl_Requsts_1.TypeCredit = 120)AND
		(Tbl_Requsts_1.Request_WorkingStatus in (1,2)) AND 
		(isnull(der_Performance.CnfirmedPrice,0)<>0)AND
        (Tbl_Requsts_1.RequestPrice >isnull(der_Performance.CnfirmedPrice,0))
ORDER BY SectionId, Tbl_Requsts_1.RequestPrice desc--RequestDate
return
end
if(@KindId = 3 and @AreaId  in (30,31,32,33,34,35,36,38))
begin
SELECT Tbl_Requsts_1.RequestRef, Tbl_Requsts_1.ConfirmDocNo, Tbl_Requsts_1.RequestRefStr, Tbl_Requsts_1.RequestDate, Tbl_Requsts_1.ReqDesc, Tbl_Requsts_1.RequestPrice, ISNULL(der_Performance.CnfirmedPrice, 0) 
                         AS CnfirmedPrice, Tbl_Requsts_1.RequestPrice - ISNULL(der_Performance.CnfirmedPrice, 0) AS Diff, Tbl_Requsts_1.SectionId, Tbl_Requsts_1.ConfirmDocDate
FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 LEFT OUTER JOIN
                             (SELECT        Tbl_Bodgets_1.TakhsisNumber, SUM(Tbl_Requsts_1.CnfirmedPrice) AS CnfirmedPrice
                               FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 INNER JOIN
                                                         TAN.PortalTamin.dbo.Tbl_Bodgets AS Tbl_Bodgets_1 ON Tbl_Requsts_1.BudgetIDKey = Tbl_Bodgets_1.id
                               WHERE        (Tbl_Bodgets_1.Year_mosavab = 1402) AND (Tbl_Bodgets_1.TakhsisNumber IS NOT NULL) AND (Tbl_Requsts_1.Request_WorkingStatus = 3)
                               GROUP BY Tbl_Bodgets_1.TakhsisNumber) AS der_Performance ON Tbl_Requsts_1.RequestRef = der_Performance.TakhsisNumber
WHERE   (Tbl_Requsts_1.SectionId = 11) AND
        (Tbl_Requsts_1.ConfirmDocNo IS NOT NULL) AND
		(Tbl_Requsts_1.YearNow = 1402) AND
		(Tbl_Requsts_1.Request_WorkingStatus in (1,2)) AND
		(Tbl_Requsts_1.TypeCredit = 120) AND
		(ISNULL(der_Performance.CnfirmedPrice, 0) <> 0) AND
		(Tbl_Requsts_1.RequestPrice > ISNULL(der_Performance.CnfirmedPrice, 0)) AND
		(Tbl_Requsts_1.DeputyExecutive in (select id from @ExecuteId))
ORDER BY Tbl_Requsts_1.SectionId, Tbl_Requsts_1.RequestPrice desc--Tbl_Requsts_1.RequestDate
return
end
--تامین اعتباراتی که اقدامی صورت گرفته ولی به بیشتر از تامین اعتبار پرداخت شده است
if(@KindId = 4 and @AreaId  in (1,2,3,4,5,6,7,8))
begin
SELECT        Tbl_Requsts_1.RequestRef, Tbl_Requsts_1.ConfirmDocNo, Tbl_Requsts_1.RequestRefStr,Tbl_Requsts_1.RequestDate,  Tbl_Requsts_1.ReqDesc, Tbl_Requsts_1.RequestPrice, isnull(der_Performance.CnfirmedPrice,0) as CnfirmedPrice, 
              Tbl_Requsts_1.RequestPrice- isnull(der_Performance.CnfirmedPrice,0) as Diff,Tbl_Requsts_1.SectionId, Tbl_Requsts_1.ConfirmDocDate
FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 LEFT OUTER JOIN
                             (SELECT        Tbl_Bodgets_1.TakhsisNumber, SUM(Tbl_Requsts_1.CnfirmedPrice) AS CnfirmedPrice
                               FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 INNER JOIN
                                                         TAN.PortalTamin.dbo.Tbl_Bodgets AS Tbl_Bodgets_1 ON Tbl_Requsts_1.BudgetIDKey = Tbl_Bodgets_1.id
                               WHERE  (Tbl_Bodgets_1.Year_mosavab = 1402) AND
							          (Tbl_Bodgets_1.TakhsisNumber IS NOT NULL) AND
									  (Tbl_Requsts_1.Request_WorkingStatus = 3)
                               GROUP BY Tbl_Bodgets_1.TakhsisNumber) AS der_Performance ON Tbl_Requsts_1.RequestRef = der_Performance.TakhsisNumber
WHERE   (Tbl_Requsts_1.SectionId = @AreaId) AND
        (Tbl_Requsts_1.ConfirmDocNo IS NOT NULL) AND
		(Tbl_Requsts_1.YearNow = 1402) AND
		(Tbl_Requsts_1.TypeCredit = 120)AND
		(Tbl_Requsts_1.Request_WorkingStatus in (1,2)) AND 
		(isnull(der_Performance.CnfirmedPrice,0)<>0)AND
        isnull(der_Performance.CnfirmedPrice,0) >Tbl_Requsts_1.RequestPrice 
ORDER BY SectionId, Tbl_Requsts_1.RequestPrice desc--RequestDate
return
end
if(@KindId = 4 and @AreaId = 10)
begin
SELECT        Tbl_Requsts_1.RequestRef, Tbl_Requsts_1.ConfirmDocNo, Tbl_Requsts_1.RequestRefStr,Tbl_Requsts_1.RequestDate,  Tbl_Requsts_1.ReqDesc, Tbl_Requsts_1.RequestPrice, isnull(der_Performance.CnfirmedPrice,0) as CnfirmedPrice, 
               Tbl_Requsts_1.RequestPrice- isnull(der_Performance.CnfirmedPrice,0) as Diff, Tbl_Requsts_1.SectionId, Tbl_Requsts_1.ConfirmDocDate
FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 LEFT OUTER JOIN
                             (SELECT        Tbl_Bodgets_1.TakhsisNumber, SUM(Tbl_Requsts_1.CnfirmedPrice) AS CnfirmedPrice
                               FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 INNER JOIN
                                                         TAN.PortalTamin.dbo.Tbl_Bodgets AS Tbl_Bodgets_1 ON Tbl_Requsts_1.BudgetIDKey = Tbl_Bodgets_1.id
                               WHERE  (Tbl_Bodgets_1.Year_mosavab = 1402) AND
							          (Tbl_Bodgets_1.TakhsisNumber IS NOT NULL) AND
									  (Tbl_Requsts_1.Request_WorkingStatus = 3)
                               GROUP BY Tbl_Bodgets_1.TakhsisNumber) AS der_Performance ON Tbl_Requsts_1.RequestRef = der_Performance.TakhsisNumber
WHERE   (Tbl_Requsts_1.SectionId IN (1, 2, 3, 4, 5, 6, 7, 8, 11)) AND
        (Tbl_Requsts_1.ConfirmDocNo IS NOT NULL) AND
		(Tbl_Requsts_1.YearNow = 1402) AND
        (Tbl_Requsts_1.TypeCredit = 120)AND
		(Tbl_Requsts_1.Request_WorkingStatus in (1,2)) AND 
		(isnull(der_Performance.CnfirmedPrice,0)<>0)AND
        isnull(der_Performance.CnfirmedPrice,0) >Tbl_Requsts_1.RequestPrice 
ORDER BY SectionId, Tbl_Requsts_1.RequestPrice desc--RequestDate
return
end
if(@KindId = 4 and @AreaId  in (30,31,32,33,34,35,36,38))
begin
SELECT        Tbl_Requsts_1.RequestRef, Tbl_Requsts_1.ConfirmDocNo, Tbl_Requsts_1.RequestRefStr, Tbl_Requsts_1.RequestDate, Tbl_Requsts_1.ReqDesc, Tbl_Requsts_1.RequestPrice, ISNULL(der_Performance.CnfirmedPrice, 0) 
                         AS CnfirmedPrice, Tbl_Requsts_1.RequestPrice - ISNULL(der_Performance.CnfirmedPrice, 0) AS Diff, Tbl_Requsts_1.SectionId, Tbl_Requsts_1.ConfirmDocDate
FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 LEFT OUTER JOIN
                             (SELECT        Tbl_Bodgets_1.TakhsisNumber, SUM(Tbl_Requsts_1.CnfirmedPrice) AS CnfirmedPrice
                               FROM            TAN.PortalTamin.dbo.Tbl_Requsts AS Tbl_Requsts_1 INNER JOIN
                                                         TAN.PortalTamin.dbo.Tbl_Bodgets AS Tbl_Bodgets_1 ON Tbl_Requsts_1.BudgetIDKey = Tbl_Bodgets_1.id
                               WHERE        (Tbl_Bodgets_1.Year_mosavab = 1402) AND (Tbl_Bodgets_1.TakhsisNumber IS NOT NULL) AND (Tbl_Requsts_1.Request_WorkingStatus = 3)
                               GROUP BY Tbl_Bodgets_1.TakhsisNumber) AS der_Performance ON Tbl_Requsts_1.RequestRef = der_Performance.TakhsisNumber
WHERE  (Tbl_Requsts_1.SectionId = 11) AND
       (Tbl_Requsts_1.ConfirmDocNo IS NOT NULL) AND
	   (Tbl_Requsts_1.YearNow = 1402) AND
	   (Tbl_Requsts_1.TypeCredit = 120)AND
	   (Tbl_Requsts_1.Request_WorkingStatus in (1,2)) AND
	   (ISNULL(der_Performance.CnfirmedPrice, 0) <> 0) AND
	   (ISNULL(der_Performance.CnfirmedPrice, 0) > Tbl_Requsts_1.RequestPrice) AND
	   (Tbl_Requsts_1.DeputyExecutive  in (select id from @ExecuteId))
ORDER BY Tbl_Requsts_1.SectionId, Tbl_Requsts_1.RequestPrice desc--Tbl_Requsts_1.RequestDate
return
end




END
GO
