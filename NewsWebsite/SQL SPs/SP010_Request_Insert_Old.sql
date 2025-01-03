USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP010_Request_Insert_Old]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP010_Request_Insert_Old]
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
						                     FROM            tblRequest
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

insert into tblRequest( YearId , AreaId, DepartmentId, Employee, UserId, DoingMethodId, Number    ,  Date   , RequestKindId, Description, EstimateAmount, SuppliersId, ResonDoingMethod)
                values( @yearId,@AreaId,@DepartmentId,@Employee,@UserId,@DoingMethodId,@NewNumber ,GetDate(),@RequestKindId,@Description,@EstimateAmount,@SuppliersId,@ResonDoingMethod)

SELECT        tblRequest.Id, tblRequest.YearId, tblRequest.AreaId, tblRequest.DepartmentId, tblRequest.Date, tblRequest.Employee, tblRequest.DoingMethodId, tblRequest.Number, tblRequest.RequestKindId, tblRequest.SuppliersId, 
                         tblRequest.Description, tblRequest.EstimateAmount, tblRequest.ResonDoingMethod, tblRequest.UserId, tblSuppliers.SuppliersName
FROM            tblRequest LEFT OUTER JOIN
                         tblSuppliers ON tblRequest.SuppliersId = tblSuppliers.id
WHERE        (tblRequest.Id = SCOPE_IDENTITY())


END



																						
GO
