USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP012_Contract_Update]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP012_Contract_Update]
@Id int,
@Number nvarchar(50),
@areaId int,
@Date date,
@Description nvarchar(300),
@SuppliersId int,
@DateFrom   date,
@DateEnd  date,
@Amount bigint,
@DoingMethodId int,
@Type int,
@CodeBaygani nvarchar(50),
@ModatType nvarchar(50),
@ModatValue nvarchar(50),
@RequestID int,
@Zemanat_Number nvarchar(50),
@Zemanat_Price bigint,
@Zemanat_Date nvarchar(10),
@Zemanat_Bank nvarchar(50),
@Zemanat_Shobe nvarchar(50),
@Zemanat_ModatValue nvarchar(50),
@Zemanat_ModatType nvarchar(50),
@Zemanat_EndDate nvarchar(50),
@Zemanat_Type nvarchar(50)
AS
BEGIN
UPDATE       tblContract
SET                Number = @Number, Date = @Date, Description = @Description, SuppliersId = @SuppliersId, DateFrom = @DateFrom, DateEnd = @DateEnd, Amount = @Amount, DoingMethodId = @DoingMethodId, Type = 2, 
                         CodeBaygani = @CodeBaygani, ModatType = @ModatType, ModatValue = @ModatValue, RequestID = @RequestID, Zemanat_Number = @Zemanat_Number, Zemanat_Price = @Zemanat_Price, 
                         Zemanat_Date = @Zemanat_Date, Zemanat_Bank = @Zemanat_Bank, Zemanat_Shobe = @Zemanat_Shobe, Zemanat_ModatType = @Zemanat_ModatType, Zemanat_ModatValue = @Zemanat_ModatValue, 
                         Zemanat_EndDate = @Zemanat_EndDate, Zemanat_Type = @Zemanat_Type
	  where id = @Id
END
GO
