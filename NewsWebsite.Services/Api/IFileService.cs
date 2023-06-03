using Microsoft.AspNetCore.Http;
using NewsWebsite.ViewModels.Api.UploadFile;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using static NewsWebsite.Common.FileExtensions;

namespace NewsWebsite.Services.Api
{
    public interface IFileService
    {
        public Task PostFileAsync(int projectId, IFormFile fileData, FileType fileType);

       // public Task DownloadFileById(int fileName);
    }
}
