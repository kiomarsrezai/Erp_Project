﻿using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using NewsWebsite.Common;
using NewsWebsite.Common.Api;
using NewsWebsite.Common.Api.Attributes;
using NewsWebsite.Data.Contracts;
using NewsWebsite.ViewModels.Api.Budget.BudgetProject;
using NewsWebsite.ViewModels.Api.Commite;
using NewsWebsite.ViewModels.Api.Request;
using NewsWebsite.ViewModels.Api.UploadFile;
using NewsWebsite.ViewModels.Project;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Threading.Tasks;
using NewsWebsite.Data;
using NewsWebsite.ViewModels.Api.Contract.AmlakLog;

namespace NewsWebsite.Areas.Api.Controllers.v1
{

    [Route("api/v{version:apiVersion}/[controller]")]
    [ApiVersion("1")]
    [ApiResultFilter]
    public class ProjectApiController : EnhancedBudgetController
    {
        public readonly IConfiguration _config;
        private readonly ProgramBuddbContext _db;
        public readonly IUnitOfWork _uw;
        private readonly IWebHostEnvironment _webHostEnvironment;
        public ProjectApiController(IUnitOfWork uw, IConfiguration config,ProgramBuddbContext db)
        {
            _config = config;
            _db = db;
            _uw = uw;
        }


        [Produces("application/json")]
        [Route("UploadFiles")]
        [HttpPost, DisableRequestSizeLimit]
        public async Task<ApiResult> UploadProjectFiles([FromBody] FileUploadModel uploadModel)
        {
            try
            {
                var file = uploadModel.FormFile;
                var folderName = Path.Combine($"{_webHostEnvironment.WebRootPath}/Resources/Project/{uploadModel.ProjectId}/");
                var pathToSave = Path.Combine(Directory.GetCurrentDirectory(), folderName);
                if (file.Length > 0)
                {
                    var fullPath = Path.Combine(pathToSave, file.FileName);
                    using (var stream = new FileStream(fullPath, FileMode.Create))
                    {
                        await file.CopyToAsync(stream);
                    }
                    return Ok();
                }
                else
                {
                    return BadRequest();
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [Route("ProjectOrgRead")]
        [HttpGet]
        public async Task<ApiResult<List<ProjectViewModel>>> GetProject(int id)
        {
            if (id == 0)
                return BadRequest("خطایی رخ داده است");

            List<ProjectViewModel> fetchViewlist = new List<ProjectViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP005_ProjectOrg_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (await dataReader.ReadAsync())
                    {
                        ProjectViewModel fetchView = new ProjectViewModel();
                        fetchView.Id = int.Parse(dataReader["Id"].ToString());
                        fetchView.ProjectCode = dataReader["ProjectCode"].ToString();
                        fetchView.ProjectName = dataReader["ProjectName"].ToString();
                        fetchView.Weight = StringExtensions.ToNullablefloat(dataReader["Weight"].ToString());
                        fetchView.AreaId = StringExtensions.ToNullableInt(dataReader["AreaId"].ToString());
                        fetchView.MotherId = StringExtensions.ToNullableInt(dataReader["MotherId"].ToString());
                        fetchViewlist.Add(fetchView);
                    }
                }
            }
            return Ok(fetchViewlist);
        }


        [Route("ProjectOrgInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> InsertProject(int id)
        {
            if (id == 0)
                return BadRequest("با خطا مواجه شد");
            if (id > 0)
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP005_ProjectOrg_Insert", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("id", id);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                        sqlconnect.Close();
                    }
                }
            }
            
            await SaveLogAsync(_db, 0, TargetTypesBudgetLog.Project, "افزودن کارت چارت پروژه شناسه "+id, "");

            return Ok("با موفقیت انجام شد");
        }


        [Route("ProjectOrgUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> Update(ProjectOrgUpdateParamViewModel param)
        {
            {
                using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("SP005_ProjectOrg_Update", sqlconnect))
                    {
                        sqlconnect.Open();
                        sqlCommand.Parameters.AddWithValue("id", param.Id);
                        sqlCommand.Parameters.AddWithValue("ProjectName", param.projectName);
                        sqlCommand.Parameters.AddWithValue("ProjectCode", param.projectCode);
                        sqlCommand.Parameters.AddWithValue("MotherId", param.motherId);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    }
                }
            }
            await SaveLogAsync(_db, 0, TargetTypesBudgetLog.Project, "بروزرسانی کارت چارت پروژه شناسه "+param.Id + " نام : "+param.projectName + " کد: "+param.projectCode, "");

            return Ok("با موفقیت انجام شد");
        }


        [Route("ProjectOrgDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> Delete([FromBody] RequestBudgetDeleteViewModel param)
        {

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP005_ProjectOrg_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", param.Id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    sqlconnect.Close();
                }
            }
            await SaveLogAsync(_db, 0, TargetTypesBudgetLog.Project, "حذف کارت چارت پروژه شناسه "+param.Id , "");

            return Ok("با موفقیت انجام شد");
        }


