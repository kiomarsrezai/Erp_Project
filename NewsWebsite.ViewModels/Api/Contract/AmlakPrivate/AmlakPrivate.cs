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
        public int Masahat{ get; set; }
        public string TypeUsing{ get; set; }
        public int DocumentType{ get; set; }
    }

    public class AmlakPrivateListVm : AmlakPrivateBaseModel {
        public string SdiId{ get; set; }
        public string Coordinates{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }

        public AreaViewModel Area{ get; set; }
        public AreaViewModel Owner{ get; set; }
    }

    public class AmlakPrivateReadVm : AmlakPrivateBaseModel {
        public string SdiId{ get; set; }
        public string Coordinates{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }

        public AreaViewModel Area{ get; set; }
        public AreaViewModel Owner{ get; set; }
    }

    public class AmlakPrivateUpdateVm : AmlakPrivateBaseModel {
    }


    public class AmlakPrivateReadInputVm {
        public int AreaId{ get; set; }
        public int OwnerId{ get; set; }
        public string TypeUsing{ get; set; }
        public int MasahatFrom{ get; set; }
        public int MasahatTo{ get; set; }
        public int DocumentType{ get; set; }
    }


    public class AreaVm {
        public int Id { get; set; }
        public string AreaName { get; set; }
    }

}
