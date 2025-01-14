USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_AmlakInfo_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_AmlakInfo_Update]
@Id int,
@AreaId int,
@AmlakInfoKindId tinyint,
@EstateInfoName nvarchar(150),
@EstateInfoAddress nvarchar(1000),
@IsSubmited bit,
@Masahat float,
@CurrentStatus nvarchar(20),
@Structure nvarchar(20),
@Owner nvarchar(20)
AS
BEGIN
UPDATE       tblAmlakInfo
SET                AreaId = @AreaId, AmlakInfoKindId = @AmlakInfoKindId, EstateInfoName = @EstateInfoName, EstateInfoAddress = @EstateInfoAddress, IsSubmited = @IsSubmited, Masahat = @Masahat,CurrentStatus=@CurrentStatus,Structure=@Structure,Owner=@Owner
WHERE        (Id = @Id)				 
END
GO
