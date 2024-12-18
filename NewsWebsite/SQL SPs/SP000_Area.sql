USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP000_Area]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP000_Area]
@areaForm tinyint
AS
BEGIN

--@AreaForm = 1 فرم بودجه پیشنهادی
--@AreaForm = 2 بودجه تفکیکی
--@AreaForm = 3  فرم واسط سازمانها

if(@areaForm=1)
begin
SELECT        Id, AreaName,AreaNameShort
FROM            TblAreas
WHERE    id not in ( 38  ,45,46,47,48,49,50,51,52)
order by Id
    return
end

if(@areaForm=2)
begin
SELECT        Id, AreaName,AreaNameShort
FROM            TblAreas
WHERE        (Id NOT IN (10,27,28     ,38      ,45,46,47,48,49,50,51,52))
    return
end

if(@areaForm=3)
begin
SELECT        Id, AreaName,AreaNameShort
FROM            TblAreas
WHERE        (Id NOT IN (27,28     ,38    ,45,46,47,48,49,50,51,52))
    return
end

-- sazman ha
if(@areaForm=4)
begin
SELECT        Id, AreaName,AreaNameShort
FROM            TblAreas
WHERE        (Id IN (11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29))
    return
end



END
go

