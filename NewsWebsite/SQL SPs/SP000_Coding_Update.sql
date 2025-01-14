-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP000_Coding_Update]
@id int,
@code nvarchar(50),
@description nvarchar(1000),
@show bit,
@crud bit,
@levelNumber tinyint,
@Scope int,
@Stability int,
@PublicConsumptionPercent int,
@PrivateConsumptionPercent int
AS
BEGIN
update tblCoding
set code = @code ,
    description = @description,
    show = @show,
    crud = @crud,
    levelNumber = @levelNumber,
    Scope = @Scope,
    Stability = @Stability,
    PublicConsumptionPercent = @PublicConsumptionPercent,
    PrivateConsumptionPercent = @PrivateConsumptionPercent
where      id = @id
END
go

