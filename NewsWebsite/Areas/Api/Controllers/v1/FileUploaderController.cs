using Microsoft.AspNetCore.Mvc;
using System;
using System.IO;
using System.Net.Http.Headers;

namespace FileUploadAPI.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class FileUploadController : ControllerBase
    {
        // the HTTP post request. The Body size limit is disabled 
        [HttpPost, DisableRequestSizeLimit]
        [ActionName("Upload")]
        public IActionResult UploadFile(int projectId)
        {
            try
            {
                // 1. get the file form the request
                var postedFile = Request.Form.Files[0];
                // 2. set the file uploaded folder
                var uploadFolder = Path.Combine(Directory.GetCurrentDirectory(), "UploadedFiles",projectId.ToString());
                // 3. check for the file length, if it is more than 0 the save it
                if (postedFile.Length > 0)
                {
                    // 3a. read the file name of the received file
                    var fileName = ContentDispositionHeaderValue.Parse(postedFile.ContentDisposition)
                        .FileName.Trim('"');
                    // 3b. save the file on Path
                    var finalPath = Path.Combine(uploadFolder, fileName);
                    using (var fileStream = new FileStream(finalPath, FileMode.Create))
                    {
                        postedFile.CopyTo(fileStream);
                    }
                    return Ok($"با موفقیت بارگذاری شد");
                }
                else
                {
                    return BadRequest("فایل نامعتبرر است");
                }


            }
            catch (Exception ex)
            {
                return StatusCode(500, $"بارگذاری دارای خطای زیر است </br> {ex.Message}");
            }
        }
    }
}