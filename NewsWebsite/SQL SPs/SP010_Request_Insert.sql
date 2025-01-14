USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP010_Request_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP010_Request_Insert]
@yearId int,
@AreaId int,
@DepartmentId int,
@UserId int,
@RequestKindId tinyint=NULL,
@DoingMethodId tinyint =NULL,
@Description nvarchar(1000)=NULL,
@EstimateAmount bigint=0,
@SuppliersId int=NULL,
@ResonDoingMethod nvarchar(1000) = NULL
AS
BEGIN
     declare @YearNumber nvarchar(4)  = (select cast(YearName as nvarchar(4)) from TblYears where id = @yearId )
	 declare @AreaNumber nvarchar(2)  = (select AreaNumber from TblAreas where id = @AreaId )
	 declare @maxNumber  nvarchar(10) = (SELECT   max(Number)
						                     FROM            tblCredit
						                   WHERE YearId = @yearId AND
										         AreaId = @AreaId AND 
												 DepartmentId = @DepartmentId)
 declare @NewNumber nvarchar(20)
 declare @Employee nvarchar(50)=(select FirstName +' '+LastName from AppUsers where id = @UserId)

if(@maxNumber is null)
 begin
       set @NewNumber = (cast(@YearNumber as nvarchar(4))+
	                                      cast(@AreaNumber as nvarchar(4))+
										  cast(@DepartmentId as nvarchar(4))+
										  '0001')
 end
if(@maxNumber is not null)
 begin
       set @NewNumber = @maxNumber+1
 end

insert into tblCredit( YearId , AreaId, DepartmentId, Employee, UserId, DoingMethodId, Number    ,  Date   ,  Description, CreditAmount, SuppliersId, ResonDoingMethod)
                values( @yearId,@AreaId,@DepartmentId,@Employee,@UserId,@DoingMethodId,@NewNumber ,GetDate(),@Description,@EstimateAmount,@SuppliersId,@ResonDoingMethod)

SELECT        tblCredit.Id, tblCredit.YearId, tblCredit.AreaId, tblCredit.DepartmentId, tblCredit.Date, tblCredit.Employee, tblCredit.DoingMethodId, tblCredit.Number, tblCredit.SuppliersId, 
                         tblCredit.Description, tblCredit.CreditAmount, tblCredit.ResonDoingMethod, tblCredit.UserId, tblSuppliers.SuppliersName
FROM            tblCredit LEFT OUTER JOIN
                         tblSuppliers ON tblCredit.SuppliersId = tblSuppliers.id
WHERE        (tblCredit.Id = SCOPE_IDENTITY())
END
GO
