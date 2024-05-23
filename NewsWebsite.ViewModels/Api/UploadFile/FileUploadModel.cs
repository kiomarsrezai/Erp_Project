using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Text;

namespace NewsWebsite.ViewModels.Api.UploadFile
{
    public class FileUploadModel
    {
        public int ProjectId { get; set; }
        public IFormFile FormFile { get; set; }
    }

    

    public class FileUploadContractAmlakModel
    {
        public int Id { get; set; }
        public IFormFile FormFile { get; set; }
    }

}
