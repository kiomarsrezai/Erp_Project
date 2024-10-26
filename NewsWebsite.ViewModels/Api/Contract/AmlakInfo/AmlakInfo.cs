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
        public int OwnerId{ get; set; }
        public int AreaId{ get; set; }
        public bool? IsSubmited{ get; set; }
        public double? Masahat{ get; set; }
        public int AmlakInfoKindId{ get; set; }
        public string EstateInfoName{ get; set; }
        public string EstateInfoAddress{ get; set; }
        public string CurrentStatus{ get; set; }
        public string Structure{ get; set; }
        public string OwnerType{ get; set; }
    }

    public class AmlakInfoListVm : AmlakInfoBaseModel {
        public string AreaName{ get; set; }
        public string AmlakInfoKindName{ get; set; }
        public string Coordinates{ get; set; }
        public string CodeUsing{ get; set; }
        public int TotalContract{ get; set; }
        public string TypeUsing{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }

        public AmlakInfoKindVm AmlakInfoKind{ get; set; }
        public AreaViewModel Area{ get; set; }
        public AreaViewModel Owner{ get; set; }
    }

    public class AmlakInfoReadVm : AmlakInfoBaseModel {
        public string AreaName{ get; set; }
        public int Rentable{ get; set; }
        public string AmlakInfoKindName{ get; set; }
        public string Coordinates{ get; set; }
        public string CodeUsing{ get; set; }
        public int TotalContract{ get; set; }
        public string TypeUsing{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }
        public bool IsContracted{ get; set; }

        public AmlakInfoKindVm AmlakInfoKind{ get; set; }
        public AreaViewModel Area{ get; set; }
        public AreaViewModel Owner{ get; set; }
    }

    public class AmlakInfoUpdateVm : AmlakInfoBaseModel {
    }


    public class AmlakInfoReadInputVm {
        public int? AreaId{ get; set; }
        public int? AmlakInfoKindId{ get; set; }
        public int Rentable{ get; set; } = 1;
        public int ContractStatus{ get; set; } = 0;
        public int ZemanatStatus{ get; set; } = 0;
        public string SupplierName{ get; set; }
        public int OwnerId{ get; set; }
        public string Search{ get; set; }
        
        public int ForMap{ get; set; } = 0;
        public int Export{ get; set; } = 0;
        public int Page{ get; set; } = 1;
        public int PageRows{ get; set; } = 10;
        public string Sort{ get; set; }="Id";
        public string SortType{ get; set; }="desc";
    }

    
    
    public class AmlakInfoReadContractVm : AmlakInfoBaseModel {
        public string TypeUsing{ get; set; }
    }
    
}