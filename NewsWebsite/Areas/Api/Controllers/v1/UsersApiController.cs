using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data;
using NewsWebsite.Data.Contracts;
using NewsWebsite.Data.Models;
using NewsWebsite.Entities.identity;
using NewsWebsite.Services.Api.Contract;
using NewsWebsite.Services.Contracts;
using NewsWebsite.ViewModels.Api.UsersApi;
using NewsWebsite.ViewModels.DynamicAccess;
using NewsWebsite.ViewModels.UserManager;

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
        private readonly NewsDBContext _Context;
        private readonly IBudget_001Rep _uw;

        public UsersApiController(IApplicationUserManager userManager, IjwtService jwtService,NewsDBContext context, IBudget_001Rep uw)
        {
            _userManager = userManager;
            _jwtService = jwtService;
            _Context = context;
            _uw = uw;
        }

        [HttpGet]
        //[JwtAuthentication(Policy = ConstantPolicies.DynamicPermission)]
        public virtual async Task<ApiResult<List<UsersViewModel>>> Get(int offset, int limit, string order, string search)
        {
            if (!search.HasValue())
                search = "";
            return Ok(await _userManager.GetPaginateUsersAsync(offset, limit, order, search));
        }

        [HttpGet("{id}")]
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
                    FirstName =User.FirstName,
                    LastName =User.LastName,
                    Lisence =User.Lisence,
                    SectionId=User.SectionId,
                    SectionName=await _uw.AreaNameByIdAsync(User.SectionId),
                    Token= await _jwtService.GenerateTokenAsync(User),
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


        [HttpGet("GetUserByTocken")]
        public virtual async Task<ApiResult<UserSignViewModel>> GetUesrByTocken (int id)
        {
            var user =await _uw.GetUserByTocken(id);
            if (user == null) return BadRequest("با خطا مواجه شدید");
            return Ok(user);
        }

        [HttpPost("Savelicense")]
        public virtual async Task<ApiResult<string>> SaveLisenc(int id, string lisence)
        {
            User user = await _Context.Users.FirstOrDefaultAsync(x=>x.Id==id);
            if (user == null) return BadRequest("توکن ارسال شده معتبر نمی باشد");

            user.Lisence = lisence;
            _Context.Users.Update(user);
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