USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_CodingNature_Com]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_CodingNature_Com]

AS
BEGIN
--SELECT        Id, CodingNatureName
--FROM            tblCodingNature

SELECT        Id, ProctorName as CodingNatureName
FROM            tblProctor

END
GO
