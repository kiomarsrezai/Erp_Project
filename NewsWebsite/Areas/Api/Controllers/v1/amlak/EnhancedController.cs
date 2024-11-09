using System;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Common;
using NewsWebsite.Data;
using NewsWebsite.Data.Models.AmlakAdmin;
using NewsWebsite.Entities.identity;
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;

namespace NewsWebsite.Areas.Api.Controllers.v1.amlak {
    public class EnhancedController:ControllerBase {
        public async Task<AmlakAdmin> CheckUserAuth(ProgramBuddbContext _db){
            
            // if (HttpContext?.User?.Identity!=null && !HttpContext.User.Identity.IsAuthenticated)
            // throw new ErrMessageException("UnAuthorized", HttpStatusCode.Conflict);
            return new AmlakAdmin(); // todo : disable

            var authHeader = Request.Headers["Authorization"].ToString();
            if (authHeader == null || !authHeader.StartsWith("Bearer "))
                throw new ErrMessageException("UnAuthorized", HttpStatusCode.Conflict);
            
            var token = authHeader.Substring("Bearer ".Length).Trim();
            var user = await _db.AmlakAdmins.Where(u => u.Token == token).FirstOrDefaultAsync();
            if (user == null){
                throw new ErrMessageException("UnAuthorized", HttpStatusCode.Conflict);
            }

            return user;
        }
        
        public async Task<int> GetUser(ProgramBuddbContext _db){
            
            // if (HttpContext?.User?.Identity!=null && !HttpContext.User.Identity.IsAuthenticated)
                // return 0;

            var authHeader = Request.Headers["Authorization"].ToString();
            if (authHeader == null || !authHeader.StartsWith("Bearer "))
                return 0;
            
            var token = authHeader.Substring("Bearer ".Length).Trim();
            var user = await _db.AmlakAdmins.Where(u => u.Token == token).FirstOrDefaultAsync();
            if (user == null){
                return 0;
            }

            return user.Id;
        }
        
        
        [NonAction]
        public async Task<bool> SaveLogAsync(ProgramBuddbContext _db, int targetId,TargetTypes targetType,string description){
            var adminId = await GetUser(_db); // todo: use CheckUserAuth
            
            var item = new AmlakLog();
            item.TargetId = targetId;
            item.TargetType = targetType;
            item.AdminId = adminId;
            item.Description = description;
            item.Date = Helpers.GetServerDateTimeType();
            _db.Add(item);
            await _db.SaveChangesAsync();

            return true;
        }
        
    }
}