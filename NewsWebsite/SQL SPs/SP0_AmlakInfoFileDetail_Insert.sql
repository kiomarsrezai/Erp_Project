USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP0_AmlakInfoFileDetail_Insert]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP0_AmlakInfoFileDetail_Insert]
@FileName nvarchar(500),
@Title nvarchar(100),
@Type nvarchar(20),
@AmlakInfoId int 
AS
BEGIN

 INSERT INTO TblAmlakInfoAttachs
                         (FileName, AmlakInfoId,FileTitle,Type)
VALUES        (@FileName,@AmlakInfoId,@Title,@Type)


END
GO
