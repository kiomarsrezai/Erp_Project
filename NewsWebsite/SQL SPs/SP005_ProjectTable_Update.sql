USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP005_ProjectTable_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP005_ProjectTable_Update]
@Id int,
@ProjectName nvarchar(500), 
@DateFrom date,
@DateEnd  date,
@AreaArray nvarchar(50),
@ProjectScaleId tinyint
AS
BEGIN
    update TblProjects
   set  ProjectName = @ProjectName , 
           DateFrom = @DateFrom,
            DateEnd = @DateEnd ,
          AreaArray = @AreaArray,
     ProjectScaleId = @ProjectScaleId
	       where id = @Id
END
GO
