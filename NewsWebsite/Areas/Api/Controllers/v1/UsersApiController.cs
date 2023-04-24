using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
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
        public UsersApiController(IApplicationUserManager userManager, IjwtService jwtService)
        {
            _userManager = userManager;
            _jwtService = jwtService;
        }

        [HttpGet]
        [JwtAuthentication(Policy = ConstantPolicies.DynamicPermission)]
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

        [HttpPost("[action]")]
        public virtual async Task<ApiResult<string>> SignIn([FromBody] SignInBaseViewModel ViewModel)
        {
            //string license = "";
            var User = await _userManager.FindByNameAsync(ViewModel.UserName);
            if (User == null)
                return BadRequest("نام کاربری یا کلمه عبور شما صحیح نمی باشد.");
            else
            {
                var result = await _signInManager.PasswordSignInAsync(ViewModel.UserName, ViewModel.Password, true, true);
                if (result.Succeeded)
                {
                    User.TokStr = await _jwtService.GenerateTokenAsync(User);
                    //User.Lisence = license;
                    await _userManager.UpdateAsync(User);
                    return Ok(User.TokStr);
                }
                else
                    return BadRequest("نام کاربری یا کلمه عبور شما صحیح نمی باشد.");
            }
        }

       
    }
}