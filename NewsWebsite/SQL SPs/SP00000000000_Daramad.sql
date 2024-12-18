USE [ProgramBudDB]
GO
/****** Object:  StoredProcedure [dbo].[SP00000000000_Daramad]    Script Date: 12/9/2024 9:39:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP00000000000_Daramad]

AS
BEGIN
SELECT        tblIncomeMunicipalityOperationAvarez.ShSerialFish, tblIncomeMunicipalityOperationAvarez.ShenaseGhabz, tblIncomeMunicipalityOperationAvarez.ShenasePardakht, tblIncomeMunicipalityOperationAvarez.SDateSodoor, 
                         tblIncomeMunicipalityOperationAvarez.MDateSodoor, tblIncomeMunicipalityOperationAvarez.MablaghKol, tblIncomeMunicipalityOperationAvarez.MablaghSahmeSazman, 
                         tblIncomeMunicipalityOperationAvarez.MablaghSahmeBank, tblIncomeMunicipalityOperationAvarez.SDatePardakht, tblIncomeMunicipalityOperationAvarez.MDatePardakht, 
                         tblIncomeMunicipalityOperationAvarez.IdIncomeMunicipalityBaseBank, tblIncomeMunicipalityOperationAvarez.IdIncomeMunicipalityBaseChannelPardakht, tblIncomeMunicipalityOperationAvarez.IsHaveSanad_MD, 
                         tblIncomeMunicipalityOperationAvarez.IdIncomeMunicipalitySanad_MD, tblIncomeMunicipalityOperationAvarez.CDate, tblIncomeMunicipalityOperationAvarez.UDate, tblIncomeMunicipalityOperationAvarez.Simak_MalekName, 
                         tblIncomeMunicipalityOperationAvarez.Simak_TarikhePardakht, tblIncomeMunicipalityOperationAvarez.DBank_State, tblIncomeMunicipalityOperationAvarez.DBank_fld_Parvande, 
                         tblIncomeMunicipalityOperationAvarez.DBank_fld_Mablagh, tblIncomeMunicipalityOperationAvarez.DBank_Mablagh_Karmozd, tblIncomeMunicipalityOperationAvarez.DBank_fld_Noe_Pardakht, 
                         tblIncomeMunicipalityOperationAvarez.DBank_Onvan_ChannelType, tblIncomeMunicipalityOperationAvarez.DBank_fld_Tarikhe_Pardakht, tblIncomeMunicipalityOperationAvarez.DBank_fld_Tarikhe_Update, 
                         tblIncomeMunicipalityOperationAvarez.DBank_fld_Bank, tblIncomeMunicipalityOperationAvarez.DBank_Onvan_Bank, tblIncomeMunicipalityOperationAvarez.DBank_Id_Bank, 
                         tblIncomeMunicipalityOperationAvarez.DBank_fld_File_Code, tblIncomeMunicipalityOperationAvarez.DBank_fld_Noe_Avarez, 
                         tblIncomeMunicipalityOperationAvarez.IsTransferToAMJDataWareHose, tblIncomeMunicipalityOperationAvarez.IsHaveTreTasvieFactorForoosh, 
                         tblIncomeMunicipalityOperationAvarez.SDatePardakhtAvalieh, tblIncomeMunicipalityOperationAvarez.MDatePardakhtAvalieh, tblIncomeMunicipalityOperationAvarez.IdIncomeMunicipalityOperationAvarezType, 
                         tblIncomeMunicipalityOperationAvarez.MablaghePishDariaft, tblIncomeMunicipalityOperationAvarez.MabetafavoteMablaghePishDariaft, tblIncomeMunicipalityOperationAvarez.MablaghKasreHezarRial, 
                         tblIncomeMunicipalityOperationAvarez.MablaghBaghimandehHezarRial, tblIncomeMunicipalityOperationAvarez.Simak_SDateTarikheVosooleGhatie, tblIncomeMunicipalityOperationAvarez.Simak_MDateTarikheVosooleGhatie, 
                         tblIncomeMunicipalityOperationAvarez.Simak_ShYektaieMelk, tblIncomeMunicipalityOperationAvarez.Simak_PelakSabti, tblIncomeMunicipalityOperationAvarez.Simak_MalekCodeMeli, 
                         tblIncomeMunicipalityOperationAvarez.Simak_MalekMobileNo, tblIncomeMunicipalityOperationAvarez.EzafatAgain, tblIncomeMunicipalityOperationAvarez.KosooratAgain, 
                         tblIncomeMunicipalityOperationAvarez.Simak_ShenaseAll_A, tblIncomeMunicipalityOperationAvarez.IdIncomeMunicipalityOperationType, 
                         tblIncomeMunicipalityOperationAvarez.IdIncomeMunicipalityBaseNahvehePardakhtType_TempOfPer, tblIncomeMunicipalityOperationAvarez.IsAsMorediOperation, 
                         tblIncomeMunicipalityOperationAvarez.IdIncomeMunicipalityBaseStructDaramdAndSarfasl_VahedeTabea, tblIncomeMunicipalityOperationAvarez.IsAcceptedOperationOnIncome, 
                         tblIncomeMunicipalityOperationAvarez.IdIncomeMunicipalityBaseNahvehePardakht_TempOfPer, tblIncomeMunicipalityOperationAvarez.Simak_MDateTarikheSabteSystem, 
                         tblIncomeMunicipalityOperationAvarez.IdIncomeMunicipalityGhateiatInSimakType, tblIncomeMunicipalityOperationAvarez.Simak_SDateTarikheSabteSystem, 
                         tblIncomeMunicipalityOperationAvarez.IdIncomeMunicipalitySimak_BillStatus, tblIncomeMunicipalityOperationAvarez_Details.ShSerialFish AS Expr1, tblIncomeMunicipalityOperationAvarez_Details.MablaghDetail, 
                         tblIncomeMunicipalityOperationAvarez_Details.BaseStructDaramdAndSarfasl_Name
FROM            AKH.AccAMJ1004.dbo.tblIncomeMunicipalityOperationAvarez INNER JOIN
                         AKH.AccAMJ1004.dbo.tblIncomeMunicipalityOperationAvarez_Details ON tblIncomeMunicipalityOperationAvarez.Id = tblIncomeMunicipalityOperationAvarez_Details.IdIncomeMunicipalityOperationAvarez
WHERE        (tblIncomeMunicipalityOperationAvarez.IdSal_MD = 17)

END
GO
