using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.ViewModels.Api.Contract.AmlakInfo;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models.AmlakInfo {
    [Table("tblAmlakInfo")]
    public class AmlakInfo:BaseModel {
        public int Id{ get; set; }
        public int AreaId{ get; set; }
        public bool? IsSubmited{ get; set; }
        public double? Masahat{ get; set; }
        public int AmlakInfoKindId{ get; set; }
        public string EstateInfoName{ get; set; }
        public string EstateInfoAddress{ get; set; }
        public string CurrentStatus{ get; set; } // AmlakInfoStatuses
        public string Structure{ get; set; } // AmlakInfoStructures
        public string Owner{ get; set; } // AmlakInfoOwners
        public string AmlakInfolate{ get; set; }
        public string AmlakInfolong{ get; set; }
        public string CodeUsing{ get; set; }
        public bool? IsContracted{ get; set; }
        public string TypeUsing{ get; set; }
        public int Rentable{ get; set; } 
        
        public virtual  AmlakInfoKind AmlakInfoKind{ get; set; }
        public virtual  TblAreas Area{ get; set; }
        
        public ICollection<AmlakInfoContract> Contracts{ get; set; }
        
    }    

    

    public static class AmlakInfoExtensions {

        public static IQueryable<AmlakInfo> AreaId(this IQueryable<AmlakInfo> query, int? value){
            if (BaseModel.CheckParameter(value,0)){
                return query.Where(e => e.AreaId == value);
            }
            return query;
        }
    }
}