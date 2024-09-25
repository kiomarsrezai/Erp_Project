using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.ViewModels.Api.Contract.AmlakInfo;
using NewsWebsite.ViewModels.Api.GeneralVm;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakInfo {
    
    
    public class AmlakInfoBaseModel {
        public int Id{ get; set; }
        public int AreaId{ get; set; }
        public bool? IsSubmited{ get; set; }
        public float? Masahat{ get; set; }
        public int AmlakInfoKindId{ get; set; }
        public string EstateInfoName{ get; set; }
        public string EstateInfoAddress{ get; set; }
        public string CurrentStatus{ get; set; } // AmlakInfoStatuses
        public string Structure{ get; set; } // AmlakInfoStructures
        public string Owner{ get; set; } // AmlakInfoOwners
    }

    public class AmlakInfoListVm : AmlakInfoBaseModel {
        public string AreaName{ get; set; }
        public string AmlakInfoKindName{ get; set; }
        public string AmlakInfolate{ get; set; }
        public string AmlakInfolong{ get; set; }
        public string CodeUsing{ get; set; }
        public int TotalContract{ get; set; }
        public bool? IsContracted{ get; set; }
        public string TypeUsing{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }

        public AmlakInfoKindVm AmlakInfoKind{ get; set; }
        public AreaViewModel Area{ get; set; }
    }

    public class AmlakInfoReadVm : AmlakInfoBaseModel {
        public string AreaName{ get; set; }
        public string AmlakInfoKindName{ get; set; }
        public string AmlakInfolate{ get; set; }
        public string AmlakInfolong{ get; set; }
        public string CodeUsing{ get; set; }
        public int TotalContract{ get; set; }
        public bool? IsContracted{ get; set; }
        public string TypeUsing{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }

        public AmlakInfoKindVm AmlakInfoKind{ get; set; }
        public AreaViewModel Area{ get; set; }
    }

    public class AmlakInfoUpdateVm : AmlakInfoBaseModel {
    }


    public class AmlakInfoReadInputVm {
        public int? AreaId{ get; set; }
        public int? AmlakInfoKindId{ get; set; }
        public int Rentable{ get; set; } = 1;
        public int ContractStatus{ get; set; } = 0;
        public string Search{ get; set; }
        
        public int ForMap{ get; set; } = 0;
        public int Export{ get; set; } = 0;
        public int Page{ get; set; } = 1;
        public int PageRows{ get; set; } = 10;
    }

    
    
    public class AmlakInfoReadContractVm : AmlakInfoBaseModel {
        public string TypeUsing{ get; set; }
    }
    

    public enum AmlakInfoStatuses {
        Rented,
        NotRented,
    }

    public enum AmlakInfoStructures {
        Sandwichpanel,
        Kaneks,
        Sonati,
        Felezi,
        Botoni,
    }

    public enum AmlakInfoOwners {
        Shahrdari,
        Sazman,
        RahShahrsazi,
        Others,
    }
}