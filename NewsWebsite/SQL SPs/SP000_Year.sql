USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP000_Year]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP000_Year]
@KindId tinyint
AS
BEGIN
if(@KindId = 1)
begin
	SELECT        Id, YearName
	FROM            TblYears
	WHERE        (Id IN (31,32, 33,34,35)) -- 23,24,25,26,27,28,29,30
return
end

if(@KindId = 2)
begin
	SELECT        Id, YearName
	FROM            TblYears
	WHERE        id between 31  and 35   -- 18-34
return
end

END
GO
