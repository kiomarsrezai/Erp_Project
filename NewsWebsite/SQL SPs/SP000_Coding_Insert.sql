-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP000_Coding_Insert]
@MotherId int ,
@code nvarchar(50),
@description nvarchar(1000),
@show bit,
@crud bit,
@levelNumber tinyint,
@BudgetProcessId tinyint,
@Scope int,
@Stability int,
@PublicConsumptionPercent int,
@PrivateConsumptionPercent int
AS
BEGIN

insert into tblCoding( MotherId ,  code ,  description , show  ,  crud , levelNumber , TblBudgetProcessId ,CodingKindId,Scope,Stability,PublicConsumptionPercent,PrivateConsumptionPercent)
values(@MotherId , @code , @description , @show , @crud ,@levelNumber ,@BudgetProcessId    ,  20       ,@Scope,@Stability,@PublicConsumptionPercent,@PrivateConsumptionPercent )


END
go

