USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP050_Car_Search]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP050_Car_Search]

AS
BEGIN
SELECT        Car.tblCar.Id, Car.tblCar.Pelak, Car.tblCar.KindMotorId, Car.tblCar.KindId, Car.tblCar.SystemId, Car.tblCar.TipeId, Car.tblCar.Color, Car.tblCar.ProductYear, Car.tblCarKind.KindName, Car.tblCarSystem.SystemName, 
                         Car.tblCarTipe.TipeName
FROM            Car.tblCar LEFT OUTER JOIN
                         Car.tblCarTipe ON Car.tblCar.TipeId = Car.tblCarTipe.Id LEFT OUTER JOIN
                         Car.tblCarSystem ON Car.tblCar.SystemId = Car.tblCarSystem.Id LEFT OUTER JOIN
                         Car.tblCarKind ON Car.tblCar.KindId = Car.tblCarKind.Id
END
GO
