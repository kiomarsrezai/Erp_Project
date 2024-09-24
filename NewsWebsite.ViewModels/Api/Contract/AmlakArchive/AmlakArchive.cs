using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.AspNetCore.Http;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.GeneralVm;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakArchive {
    
    public class AmlakArchiveBaseModel {
        public int AreaId{ get; set; }
        public int OwnerId{ get; set; }
        public string ArchiveCode{ get; set; }
        public string AmlakCode{ get; set; }
        public string JamCode{ get; set; }
        public string Section{ get; set; }
        public string Plaque1{ get; set; }
        public string Plaque2{ get; set; }
    }

    public class AmlakArchiveListVm : AmlakArchiveBaseModel {
        public int Id{ get; set; }
        public int IsSubmitted{ get; set; }
        public string Coordinates{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }
        
        public AreaViewModel Area{ get; set; }
        public AreaViewModel Owner{ get; set; }
    }

    public class AmlakArchiveReadVm : AmlakArchiveBaseModel {
        public int Id{ get; set; }
        public string Description{ get; set; }
        public string Address{ get; set; }
        public int IsSubmitted{ get; set; }
        public string Coordinates{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }

         
        public AreaViewModel Area{ get; set; }
        public AreaViewModel Owner{ get; set; }

    }
    public class AmlakArchiveUpdateVm : AmlakArchiveBaseModel {
        public int Id{ get; set; }
        public string Address{ get; set; }
        public string Description{ get; set; }
    
    }
    public class AmlakArchiveReadInputVm  {
        public string ArchiveCode{ get; set; }
        public string AmlakCode{ get; set; }
        public int AreaId{ get; set; }
    }

    public class AmlakArchiveStoreResultVm {
        public int Id{ get; set; }
        public string Message{ get; set; }
    }

}