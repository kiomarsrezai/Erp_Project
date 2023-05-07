using Microsoft.AspNetCore.Authorization;
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
using NewsWebsite.ViewModels.Api.UsersApi;
using NewsWebsite.ViewModels.Manage;
using NewsWebsite.ViewModels.UserManager;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace NewsWebsite.Areas.Api.Controllers.v1
{
    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiResultFilter]
    [ApiVersion("1")]
    public class UsersApiController : ControllerBase
    {
        private readonly IApplicationUserManager _userManager;
        private readonly SignInManager<User> _signInManager;
        private readonly IjwtService _jwtService;
        private readonly ProgramBuddbContext _Context;
        private readonly IBudget_001Rep _uw;
        public readonly IConfiguration _configuration;


        public UsersApiController(IApplicationUserManager userManager, IjwtService jwtService, ProgramBuddbContext context, IBudget_001Rep uw, IConfiguration configuration)
        {
            _configuration = configuration;
            _userManager = userManager;
            _jwtService = jwtService;
            _Context = context;
            _uw = uw;
        }

        [Route("UserListPagination")]
        [HttpGet]
        //[JwtAuthentication(Policy = ConstantPolicies.DynamicPermission)]
        public virtual async Task<ApiResult<List<UsersViewModel>>> Get(int offset, int limit, string searchText="")
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
            }else
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

        [HttpPost("[Action]")]
        [AllowAnonymous]
        public virtual async Task<ApiResult<UserSignViewModel>> SignIn([FromBody] SignInBaseViewModel ViewModel)
        {

            var User = await _userManager.FindByNameAsync(ViewModel.UserName);

            if (User == null)
                return BadRequest("شماره موبایل یا کلمه عبور شما صحیح نمی باشد.");
            else
            {
                User.Token = await _jwtService.GenerateTokenAsync(User);
                await _userManager.UpdateAsync(User);

                UserSignViewModel userSignView = new UserSignViewModel()
                {
                    Id = User.Id,
                    FirstName = User.FirstName,
                    LastName = User.LastName,
                    Lisence = User.Lisence,
                    SectionId = User.SectionId,
                    SectionName = await _uw.AreaNameByIdAsync(User.SectionId),
                    Token = User.Token,
                    UserName = User.UserName,
                    Bio = User.Bio,
                };
                var result = await _userManager.CheckPasswordAsync(User, ViewModel.Password);
                if (result)
                    return Ok(userSignView);
                else
                    return BadRequest("شماره موبایل یا کلمه عبور شما صحیح نمی باشد.");
            }
        }

        [Route("UserChangePassword")]
        [HttpPost]
        public virtual async Task<ApiResult<string>> ChangePassword([FromBody] ChangePasswordViewModel ViewModel)
        {
            var user = _userManager.GetById(ViewModel.Id);
            if (user == null)
                return BadRequest("");

            var changePassResult = await _userManager.ChangePasswordAsync(user, ViewModel.OldPassword, ViewModel.NewPassword);

            if (changePassResult.Succeeded)
                return Ok("موفق");
            else
                return BadRequest("ناموفق");
        }


        [Route("ForgetPassword")]
        [HttpPost]
        public virtual async Task<ApiResult<string>> ForgetPassword([FromBody] ResetPasswordViewModel ViewModel)
        {
            var user = await _Context.Users.FirstOrDefaultAsync(x => x.PhoneNumber == ViewModel.PhoneNumber);
            if (user == null)
                return BadRequest("");

            //ارسال رمز عبور که رندوم ساخته شد
            string pass = "Aa54321";
            //ارسال پیام برای شخص

            return Ok(pass);
        }

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
                        userfech.Bio = dataReader["Bio"].ToString();
                        userfech.FirstName = dataReader["FirstName"].ToString();
                        userfech.LastName = dataReader["LastName"].ToString();
                        userfech.SectionId = int.Parse(dataReader["SectionId"].ToString());
                        userfech.SectionName = await _uw.AreaNameByIdAsync(int.Parse(dataReader["SectionId"].ToString()));
                        userfech.Token = dataReader["Token"].ToString();
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
            return Ok("با موفقیت انجام شد");
        }

        //[HttpPost("CreateUser")]
        //public async Task<User> Create([FromBody] UsersViewModel viewModel)
        //{
        //    // validation
        //    if (string.IsNullOrWhiteSpace(viewModel.Password))
        //        throw new Exception("Password is required");

        //    if (await _Context.Users.AnyAsync(x => x.UserName == viewModel.UserName))
        //        throw new Exception("Username \"" + viewModel.UserName + "\" is already taken");

        //    byte[] passwordHash, passwordSalt;
        //    _userService.CreatePasswordHash(viewModel.Password, out passwordHash, out passwordSalt);

        //    User user = new User
        //    {
        //        passStoredHash = passwordHash,
        //    passStoredSalt = passwordSalt,
        //    };

        //    await _Context.Users.AddAsync(user,cancellationToken);
        //    _Context.SaveChanges();

        //    return user;
        //}

        //[HttpPost("UpdateUser")]
        //public void Update(User userParam, string password = null)
        //{
        //    var user = _Context.Users.Find(userParam.Id);

        //    if (user == null)
        //        throw new Exception("User not found");

        //    // update username if it has changed
        //    if (!string.IsNullOrWhiteSpace(userParam.UserName) && userParam.UserName != user.UserName)
        //    {
        //        // throw error if the new username is already taken
        //        if (_Context.Users.Any(x => x.UserName == userParam.UserName))
        //            throw new Exception("Username " + userParam.UserName + " is already taken");

        //        user.UserName = userParam.UserName;
        //    }

        //    // update user properties if provided
        //    if (!string.IsNullOrWhiteSpace(userParam.FirstName))
        //        user.FirstName = userParam.FirstName;

        //    if (!string.IsNullOrWhiteSpace(userParam.LastName))
        //        user.LastName = userParam.LastName;

        //    // update password if provided
        //    if (!string.IsNullOrWhiteSpace(password))
        //    {
        //        byte[] passwordHash, passwordSalt;
        //        _userManager.CreatePasswordHash(password, out passwordHash, out passwordSalt);

        //        user.passStoredHash = passwordHash;
        //        user.passStoredSalt = passwordSalt;
        //    }

        //    _Context.Users.Update(user);
        //    _Context.SaveChanges();
        //}

        //[HttpPost("DeleteUser")]
        //public void Delete(int id)
        //{
        //    var user = _Context.Users.Find(id);
        //    if (user != null)
        //    {
        //        _Context.Users.Remove(user);
        //        _Context.SaveChanges();
        //    }
        //}

        // private helper methods


    }
}