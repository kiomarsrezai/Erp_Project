USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9900_Akh_TO_Olden_Then_Budget_401_402_Main_All]    Script Date: 12/9/2024 9:39:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9900_Akh_TO_Olden_Then_Budget_401_402_Main_All]
@Year int
AS
BEGIN

if(@Year = 1402)
begin
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 1
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 2
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 3
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 4
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 5
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 6
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 7
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 8
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 9
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 11
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 12
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 13
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 14
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 15
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 16
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 17
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 18
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 19
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 20
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 21
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 22
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 23
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 24
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 25
	Exec SP9900_Akh_TO_Olden_Then_Budget_1402_Main 26
	return
end

--if(@Year = 1401)
--begin
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 1
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 2
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 3
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 4
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 5
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 6
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 7
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 8
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 9
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 11
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 12
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 13
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 14
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 15
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 16
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 17
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 18
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 19
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 20
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 21
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 22
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 23
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 24
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 25
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 26
--	Exec SP9900_Akh_TO_Olden_Then_Budget_1401_Main 29
--	return
--end




END
GO
