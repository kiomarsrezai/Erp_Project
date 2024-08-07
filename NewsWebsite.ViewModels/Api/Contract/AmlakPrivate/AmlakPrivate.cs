using System.ComponentModel.DataAnnotations.Schema;

namespace NewsWebsite.ViewModels.Api.Contract.AmlakPrivate {
    [Table("tblAmlakPrivateNew")]
    public class AmlakPrivateNew {
        public int Id{ get; set; }
        public int AreaId{ get; set; }
        public string Masahat{ get; set; }
        public string Title{ get; set; }
        public string TypeUsing{ get; set; }
        public string SadaCode{ get; set; } 
        public string SdiId{ get; set; }
        public string Coordinates{ get; set; }
    }

    
    public class AmlakPrivateBaseModel {
        public int Id{ get; set; }
        public int AreaId{ get; set; }
        public float? Masahat{ get; set; }
        public string Title{ get; set; }
        public string TypeUsing{ get; set; }
        public string SadaCode{ get; set; } 
    }

    public class AmlakPrivateReadVm : AmlakPrivateBaseModel {
        public string SdiId{ get; set; }
        public string Coordinates{ get; set; }
    }

    public class AmlakPrivateUpdateVm : AmlakPrivateBaseModel {
    }


    public class AmlakPrivateReadInputVm {
        public int? AreaId{ get; set; }
    }


}