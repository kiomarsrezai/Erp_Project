using System;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Common;
using NewsWebsite.Data;
using NewsWebsite.Entities.identity;

namespace NewsWebsite.Areas.Api.Controllers.v1 {
    public class EnhancedController:ControllerBase {
        public async Task<User> CheckUserAuth(ProgramBuddbContext _db){
            var authHeader = Request.Headers["Authorization"].ToString();
            
            if (authHeader == null || !authHeader.StartsWith("Bearer "))
                throw new ErrMessageException("UnAuthorized", HttpStatusCode.Conflict);
            
            var token = authHeader.Substring("Bearer ".Length).Trim();
            var user = await _db.Users.Where(u => u.Token == token).FirstOrDefaultAsync();
            if (user == null){
                throw new ErrMessageException("UnAuthorized", HttpStatusCode.Conflict);
            }

            return user;
        }
    }
}