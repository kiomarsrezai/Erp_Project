USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP9999_Convert_BaseTables_ERP_To_Tamin]    Script Date: 08/10/1403 04:33:32 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP9999_Convert_BaseTables_ERP_To_Tamin]
--@BodgetId      nvarchar(50),
--@BodgetDesc    nvarchar(2000),
--@RequestDate   nvarchar(50),
--@RequestPrice  bigint,
--@ReqDesc       nvarchar(2000),
--@RequestRefStr nvarchar(2000),
--@SectionId int
AS
BEGIN

--انتقال تامین اعتبارات جاری شهرداری
insert into TAN.tblCoding (Id, MotherId, Code, Description, levelNumber, TblBudgetProcessId, Show, Crud, CodingPBBId, CodePBB, CodeVaset, ProctorId, ExecuteId, CodingKindId, CodeVasetTaminEtebarat, SubjectId, CodingNatureId, OnlyReport)
SELECT  Id, MotherId, Code, Description, levelNumber, TblBudgetProcessId, Show, Crud, CodingPBBId, CodePBB, CodeVaset, ProctorId, ExecuteId, CodingKindId, CodeVasetTaminEtebarat, SubjectId, CodingNatureId, OnlyReport
FROM tblCoding

END
