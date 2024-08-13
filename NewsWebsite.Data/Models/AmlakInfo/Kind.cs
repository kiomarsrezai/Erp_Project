using System.ComponentModel.DataAnnotations.Schema;

namespace NewsWebsite.Data.Models.AmlakInfo {
    [Table("tblAmlakInfoKind")]
    public class AmlakInfoKind {
        public int Id{ get; set; }
        public string AmlakInfoKindName{ get; set; }
    }
    
}