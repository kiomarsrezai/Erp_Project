using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class SupplierAmlakInfoInsertDto
    {
        public string FirsrtName { get; set; }
        public string LastName { get; set; }
        public string Mobile { get; set; }
    }

    public class SupplierAmlakInfoUpdateDto
    {
        public int Id { get; set; }
        public string FirsrtName { get; set; }
        public string LastName { get; set; }
        public string Mobile { get; set; }

    }


}
