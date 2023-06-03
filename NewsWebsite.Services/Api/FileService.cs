using Microsoft.AspNetCore.Http;
using NewsWebsite.Entities;
using NewsWebsite.ViewModels.Api.UploadFile;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using static NewsWebsite.Common.FileExtensions;
using System.Threading.Tasks;
using NewsWebsite.Data.Contracts;
using System.Linq;
using Microsoft.EntityFrameworkCore;

namespace NewsWebsite.Services.Api
{
    public class FileService:IFileService
    {
        public readonly IUnitOfWork _uw;

        public FileService(IUnitOfWork uw)
        {
            _uw = uw;
        }

        public async Task PostFileAsync(int projectId,IFormFile fileData, FileType fileType)
        {
            try
            {
                var fileDetails = new FileDetail()
                {
                    ID = projectId,
                    FileName = fileData.FileName,
                };

                using (var stream = new MemoryStream())
                {
                    fileData.CopyTo(stream);
                }

                var result = _uw._Context.FileDetails.Add(fileDetails);
                await _uw._Context.SaveChangesAsync();
            }
            catch (Exception)
            {
                throw;
            }
        }


        //public async Task DownloadFileById(int Id)
        //{
        //    try
        //    {
        //        var file = _uw._Context.FileDetails.Where(x => x.ID == Id).FirstOrDefaultAsync();

        //        var content = new System.IO.MemoryStream(file.Result.FileName);
        //        var path = Path.Combine(
        //           Directory.GetCurrentDirectory(), "FileDownloaded",
        //           file.Result.FileName);

        //        await CopyStream(content, path);
        //    }
        //    catch (Exception)
        //    {
        //        throw;
        //    }
        //}

        public async Task CopyStream(Stream stream, string downloadPath)
        {
            using (var fileStream = new FileStream(downloadPath, FileMode.Create, FileAccess.Write))
            {
                await stream.CopyToAsync(fileStream);
            }
        }
    }
}