        [Route("ProjectScaleCom")]
        [HttpGet]
        public async Task<ApiResult<List<ProjectScaleComViewModel>>> ProjectScaleCom()
        {
            List<ProjectScaleComViewModel> ScaleCom = new List<ProjectScaleComViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP005_ProjectScale_Com", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (await dataReader.ReadAsync())
                    {
                        ProjectScaleComViewModel ScaleComview = new ProjectScaleComViewModel();
                        ScaleComview.Id = int.Parse(dataReader["Id"].ToString());
                        ScaleComview.ProjectScaleName = dataReader["ProjectScaleName"].ToString();
                        ScaleCom.Add(ScaleComview);
                    }
                }
            }

            return Ok(ScaleCom);
        }


        [Route("ProjectTableRead")]
        [HttpGet]
        public async Task<ApiResult<List<ProjectTableReadViewModel>>> GetProjectTable(ProjectTableReadParamViewModel param)
        {
            List<ProjectTableReadViewModel> fetchViewlist = new List<ProjectTableReadViewModel>();

            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP005_ProjectTable_Read", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("areaId", param.AreaId);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (await dataReader.ReadAsync())
                    {
                        ProjectTableReadViewModel data = new ProjectTableReadViewModel();
                        data.Id = int.Parse(dataReader["Id"].ToString());
                        data.ProjectCode = dataReader["ProjectCode"].ToString();
                        data.ProjectName = dataReader["ProjectName"].ToString();
                        data.DateFrom = dataReader["DateFrom"].ToString();
                        data.DateEnd = dataReader["DateEnd"].ToString();
                        data.DateFromShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["DateFrom"].ToString()), "yyyy/MM/dd");
                        data.DateEndShamsi = DateTimeExtensions.ConvertMiladiToShamsi(StringExtensions.ToNullableDatetime(dataReader["DateEnd"].ToString()), "yyyy/MM/dd");
                        data.AreaArray = dataReader["AreaArray"].ToString();
                        data.ProjectScaleId = int.Parse(dataReader["ProjectScaleId"].ToString());
                        data.ProjectScaleName = dataReader["ProjectScaleName"].ToString();
                        fetchViewlist.Add(data);
                    }
                }
            }
            return Ok(fetchViewlist);
        }


        [Route("ProjectTableInsert")]
        [HttpPost]
        public async Task<ApiResult<string>> InsertTableProject([FromBody] ProjectTableInsertParamViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP005_ProjectTable_Insert", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("ProjectName", param.ProjectName);
                    sqlCommand.Parameters.AddWithValue("DateFrom", param.DateFrom);
                    sqlCommand.Parameters.AddWithValue("DateEnd", param.DateEnd);
                    sqlCommand.Parameters.AddWithValue("ProjectScaleId", param.ProjectScaleId);
                    sqlCommand.Parameters.AddWithValue("AreaArray", param.AreaArray);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
                    }
                    sqlconnect.Close();
                }
            }

            if (string.IsNullOrEmpty(readercount)){
                
                await SaveLogAsync(_db, 0, TargetTypesBudgetLog.Project, "افزودن پروژه "+param.ProjectName , "");

                return Ok("با موفقیت انجام شد");
            }
            else
                return BadRequest(readercount);
        }


        [Route("ProjectTableUpdate")]
        [HttpPost]
        public async Task<ApiResult<string>> UpdateTableProject([FromBody] ProjectTableUpdateParamViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP005_ProjectTable_Update", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("Id", param.Id);
                    sqlCommand.Parameters.AddWithValue("ProjectName", param.ProjectName);
                    sqlCommand.Parameters.AddWithValue("DateFrom", param.DateFrom);
                    sqlCommand.Parameters.AddWithValue("DateEnd", param.DateEnd);
                    sqlCommand.Parameters.AddWithValue("ProjectScaleId", param.ProjectScaleId);
                    sqlCommand.Parameters.AddWithValue("AreaArray", param.AreaArray);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
                    }
                }
            }

            if (string.IsNullOrEmpty(readercount)){
                
                await SaveLogAsync(_db, param.Id, TargetTypesBudgetLog.Project, "ویرایش پروژه "+param.ProjectName , "");

                return Ok("با موفقیت انجام شد");
            }
            else
                return BadRequest(readercount);
        }


        [Route("ProjectTableDelete")]
        [HttpPost]
        public async Task<ApiResult<string>> FnProjectTableDelete([FromBody] RequestBudgetDeleteViewModel param)
        {
            string readercount = null;
            using (SqlConnection sqlconnect = new SqlConnection(_config.GetConnectionString("SqlErp")))
            {
                using (SqlCommand sqlCommand = new SqlCommand("SP005_ProjectTable_Delete", sqlconnect))
                {
                    sqlconnect.Open();
                    sqlCommand.Parameters.AddWithValue("id", param.Id);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    SqlDataReader dataReader = await sqlCommand.ExecuteReaderAsync();
                    while (dataReader.Read())
                    {
                        if (dataReader["Message_DB"].ToString() != null) readercount = dataReader["Message_DB"].ToString();
                    }
                }
            }

            if (string.IsNullOrEmpty(readercount)){
                await SaveLogAsync(_db, param.Id, TargetTypesBudgetLog.Project, "حذف پروژه " , "");
   
                return Ok("با موفقیت انجام شد");
            }
            else
                return BadRequest(readercount);
        }








    }
}
