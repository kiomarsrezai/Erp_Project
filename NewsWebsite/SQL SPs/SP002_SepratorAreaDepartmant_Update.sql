USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP002_SepratorAreaDepartmant_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP002_SepratorAreaDepartmant_Update]
@Id int,
@MosavabDepartment bigint
AS
BEGIN
   update tblBudgetDetailProjectAreaDepartment
   set MosavabDepartment = @MosavabDepartment
                where id = @Id
END
GO
