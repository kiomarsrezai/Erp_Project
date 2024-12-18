USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_AmlakPrivateNew_Insert]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_AmlakPrivateNew_Insert]
            @AreaId int ,
            @SdiId nvarchar(150),
            @Coordinates nvarchar(500),
            @Masahat float,
            @Title nvarchar(100),
            @TypeUsing nvarchar(50),
            @SadaCode nvarchar(50)
AS
BEGIN
declare @CountAmlakPrivateId int  = (SELECT COUNT(Id) AS Expr1 FROM tblAmlakPrivateNew WHERE (SdiId = @SdiId))

if (@CountAmlakPrivateId=0)
begin
    
	insert into tblAmlakPrivateNew ( AreaId,SdiId,Coordinates,Masahat,Title,TypeUsing,SadaCode)
	values(@AreaId,@SdiId,@Coordinates,@Masahat,@Title,@TypeUsing,@SadaCode)

return
end
END
GO
