using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using Microsoft.AspNetCore.Http;
using NewsWebsite.Common;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.ViewModels.Api.Contract {
    
    public class BudgetLogBaseModel {
        public int Id{ get; set; }
        public int TargetId{ get; set; }
        public string TargetType{ get; set; }
        public string TargetTypeText{ get; set; }
        public string TargetUrlPrefix{ get; set; }
        public string DateFa{ get; set; }
        public int AdminId{ get; set; }
        public string Description{ get; set; }
        public string Coding{ get; set; }
        public string Url{ get; set; }
        public string Ip{ get; set; }
        public string Device{ get; set; }
    }

    public class BudgetLogListVm : BudgetLogBaseModel {
        public AdminVmBudget Admin{ get; set; }

    }
    public class AdminVmBudget{
        public string FirstName{ get; set; }
        public string LastName{ get; set; }
    }

    public class BudgetLogReadVm : BudgetLogBaseModel {
    }
    
    public class BudgetLogReadInputVm  {
        public string Description{ get; set; }
        public string Url{ get; set; }
        public string Coding{ get; set; }
        public int TargetType{ get; set; }
        public int TargetId{ get; set; }
        public int AdminId{ get; set; }
        public int Page{ get; set; } = 1;
        public int PageRows{ get; set; } = 10;
        public string Sort{ get; set; }="Id";
        public string SortType{ get; set; }="desc";
    }

    public class BudgetLogStoreResultVm {
        public int Id{ get; set; }
        public string Message{ get; set; }
    }

}