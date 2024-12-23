USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetCodingMainModal]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetCodingMainModal] 
@BudgetProcessId tinyint,
@yearId int,
@areaId int
AS
BEGIN
if(@BudgetProcessId =1)
begin
		 SELECT        Id, Code, Description, levelNumber
	           FROM            tblCoding
	            WHERE        (TblBudgetProcessId = 1) and (levelNumber in (2,3,4,5)) and ( Code not like '0%')
return
end

if(@BudgetProcessId =2)
begin
		 SELECT        Id, Code, Description, levelNumber
	           FROM            tblCoding
	            WHERE        (TblBudgetProcessId = 2) and (levelNumber in (3,4,5))
return
end

if(@BudgetProcessId =3)
begin
		 SELECT        Id, Code, Description, levelNumber
	           FROM            tblCoding
	            WHERE        (TblBudgetProcessId = 3) and (levelNumber in (4,5,6))
return
end

if(@BudgetProcessId =4)
begin
		 SELECT        Id, Code, Description, levelNumber
	           FROM            tblCoding
	            WHERE        (TblBudgetProcessId = 4) 
return
end


if(@BudgetProcessId =5)
begin
		 SELECT        Id, Code, Description, levelNumber
	           FROM            tblCoding
	            WHERE        (TblBudgetProcessId = 5) 
return
end

if(@BudgetProcessId =8)
begin
		 SELECT        Id, Code, Description, levelNumber
	           FROM            tblCoding
	            WHERE        (TblBudgetProcessId = 8) 
return
end

if(@BudgetProcessId =9)
begin
		 SELECT        Id, Code, Description, levelNumber
	           FROM            tblCoding
	            WHERE        (TblBudgetProcessId = 9) 
				order by Code
return
end

if(@BudgetProcessId =10)
begin
SELECT        Id, Code, Description, levelNumber
FROM            tblCoding
WHERE        (TblBudgetProcessId = 10)
order by Code
    return
end

if(@BudgetProcessId =11)
begin
SELECT        Id, Code, Description, levelNumber
FROM            tblCoding
WHERE        (TblBudgetProcessId = 11)
order by Code
    return
end
END
GO
