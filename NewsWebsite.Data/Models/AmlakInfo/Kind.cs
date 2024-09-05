using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models.AmlakInfo {
    [Table("tblAmlakInfoKind")]
    public class AmlakInfoKind {
        public int Id{ get; set; }
        public string AmlakInfoKindName{ get; set; }
        public int Rentable{ get; set; }
    }
    
    public static class AmlakInfoKindExtensions {

        public static IQueryable<AmlakInfoKind> Rentable(this IQueryable<AmlakInfoKind> query, int? value){
            return query.Where(e => e.Rentable == value);
        }
        
    }
}