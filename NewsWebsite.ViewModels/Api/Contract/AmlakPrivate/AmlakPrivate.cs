using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.GeneralVm;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakPrivate {
    
    public class AmlakPrivateBaseModel {
        public int Id{ get; set; }
        public int AreaId{ get; set; }
        public int OwnerId{ get; set; }
        public string Title{ get; set; }
        public string PredictionUsage{ get; set; }
        public string SadaCode{ get; set; } 
        public string JamCode{ get; set; } 
        public double Masahat{ get; set; }
        public int DocumentType{ get; set; }
        public string MainPlateNumber { get; set; }
        public string SubPlateNumber { get; set; }
        public string PropertyType { get; set; }
        public string UsageUrban { get; set; }
    }

    public class AmlakPrivateListVm : AmlakPrivateBaseModel {
        public string SdiId{ get; set; }
        public string Section{ get; set; }
        public string DocumentTypeText{ get; set; }
        public string Coordinates{ get; set; }
        public string OwnershipValue{ get; set; }
        public string OwnershipValueTotal{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }

        public AmlakPrivateDocHistoryVm LastDocHistory{ get; set; }
        public AmlakPrivateDocHistoryVm LastDocHistoryPossession{ get; set; }
        public AreaViewModel Area{ get; set; }
        public AreaViewModel Owner{ get; set; }
    }

    public class AmlakPrivateReadVm : AmlakPrivateBaseModel {
        public string SdiId{ get; set; }
        public string Coordinates{ get; set; }
        public string SimakCode { get; set; }
        public string Section { get; set; }
        public string Address { get; set; }
        public string UsageOnDocument { get; set; }
        public string OwnershipType { get; set; }
        public string OwnershipValueType { get; set; }
        public double OwnershipValue { get; set; }
        public int OwnershipValueTotal { get; set; }
        public string TransferredFrom { get; set; }
        public int InPossessionOf { get; set; }
        public string InPossessionOfOther { get; set; }
        public string BlockedStatusSimakUnitWindow { get; set; }
        public string Status { get; set; }
        public string Notes { get; set; }
        public string ArchiveLocation { get; set; }
        public string DocumentSerial { get; set; }
        public string DocumentSeries { get; set; }
        public string DocumentAlphabet { get; set; }
        public string PropertyCode { get; set; }
        public string Year { get; set; }
        public string EntryDate { get; set; }
        public DateTime? InternalDate { get; set; }
        public string InternalDateFa { get; set; }
        public DateTime? DocumentDate { get; set; }
        public string DocumentDateFa { get; set; }
        public int LatestGeneratingDecision { get; set; }
        public string LatestGeneratingDecisionText { get; set; }
        public int BuildingStatus { get; set; }
        public int BuildingMasahat { get; set; }
        public int BuildingFloorsNumber { get; set; }
        public int BuildingUsage { get; set; }
        public string MeterNumberGas { get; set; }
        public string MeterNumberWater { get; set; }
        public string MeterNumberElectricity { get; set; }
        public string MeterNumberPhone { get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }

        public AreaViewModel Area{ get; set; }
        public AreaViewModel Owner{ get; set; }
    }

    public class AmlakPrivateUpdateVm : AmlakPrivateBaseModel {
        public string SimakCode { get; set; }
        public string Section { get; set; }
        public string Address { get; set; }
        public string UsageOnDocument { get; set; }
        public string OwnershipType { get; set; }
        public string OwnershipValueType { get; set; }
        public double OwnershipValue { get; set; }
        public int OwnershipValueTotal { get; set; }
        public string TransferredFrom { get; set; }
        public int InPossessionOf { get; set; }
        public string InPossessionOfOther { get; set; }
        public string BlockedStatusSimakUnitWindow { get; set; }
        public string Status { get; set; }
        public string Notes { get; set; }
        public string ArchiveLocation { get; set; }
        public string DocumentSerial { get; set; }
        public string DocumentSeries { get; set; }
        public string DocumentAlphabet { get; set; }
        public string PropertyCode { get; set; }
        public string Year { get; set; }
        public string InternalDate { get; set; }
        public string DocumentDate { get; set; }
        public int BuildingStatus { get; set; }
        public int BuildingMasahat { get; set; }
        public int BuildingFloorsNumber { get; set; }
        public int BuildingUsage { get; set; }
        public string MeterNumberGas { get; set; }
        public string MeterNumberWater { get; set; }
        public string MeterNumberElectricity { get; set; }
        public string MeterNumberPhone { get; set; }
    }

    public class AmlakPrivateUpdateNoteVm  {
        public int Id{ get; set; }
        public string Notes{ get; set; }

    }


    public class AmlakPrivateReadInputVm {
        public int? AreaId{ get; set; }
        public int? OwnerId{ get; set; }
        public string UsageUrban{ get; set; }
        public double MasahatFrom{ get; set; }
        public double MasahatTo{ get; set; }
        public int? DocumentType{ get; set; }
        public string SadaCode{ get; set; }
        public string JamCode{ get; set; }
        public string MainPlateNumber{ get; set; }
        public string SubPlateNumber{ get; set; }
        public string MultiplePlates{ get; set; }
        public int? PropertyType{ get; set; }
        public int? LatestGeneratingDecision{ get; set; }
        public int? IsSubmitted{ get; set; }
        public int? IsTransfered{ get; set; }
        public int? HasSdiLayer{ get; set; }
        public int ForMap{ get; set; } = 0;
        public int Export{ get; set; } = 0;
        public int ExportKMZ{ get; set; } = 0;
        public int Page{ get; set; } = 1;
        public int PageRows{ get; set; } = 10;
        public string Search{ get; set; }
        public string Sort{ get; set; }="Id";
        public string SortType{ get; set; }="desc";
    }


    public class AreaVm {
        public int Id { get; set; }
        public string AreaName { get; set; }
    }

}
