using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text.Json.Nodes;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Common;
using NewsWebsite.Data;
using NewsWebsite.Data.Models.AmlakAdmin;
using NewsWebsite.Entities.identity;
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;
using Newtonsoft.Json;

namespace NewsWebsite.Areas.Api.Controllers.v1.amlak {
    public class EnhancedController:ControllerBase {
        public async Task<AmlakAdmin> CheckUserAuth(ProgramBuddbContext _db){
            if (Request.Headers != null && Request.Headers["Referer"].ToString()!.Contains("swagger")){
                return await _db.AmlakAdmins.FirstOrDefaultAsync(); // Return a default AmlakAdmin object for Swagger.
            }
            
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
        
        
        
        public static bool CheckPermission(AmlakAdmin admin, string keys, string requestedPermission){
            var permissions = GetPermissionNode(admin, keys);

            if (permissions is JsonArray kindArray){
                return kindArray.Count > 0 &&
                       (kindArray[0]?.GetValue<string>() == "*" ||
                        kindArray.Any(item => item?.GetValue<string>() == requestedPermission));
            }
            else if (permissions is JsonValue valueNode){
                return valueNode.GetValue<string>() == requestedPermission;
            }

            return false;
        }

        public static List<string> GetPermission(AmlakAdmin admin, string keys){
            var permissions = GetPermissionNode(admin, keys);

            if (permissions is JsonArray arrayNode){
                return arrayNode.Select(node => node?.GetValue<string>())
                    .Where(value => value != null)
                    .ToList()!;
            }

            return new List<string>();
        }

        private static JsonNode? GetPermissionNode(AmlakAdmin admin, string keys){
            try{
                if (admin.AmlakLisence == null)
                    return null;
                var permissions = JsonNode.Parse(admin.AmlakLisence);
                if (permissions == null)
                    return null;

                var keyParts = keys.Split('.');

                foreach (var key in keyParts){
                    if (!(permissions is JsonObject currentObject) || !currentObject.ContainsKey(key))
                        return null;

                    permissions = currentObject[key];
                }

                return permissions;
            }
            catch (JsonException){
                return null;
            }
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