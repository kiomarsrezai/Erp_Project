using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.ViewModels.Api.GeneralVm;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakPrivate {
    
    public class AmlakPrivateGeneratingBaseModel {
        public int Decision{ get; set; }
        public string DecisionLetterNumber{ get; set; }
        public string DecisionLetterDate{ get; set; }
        public int MunicipalityActionRequired{ get; set; }
        public int MunicipalityAction{ get; set; } 
        public string MunicipalityActionLetterNumber{ get; set; } 
        public int LegalActionRequired{ get; set; }
        public string LegalAction{ get; set; }
        public string LegalActionLetterNumber{ get; set; }
        public int UrbanPlanningPermitRequired{ get; set; }
        public string UrbanPlanningPermitNumber{ get; set; }
        public string UrbanPlanningPermitDate{ get; set; }
        public string DocumentImage{ get; set; }
        public string ArchitecturalMapImage{ get; set; }
        public string SurveyMapImage{ get; set; }
        public string PermitImage{ get; set; }
        public string MoldReportImage{ get; set; }
        public int ActionHistory{ get; set; }
        public int FollowUpSentTo1{ get; set; }
        public string LetterNumber1{ get; set; }
        public string LetterDate1{ get; set; }
        public int FollowUpSentTo2{ get; set; }
        public string LetterNumber2{ get; set; }
        public string LetterDate2{ get; set; }
        public int FollowUpSentTo3{ get; set; }
        public string LetterNumber3{ get; set; }
        public string LetterDate3{ get; set; }
    }

    public class AmlakPrivateGeneratingListVm : AmlakPrivateGeneratingBaseModel {
        public int Id{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }
        public AmlakPrivateListVm AmlakPrivate{ get; set; }
    }

    public class AmlakPrivateGeneratingReadVm : AmlakPrivateGeneratingBaseModel {
        public int Id{ get; set; }
        public string UrbanPlanningPermitDateFa{ get; set; }
        public string LetterDate1Fa{ get; set; }
        public string LetterDate2Fa{ get; set; }
        public string LetterDate3Fa{ get; set; }
        public string DecisionLetterDateFa{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }
        public AmlakPrivateListVm AmlakPrivate{ get; set; }

    }

    public class AmlakPrivateGeneratingUpdateVm : AmlakPrivateGeneratingBaseModel {
        public int Id{ get; set; }
    }

    public class AmlakPrivateGeneratingStoreVm : AmlakPrivateGeneratingBaseModel {
        public int AmlakPrivateId{ get; set; }
    }


    public class AmlakPrivateGeneratingReadInputVm {
        public int? AreaId{ get; set; }
        public string MainPlateNumber{ get; set; }
        public string SubPlateNumber{ get; set; }
        public int? Decision{ get; set; }
        
        public int? AmlakPrivateId{ get; set; }
        public int Page{ get; set; } = 1;
        public int PageRows{ get; set; } = 10;
        public string Sort{ get; set; }="Id";
        public string SortType{ get; set; }="desc";
        public int ForMap{ get; set; } = 0;
    }
}
