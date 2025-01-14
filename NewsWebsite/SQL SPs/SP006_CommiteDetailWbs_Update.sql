USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP006_CommiteDetailWbs_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP006_CommiteDetailWbs_Update]
@Id int ,
@Description nvarchar(2000), 
@DateStart date,
@DateEnd date
AS
BEGIN
     update tblCommiteDetailWbs
	 set       Description = @Description ,
			     DateStart = @DateStart ,
		           DateEnd = @DateEnd
				  where Id = @Id
END
GO
