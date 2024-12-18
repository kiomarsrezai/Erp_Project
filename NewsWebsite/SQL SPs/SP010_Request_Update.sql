USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP010_Request_Update]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP010_Request_Update]
@Id int,
@RequestKindId tinyint=NULL,
@DoingMethodId tinyint=NULL ,
@Description nvarchar(1000)=NULL,
@EstimateAmount bigint,
@SuppliersId int=NULL,
@ResonDoingMethod nvarchar(1000)=NULL
AS
BEGIN
   update tblRequest
   set RequestKindId = @RequestKindId,
         SuppliersId = @SuppliersId , 
       DoingMethodId = @DoingMethodId ,
         Description = @Description,
      EstimateAmount = @EstimateAmount,
    ResonDoingMethod = @ResonDoingMethod
	        where id = @Id

END
GO
