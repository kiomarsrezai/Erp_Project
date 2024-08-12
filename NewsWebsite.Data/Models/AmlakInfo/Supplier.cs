using System.ComponentModel.DataAnnotations.Schema;
using NewsWebsite.ViewModels.Api.Public;

namespace NewsWebsite.Data.Models.AmlakInfo {
    [Table("tblSuppliers")]
    public class Supplier :BaseModel{
        public string FirstName{ get; set; }
        public string LastName{ get; set; }
        public string NationalCode{ get; set; }
        public string Mobile{ get; set; }
        public string CodePost{ get; set; }
        public string Address{ get; set; }
    }
    
}