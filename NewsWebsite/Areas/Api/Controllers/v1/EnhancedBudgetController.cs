using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Text.Json.Nodes;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Controllers;
using Microsoft.AspNetCore.Routing.Patterns;
using Microsoft.EntityFrameworkCore;
using NewsWebsite.Common;
using NewsWebsite.Data;
using NewsWebsite.Data.Models;
using NewsWebsite.Data.Models.AmlakAdmin;
using NewsWebsite.Entities.identity;
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;
using Newtonsoft.Json;

namespace NewsWebsite.Areas.Api.Controllers.v1 {
    public class EnhancedBudgetController:ControllerBase {
        public async Task<User> CheckUserAuth(ProgramBuddbContext _db){
            if (Request.Headers != null && Request.Headers["Referer"].ToString()!.Contains("swagger")){
                return await _db.Users.FirstOrDefaultAsync(); // Return a default User object for Swagger.
            }
            
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
        
        public async Task<int> GetUser(ProgramBuddbContext _db){
            
            if (Request.Headers != null && Request.Headers["Referer"].ToString()!.Contains("swagger")){
                return (await _db.Users.FirstOrDefaultAsync()).Id; // Return a default User object for Swagger.
            }
            // if (HttpContext?.User?.Identity!=null && !HttpContext.User.Identity.IsAuthenticated)
                // return 0;

            var authHeader = Request.Headers["Authorization"].ToString();
            if (authHeader == null || !authHeader.StartsWith("Bearer "))
                return 0;
            
            var token = authHeader.Substring("Bearer ".Length).Trim();

            var user = await _db.Users.Where(u => u.Token == token).FirstOrDefaultAsync();
            if (user == null){
                return 0;
            }

            return user.Id;
        }
        
        [NonAction]
        public async Task<bool> SaveLogAsync(ProgramBuddbContext _db, int targetId,TargetTypesBudgetLog targetType,string description,int codingId){
            var coding = "";
            if(codingId!=0){
                var c = await _db.TblCodings.FirstOrDefaultAsync(c=>c.Id==codingId);
                coding = c.Code;
            }
            await SaveLogAsync(_db, targetId, targetType, description, coding);
                

            return true;
        }  

      
        
        [NonAction]
        public async Task<bool> SaveLogAsync(ProgramBuddbContext _db, int targetId,TargetTypesBudgetLog targetType,string description,string coding){
            var adminId = await GetUser(_db); // todo: use CheckUserAuth
            var item = new BudgetLog();
            item.TargetId = targetId;
            item.TargetType = targetType;
            item.AdminId = adminId;
            item.Description = description;
            item.Coding = coding;
            item.Url = GetRoute();
            item.Ip = Helpers.GetUserIp(HttpContext);
            item.Device = Helpers.GetUserDeviceInfo(HttpContext);
            item.Date = Helpers.GetServerDateTimeType();
            await _db.AddAsync(item);
            await _db.SaveChangesAsync();

            return true;
        }
        
        
        

        [NonAction]
        public string GetRoute(){
            var metadata = HttpContext.GetEndpoint().Metadata.GetMetadata<ControllerActionDescriptor>();
            var route = metadata.AttributeRouteInfo.Template;
            string pattern = @"([^/]+/[^/]+)$"; // Matches the last two parts of the string
            Match match = Regex.Match(route, pattern);

            if (match.Success)
                return match.Value;

            return "";
        }  


        [NonAction]
        public async Task<TblCodings> getCoding(ProgramBuddbContext _db, int id){
            var coding = new TblCodings();
            coding = await _db.TblCodings.FirstOrDefaultAsync(c=>c.Id==id);

            return coding;
        }  

        
        // Code , YearId
        [NonAction]
        public async Task<CodingObj> getCodingBaseBD(SqlConnection sqlconnect, int id){
            // sqlconnect.Open();
            using SqlCommand sqlCommand = new SqlCommand("SP501_GetCodingBaseBD", sqlconnect);
            sqlCommand.Parameters.AddWithValue("Id", id);
            sqlCommand.CommandType = CommandType.StoredProcedure;
            SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
            CodingObj obj = new CodingObj();
            while (dataReader.Read()){
                if (dataReader["Code"].ToString() != null) obj.Code= dataReader["Code"].ToString();
                if (dataReader["YearId"].ToString() != null) obj.YearId= int.Parse(dataReader["YearId"].ToString());
            }
            dataReader.Close();

            return obj;
        }

        // Code , YearId
        [NonAction]
        public async Task<CodingObj> getCodingBaseBDP(SqlConnection sqlconnect, int id){
            // sqlconnect.Open();
            using SqlCommand sqlCommand = new SqlCommand("SP501_GetCodingBaseBDP", sqlconnect);
            sqlCommand.Parameters.AddWithValue("Id", id);
            sqlCommand.CommandType = CommandType.StoredProcedure;
            SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
            CodingObj obj = new CodingObj();
            while (dataReader.Read()){
                if (dataReader["Code"].ToString() != null) obj.Code= dataReader["Code"].ToString();
                if (dataReader["YearId"].ToString() != null) obj.YearId= int.Parse(dataReader["YearId"].ToString());
            }
            dataReader.Close();

            return obj;
        }

        // Code , YearId , AreaId
        [NonAction]
        public async Task<CodingObj> getCodingBaseBDPA(SqlConnection sqlconnect, int id){
            // sqlconnect.Open();
            using SqlCommand sqlCommand = new SqlCommand("SP501_GetCodingBaseBDPA", sqlconnect);
            sqlCommand.Parameters.AddWithValue("Id", id);
            sqlCommand.CommandType = CommandType.StoredProcedure;
            SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
            CodingObj obj = new CodingObj();
            while (dataReader.Read()){
                if (dataReader["Code"].ToString() != null) obj.Code= dataReader["Code"].ToString();
                if (dataReader["YearId"].ToString() != null) obj.YearId= int.Parse(dataReader["YearId"].ToString());
                if (dataReader["AreaId"].ToString() != null) obj.AreaId= int.Parse(dataReader["AreaId"].ToString());
            }
            dataReader.Close();

            return obj;
        }

        public class CodingObj {
            public string? Code="";
            public int? YearId=0;
            public int? AreaId=0;
        }
        
    }
}