USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP050_Car_Update]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP050_Car_Update]
@Id int,
@Pelak nvarchar(20),
@KindMotorId tinyint,
@KindId int,
@SystemId int,
@TipeId int,
@Color nvarchar(20),
@ProductYear nvarchar(4)
AS
BEGIN
    update car.tblCar
	   set Pelak = @Pelak,
          KindId = @KindId ,
        SystemId = @SystemId ,
          TipeId = @TipeId ,
           Color = @Color ,
     ProductYear = @ProductYear
	    where Id = @Id
END
GO
