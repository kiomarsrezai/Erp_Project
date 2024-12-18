USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_AmlakInfo_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_AmlakInfo_Insert]
@AreaId int ,
@AmlakInfoKindId tinyint,
@EstateInfoName nvarchar(150),
@EstateInfoAddress nvarchar(1000),
@AmlakInfolate nvarchar(50),
@AmlakInfolong nvarchar(50),
@AmlakInfoId nvarchar(50)
AS
BEGIN
declare @CountAmlakInfoId int  = (SELECT COUNT(AmlakInfoId) AS Expr1 FROM tblAmlakInfo WHERE (AmlakInfoId = @AmlakInfoId))

if (@CountAmlakInfoId=0)
begin
    
	insert into tblAmlakInfo ( AreaId , AmlakInfoKindId  , EstateInfoName , EstateInfoAddress,AmlakInfolate,AmlakInfolong,AmlakInfoId,IsSubmited)
	values(@AreaId , @AmlakInfoKindId ,@EstateInfoName ,@EstateInfoAddress,@AmlakInfolate,@AmlakInfolong,@AmlakInfoId,1)

return
end
END
GO
