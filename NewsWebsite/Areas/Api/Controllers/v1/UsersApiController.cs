﻿using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data;
using NewsWebsite.Data.Contracts;
using NewsWebsite.Entities.identity;
using NewsWebsite.Services.Api.Contract;
using NewsWebsite.Services.Contracts;
using NewsWebsite.ViewModels.Api.Budget.BudgetSeprator;
using NewsWebsite.ViewModels.Api.UsersApi;
using NewsWebsite.ViewModels.Manage;
using NewsWebsite.ViewModels.UserManager;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;

namespace NewsWebsite.Areas.Api.Controllers.v1
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiResultFilter]
    [ApiVersion("1")]
    public class UsersApiController : EnhancedBudgetController
    {
        private readonly IApplicationUserManager _userManager;
        private readonly IApplicationRoleManager _roleManager;
        private readonly SignInManager<User> _signInManager;
        private readonly IjwtService _jwtService;
        private readonly ProgramBuddbContext _Context;
        private readonly IBudget_001Rep _uw;
        public readonly IConfiguration _configuration;


        public UsersApiController(IApplicationUserManager userManager, IApplicationRoleManager roleManager, IjwtService jwtService, ProgramBuddbContext context, IBudget_001Rep uw, IConfiguration configuration)
        {
            _userManager = userManager;
            _roleManager = roleManager;
            _jwtService = jwtService;
            _Context = context;
            _uw = uw;
            _configuration = configuration;
        }

        [Route("UserListPagination")]
        [HttpGet]
        //[JwtAuthentication(Policy = ConstantPolicies.DynamicPermission)]
        public virtual async Task<ApiResult<List<UsersViewModel>>> Get(int offset, int limit, string searchText = "")
        {
            List<UsersViewModel> users;
            if (searchText.Length > 0)
            {
                users = await _Context.Users.Include(u => u.Roles).Include(l => l.Section)
                      .Where(t => t.FirstName.Contains(searchText) || t.LastName.Contains(searchText) || t.Email.Contains(searchText) || t.UserName.Contains(searchText))
                      .Skip(offset).Take(limit)
                      .Select(user => new UsersViewModel
                      {
                          Id = user.Id,
                          Email = user.Email,
                          UserName = user.UserName,
                          Bio = user.Bio,
                          Lisence = user.Lisence,
                          PhoneNumber = user.PhoneNumber,
                          FirstName = user.FirstName,
                          LastName = user.LastName,
                          IsActive = user.IsActive,
                          Image = user.Image,
                          SectionId = user.SectionId,
                          SectionName = _Context.Sections.FirstOrDefault(a => a.SectionId == user.SectionId).Name,
                          PersianBirthDate = user.BirthDate.ConvertMiladiToShamsi("yyyy/MM/dd"),
                          PersianRegisterDateTime = user.RegisterDateTime.ConvertMiladiToShamsi("yyyy/MM/dd ساعت HH:mm:ss"),
                          GenderName = user.Gender == GenderType.Male ? "مرد" : "زن",
                          RoleId = user.Roles.Select(r => r.Role.Id).FirstOrDefault(),
                          RoleName = user.Roles.Select(r => r.Role.Name).FirstOrDefault()
                      }).AsNoTracking().ToListAsync();
            }
            else
            {
                users = await _Context.Users.Include(u => u.Roles).Include(l => l.Section)
                      .Skip(offset).Take(limit)
                      .Select(user => new UsersViewModel
                      {
                          Id = user.Id,
                          Email = user.Email,
                          UserName = user.UserName,
                          Bio = user.Bio,
                          Lisence = user.Lisence,
                          PhoneNumber = user.PhoneNumber,
                          FirstName = user.FirstName,
                          LastName = user.LastName,
                          IsActive = user.IsActive,
                          Image = user.Image,
                          SectionId = user.SectionId,
                          SectionName = _Context.Sections.FirstOrDefault(a => a.SectionId == user.SectionId).Name,
                          PersianBirthDate = user.BirthDate.ConvertMiladiToShamsi("yyyy/MM/dd"),
                          PersianRegisterDateTime = user.RegisterDateTime.ConvertMiladiToShamsi("yyyy/MM/dd ساعت HH:mm:ss"),
                          GenderName = user.Gender == GenderType.Male ? "مرد" : "زن",
                          RoleId = user.Roles.Select(r => r.Role.Id).FirstOrDefault(),
                          RoleName = user.Roles.Select(r => r.Role.Name).FirstOrDefault()
                      }).AsNoTracking().ToListAsync();
            }
            return Ok(users);
        }

        [Route("GetUser{id}")]
        [HttpGet]
        public virtual async Task<ApiResult<UsersViewModel>> Get(int id)
        {
            var user = await _userManager.FindUserWithRolesByIdAsync(id);
            if (user == null)
                return NotFound();
            else
                return Ok(user);
        }

        // [HttpPost("[Action]")]
        // [AllowAnonymous]
        // public virtual async Task<ApiResult<UserSignViewModel>> SignIn([FromBody] SignInBaseViewModel ViewModel)
        // {
        //
        //     var User = await _userManager.FindByNameAsync(ViewModel.UserName);
        //
        //     if (User == null)
        //         return BadRequest(" نام کاربری یا کلمه عبور شما صحیح نمی باشد.");
        //     else
        //     {
        //         User.Token = await _jwtService.GenerateTokenAsync(User);
        //         await _userManager.UpdateAsync(User);
        //
        //         UserSignViewModel userSignView = new UserSignViewModel()
        //         {
        //             Id = User.Id,
        //             FirstName = User.FirstName,
        //             LastName = User.LastName,
        //             Lisence = User.Lisence,
        //             AmlakLisence = User.AmlakLisence,
        //             SectionId = User.SectionId,
        //             SectionName = await _uw.AreaNameByIdAsync(User.SectionId),
        //             Token = User.Token,
        //             UserName = User.UserName,
        //             Bio = User.Bio,
        //             DateNow = DateTime.Now.ToShortDateString()
        //         };
        //         var result = await _userManager.CheckPasswordAsync(User, ViewModel.Password);
        //         if (result){
        //             await SaveLogAsync(_Context, User.Id, TargetTypesBudgetLog.User, "ورود موفق به حساب "+ViewModel.UserName , "");
        //
        //             return Ok(userSignView);
        //         }
        //         else{
        //             await SaveLogAsync(_Context, User.Id, TargetTypesBudgetLog.User, "ورود ناموفق به حساب "+ViewModel.UserName , "");
        //
        //             return BadRequest("شماره موبایل یا کلمه عبور شما صحیح نمی باشد.");
        //         }
        //     }
        // }

        
        
        [HttpPost("[Action]")]
        [AllowAnonymous]
        public virtual async Task<ApiResult<UserSignViewModel>> SignInNew([FromBody] SignInBaseViewModel ViewModel)
        {
            var User = await _Context.Users.Where(c=>c.UserName==ViewModel.UserName).FirstOrDefaultAsync();

            if (User == null){
                await SaveLogAsync(_Context, User.Id, TargetTypesBudgetLog.User, "تلاش ناموفق برای ورود به حساب "+ViewModel.UserName , "");

                return BadRequest(" نام کاربری یا کلمه عبور شما صحیح نمی باشد.");
            }
            
            if (!User.IsActive)
                return BadRequest(" حساب شما غیرفعال می باشد.");
            
            User.Token = Helpers.GenerateToken();
            UserSignViewModel userSignView = new UserSignViewModel()
            {
                Id = User.Id,
                FirstName = User.FirstName,
                LastName = User.LastName,
                Lisence = User.Lisence,
                Token = User.Token,
                UserName = User.UserName,
                Bio = User.Bio,
                DateNow = DateTime.Now.ToShortDateString()
            };
            var passVerifyResult = new PasswordHasher<UserSignViewModel>().VerifyHashedPassword(null, User.PasswordHash, ViewModel.Password);
            if (passVerifyResult!=PasswordVerificationResult.Success){ // todo: check hash
                await SaveLogAsync(_Context, User.Id, TargetTypesBudgetLog.User, "تلاش ناموفق (رمز غلط) برای ورود به حساب "+ViewModel.UserName , "");
                return BadRequest(" نام کاربری یا کلمه عبور شما صحیح نمی باشد.");
            }
            //     
            await SaveLogAsync(_Context, User.Id, TargetTypesBudgetLog.User, "ورود موفق به حساب "+ViewModel.UserName , "");

            await _Context.SaveChangesAsync();
            
            return Ok(userSignView);
        }

        
        [Route("UserChangePassword")]
        [HttpPost]
        public virtual async Task<ApiResult<string>> ChangePassword([FromBody] ChangePasswordViewModel ViewModel)
        {
            var user = await _Context.Users.FirstOrDefaultAsync(a => a.Id == ViewModel.Id);
            if (user == null)
                return BadRequest("");

            var changePassResult = await _userManager.ChangePasswordAsync(user, ViewModel.OldPassword, ViewModel.NewPassword);

            if (changePassResult.Succeeded){
                await SaveLogAsync(_Context, ViewModel.Id, TargetTypesBudgetLog.User, "تغییر رمز عبور کاربر "+ViewModel.Id , "");
   
                return Ok("موفق");
            }
            else
                return BadRequest("ناموفق");
        }


        // [Route("ForgetPassword")]
        // [HttpPost]
        // public virtual async Task<ApiResult<string>> ForgetPassword([FromBody] ResetPasswordViewModel ViewModel)
        // {
        //     var user = await _Context.Users.FirstOrDefaultAsync(x => x.PhoneNumber == ViewModel.PhoneNumber);
        //     if (user == null)
        //         return BadRequest("");
        //
        //     //ارسال رمز عبور که رندوم ساخته شد
        //     string pass = "Aa54321";
        //     //ارسال پیام برای شخص
        //
        //     return Ok(pass);
        // }

        [HttpPost("GetUserByTocken")]
        [AllowAnonymous]
        public virtual async Task<ApiResult<UserSignViewModel>> GetUserByTocken([FromBody] TockenViewModel tocken)
        {
            UserSignViewModel userfech = new UserSignViewModel();
            using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP000_GetUserInfoByTocken", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("tocken", tocken.Tocken);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (await dataReader.ReadAsync())
                    {
                        userfech.Id = int.Parse(dataReader["Id"].ToString());
                        userfech.UserName = dataReader["UserName"].ToString();
                        userfech.Lisence = dataReader["Lisence"].ToString();
                        userfech.AmlakLisence = dataReader["AmlakLisence"].ToString();
                        userfech.Bio = dataReader["Bio"].ToString();
                        userfech.FirstName = dataReader["FirstName"].ToString();
                        userfech.LastName = dataReader["LastName"].ToString();
                        userfech.SectionId = int.Parse(dataReader["SectionId"].ToString());
                        userfech.SectionName = await _uw.AreaNameByIdAsync(int.Parse(dataReader["SectionId"].ToString()));
                        userfech.Token = dataReader["Token"].ToString();
                        userfech.DateNow = DateTime.Now.ToShortDateString();
                    }
                }
            }
            if (userfech.Id > 0)
                return Ok(userfech);
            else return BadRequest();
        }

        [HttpPost("Savelicense")]
        public virtual async Task<ApiResult<string>> SaveLisenc([FromBody] SaveLisenceViewModel lisence)
        {
            var user = await _Context.Users.FirstOrDefaultAsync(x => x.Id == lisence.Id);
            user.Lisence = lisence.Lisence;
            await _Context.SaveChangesAsync();
            await SaveLogAsync(_Context, lisence.Id, TargetTypesBudgetLog.User, "تغییر دسترسی های کاربر "+lisence.Id , "");

            return Ok("با موفقیت انجام شد");
        }

        [HttpPost("SaveAmlaklicense")]
        public virtual async Task<ApiResult<string>> SaveAmlakLisenc([FromBody] SaveAmlakLisenceViewModel saveAmlak)
        {
            var user = await _Context.Users.FirstOrDefaultAsync(x => x.Id == saveAmlak.Id);
            user.AmlakLisence = saveAmlak.AmlakLisence;
            await _Context.SaveChangesAsync();
            return Ok("با موفقیت انجام شد");
        }

        //[Route("EmployeeInsert")]
        //[HttpPost]
        //public async Task<ApiResult<string>> AC_EmployeeInsert([FromBody] EmployeeInsertViewModel param)
        //{
        //    string readercount = null;
        //    using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
        //    {
        //        using (SqlCommand sqlCommand = new SqlCommand("SP000_Employee_Insert", sqlconnect))
        //        {
        //            sqlconnect.Open();
        //            sqlCommand.Parameters.AddWithValue("UserName", param.UserName);
        //            sqlCommand.Parameters.AddWithValue("PhoneNumber", param.PhoneNumber);
        //            sqlCommand.Parameters.AddWithValue("FirstName", param.FirstName);
        //            sqlCommand.Parameters.AddWithValue("LastName", param.LastName);
        //            sqlCommand.Parameters.AddWithValue("Gender", param.Gender);
        //            sqlCommand.Parameters.AddWithValue("Bio", param.Bio);
        //            sqlCommand.CommandType = CommandType.StoredProcedure;
        //            SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
        //            while (dataReader.Read())
        //            {
        //                if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
        //            }
        //        }
        //    }
        //    if (string.IsNullOrEmpty(readercount)) return Ok("با موفقیت انجام شد");
        //    else
        //        return BadRequest(readercount);
        //}

        //[Route("EmployeeUpdate")]
        //[HttpPost]
        //public async Task<ApiResult<string>> AC_EmployeeUpdate([FromBody] EmployeeUpdateViewModel param)
        //{
        //    string readercount = null;
        //    using (SqlConnection sqlconnect = new SqlConnection(_configuration.GetConnectionString("SqlErp")))
        //    {
        //        using (SqlCommand sqlCommand = new SqlCommand("SP000_Employee_Update", sqlconnect))
        //        {
        //            sqlconnect.Open();
        //            sqlCommand.Parameters.AddWithValue("Id", param.Id);
        //            sqlCommand.Parameters.AddWithValue("UserName", param.UserName);
        //            sqlCommand.Parameters.AddWithValue("PhoneNumber", param.PhoneNumber);
        //            sqlCommand.Parameters.AddWithValue("FirstName", param.FirstName);
        //            sqlCommand.Parameters.AddWithValue("LastName", param.LastName);
        //            sqlCommand.Parameters.AddWithValue("Gender", param.Gender);
        //            sqlCommand.Parameters.AddWithValue("Bio", param.Bio);
        //            sqlCommand.Parameters.AddWithValue("NormalizedUserName", param.NormalizedUserName);
        //            sqlCommand.Parameters.AddWithValue("Email", param.Email);
        //            sqlCommand.Parameters.AddWithValue("NormalizedEmail", param.NormalizedEmail);
        //            sqlCommand.Parameters.AddWithValue("BirthDate", param.BirthDate);
        //            sqlCommand.Parameters.AddWithValue("IsActive", param.IsActive);
        //            sqlCommand.CommandType = CommandType.StoredProcedure;
        //            SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
        //            while (dataReader.Read())
        //            {
        //                if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
        //            }
        //        }
        //    }
        //    if (string.IsNullOrEmpty(readercount)) return Ok("با موفقیت انجام شد");
        //    else
        //        return BadRequest(readercount);
        //}
        //
        // [HttpPost("EmployeeInsert")]
        // public async Task<ApiResult<string>> Create([FromBody] UserInsertViewModel viewModel)
        // {
        //     if (viewModel.UserName == null) BadRequest("پارامترهای ارسالی نامعتبر می باشد");
        //     // validation
        //     var roleresult = await _roleManager.FindByNameAsync("کاربر");
        //         if (roleresult == null)
        //             await _roleManager.CreateAsync(new Role("کاربر"));
        //     var user = new User
        //     {
        //         UserName = viewModel.UserName,
        //         Bio = viewModel.Bio,
        //         Email = null,
        //         BirthDate = DateTime.Now,
        //         RegisterDateTime = DateTime.Now,
        //         IsActive = true,
        //         SectionId = 9,
        //         FirstName = viewModel.FirstName,
        //         LastName = viewModel.LastName,
        //     };
        //
        //     IdentityResult result = await _userManager.CreateAsync(user,"abc123");
        //
        //     if (result.Succeeded)
        //     {
        //         await _userManager.AddToRoleAsync(user, "کاربر");
        //
        //         byte[] passwordHash, passwordSalt;
        //         _userManager.CreatePasswordHash("abc123", out passwordHash, out passwordSalt);
        //
        //         await _Context.Users.AddAsync(user);
        //         _Context.SaveChanges();
        //
        //     }
        //     
        //     await SaveLogAsync(_Context, user.Id, TargetTypesBudgetLog.User, "ایجاد کاربر "+viewModel.UserName , "");
        //
        //     return Ok("کاربر با موفقیت ایجاد شد");
        // }

        [HttpPost("EmployeeInsertNew")]
        public async Task<ApiResult<string>> CreateNew([FromBody] UserInsertViewModel viewModel)
        {
            if (viewModel.UserName == null) BadRequest("پارامترهای ارسالی نامعتبر می باشد");
            var oldUser = _Context.Users.FirstOrDefault(u => u.UserName == viewModel.UserName);
            if(oldUser!=null)
                return BadRequest("این نام کاربری قبلا وجود دارد");

            var user = new User
            {
                UserName = viewModel.UserName,
                Bio = viewModel.Bio,
                Email = "",
                BirthDate = DateTime.Now,
                RegisterDateTime = DateTime.Now,
                IsActive = true,
                SectionId = 9,
                FirstName = viewModel.FirstName,
                LastName = viewModel.LastName,
                PhoneNumber = viewModel.PhoneNumber,
                PasswordHash = new PasswordHasher<User>().HashPassword(null, viewModel.PhoneNumber)
            };

            _Context.Add(user);
            await _Context.SaveChangesAsync();
            
            await SaveLogAsync(_Context, user.Id, TargetTypesBudgetLog.User, "ایجاد کاربر "+viewModel.UserName , "");

            return Ok("کاربر با موفقیت ایجاد شد");
        }

        [HttpPost("EmployeeUpdateNew")]
        public async Task<ApiResult<string>> UpdateNew([FromBody] UserUpdateViewModel viewModel)
        {
            if (viewModel.UserName == null) BadRequest("پارامترهای ارسالی نامعتبر می باشد");

            var oldUser = _Context.Users.FirstOrDefault(u => u.UserName == viewModel.UserName && u.Id != viewModel.Id );
            if(oldUser!=null)
                return BadRequest("این نام کاربری قبلا وجود دارد");
            
            var user = _Context.Users.FirstOrDefault(u => u.Id == viewModel.Id);
            if (user == null){
               return BadRequest("کاربر یافت نشد");
            }
            
            user.UserName=viewModel.UserName;
            user.Bio=viewModel.Bio;
            user.FirstName=viewModel.FirstName;
            user.LastName=viewModel.LastName;
            user.PhoneNumber=viewModel.PhoneNumber;
            
            await _Context.SaveChangesAsync();
            
            await SaveLogAsync(_Context, user.Id, TargetTypesBudgetLog.User, "ویرایش کاربر "+viewModel.UserName +
                                                                            " نام کاربری : "+viewModel.UserName+
                                                                            " سمت : "+viewModel.Bio+
                                                                            " نام : "+viewModel.FirstName+
                                                                            " نام خانوادگی : "+viewModel.LastName+
                                                                            " شماره تلفن : "+viewModel.PhoneNumber
                , "");

            
            return Ok("کاربر با موفقیت ویرایش شد");
        }

        [HttpPost("RenewPassword")]
        public async Task<ApiResult<string>> RenewPassword([FromBody] UserRenewPasswordViewModel viewModel)
        {
            var User = await _Context.Users.Where(c=>c.Id==viewModel.UserId).FirstOrDefaultAsync();

            if (User == null) BadRequest("پارامترهای ارسالی نامعتبر می باشد");
            User.PasswordHash = new PasswordHasher<User>().HashPassword(null, User.PhoneNumber);
            
            await _Context.SaveChangesAsync();
            
            await SaveLogAsync(_Context, User.Id, TargetTypesBudgetLog.User, "بازنشانی رمز کاربر "+User.UserName , "");

            return Ok("رمز عبور بازنشانی شد");
        }

        [HttpPost("ChangeActivation")]
        public async Task<ApiResult<string>> RenewPassword([FromBody] UserActivationViewModel viewModel)
        {
            var User = await _Context.Users.Where(c=>c.Id==viewModel.UserId).FirstOrDefaultAsync();

            if (User == null) BadRequest("پارامترهای ارسالی نامعتبر می باشد");
            User.IsActive = viewModel.isActive==1?true:false;
            
            await _Context.SaveChangesAsync();
            
            if(viewModel.isActive==1)
                await SaveLogAsync(_Context, User.Id, TargetTypesBudgetLog.User, "فعال سازی کاربر "+User.UserName , "");
            if(viewModel.isActive==0)
                await SaveLogAsync(_Context, User.Id, TargetTypesBudgetLog.User, "غیرفعال سازی کاربر "+User.UserName , "");

            return Ok("وضعیت کاربر تغییر یافت");
        }

        // [HttpPost("UpdateUser")]
        // public void Update(User userParam)
        // {
        //     var user = _Context.Users.Find(userParam.Id);
        //
        //     if (user == null)
        //         throw new Exception("User not found");
        //
        //     // update username if it has changed
        //     if (!string.IsNullOrWhiteSpace(userParam.UserName) && userParam.UserName != user.UserName)
        //     {
        //         // throw error if the new username is already taken
        //         if (_Context.Users.Any(x => x.UserName == userParam.UserName))
        //             throw new Exception("Username " + userParam.UserName + " is already taken");
        //
        //         user.UserName = userParam.UserName;
        //     }
        //
        //     // update user properties if provided
        //     if (!string.IsNullOrWhiteSpace(userParam.FirstName))
        //         user.FirstName = userParam.FirstName;
        //
        //     if (!string.IsNullOrWhiteSpace(userParam.LastName))
        //         user.LastName = userParam.LastName;
        //
        //     // update password if provided
        //     //if (!string.IsNullOrWhiteSpace(password))
        //     //{
        //     //    byte[] passwordHash, passwordSalt;
        //     //    _userManager.CreatePasswordHash(password, out passwordHash, out passwordSalt);
        //
        //     //    user.passStoredHash = passwordHash;
        //     //    user.passStoredSalt = passwordSalt;
        //     //}
        //
        //     _Context.Users.Update(user);
        //     _Context.SaveChanges();
        // }

        // [HttpPost("DeleteUser")]
        // public void Delete(int id)
        // {
        //     var user = _Context.Users.Find(id);
        //     if (user != null)
        //     {
        //         _Context.Users.Remove(user);
        //         _Context.SaveChanges();
        //     }
        // }

        [HttpGet("SearchLicense")]
        public async Task<ApiResult<List<UsersViewModel>>> SearchLicense(string license){

            if (license.Length < 3 || !license.Contains("."))
                return BadRequest("دسترسی وارد شده صحیح نمی باشد");
            
            var users = await _Context.Users.Where(a => EF.Functions.Like(a.Lisence, $"%{license}%")) .Select(user => new UsersViewModel
            {
                Id = user.Id,
                UserName = user.UserName,
                FirstName = user.FirstName,
                LastName = user.LastName,
                }).ToListAsync();;

            return Ok(users);
        }

    }
}