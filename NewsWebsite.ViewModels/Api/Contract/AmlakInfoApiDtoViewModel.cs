using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.Contract
{
    public class SupplierAmlakInfoInsertDto
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Mobile { get; set; }
        public string CodePost { get; set; }
        public string Address { get; set; }
        public string NationalCode { get; set; }
    }

    public class SupplierAmlakInfoUpdateDto
    {
        public int Id { get; set; }
        public string FirsrtName { get; set; }
        public string LastName { get; set; }
        public string Mobile { get; set; }
        public string CodePost { get; set; }
        public string Address { get; set; }
        public string NationalCode { get; set; }
    }

    public class AmlakInfoFileList
    {
        public int Id { get; set; }
        public string FileName { get; set; }
    }
    public class UploadContractAmlakFileDto
    {
        public int Id { get; set; }
        public IFormFile AttachFile { get; set; }
    }

    }
