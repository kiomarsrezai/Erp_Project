USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP001_BudgetModal3Area_Delete]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP001_BudgetModal3Area_Delete]
   @Id int
AS
BEGIN


    declare @isDelegateRecord int =(SELECT Id FROM tblBudgetDetailProjectAreaDelegate where CostRecordId = @Id or NiabatiRecordId = @Id)

    if (@isDelegateRecord is not null and @isDelegateRecord <> '')
begin
select 'این ردیف نیابتی است  و تنها از طریق تغییر ردیف بودجه نیابت دهنده قابل ویرایش می باشد' as Message_DB
    return
end


    declare @Count1 int = (select count(*) from tblRequestBudget where BudgetDetailProjectAreaId = @Id)
    if (@Count1 > 0)
begin
select 'از ردیف فوق در درخواستها استفاده شده است' as Message_DB
    return
end


-- delete naibat records if is niabati
    declare @NiabatiRecordId int=0 ,@CostRecordId int=0
SELECT @NiabatiRecordId = NiabatiRecordId, @CostRecordId = CostRecordId FROM tblBudgetDetailProjectAreaDelegate where BudgetDetailProjectAreaId = @Id
    if (@NiabatiRecordId > 0 and @CostRecordId > 0)
begin
delete from tblBudgetDetailProjectAreaDelegate where BudgetDetailProjectAreaId = @Id
delete from tblBudgetDetailProjectArea where id in (@NiabatiRecordId, @CostRecordId)
end


    delete tblBudgetDetailProjectAreaDepartment
    where BudgetDetailProjectAreaId = @Id

    delete tblBudgetDetailProjectArea
    where id = @Id
END
go

