using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;

namespace NewsWebsite.Common {
    public class UploadHelper {
        public static async Task<string> UploadFile(IFormFile file, string path,string extensions="jpg,jpeg,png,gif,bmp,pdf",int maxSizeMB=30){
            
            if (!CheckFileType(file, extensions))
                throw new ErrMessageException("فایل نامعتبر می باشد . پسوند های مجاز :  "+extensions);
            
            if (file.Length>maxSizeMB * 1024 * 1024)
                throw new ErrMessageException("حجم فایل بیشتر از "+maxSizeMB+" مگابایت مجاز نمی باشد.");
            
            string fileName;

            var extension = "." + file.FileName.Split('.')[file.FileName.Split('.').Length - 1];
            fileName = DateTime.Now.Ticks + extension; //Create a new Name for the file due to security reasons.
            var folderPath = Path.Combine("wwwroot", "Upload", path);

            if (!Directory.Exists(folderPath)){
                Directory.CreateDirectory(folderPath);
            }

            var pathfile = Path.Combine(folderPath, fileName);

            using var stream = new FileStream(pathfile, FileMode.Create);
            await file.CopyToAsync(stream);

            return fileName;
        }

        public static bool CheckFileType(IFormFile file, string extensions){
            if (file == null || string.IsNullOrEmpty(extensions)){
                return false;
            }
            
            var fileExtension = Path.GetExtension(file.FileName).ToLowerInvariant();

            var allowedExtensions = extensions.Split(',');
            foreach (var extension in allowedExtensions){
                if (fileExtension.Equals("."+extension.Trim().ToLowerInvariant(), StringComparison.OrdinalIgnoreCase)){
                    return true;
                }
            }

            return false;
        }

        
        public static bool DeleteFile(string fileName, string path){

            var folderPath = Path.Combine("wwwroot", "Upload", path);

            // if (!Directory.Exists(folderPath)){
            //     return true;
            //     Directory.CreateDirectory(folderPath);
            // }

            var pathfile = Path.Combine(folderPath, fileName);

            if (File.Exists(pathfile)){
                File.Delete(pathfile);
            }
            
            return true;
        }

        
    }
}