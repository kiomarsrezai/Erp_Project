using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.AspNetCore.Http;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;
using NewsWebsite.ViewModels.Api.GeneralVm;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakAdmin {
    
    public class AmlakAdminBaseModel {
        public string FirstName{ get; set; }
        public string LastName{ get; set; }
        public string UserName{ get; set; }
        public string PhoneNumber{ get; set; }
        public string Bio{ get; set; }
    }

    public class AmlakAdminListVm : AmlakAdminBaseModel {
        public int Id{ get; set; }
        public int IsActive{ get; set; }

        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }
        
    }

    public class AmlakAdminReadVm : AmlakAdminBaseModel {
        public int Id{ get; set; }
        public int IsActive{ get; set; }
        public string AmlakLisence{ get; set; }
        public string CreatedAtFa{ get; set; }
        public string UpdatedAtFa{ get; set; }
    }
    public class AmlakAdminStoreVm : AmlakAdminBaseModel {
        public string Password{ get; set; }

    }
    public class AmlakAdminUpdateVm : AmlakAdminBaseModel {
        public int Id{ get; set; }

    }
    public class AmlakAdminUpdateLicenseVm  {
        public int Id{ get; set; }
        public string AmlakLisence{ get; set; }

    }
    
    public class AmlakAdminActivationViewModel
    {
        public int Id { get; set; }
        public int isActive { get; set; }
    }
    public class AmlakAdminReadInputVm  {
        public string Search{ get; set; }

        public int Page{ get; set; } = 1;
        public int PageRows{ get; set; } = 10;
        public string Sort{ get; set; }="Id";
        public string SortType{ get; set; }="desc";
    }

    public class AmlakAdminLoginVm {
        public string UserName{ get; set; }
        public string Password{ get; set; }
        public string Remember{ get; set; }
    }
    
    public class AmlakAdminChangePasswordVm {
        public string Token{ get; set; }
        public string OldPassword{ get; set; }
        public string NewPassword{ get; set; }
    }

    public class AmlakAdminChangePasswordAdminVm {
        public int Id{ get; set; }
        public string NewPassword{ get; set; }
    }

    public class AmlakAdminStoreResultVm {
        public int Id{ get; set; }
        public string Message{ get; set; }
    }
    
    
    public class AmlakAdminTicket {
        public int Id{ get; set; }
        public string FirstName{ get; set; }
        public string LastName{ get; set; }
    }

}