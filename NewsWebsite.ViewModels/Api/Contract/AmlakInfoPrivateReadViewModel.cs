using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class AmlakInfoPrivateReadViewModel
    {
        public int Id { get; set; }
        public int AreaId { get; set; }
        public int AmlakInfoKindId { get; set; }
        public string AreaName { get; set; }
        public string AmlakInfoKindName { get; set; }
        public string EstateInfoName { get; set; }
        public string EstateInfoAddress { get; set; }
        public string AmlakInfolate { get; set; }
        public string AmlakInfolong { get; set; }
        public string CodeUsing { get; set; }
        public int TotalContract { get; set; }
        public float? Masahat { get; set; }
        public bool? IsSubmited { get; set; }
        public bool? IsContracted { get; set; }
        public string TypeUsing { get; set; }
        public string CurrentStatus { get; set; } // AmlakInfoStatuses
        public string Structure { get; set; } // AmlakInfoStructures
        public string Owner { get; set; } // AmlakInfoOwners
        
    }

    public class LoginParamModelFromSdi
    {
        public string userId { get; set; }
        public string id { get; set; }
        public string title { get; set; }
        public string completed { get; set; }
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
