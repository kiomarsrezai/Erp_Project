USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_AmlakPrivate_Read]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_AmlakPrivate_Read]
@AmlakInfoId int
AS
BEGIN
SELECT        Id, Masahat, NumberGhorfe
FROM            tblAmlakPrivate
WHERE        (AmlakInfoId = @AmlakInfoId)
order by NumberGhorfe
END
GO
