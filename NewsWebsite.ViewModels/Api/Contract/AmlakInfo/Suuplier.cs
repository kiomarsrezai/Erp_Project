namespace NewsWebsite.ViewModels.Api.Contract.AmlakInfo {
    public class AmlakInfoSupplierBaseModel {
        public string FirstName{ get; set; }
        public string LastName{ get; set; }
        public string Mobile{ get; set; }
        public string CodePost{ get; set; }
        public string Address{ get; set; }
        public string NationalCode{ get; set; }
    }

    public class AmlakInfoSupplierInsertVm : AmlakInfoSupplierBaseModel {
    }

    public class AmlakInfoSupplierUpdateVm : AmlakInfoSupplierBaseModel {
        public int Id{ get; set; }
    }
    public class AmlakInfoSupplierContractReadVm : AmlakInfoSupplierBaseModel {
        public int Id{ get; set; }
    }
}