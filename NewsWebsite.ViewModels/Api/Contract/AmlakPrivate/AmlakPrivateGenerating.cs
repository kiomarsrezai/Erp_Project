﻿using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.ViewModels.Api.GeneralVm;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakPrivate {
    
    public class AmlakPrivateGeneratingBaseModel {
        public string MunicipalityActionRequired{ get; set; }
        public string MunicipalityAction{ get; set; } 
        public string MunicipalityActionLetterNumber{ get; set; } 
        public string LegalActionRequired{ get; set; }
        public string LegalAction{ get; set; }
        public string LegalActionLetterNumber{ get; set; }
        public string UrbanPlanningPermitRequired{ get; set; }
        public string UrbanPlanningPermitNumber{ get; set; }
        public string UrbanPlanningPermitDate{ get; set; }
        public string DocumentImage{ get; set; }
        public string ArchitecturalMapImage{ get; set; }
        public string SurveyMapImage{ get; set; }
        public string PermitImage{ get; set; }
        public string MoldReportImage{ get; set; }
        public string ActionHistory{ get; set; }
        public string FollowUpSentTo1{ get; set; }
        public string LetterNumber1{ get; set; }
        public string LetterDate1{ get; set; }
        public string FollowUpSentTo2{ get; set; }
        public string LetterNumber2{ get; set; }
        public string LetterDate2{ get; set; }
        public string FollowUpSentTo3{ get; set; }
        public string LetterNumber3{ get; set; }
        public string LetterDate3{ get; set; }
    }

    public class AmlakPrivateGeneratingListVm : AmlakPrivateGeneratingBaseModel {
        public int Id{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }
    }

    public class AmlakPrivateGeneratingReadVm : AmlakPrivateGeneratingBaseModel {
        public int Id{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }
    }

    public class AmlakPrivateGeneratingUpdateVm : AmlakPrivateGeneratingBaseModel {
        public int Id{ get; set; }
    }

    public class AmlakPrivateGeneratingStoreVm : AmlakPrivateGeneratingBaseModel {
        public int AmlakPrivateId{ get; set; }
    }


    public class AmlakPrivateGeneratingReadInputVm {
        public int? AmlakPrivateId{ get; set; }
        public int Page{ get; set; } = 1;
        public int PageRows{ get; set; } = 10;
        public string Sort{ get; set; }="Id";
        public string SortType{ get; set; }="desc";
    }
}