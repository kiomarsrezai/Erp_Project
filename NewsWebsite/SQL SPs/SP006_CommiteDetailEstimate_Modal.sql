USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP006_CommiteDetailEstimate_Modal]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP006_CommiteDetailEstimate_Modal]
@CommiteDetailId int
AS
BEGIN
  SELECT        Id, Description, Quantity, Price, Amount
FROM            tblCommiteDetailEstimate
WHERE        (CommiteDetailId = @CommiteDetailId)
END
GO
