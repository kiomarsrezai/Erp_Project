USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP006_Commite_Modal]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP006_Commite_Modal]
@CommiteKindId int ,
@YearId int
AS
BEGIN
SELECT        Id,dateS, Number 
FROM            tblCommite
WHERE        (YearId = 32) AND (CommiteKindId = 2)
END
GO
