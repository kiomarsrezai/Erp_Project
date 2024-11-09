using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.AspNetCore.Http;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Contract.AmlakInfo;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakAdmin {
    
    public class AmlakLogBaseModel {
        public int Id{ get; set; }
        public int TargetId{ get; set; }
        public string TargetType{ get; set; }
        public string TargetTypeText{ get; set; }
        public string TargetUrlPrefix{ get; set; }
        public string DateFa{ get; set; }
        public int AdminId{ get; set; }
        public string Description{ get; set; }
    }

    public class AmlakLogListVm : AmlakLogBaseModel {
        public AdminVm Admin{ get; set; }

    }
    public class AdminVm{
        public string FirstName{ get; set; }
        public string LastName{ get; set; }
    }

    public class AmlakLogReadVm : AmlakLogBaseModel {
    }
    
    public class AmlakLogReadInputVm  {
        public int TargetType{ get; set; }
        public int TargetId{ get; set; }
        public int AdminId{ get; set; }
        public int Page{ get; set; } = 1;
        public int PageRows{ get; set; } = 10;
        public string Sort{ get; set; }="Id";
        public string SortType{ get; set; }="desc";
    }

    public class AmlakLogStoreResultVm {
        public int Id{ get; set; }
        public string Message{ get; set; }
    }

}