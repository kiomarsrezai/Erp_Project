USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[A_LastChanges]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[A_LastChanges]

@search nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select * from (
		SELECT 
		name AS ObjectName, 
		create_date AS CreatedDate, 
		modify_date AS ModifiedDate 
		FROM 
		sys.objects 
		WHERE 
		type = 'P'

		UNION ALL

		SELECT 
		name AS ObjectName, 
		create_date AS CreatedDate, 
		modify_date AS ModifiedDate 
		FROM 
		sys.tables 

		) as tmp where ObjectName like CONCAT('%',@search,'%')
		ORDER BY 
		ModifiedDate DESC;
END
GO
