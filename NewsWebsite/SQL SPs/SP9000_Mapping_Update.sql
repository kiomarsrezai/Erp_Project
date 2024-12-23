USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9000_Mapping_Update]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9000_Mapping_Update]
@Id int,
@areaId int,
@codeAcc nvarchar(500),
@titleAcc nvarchar(1500)
AS
BEGIN

if(@areaId <= 9)
begin
    update TblCodingsMapSazman
	  set CodeVasetShahrdari = @codeAcc ,
	                TitleAcc = @titleAcc
		            where id = @Id
return
end

if(@areaId >= 11)
begin
    update TblCodingsMapSazman
	  set CodeAcc = @codeAcc ,
	     TitleAcc = @titleAcc
		 where id = @Id
return
end

  
END
GO
