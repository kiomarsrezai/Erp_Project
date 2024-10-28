using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.FileProviders;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Contract;
using NewsWebsite.ViewModels.Api.Public;
using Newtonsoft.Json;
using RestSharp;
using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Data;
using NewsWebsite.ViewModels;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Net;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Identity;
using NewsWebsite.Data.Models.AmlakAdmin;
using NewsWebsite.ViewModels.Api.Contract.AmlakAdmin;
using NewsWebsite.ViewModels.Api.Contract.AmlakPrivate;

namespace NewsWebsite.Areas.Api.Controllers.v1.amlak {
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class AmlakAdminApiController : EnhancedController {
        public readonly IConfiguration _config;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        protected readonly ProgramBuddbContext _db;

        public AmlakAdminApiController(IUnitOfWork uw, IConfiguration config, IWebHostEnvironment webHostEnvironment, ProgramBuddbContext db){
            _config = config;
            _uw = uw;
            _webHostEnvironment = webHostEnvironment;
            _db = db;
        }


        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------
        //-------------------------------------------------------------------------------------------------------------------------------------------


        [Route("List")]
        [HttpGet]
        public async Task<ApiResult<object>> AmlakAdminList(AmlakAdminReadInputVm param){
            await CheckUserAuth(_db);

            var builder = _db.AmlakAdmins
                .Search(param.Search);

            var pageCount = (int)Math.Ceiling((await builder.CountAsync())/Convert.ToDouble(param.PageRows));
            var items = await builder.OrderBy(param.Sort,param.SortType).Page2(param.Page, param.PageRows).ToListAsync();
            
            var finalItems = MyMapper.MapTo<AmlakAdmin, AmlakAdminListVm>(items);
        
            return Ok(new{items=finalItems,pageCount});
        }
        
        
          
        [Route("Read")]
        [HttpGet]
        public async Task<ApiResult<AmlakAdminReadVm>> AmlakAdminRead(PublicParamIdViewModel param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakAdmins.Id(param.Id)
                .FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");
            
            var finalItem = MyMapper.MapTo<AmlakAdmin, AmlakAdminReadVm>(item);
        
            return Ok(finalItem);
        }
        
        
        
        [Route("Create")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakAdminUpdate([FromBody] AmlakAdminStoreVm param){
            // await CheckUserAuth(_db);

            var item1 = await _db.AmlakAdmins.Where(c=>c.UserName==param.UserName).FirstOrDefaultAsync();
            if (item1 != null)
                return BadRequest("کاربر با این نام کاربری قبلا ثبت نام کرده است");

            var item = new AmlakAdmin();
            item.FirstName = param.FirstName;
            item.LastName = param.LastName;
            item.UserName = param.UserName;
            item.PhoneNumber = param.PhoneNumber;
            item.Bio = param.Bio;
            item.Password =new PasswordHasher<AmlakAdmin>().HashPassword(null, param.Password);
            item.CreatedAt = Helpers.GetServerDateTimeType();
            item.UpdatedAt = Helpers.GetServerDateTimeType();
             _db.Add(item);
            await _db.SaveChangesAsync();
        
            
            return Ok("با موفقیت انجام شد");
        }
        
        
        [Route("Update")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakAdminUpdate([FromBody] AmlakAdminUpdateVm param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakAdmins.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");

            item.FirstName = param.FirstName;
            item.LastName = param.LastName;
            item.UserName = param.UserName;
            item.PhoneNumber = param.PhoneNumber;
            item.Bio = param.Bio;
            item.UpdatedAt = Helpers.GetServerDateTimeType();
            await _db.SaveChangesAsync();
        
            return Ok("با موفقیت انجام شد");
        }
           
        [Route("UpdateLicense")]
        [HttpPost]
        public async Task<ApiResult<string>> AmlakAdminUpdateLicense([FromBody] AmlakAdminUpdateLicenseVm param){
            await CheckUserAuth(_db);

            var item = await _db.AmlakAdmins.Id(param.Id).FirstOrDefaultAsync();
            if (item == null)
                return BadRequest("پیدا نشد");

            item.AmlakLisence = param.AmlakLisence;
            item.UpdatedAt = Helpers.GetServerDateTimeType();
            await _db.SaveChangesAsync();
        
            return Ok("با موفقیت انجام شد");
        }
           
        
        [Route("Login")]
        [HttpPost]
        public async Task<ApiResult<object>> AmlakAdminLogin([FromBody] AmlakAdminLoginVm param){

            var admin = await _db.AmlakAdmins.Where(c=>c.UserName==param.UserName).FirstOrDefaultAsync();
            if (admin == null)
                return BadRequest("نام کاربری یا رمز عبور صحیح نمی باشد");

            
            
            var passVerifyResult = new PasswordHasher<AmlakAdmin>().VerifyHashedPassword(null, admin.Password, param.Password);
            if (passVerifyResult!=PasswordVerificationResult.Success){ // todo: check hash
                throw new ErrMessageException("رمز عبور صحیح نمی باشد", HttpStatusCode.NotFound);
            }


            // var claims = new[]{
            //     new Claim(ClaimTypes.NameIdentifier, admin.Id.ToString()), // Replace with the actual username
            //     new Claim(ClaimTypes.Name, admin.UserName), // Replace with the actual username
            //     new Claim(ClaimTypes.Email, "user@email.com"), // Replace with the actual email
            //     // Add any additional claims as needed
            // };
            //
            // var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
            // var authProperties = new AuthenticationProperties{
            //     IsPersistent = true, // Set to true if you want to persist the cookie across sessions
            //     ExpiresUtc =param.Remember == "true" ? DateTime.UtcNow.AddDays(30):DateTime.UtcNow.AddHours(4),
            // };
            //
            // HttpContext.SignInAsync(
            //     CookieAuthenticationDefaults.AuthenticationScheme,
            //     new ClaimsPrincipal(claimsIdentity),
            //     authProperties);

            var adminData = new{
                Id=admin.Id,
                FirstName=admin.FirstName,
                LastName=admin.LastName,
                UserName=admin.UserName,
                Bio=admin.Bio,
                AmlakLisence=admin.AmlakLisence,
                Token=Helpers.GenerateToken(),
            };

            // todo set expire token date
            admin.Token = adminData.Token;
            await _db.SaveChangesAsync();
            
            return Ok(adminData);
        }
        
        [Route("ChangePassword")]
        [HttpPost]
        public async Task<ApiResult<object>> AmlakAdminChangePasword([FromBody] AmlakAdminChangePasswordVm param){

            if (string.IsNullOrEmpty(param.Token)){
                return BadRequest("UnAuthenticated");
            }
            
            var admin = await _db.AmlakAdmins.Where(c=>c.Token==param.Token).FirstOrDefaultAsync();
            if (admin == null)
                return BadRequest("کاربر یافت نشد");

            
            var passVerifyResult = new PasswordHasher<AmlakAdmin>().VerifyHashedPassword(null, admin.Password, param.OldPassword);
            if (passVerifyResult!=PasswordVerificationResult.Success){ // todo: check hash
                throw new ErrMessageException("رمز عبور صحیح نمی باشد", HttpStatusCode.NotFound);
            }

            admin.Token = Helpers.GenerateToken();
            admin.TokenExpireDate = DateTime.Now.AddDays(1);
            admin.Password =new PasswordHasher<AmlakAdmin>().HashPassword(null, param.NewPassword);
            await _db.SaveChangesAsync();
            
            return Ok(admin.Token);
        }
           
        [Route("ChangePasswordAdmin")]
        [HttpPost]
        public async Task<ApiResult<object>> AmlakAdminChangePaswordAdmin([FromBody] AmlakAdminChangePasswordAdminVm param){

            var admin = await _db.AmlakAdmins.Where(c=>c.Id==param.Id).FirstOrDefaultAsync();
            if (admin == null)
                return BadRequest("کاربر یافت نشد");

            admin.Token = "";
            admin.TokenExpireDate = null;
            admin.Password =new PasswordHasher<AmlakAdmin>().HashPassword(null, param.NewPassword);
            await _db.SaveChangesAsync();
            
            return Ok(admin.Token);
        }
        
        [Route("User")]
        [HttpGet]
        public async Task<ApiResult<object>> AmlakAdminGetUser(string token){

            var admin = await _db.AmlakAdmins.Where(c=>c.Token==token).FirstOrDefaultAsync();
            if (admin == null)
                return BadRequest("UnAuthenticated");

            // todo check expire token date
            var adminData = new{
                Id=admin.Id,
                FirstName=admin.FirstName,
                LastName=admin.LastName,
                UserName=admin.UserName,
                Bio=admin.Bio,
                AmlakLisence=admin.AmlakLisence,
            };
            
            return Ok(adminData);
        }
        
        
    }
}